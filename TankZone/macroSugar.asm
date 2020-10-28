; Branch less than
defm    blt
        bcc /1
endm

; Branch less than or equal to
defm    ble
        bcc /1
        beq /1
endm

; Branch greater or equal
defm    bge
        bcs /1
endm

; Branch greater than
defm    bgt
        beq @alreadyequal
        bcs /1
@alreadyequal
endm
