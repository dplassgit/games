; Copies from copysrc to copydst until a 0 is found at copysrc
; If there's a space in the source, does not overwrite output
; Side effects: destroys a

copysrc   = $5e
copydst   = $60

copy0_nospace
                tya
                pha
                ldy #0
@nextch         lda (copysrc),y
                beq @exit_copy0
                cmp #32
                beq @nexty
                sta (copydst),y
@nexty          iny
                bne @nextch
@exit_copy0
                pla
                tay
                rts

; Copies a sprite from copysrc to copydst; when the first
; 0 is found at copysrc, copydst is incremented by 40 characters.
; If there's a space in the source, does not overwrite output
; Side effects: destroys a

copy_sprite
                tya
                pha

lineloop
                ldy #0

charloop
                lda (copysrc),y
                beq nextdstline
                cmp #$20
                beq skipspace
                sta (copydst),y
skipspace       iny
                jmp charloop

nextdstline
                iny
                lda (copysrc),y
                beq copy_sprite_end       ; two zeros in a row

                lda copydst
                clc
                adc #40
                sta copydst
                bcc nextsrcline
                inc copydst+1

nextsrcline
                tya ; add y to src and reset y to 0
                clc
                adc copysrc
                sta copysrc
                bcc lineloop
                inc copysrc+1
                jmp lineloop

copy_sprite_end
                pla
                tay
                rts


; Free zero-page:
;5E-63
;66-6B
;9C
;A2
;AD
;B1
;B4
;BA-BD
;C2,C3
;C7-CC
;CE,CF
;F9-FA
;FD-FE

