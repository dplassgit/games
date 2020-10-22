; ========================================
; Project   : TankZone
; Target    : Commodore PET 2001+
; Comments  : 
; Author    : David Plass
; ========================================

*=$0500

start         jmp start_game
               
incasm "copyMacros.asm"
incasm "libDraw.asm"
incasm "libTest.asm"

;; How much to increment the low byte of "angle" each time we move.
ANGLE_INCREMENT=16
;; Represents the "angle"
;; Max is $a000 (=40960 = 160*256; 160 is the width of the background)
angle         word 0

;; Whether we should show the top reticle or not. For debugging.
showtop       byte 1


start_game
              jsr draw_hud
              jsr draw_horizon

reset_bg
              LDY #0
              sty angle
              sty angle+1

bg_loop       ;jsr polar_one
              jsr draw_background
bg_loop2      jsr sweep_radar

waiting       LDA 151
              cmp #$ff
              ; beq waiting ; will not update radar
              ; beq bg_loop2; update radar but not background
              beq bg_loop ; will update background and radar

akey          CMP #"0"
              bne maybe_left
              beq reset_bg

maybe_left    CMP #"j"
              bne maybe_right

              ; Decrement the angle by #ANGLE_INCREMENT.
              ; If it goes negative, reset to 40960 =
              ; 160 ($A0) in the high byte and 0 in the low byte 
              lda angle
              sec
              sbc #ANGLE_INCREMENT
              sta angle
              bne bg_loop
              dec angle+1
              lda angle+1
              cmp #$ff
              beq set_angle_to_max
              bne bg_loop

set_angle_to_max
              LDY #BG_LENGTH
              sty angle+1
              ldy #0
              sty angle
              jmp bg_loop

maybe_right   CMP #"l"
              bne maybe_quit

              ; increment the angle. if it reaches $a0 in the high byte
              ; and 0 in the low byte, reset high byte to 0
              lda angle
              clc
              adc #ANGLE_INCREMENT
              sta angle
              BNE after_inc
              INC angle+1
after_inc     lda angle+1
              cmp #BG_LENGTH
              beq reset_bg
              bne bg_loop

maybe_quit    CMP #"q"
              bne mayble_toggle
              beq quit

              ; Toggle the top reticle
maybe_toggle  CMP #"t"
              bne bg_loop
              sec
              lda #1
              sbc showtop
              sta showtop

              jmp bg_loop

quit          rts
