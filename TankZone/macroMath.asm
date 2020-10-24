; Puts a random number into A. Preserves x
defm    RND
        txa
        pha
        jsr $d229
        pla
        tax
        lda $8c
        endm