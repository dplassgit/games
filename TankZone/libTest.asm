incasm "libTrig.asm"

POLAR_CENTER=$8325

testangle byte 0

;; Draw a circle of dots at POLAR_CENTER
;; Inputs: none
;; Outputs: None
;; Side effects: destroys a, x, y
polar_test     lda #BG_LENGTH
               sta testangle

polar_loop     ldx testangle
               dex
               ldy #10 ; radius
               ; theta in x, radius in y
               jsr polar_to_screen

               ; add to the "center"
               clc
               lda #<POLAR_CENTER
               adc polar_result
               sta polar_result
               lda #>POLAR_CENTER
               adc polar_result+1
               sta polar_result+1

               ; plot a dot. heh
               ldy #0
               lda #"."
               sta (polar_result),y
               dec testangle
               bne polar_loop

               lda #"*"
               sta POLAR_CENTER
               rts

;; Draws a single point centered at POLAR_CENTER, at the angle at angle=1
;; with radius 10
;; Inputs: angle (effectively)
;; Outputs: none
;; Side effects: destroys a, x, y
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
