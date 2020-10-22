; ========================================
; Project   : TankZone
; Target    : Commodore PET 2001+
; Comments  : 
; Author    : David Plass
; ========================================

*=$0500

start         jmp start_game
               
incasm "copyMacros.asm"
incasm "libFixedpoint.asm"
incasm "libTrig.asm"
incasm "libDraw.asm"
incasm "libTest.asm"
               
start_game
              jsr draw_hud
              jsr draw_horizon

reset_bg
              LDY #0
              sty angle

bg_loop
              jsr draw_background
              jsr sweep_radar

waiting       LDA 151
              cmp #$ff
              beq bg_loop
;; alternatively: beq waiting

akey          CMP #"0"
              bne maybe_left
              jmp reset_bg

maybe_left    CMP #"j"
              bne maybe_right
              dec angle
              lda angle
              cmp #$ff
              beq goto_end
              jmp bg_loop

goto_end      LDY #BG_LENGTH
              sty angle
              jmp bg_loop

maybe_right   CMP #"l"
              bne maybe_quit
              inc angle
              lda angle
              cmp #BG_LENGTH+1
              beq reset_bg
              jmp bg_loop

maybe_quit    CMP #"q"
              beq quit

maybe_toggle  CMP #"t"
              bne bg_loop
              sec
              lda #1
              sbc showtop
              sta showtop
              jmp bg_loop

quit          rts

angle         byte 0
showtop       byte 1
