; Copies from /1 to /2 until a 0 is found at /1
; Destroys a, y
defm           COPY0
               LDY #0
@nextch        LDA /1,y
               beq @exitmac
               sta /2,y
               iny
               jmp @nextch
@exitmac
               endm

; Copies from /1 to /2 until a 0 is found at /1
; If there's a space in the source, does not overwrite output
defm           COPY0_NOSPACE
               LDY #0
@nextch        LDA /1,y
               beq @exitmac
               cmp #32
               beq @nexty
               sta /2,y
@nexty         iny
               jmp @nextch
@exitmac
               endm

; Copies up to 40 characters from /1 (offset in y) to /2
; Destroys a, x, y
defm           COPY40
               LDX #0
@nextch        LDA /1,y
               beq @start_over
               sta /2,x
               iny
               inx
               cpx #40
               beq @exitmac
               jmp @nextch

@start_over    ldy #0  ; start from the beginning of the string
               jmp @nextch

@exitmac
               endm
