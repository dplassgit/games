; convert from r, theta (0-78) polar to offset from 0 (x+40*y)
; 1. get cos(theta)
; 2. multiply r by cos(theta), put high byte in polarx
; 3. get sin(theta)
; 4. multiply r by sin(theta), put high byte in polary
; 5. multiply polary by 40, put into polar_result (2 bytes)
; 6. add polarx to polar_result (or subtract if polarx is negative)

; inputs: theta in x, radius in y

from_polar     STX theta
               sty radius  
               lda costab,x
               tax
               jsr mpy     
                           ; Note, we discard the low byte because we're doing fixed point.
               lda result+1
                           ; this is scaled 50%, which is wrong
               sta polarx  

               ldx theta   
               lda sintab,x
               tax
               ldy radius  
               jsr mpy     
               lda result+1
                           ; this is scaled 50%, which is wrong
               sta polary  

               tay
               ldx #40     
               jsr mpy     ; multiply polary by 40

                           ; copy 2 byte signed result to polar_result
               lda result+1
               sta polar_result+1
               lda result  
               sta polar_result

                           ; add (signed) polar x to polar result -- this part is
                           ; annoying, since I can't figure out how to get the
                           ; signed add to work when polarx is negative...
               lda polarx  
               beq from_polar_exit
               bpl polar_xpos

                           ; negate a:
               eor #$ff    
               clc
               adc #$01    
                           ; stash updated polarx
               sta polarx  
                           ; subtract polarx from polar_result
               lda polar_result
               sec
               sbc polarx  
               sta polar_result
               bcs from_polar_exit
               dec polar_result+1
               jmp from_polar_exit

polar_xpos     clc
               ADC polar_result
               sta polar_result
               bcc from_polar_exit
               inc polar_result+1

from_polar_exit rts


; there must be a way to reduce these...
theta          byte 0
radius         byte 0
polarx         byte 0
polary         byte 0
; zero page
polar_result   = $fd

sintab40       byte $0A,$1E,$31,$42,$52,$61,$6C,$75,$7B,$7F,$7F,$7B,$75,$6C,$61,$52,$42,$31,$1E,$0A,$F6,$E2,$CF,$BE,$AE,$9F,$94,$8B,$85,$81,$81,$85,$8B,$94,$9F,$AE,$BE,$CF,$E2,$F6,$0A
costab40       byte $7F,$7B,$75,$6C,$61,$52,$42,$31,$1E,$0A,$F6,$E2,$CF,$BE,$AE,$9F,$94,$8B,$85,$81,$81,$85,$8B,$94,$9F,$AE,$BE,$CF,$E2,$F6,$0A,$1E,$31,$42,$52,$61,$6C,$75,$7B,$7F,$7f

sintab         byte $04, $0e, $18, $22, $2c, $35, $3e, $47, $4f, $57, $5e, $65, $6a, $70, $74, $78, $7b, $7d, $7e, $7e, $7e, $7d, $7b, $78, $75, $70, $6b, $65, $5f, $58, $50, $48, $40, $37, $2d, $23, $1a, $0f, $05, $fc, $f2, $e8, $de, $d4, $cb, $c2, $b9, $b1, $a9, $a2, $9b, $96, $90, $8c, $88, $85, $83, $82, $82, $82, $83, $85, $88, $8b, $90, $95, $9b, $a1, $a8, $b0, $b8, $c0, $c9, $d3, $dd, $e6, $f1, $fb
costab         byte $7e, $7e, $7c, $7a, $76, $73, $6e, $68, $62, $5c, $54, $4c, $44, $3b, $32, $28, $1f, $15, $0a, $01, $f7, $ed, $e3, $d9, $cf, $c6, $bd, $b5, $ad, $a5, $9f, $98, $93, $8e, $8a, $87, $84, $83, $82, $82, $82, $84, $86, $8a, $8d, $92, $98, $9e, $a4, $ac, $b4, $bc, $c5, $ce, $d8, $e1, $eb, $f6, $01, $09, $13, $1d, $27, $31, $3a, $43, $4b, $53, $5b, $61, $68, $6d, $72, $76, $79, $7c, $7d, $7e