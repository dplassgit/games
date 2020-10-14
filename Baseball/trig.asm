; convert from r,theta (0-39) polar to offset from 0 (x+40*y)
; 1. get cos(theta)
; 2. multiply r by cos(theta), put high byte in polarx
; 3. get sin(theta)
; 4. multiply r by sin(theta), put high byte in polary
; 5. multiply polary by 40, put into polar_result
; 6. add polarx to polar_result
; 7. add 32768+12*40 to polar_result ($80 to >polar)

; inputs: theta in x, radius in y

from_polar     stx theta
               sty radius
               lda costab,x
               tax
               jsr mpy
               ; throws out the low byte, which probably causes rounding errors
               lda result+1
               ; this is scaled 50%, which is wrong
               ; temporarily make polarx always positive
                bpl foundabs
                lda #0
                sec
                sbc result+1
foundabs        sta polarx
               
               ldx theta
               lda sintab,x
               tax
               ldy radius
               jsr mpy     
               lda result+1
               ; this is scaled 50%, which is wrong
               sta polary

               tay      ; may be negative
               ldx #40
               jsr mpy  ; multiply polary by 40

                           ; copy 2 byte result to polar_result
               clc
               lda result+1
               sta polar_result+1
               lda result
               sta polar_result
               
               ; add (signed) polar x to polar result
               adc polarx
               sta polar_result
               bcc add32768
               inc polar_result+1
               lda polarx

add32768       ; add 32768+12*40+20 to polar_result
               ; = 33268, in hex, 81F4
               clc
               lda #$f3    
               adc polar_result
               sta polar_result
               ; notice carry is not cleared
               lda #$81    
               adc polar_result+1
               sta polar_result+1
               rts


; there must be a way to reduce these...
theta          byte 0
radius         byte 0
polarx         byte 0
polary         byte 0
; zero page
polar_result   = $fd
               
sintab1        byte 0,$14,$27,$3A,$4B,$5A,$67,$71,$79,$7D,$7F,$7D,$79,$71,$67,$5A,$4B,$3A,$27,$14,$0,$EC,$D9,$C6,$B5,$A6,$99,$8F,$87,$83,$81,$83,$87,$8F,$99,$A6,$B5,$C6,$D9,$EC
costab1        byte $7F,$7D,$79,$71,$67,$5A,$4B,$3A,$27,$14,$0,$EC,$D9,$C6,$B5,$A6,$99,$8F,$87,$83,$81,$83,$87,$8F,$99,$A6,$B5,$C6,$D9,$EC,$0,$14,$27,$3A,$4B,$5A,$67,$71,$79,$7D
sintab         byte $0A,$1E,$31,$42,$52,$61,$6C,$75,$7B,$7F,$7F,$7B,$75,$6C,$61,$52,$42,$31,$1E,$0A,$F6,$E2,$CF,$BE,$AE,$9F,$94,$8B,$85,$81,$81,$85,$8B,$94,$9F,$AE,$BE,$CF,$E2,$F6
costab         byte $7F,$7B,$75,$6C,$61,$52,$42,$31,$1E,$0A,$F6,$E2,$CF,$BE,$AE,$9F,$94,$8B,$85,$81,$81,$85,$8B,$94,$9F,$AE,$BE,$CF,$E2,$F6,$0A,$1E,$31,$42,$52,$61,$6C,$75,$7B,$7F
; multiplication table for 40s - how to deal with negatives
; forties        word 0,40,80,120,160,200,240,280,320,360