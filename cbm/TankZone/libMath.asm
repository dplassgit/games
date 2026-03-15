; inputs: val1, val2, val3
; clears carry if val1 <= val2 < val3
; sets carry otherwise.
; does not affect other flags or registers.
is_between
        pha
        lda val2
        cmp val1
        blt not_between ; if val2<val1, we're outside

        cmp val3
        bge is_between_done; if val2>=val3, it's too big, (carry is already set)

        ; else, we're good. carry is clear, we're done.
        bcc is_between_done

not_between
        sec
        
is_between_done
        pla
        rts


val1 byte 0
val2 byte 0
val3 byte 0
val4 byte 0
