incasm "libTrig.asm"

testangle byte 0

polar_test     LDA #BG_LENGTH
               sta testangle

polar_loop     ldx testangle
               dex
               ldy #10 ; radius
               ; theta in x, radius in y
               jsr polar_to_screen
               ; For the radar, add 32768+2*40+19 to polar_result
               ; = 32867, in hex, 8063
               ; For the center, add 32768+12*40+19 = 33267, in hex 81f3
               clc
               lda #<POLAR_CENTER
               adc polar_result
               sta polar_result
               lda #>POLAR_CENTER
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda #"."
               sta (polar_result),y
               dec testangle
               bne polar_loop

               lda #"*"
               sta POLAR_CENTER
               rts

POLAR_CENTER=$8325
polar_one      ldy #10 ;radius
               ldx angle+1
               jsr polar_to_screen

               ; For the center of the screen, start at 32768+12*40+19 = 33267, in hex 81f3
               ; For the lower left, start at 32768+20*40+5=33573, in hex 0x8325
               clc
               lda #<POLAR_CENTER
               adc polar_result
               sta polar_result
               lda #>POLAR_CENTER
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda angle+1
               sta (polar_result),y
               rts
