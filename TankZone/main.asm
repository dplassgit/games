*=$0500


; Copies from /1 to /2 until a 0 is found at /1
; Destroys a, y
defm           COPY0
               LDY #0
@nextch        LDA /1,y
               beq @exitmac
               sta /2,y
               iny
               jmp @nextch
@exitmac
               endm

; Copies from /1 to /2 until a 0 is found at /1
; If there's a space in the source, does not overwrite output
defm           COPY0_NOSPACE
               LDY #0
@nextch        LDA /1,y
               beq @exitmac
               cmp #32
               beq @nexty
               sta /2,y
@nexty         iny
               jmp @nextch
@exitmac
               endm

; Copies up to 40 characters from /1 (offset in y) to /2
; Destroys a, x, y
defm           COPY40
               LDX #0
@nextch        LDA /1,y
               beq @start_over
               sta /2,x
               iny
               inx
               cpx #40
               beq @exitmac
               jmp @nextch

@start_over    ldy #0  ; start from the beginning of the string
               jmp @nextch

@exitmac
               endm


start
               COPY0 enemy,enemy_1_org
               COPY0 enemy_left,enemy_2_org
               COPY0 score,score_org
               COPY0 radar1,radar1_org
               COPY0 radar2,radar2_org
               COPY0 radar3,radar3_org
               COPY0 radar4,radar4_org

               ldx #40
               lda #99
horizon_loop   STA horizon_org,x
               dex
               bne horizon_loop

               COPY0 bottom_ret1,bottom_ret1_org
               COPY0 bottom_ret2,bottom_ret2_org
               COPY0 bottom_ret3,bottom_ret3_org

reset_bg
              LDY #0
              sty angle

bg_loop
               ; update the radar sweep
               inc sweep
               lda sweep
               and #96
               clc
               ror
               clc
               ror
               clc
               ror
               clc
               ror
               clc
               ror
               tax
               lda radar_sweep,x
               sta radar_sweep_org

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
               beq waiting
               COPY0_NOSPACE top_ret1,top_ret1_org
               COPY0_NOSPACE top_ret2,top_ret2_org
               COPY0_NOSPACE top_ret3,top_ret3_org

waiting        LDA 151
               cmp #$ff
;               beq waiting
               bne akey
               jmp bg_loop      ; redraw everything, so we can see the backround under the top reticle

akey           CMP #48     ; 0 = reset
               bne maybe_left
               jmp reset_bg

maybe_left     CMP #74     ; j
               bne maybe_right
               dec angle
               lda angle
               cmp #$ff
               beq goto_end
               jmp bg_loop

goto_end       LDY #BG_LENGTH
               sty angle
               jmp bg_loop

maybe_right    CMP #76     ; l
               bne maybe_quit
               inc angle
               lda angle
               cmp #BG_LENGTH+1
               beq jmp_reset_bg
               jmp bg_loop

maybe_quit     CMP #81  ;q
               beq quit

;maybe_toggle   CMP #84  ;t
;               bne jmp_bg_loop
;               sec
;               lda #1
;               sbc showtop
;               sta showtop

jmp_bg_loop    jmp bg_loop
jmp_reset_bg   JMP reset_bg

quit

polar_test     LDA #78
               sta angle2

polar_loop     ldx angle2
               dex
               ldy #5 ; radius
               ; theta in x, radius in y
               jsr from_polar
               ; add 32768+2*40+19 to polar_result
               ; = 32867, in hex, 8063
               clc
               lda #$64
               adc polar_result
               sta polar_result
               lda #$80
               adc polar_result+1
               sta polar_result+1
               ldy #0
               lda #"."
               sta (polar_result),y
               dec angle2
               bne polar_loop

               lda #"*"
               sta $8063
               rts

incasm "fixedpoint.asm"
incasm "trig.asm"

angle          byte 0
angle2 byte 0
showtop        byte 1

horizon_org        = 32767+40*14

radar1_org     = $8011
radar2_org     = radar1_org+41
radar3_org     = radar1_org+80
radar4_org     = radar1_org+162
radar1         byte $4d,$20,$5d,$20,$4e,0
radar2         byte $4d,$20,$4e,0
radar3         byte $40,$20,67,$20,$40,0
radar4         byte $5d, 0

radar_sweep_org  = radar3_org+2
sweep          byte 0
radar_sweep    byte 67,78,$5d,77
radar_sweep_len = 4

; bottom reticle
bottom_ret1_org = 32768+16*40+17
bottom_ret2_org = bottom_ret1_org+40
bottom_ret3_org = bottom_ret2_org+42
bottom_ret1    byte 101,$20,$20,$20,103,0
bottom_ret2    byte 99,99,$5D,99,99,0
bottom_ret3    byte $5d,0

; top reticle
top_ret1_org   = 32768+9*40+19
top_ret2_org   = top_ret1_org+40-2
top_ret3_org   = top_ret2_org+39
top_ret1       byte $5D,0
top_ret2       byte 100,100,93,100,100,0
top_ret3       byte 103,$20,$20,$20,$20,$20,101,0

enemy_1_org    = 32768
enemy          null 'enemy in range'
enemy_2_org    = 32768+80
enemy_right    null 'enemy to right'
enemy_left     null 'enemy to left'
enemy_rear     null 'enemy to rear'

score_org      = 32768+40+26
score          null 'score'

; backgrounds
bg_org          = 32768+8*40
BG_LENGTH       = 78
bgn            null '123456789012345678901234567890123456789012345678901234567890123456789012345678'
bg0            null 'UI               .                                                     .      '
bg1            null 'JK                             *             .                              . '
bg2            null '   NM     .                          W    NM    .                             '
bg3            null '  N  MNM               .  NMNM           N  MNM               Q  NMNM         '
bg4            text '',99,99,'   N  M     N',99,99,99,'M      N  M M',100,'      N',99,99,'   N  M     N',99,99,99,'M      N  M M',100,'      N',0
bg5            text '    N    M   N     ',99,'M   N    M  M NM N     N    M   N     ',99,'M   N    M  M NM N ',0
