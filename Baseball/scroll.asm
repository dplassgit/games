*=$0500

defm           COPYLINE
               LDY #0      ;; index into radar
@nextch        LDA /1,y
               beq @exitmac
               sta /2,y    
               iny
               jmp @nextch 
@exitmac
               endm


start          nop
               COPYLINE enemy, enemy_loc
               COPYLINE radar1,radar1_loc
               COPYLINE radar2,radar2_loc
               COPYLINE radar3,radar3_loc
               COPYLINE radar4,radar4_loc

done                       ; put the horizon
               ldx #40     
               lda #99     
horizon_loop   STA 33327,x ; 14th line
               dex
               bne horizon_loop

               COPYLINE bottom_ret1,bottom_ret1_loc
               COPYLINE bottom_ret2,bottom_ret2_loc
               COPYLINE bottom_ret3,bottom_ret3_loc

               COPYLINE top_ret1,top_ret1_loc
               COPYLINE top_ret2,top_ret2_loc
               COPYLINE top_ret3,top_ret3_loc

bg_loop        nop
               rts

radar1_loc     = $8011
radar2_loc     = radar1_loc+41
radar3_loc     = radar1_loc+80
radar4_loc     = radar1_loc+162
radar1         byte $4d,$20,$5d,$20,$4e,0 ; zero terminates
radar2         byte $4d,$20,$4e,0
radar3         byte $40,$20,42,$20,$40,0
radar4         byte $5d, 0

bottom_ret1_loc = 32768+16*40+17
bottom_ret2_loc = bottom_ret1_loc+40
bottom_ret3_loc = bottom_ret2_loc+42
bottom_ret1    byte 101,$20,$20,$20,103,0
bottom_ret2    byte 99,99,$5D,99,99,0
bottom_ret3    byte $5D,0

top_ret1_loc   = 32768+9*40+19
top_ret2_loc   = top_ret1_loc+40-2
top_ret3_loc   = top_ret2_loc+40
top_ret1    byte $5D,0
top_ret2    byte 100,100,93,100,100,0
top_ret3    byte 101,$20,$20,$20,103,0

enemy_loc      = 32768
enemy          null "enemy in range"              

; backgrounds
bg0            text ".UI               .                                                     .      "
bg1            text ".JK                             *             .                              . "
bg2            text ".   NM     .                          W    NM    .             Q               "
bg3            text ".  N  MNM               .  NMNM           N  MNM                  NMNM         "
bg4            text ".",99,99,"   N  M     N",99,99,99,"M      N  M M",100,"      N",99,99,"   N  M     N",99,99,99,"M      N  M M",100,"      N"
bg5            text ".    N    M   N     ",99,"M   N    M  M NM N     N    M   N     ",99,"M   N    M  M NM N "
