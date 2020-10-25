; Puts a random number into A. 
; Inputs: none.
; Outputs: random number in a
; Side effects: preserves x, probably destroys y
defm    RND
        txa
        pha
        jsr $d229
        pla
        tax
        lda $8c
        endm