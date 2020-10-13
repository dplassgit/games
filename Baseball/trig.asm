

; convert from r,theta (0-39) polar to offset from 0 (x+40*y)
; 1. get sin(theta)
; 2. multiply r by sin(theta), put high byte in polarx
; 3. get cos(theta)
; 4. multiply r by cos(theta), put high byte in polary
; 5. multiply polary by 40, put into polar_result
; 6. add polarx to polar_result
; 7. add 32768 to polar_result ($80 to >polar)

; inputs: theta in x, radius in y

from_polar     stx theta
               sty radius
               lda sintab,x
               tax
               jsr mpy
               lda result+1
               ; this may have to be shifted right...
               sta polarx

               ldx theta
               lda costab,x
               ldy radius
               jsr mpy
               lda result+1
               ; this may have to be shifted right...
               sta polary

               ldy polary
               ldx #40
               jsr mpy

               lda result+1
               sta polar_result+1
               lda result
               sta polar_result
               clc
               adc polarx ; is this allowed?
               sta polar_result
               bcc add32768
               inc polar_result+1

add32768       lda polar_result+1
               clc
               adc #$80
               sta polar_result+1
               rts


; there must be a way to reduce these...
theta          byte 0
radius         byte 0
polarx         byte 0
polary         byte 0
polar_result   word 0

sintab         byte 0,$14,$27,$3A,$4B,$5A,$67,$71,$79,$7D,$7F,$7D,$79,$71,$67,$5A,$4B,$3A,$27,$14,$0,$EC,$D9,$C6,$B5,$A6,$99,$8F,$87,$83,$81,$83,$87,$8F,$99,$A6,$B5,$C6,$D9,$EC
costab         byte $7F,$7D,$79,$71,$67,$5A,$4B,$3A,$27,$14,$0,$EC,$D9,$C6,$B5,$A6,$99,$8F,$87,$83,$81,$83,$87,$8F,$99,$A6,$B5,$C6,$D9,$EC,$0,$14,$27,$3A,$4B,$5A,$67,$71,$79,$7D
