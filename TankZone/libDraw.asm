;; Draw the heads-up display: enemy, score, radar
draw_hud
               ; The "enemy" messages should change when there are, you know,
               ; enemies.
               COPY0 enemy_in_range_msg,enemy_1_org
               COPY0 enemy_left_msg,enemy_2_org

               COPY0 score_msg,score_org

               ; Draw blank radar
               COPY0 radar1,radar1_org
               COPY0 radar2,radar2_org
               COPY0 radar3,radar3_org

               rts

;; Draw the horizon from right to left, & the bottom reticle
draw_horizon   ldx #40
               lda #99
horizon_loop   sta horizon_org,x
               dex
               bne horizon_loop

               COPY0 bottom_ret1,bottom_ret1_org
               COPY0 bottom_ret2,bottom_ret2_org
               COPY0 bottom_ret3,bottom_ret3_org
               rts

;; Draw the background at the current angle. Currently uses
;; the high byte of the angle, which maxes out at 160
draw_background
               ldy angle+1
               COPY40 bg0,bg_org
               ldy angle+1
               COPY40 bg1,bg_org+40
               ldy angle+1
               COPY40 bg2,bg_org+80
               ldy angle+1
               COPY40 bg3,bg_org+120
               ldy angle+1
               COPY40 bg4,bg_org+160
               ldy angle+1
               COPY40 bg5,bg_org+200

               lda showtop
               beq bg_exit
               COPY0_NOSPACE top_ret1,top_ret1_org
               COPY0_NOSPACE top_ret2,top_ret2_org
               COPY0_NOSPACE top_ret3,top_ret3_org

bg_exit        rts


draw_visible_enemies
               ; first, clear the enemy "row"
               ldx #0
               lda #' '
clear_enemy_loop
               sta temp_enemy_org,x
               inx
               cpx #40
               bne clear_enemy_loop

               ; now, draw the visible enemies.
               ldy #0

               lda angle+1
               sta val1 ; val1 = angle
               clc
               adc #40
               sta val3 ;val3 = angle+40

               ; make angle - 120, put in val4
               lda angle+1
               sec
               sbc #120
               sta val4

draw_enemy_loop
; 1. if angle > 120 then goto 2a
; 1a: if angle <= et and et < angle+40 then goto 3a
; 1b: goto 4
; 2a: if et > angle then goto 3a
; 2b: if et < angle-120 then goto 3b
; 2c: goto 4
; 3a. x = et-angle. show it. goto 5.
; 3b. d=160-angle. x = d + et. show it. goto 5
; 4. skip it
; 5. next enemy
               ldx enemy_theta,y
               lda angle+1
               cmp #120
               bgt twoa

onea           
               stx val2 ; val2 = et               
               jsr is_between   ; is angle (val1) <= et and et < angle+40 (val3)
               bcc threea       ; carry clear = yes, is between
               bcs skip_to_drawing_next_enemy   ; else, is not between.

twoa           ; if et(x) > angle, goto 3a
               cpx angle+1       ; x is et
               bgt threea

twob           ; if et(x) < angle-120, goto 3b
               cpx val4
               blt threeb
               bge skip_to_drawing_next_enemy

; offset = et - angle
threea         txa      ; a has et
               sec
               sbc angle+1       ; a has et-angle
               tax      ; x has offset
               jmp draw_one_enemy

; x has et. d=160-angle. offset = d + et
threeb         lda #160
               sec
               sbc angle+1
               ; need to add a+x but can't, so use val2 as a temp
               sta val2 ; val2 = 160-angle
               txa 
               clc
               adc val2 ; a = x + (160-angle)
               tax

draw_one_enemy 
               tya       ; y has enemy #
               clc
               adc #1
               sta temp_enemy_org,x

skip_to_drawing_next_enemy
               iny ; bump it here so we start showing from A not @
               cpy num_enemies
               bne draw_enemy_loop
               rts

sweep_radar
               inc sweep_angle
               lda sweep_angle
               ; 0b1100000 - this way it only changes every 96 ticks
               and #96
               clc
               ror
               ror
               ror
               ror
               ror
               tax
               lda sweep_chars,x
               sta sweep_org
               rts

; NOTE, we start at the END of the lines, so we need to start at 32767
horizon_org    = 32767+40*14
; this one starts at the beginning of the ine.
temp_enemy_org = horizon_org+41

radar1_org     = 32768+19
radar2_org     = radar1_org+78
radar3_org     = radar1_org+160
radar1         byte $5d,0
radar2         byte $40,$20,67,$20,$40,0
radar3         = radar1

sweep_org      = radar2_org+2
sweep_angle    byte 0
sweep_chars    byte 67,78,$5d,77

enemy_1_org    = 32768
enemy_in_range_msg null 'enemy in range'
enemy_2_org    = 32768+80
enemy_right_msg null 'enemy to right'
enemy_left_msg  null 'enemy to left'
enemy_rear_msg  null 'enemy to rear'

; bottom reticle
bottom_ret1_org = 32768+16*40+17
bottom_ret2_org = bottom_ret1_org+40
bottom_ret3_org = bottom_ret2_org+42
bottom_ret1     byte 101,$20,$20,$20,103,0
bottom_ret2     byte 99,99,$5D,99,99,0
bottom_ret3     = radar1

; top reticle
top_ret1_org   = 32768+9*40+19
top_ret2_org   = top_ret1_org+40-2
top_ret3_org   = top_ret2_org+39
top_ret1       = radar1
top_ret2       byte 100,100,93,100,100,0
top_ret3       byte 103,$20,$20,$20,$20,$20,101,0

score_org      = 32768+40+26
score_msg      null 'score'

; backgrounds
bg_org         = 32768+8*40
BG_LENGTH      = 160
;bg0            null '          111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffff'
;bg1            null '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'
bg0 text '    .       .        .  W         .             U',$40,'I         .             Q     *          .            .          UI    .   ',$64,'    .      .                      ',0
bg1 text '                 +                        *    ',$40,$73,$20,$6B,$40,'                 -                                             JK       N M                 .               ',0
bg2 text '         .               .   .             .    J',$40,'K           .             .                  .   -             .          ',$65,'  ',$65,'                   .            ',0
bg3 text '   .           NMNM                N',$63,'M .        .        NM     .     .              NMNM                N',$63,'M .     .   *    ',$65,'  ',$65,'            NMNM        Q       ',0
bg4 text '     ',$64,'NM   .  N N  M',$64,'.     -     ',$64,'N   M                 N  V',$63,'M          ',$64,'NM   .     N N  M',$64,'.     W     ',$64,'N   M              N   M    +     ',$64,'N  M M           NM  ',0
bg5 text '    NN  M    N N     M          N      ',$65,'    NM  NM     N  N M M        NN  M       N N     M          N      ',$65,'    NM      N     M        N     M M   NM    N  M ',0
