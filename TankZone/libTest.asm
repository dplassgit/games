polar_test     LDA #78
               sta angle2

polar_loop     ldx angle2
               dex
               ldy #5 ; radius
               ; theta in x, radius in y
               jsr from_polar
               ; add 32768+2*40+19 to polar_result
               ; = 32867, in hex, 8063
               clc
               lda #$64
               adc polar_result
               sta polar_result
               lda #$80
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda #"."
               sta (polar_result),y
               dec angle2
               bne polar_loop

               lda #"*"
               sta $8063
               rts
               
angle2 byte 0
