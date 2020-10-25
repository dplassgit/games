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
                ldx #10 ; decided by fair dice roll
                stx num_enemies

create_enemy  
                lda #1
                sta enemy_exists,x
                RND
                sta enemy_health,x

                ; pick a radius
                RND
                and #$7  ; TEMPORARY: only keep lower 4 bits
                sta enemy_radius,x

                RND
                ; Change to a random number between 0 and 3
                and #3
                clc
                adc #1 ; now 1-4...ignore type 5 for now.
                sta enemy_type,x

                RND
                ; can only go from 0 to 160, so if it's too big, truncate
                cmp #160
                bcc store_theta ;; blt
                lda #160
store_theta     sta enemy_theta,x
                dex
                bne create_enemy
                rts


;; Plot all enemies in the polar circle
;; Inputs: none
;; Outputs: none
;; Side effects: destroys a, x, y
plot_enemies    lda num_enemies
                pha     ; stack has # enemies
                tax

next_enemy      ; x must be enemy # (index)
                ldy enemy_radius,x
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
                lda #'x'
                sta (polar_result),y

                pla ; get index off stack
                tax ; x has index
                dex ; go to next index
                txa ; a has next index
                pha ; push next index onto stack
                bne next_enemy ; (flags from the dex)
                pla ; whoops didn't need to push it two cycles ago.
                rts
