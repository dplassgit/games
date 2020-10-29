; Copies from /1 to /2 until a 0 is found at /1
; Side effects: Destroys a, y, preserves x
defm           COPY0
               ldy #0
@nextch        lda /1,y
               beq @exitmac
               sta /2,y
               iny
               bne @nextch
@exitmac
               endm

; Copies from /1 to /2 until a 0 is found at /1
; If there's a space in the source, does not overwrite output
; Side effects: Destroys a, y, preserves x
defm           COPY0_NOSPACE
               ldy #0
@nextch        lda /1,y
               beq @exitmac
               cmp #32
               beq @nexty
               sta /2,y
@nexty         iny
               bne @nextch
@exitmac
               endm

; Copies up to 40 characters from /1 (offset in y) to /2
; Side effects: Destroys a, x, y
defm           COPY40
               ldx #0
@nextch        lda /1,y
               bne @storeit
               ldy #0
               beq @nextch
@storeit       sta /2,x
               iny
               inx
               cpx #40
               bne @nextch

@exitmac
               endm
