0 print "{clear}"
5 w=38: al=5: rem width, a-length
10 i=0
11 a$(0)="UI               .                                                     .      "
12 a$(1)="JK                             *             .                              . "
30 a$(2)="   NM     .                          W    NM    .             Q               "
40 a$(3)="  N  MNM               .  NMNM           N  MNM                  NMNM         "
50 a$(4)="{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N"
60 a$(5)="    N    M   N     {163}M   N    M  M NM N     N    M   N     {163}M   N    M  M NM N "
80 ml=len(a$(0)): rem max len

90 b$="": for i = 0 to w: b$=b$+"{163}": next

100 a=0: gosub 1000: ?b$
160 ?: ?"                 N   M"
160 ?: ?"                 {$A5}   {$A7}"
170 ?"                 {$A3}{$A3}{$DD}{$A3}{$A3}"
180 ?"                   {$DD}"

190 ac=0: rem acceleration

200 get d$: rem keeps turning in the current direction
210 if d$="j" then ac=ac+2: goto 230
215 if d$="l" then ac=ac-2: goto 230
220 if d$="," then ac=ac+1: goto 230
225 if d$="." then ac=ac-1
230 if ac > 4 then ac = 4
240 if ac < -4 then ac = -4
250 a=a+ac
255 if a >= ml then a = a - ml: goto 290
260 if a < 0 then a = a + ml
290 gosub 1000: goto 200

1000 rem pick a location and start showing from there.
1000 print "{home}{down}{down}{down}{down}{down}{down}"
1010 as=a+1:ab=0:if as+w>ml then ab=(as+w)-ml: rem we need to get more from the front
1020 for i = 0 to al: a$=mid$(a$(i),as,w+1) :if ab > 0 then a$=a$+left$(a$(i),ab)
1031 rem if i=1 then a$=left$(a$,19)+"{$DD}"+right$(a$,19)
1032 rem if i=2 then a$=left$(a$,17)+"{164}{164}{$DD}{164}{164}"+right$(a$,17)
1033 rem if i=3 then a$=left$(a$,17)+"{$A5}   {$A7}"+right$(a$,17)
1035 ? a$
1040 next i
1041 rem if i=0 then a$=left$(a$,19)+"{$DD}"+right$(a$,19)
1042 rem if i=1 then a$=left$(a$,17)+"{164}{164}{$DD}{164}{164}"+right$(a$,17)
1043 rem if i=2 then a$=left$(a$,17)+"{$A5}   {$A7}"+right$(a$,17)
1041 rem print "{home}{down}{down}{down}{down}{down}{down}{down}{164}{164}{$DD}{164}{164}"
1050 poke 33145, 100: poke 33146, 100: poke 33147,93:poke 33148, 100: poke 33149, 100
1051 poke 33185, 101: poke 33189, 103
1099 return
