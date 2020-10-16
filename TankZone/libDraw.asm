
;; draw the heads-up display
draw_hud
               COPY0 enemy,enemy_1_org
               COPY0 enemy_left,enemy_2_org
               COPY0 score,score_org

               COPY0 radar1,radar1_org
               COPY0 radar2,radar2_org
               COPY0 radar3,radar3_org
               COPY0 radar4,radar4_org
               
               rts

draw_horizon   ldx #40
               lda #99
horizon_loop   STA horizon_org,x
               dex
               bne horizon_loop

               COPY0 bottom_ret1,bottom_ret1_org
               COPY0 bottom_ret2,bottom_ret2_org
               COPY0 bottom_ret3,bottom_ret3_org
               rts

draw_background
               LDY angle
               COPY40 bg0,bg_org
               ldy angle
               COPY40 bg1,bg_org+40
               ldy angle
               COPY40 bg2,bg_org+80
               ldy angle
               COPY40 bg3,bg_org+120
               ldy angle
               COPY40 bg4,bg_org+160
               ldy angle
               COPY40 bg5,bg_org+200

               lda showtop
               beq bg_exit
               COPY0_NOSPACE top_ret1,top_ret1_org
               COPY0_NOSPACE top_ret2,top_ret2_org
               COPY0_NOSPACE top_ret3,top_ret3_org

bg_exit        rts
            
sweep_radar
               inc radar_sweep_angle
               lda radar_sweep_angle
               ; 0b1100000 - this way it only changes every 96
               ; ticks
               and #96
               clc
               ror
               ror
               ror
               ror
               ror
               tax
               lda radar_sweep_chars,x
               sta radar_sweep_org
               rts
               
horizon_org    = 32767+40*14

radar1_org     = $8011
radar2_org     = radar1_org+41
radar3_org     = radar1_org+80
radar4_org     = radar1_org+162
radar1         byte $4d,$20,$5d,$20,$4e,0
radar2         byte $4d,$20,$4e,0
radar3         byte $40,$20,67,$20,$40,0
radar4         byte $5d, 0

enemy_1_org    = 32768
enemy          null 'enemy in range'
enemy_2_org    = 32768+80
enemy_right    null 'enemy to right'
enemy_left     null 'enemy to left'
enemy_rear     null 'enemy to rear'

; bottom reticle
bottom_ret1_org = 32768+16*40+17
bottom_ret2_org = bottom_ret1_org+40
bottom_ret3_org = bottom_ret2_org+42
bottom_ret1    byte 101,$20,$20,$20,103,0
bottom_ret2    byte 99,99,$5D,99,99,0
bottom_ret3    byte $5d,0

radar_sweep_org  = radar3_org+2
radar_sweep_angle  byte 0
radar_sweep_chars  byte 67,78,$5d,77

; top reticle
top_ret1_org   = 32768+9*40+19
top_ret2_org   = top_ret1_org+40-2
top_ret3_org   = top_ret2_org+39
top_ret1       byte $5D,0
top_ret2       byte 100,100,93,100,100,0
top_ret3       byte 103,$20,$20,$20,$20,$20,101,0

score_org      = 32768+40+26
score          null 'score'

; backgrounds
bg_org         = 32768+8*40
BG_LENGTH      = 78
bgm            null '         111111111122222222223333333333444444444455555555556666666666777777777'
bgn            null '123456789012345678901234567890123456789012345678901234567890123456789012345678'
bg0            null 'UI               .                                                     .      '
bg1            null 'JK                             *             .                              . '
bg2            null '   NM     .                          W    NM    .                             '
bg3            null '  N  MNM               .  NMNM           N  MNM               Q  NMNM         '
bg4            text '',99,99,'   N  M     N',99,99,99,'M      N  M M',100,'      N',99,99,'   N  M     N',99,99,99,'M      N  M M',100,'      N',0
bg5            text '    N    M   N     ',99,'M   N    M  M NM N     N    M   N     ',99,'M   N    M  M NM N ',0