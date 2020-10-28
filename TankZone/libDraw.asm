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
               lda #$20
clear_enemy_loop
               sta temp_enemy_org,x
               inx
               cpx #40
               bne clear_enemy_loop

               ; now, draw the visible enemies.
               ldy num_enemies
               dey ; off by one...

draw_enemy_loop
; say enemy_theta is 0
; and angle+1 is 0.

; we want:
; enemy_theta >= angle+1  (true: 0 >= 0)
; enemy_theta < angle+1 plus 40 (true: 0 < 40)
; =
; enemy_theta - 40 < angle+1 (true, -40 < 0) ; 
; SIGNED COMPARISON BUT! angle+1 can go up to 160, which is a0, which looks negative...

               lda enemy_theta,y
               cmp angle+1
               blt draw_next_enemy

               sec
               sbc #40
               cmp angle+1
; deal with overflow
               bcs draw_next_enemy ; a is > angle+1, too big.
               ; draw it at an offset based on the enemy's relative
               ; angle to our angle
               sec
               lda enemy_theta,y
               sbc angle+1
               ; now A has the new angle, but can't index off A; index off x
               tax
               tya ; y is the enemy index, it's the value to store
               sta temp_enemy_org,x

draw_next_enemy
               dey
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
;bgm            null '          111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999aaaaaaaaaabbbbbbbbbbccccccccccddddddddddeeeeeeeeeeffffffffff'
;bgn            null '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'
bg0 text '    .       .        .  W         .             U',$40,'I         .             Q     *          .            .          UI    .   ',$64,'    .      .                      ',0
bg1 text '                 +                        *    ',$40,$73,$20,$6B,$40,'                 -                                             JK       N M                 .               ',0
bg2 text '         .               .   .             .    J',$40,'K           .             .                  .   -             .          ',$65,'  ',$65,'                   .            ',0
bg3 text '   .           NMNM                N',$63,'M .        .        NM     .     .              NMNM                N',$63,'M .     .   *    ',$65,'  ',$65,'            NMNM        Q       ',0
bg4 text '     ',$64,'NM   .  N N  M',$64,'.     -     ',$64,'N   M                 N  V',$63,'M          ',$64,'NM   .     N N  M',$64,'.     W     ',$64,'N   M              N   M    +     ',$64,'N  M M           NM  ',0
bg5 text '    NN  M    N N     M          N      ',$65,'    NM  NM     N  N M M        NN  M       N N     M          N      ',$65,'    NM      N     M        N     M M   NM    N  M ',0
