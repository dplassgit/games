; ========================================
; Project   : TankZone
; Target    : Commodore PET 4016+
; Comments  : For some reason 2001 doesn't load at all, and 3016 doesn't accept
;           ; keyboard input
; Author    : David Plass
; ========================================

*=$0500

start         jmp start_game

incasm "macroCopy.asm"
incasm "macroSugar.asm"
incasm "libCopy.asm"
incasm "libEnemies.asm"
incasm "libDraw.asm"
incasm "libMath.asm"
incasm "libTest.asm"

;; How much to increment the low byte of "angle" each time we move.
ANGLE_INCREMENT=1
;; Represents the "angle"
;; Max is $a000 (=40960 = 160*256; 160 is the width of the background)
angle         word 0
prev_angle    word $ffff

;; Whether we should show the top reticle or not. For debugging.
showtop       byte 1

start_game    jsr draw_hud
              jsr draw_horizon
              jsr create_enemies
              jsr polar_test
              jsr plot_enemies

reset_angle
              ldy #0
              sty angle
              sty angle+1

bg_loop       lda angle+1             
              cmp prev_angle
              beq bg_loop2
              ; only draw the background etc, if
              ; we actually moved.
              sta prev_angle
              jsr draw_background
              jsr draw_visible_enemies
              ;jsr polar_test    ;; TEMPORARY
              ;jsr polar_one     ;; TEMPORARY
              ;jsr plot_enemies  ;; TEMPORARY
bg_loop2      
              jsr sweep_radar

waiting       lda 151   ; gets a character
              cmp #$ff
              ; beq waiting ; will not update radar
              ; beq bg_loop2; update radar but not background
              beq bg_loop ; will update background and radar

akey          cmp #"0"
              bne maybe_left
              beq reset_angle

maybe_left    cmp #"j"
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
              ldy #BG_LENGTH
              sty angle+1
              ldy #0
              sty angle
              beq bg_loop

maybe_right   cmp #"l"
              bne maybe_quit

              ; increment the angle. if it reaches $a0 in the high byte
              ; and 0 in the low byte, reset high byte to 0
              lda angle
              clc
              adc #ANGLE_INCREMENT
              sta angle
              bne after_inc
              inc angle+1
after_inc     lda angle+1
              cmp #BG_LENGTH
              beq reset_angle
              bne bg_loop

maybe_quit    cmp #"q"
              bne maybe_toggle
              beq quit

              ; Toggle the top reticle
maybe_toggle  cmp #"t"
              bne bg_loop
              sec
              lda #1
              sbc showtop
              sta showtop

              jmp bg_loop

quit          brk
              jmp bg_loop
              rts
