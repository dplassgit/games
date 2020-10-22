incasm "libFixedpoint.asm"

; Convert from r, theta (0-159) polar to x, y
; Inputs: theta in x, radius in y
; Outputs: x in x, y in y

; 1. get cos(theta) (8 bits, signed)
; 2. x = r * cos(theta), stash x
; 3. get sin(theta)
; 4. y = r * sin(theta)
; 5. retrieve x from stack
polar_to_rect     
               stx theta
               sty radius
               lda costab,x
               tax           ; now x=cos(theta)
               jsr mpy       ; multiply y (radius) by x (cosine)

               ; Discard the low byte because we're doing fixed point.
               ; This is scaled 50%, which may be wrong.
               lda result+1
               pha      ; stash x result on stack  

               ldx theta   
               lda sintab,x
               tax           ; now x=sin(theta)
               ldy radius    ; y=radius
               jsr mpy       ; multiply y (radius) by x(sine)

               ; Discard the low byte because we're doing fixed point.
               ; This is scaled 50%, which may be wrong.
               lda result+1
               tay

               pla      ; get x from stack
               tax                
               rts

; Convert from r, theta (0-159) polar to offset from 0 (x+40*y)
; Inputs: theta in x, radius in y
; Outputs: location in polar_result (word)

; 1. convert r,theta to get x,y
; 2. multiply y by 40, put into polar_result (2 bytes)
; 3. add x to polar_result (or subtract if polarx is negative)
polar_to_screen
               jsr polar_to_rect ; results in x,y
               stx polarx
               ldx #40     
               jsr mpy     ; multiply polary by 40

               ; copy 2 byte signed result to polar_result
               lda result+1
               sta polar_result+1
               lda result  
               sta polar_result

               ; add (signed) polar x to polar result
               lda polarx
               bpl xpos
               dec polar_result+1
xpos           clc
               adc polar_result
               sta polar_result
               bcc polar_to_screen_exit
               inc polar_result+1

polar_to_screen_exit
               rts


; there must be a way to reduce these...
theta          byte 0
radius         byte 0
polarx         byte 0

; zero page
polar_result   = $fd

sintab byte $02,$07,$0c,$11,$16,$1a,$1f,$24,$29,$2e,$32,$37,$3b,$3f,$44,$48,$4c,$50,$54,$57,$5b,$5e,$61,$65,$68,$6a,$6d,$6f,$72,$74,$76,$77,$79,$7a,$7b,$7c,$7d,$7e,$7e,$7e,$7e,$7e,$7e,$7d,$7d,$7c,$7a,$79,$78,$76,$74,$72,$70,$6d,$6b,$68,$65,$62,$5f,$5b,$58,$54,$50,$4c,$48,$44,$40,$3c,$37,$33,$2e,$29,$25,$20,$1b,$16,$11,$0c,$07,$02,$fe,$f9,$f4,$ef,$ea,$e6,$e1,$dc,$d7,$d2,$ce,$c9,$c5,$c1,$bc,$b8,$b4,$b0,$ac,$a9,$a5,$a2,$9f,$9b,$98,$96,$93,$91,$8e,$8c,$8a,$89,$87,$86,$85,$84,$83,$82,$82,$82,$82,$82,$82,$83,$83,$84,$86,$87,$88,$8a,$8c,$8e,$90,$93,$95,$98,$9b,$9e,$a1,$a5,$a8,$ac,$b0,$b4,$b8,$bc,$c0,$c4,$c9,$cd,$d2,$d7,$db,$e0,$e5,$ea,$ef,$f4,$f9
costab byte $7e,$7e,$7e,$7d,$7d,$7c,$7a,$79,$78,$76,$74,$72,$70,$6d,$6b,$68,$65,$62,$5f,$5b,$58,$54,$50,$4c,$48,$44,$40,$3c,$37,$33,$2e,$29,$25,$20,$1b,$16,$11,$0c,$07,$02,$fe,$f9,$f4,$ef,$ea,$e6,$e1,$dc,$d7,$d2,$ce,$c9,$c5,$c1,$bc,$b8,$b4,$b0,$ac,$a9,$a5,$a2,$9f,$9b,$98,$96,$93,$91,$8e,$8c,$8a,$89,$87,$86,$85,$84,$83,$82,$82,$82,$82,$82,$82,$83,$83,$84,$86,$87,$88,$8a,$8c,$8e,$90,$93,$95,$98,$9b,$9e,$a1,$a5,$a8,$ac,$b0,$b4,$b8,$bc,$c0,$c4,$c9,$cd,$d2,$d7,$db,$e0,$e5,$ea,$ef,$f4,$f9,$fe,$02,$07,$0c,$11,$16,$1a,$1f,$24,$29,$2e,$32,$37,$3b,$3f,$44,$48,$4c,$50,$54,$57,$5b,$5e,$61,$65,$68,$6a,$6d,$6f,$72,$74,$76,$77,$79,$7a,$7b,$7c,$7d,$7e,$7e
