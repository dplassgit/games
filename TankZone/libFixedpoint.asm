
test           LDX #14
               ldy #$F6    

; Signed multiply.
; Inputs: x and y
; Outputs: high byte of value into a, full 16 bits in RESULT
mpy            STX NUM1
               STY NUM2    
               ;clc
               ;clv
               LDA NUM1    ;Compute sign of result
               EOR NUM2    
               PHP         ;Save it on the stack
               LDA NUM1    ;Is NUM1 negative?
               BPL T1      
               EOR #$FF    ;If so, make it positive
               CLC
               ADC #1      
               STA NUM1    
T1             LDA NUM2    ;Is NUM2 negative?
               BPL T2      
               EOR #$FF    ;If so, make it positive
               CLC
               ADC #1      
               STA NUM2    
T2             JSR MUL1BYTE;Do the unsigned multiplication
               PLP         ;Get sign of result
               BPL T3      
               LDA #0      ;If negative, negate result
               SEC
               SBC RESULT  
               STA RESULT  
               LDA #0      
               SBC RESULT+1
               STA RESULT+1
T3             RTS

; multiply num1 by num2, result in RESULT
MUL1BYTE       LDA #$80    ;Preload sentinel bit into RESULT
               STA RESULT  
               ASL A       ;Initialize RESULT hi byte to 0
               DEC NUM1    
L1             LSR NUM2    ;Get low bit of NUM2
               BCC L2      ;0 or 1?
               ADC NUM1    ;If 1, add (NUM1-1)+1
L2             ROR A       ;"Stairstep" shift (catching carry from add)
               ROR RESULT  
               BCC L1      ;When sentinel falls off into carry, we're done
               STA RESULT+1
               rts

NUM1           byte 0
NUM2           byte 0
RESULT         word 0
