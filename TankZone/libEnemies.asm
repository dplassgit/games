incasm "macroMath.asm"

num_enemies     byte 0
; Whether this enemy exists
enemy_exists    dcb 10,0
; The theta is from 0 to $a0
enemy_theta     dcb 10,0
; The radius from -127 to +127
enemy_radius    dcb 10,0
; Equivalent x & y locations, maybe.
enemy_x         dcw 10,0
enemy_y         dcw 10,0
; Enumeration of enemy types
NONE=0
SQUARE_BLOCK=1
PYRAMID_BLOCK=2
TANK_ENEMY=3
UFO_ENEMY=4
TRIANGULAR_TANK_ENEMY=5
enemy_type      dcb 10,0
; Health level of each enemy
enemy_health    dcb 10,0

;; Create a random # of enemies and populate the arrays
;; Inputs: none
;; Outputs: none
;; Side effects: destroys a, x, y

create_enemies
                ; pick a random number
                ldx #5  ; decided by fair dice roll
                stx num_enemies
                ldx #0

create_enemy  
                lda #1
                sta enemy_exists,x
                RND
                sta enemy_health,x

                ; pick a radius
      ;          RND
                txa
                asl
                asl
                asl
                asl
                asl     ; * 32
                sta enemy_radius,x

                RND
                ; Change to a random number between 0 and 3
                and #3
                clc
                adc #1 ; now 1-4...ignore type 5 for now.
                sta enemy_type,x

     ;           RND
                txa
                asl
                asl
                asl
                asl     ; * 16
                ; can only go from 0 to 160, so if it's too big, truncate
                cmp #161
                blt store_theta
                sec
                sbc #160
store_theta     sta enemy_theta,x
                inx
                cpx num_enemies
                bne create_enemy
                rts


;; Plot all enemies in the polar circle
;; Inputs: none
;; Outputs: none
;; Side effects: destroys a, x, y
plot_enemies    lda #0  ; enemy #
                pha     ; stack has enemy #
                tax

next_enemy      ; x must be enemy # (index)
                lda enemy_radius,x
                lsr
                lsr
                lsr
                lsr
                lsr
                tay     ; radius in y
                lda enemy_theta,x
                tax
                ; theta in x, radius in y, output in polar_result
                jsr polar_to_screen

                ; poke it in the fake radar
                lda #<POLAR_CENTER ; sweep_org
                clc
                adc polar_result
                sta polar_result
                lda #>POLAR_CENTER ; sweep_org
                adc polar_result+1
                sta polar_result+1

                ldy #0
                ; TODO: use the enemy type for the plot
                ; lda #'x'
                pla ; a has index
                ; increase by 1, so we start plotting from "A" and not "@"
                clc
                adc #1
                sta (polar_result),y

                tax ; x has index
                pha ; push next index onto stack
                cmp num_enemies
                bne next_enemy

                pla ; whoops didn't need to push it two cycles ago.
                rts

;; For each enemy, update their theta by (delta?)
update_enemy_angles
                rts

;; For each enemy, update their radius by (delta)
;; 1. convert to x,y
;; 2. mumble something
;; 3. ???
;; 4. profit!
update_enemy_radii
                rts