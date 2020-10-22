incasm "libTrig.asm"

polar_test     LDA #159
               sta testangle

polar_loop     ldx testangle
               dex
               ldy #23 ; radius
               ; theta in x, radius in y
               jsr polar_to_screen
               ; For the radar, add 32768+2*40+19 to polar_result
               ; = 32867, in hex, 8063
               ; For the center, add 32768+12*40+19 = 33267, in hex 81f3
               clc
               lda #$f3
               adc polar_result
               sta polar_result
               lda #$81
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda #"."
               sta (polar_result),y
               dec testangle
               bne polar_loop

               lda #"*"
               sta $81f3
               rts
               
polar_one      ldy #23 ;radius
               ldx angle+1
               jsr polar_to_screen

               ; For the center, add 32768+12*40+19 = 33267, in hex 81f3
               clc
               lda #$f3
               adc polar_result
               sta polar_result
               lda #$81
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda angle+1
               sta (polar_result),y
               rts

testangle byte 0
