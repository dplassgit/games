0 print "{clear}"
5 w=38: w1=w+1: al=5: rem width, a-length
10 i=0
15 a$(0)="UI               .                                                     .      "
20 a$(1)="JK                             *             .                              . "
25 a$(2)="   NM     .                          W    NM    .             Q               "
30 a$(3)="  N  MNM               .  NMNM           N  MNM                  NMNM         "
35 a$(4)="{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N"
40 a$(5)="    N    M   N     {163}M   N    M  M NM N     N    M   N     {163}M   N    M  M NM N "
45 ml=len(a$(0)): rem max len

50 b$="": for i = 0 to w: b$=b$+"{163}": next
60 a=0: gosub 100: ?b$
70 rem this is the bottom reticle.
70 rem ?: ?"                 N   M"
70 ?: ?"                 {$A5}   {$A7}"
80 ?"                 {$A3}{$A3}{$DD}{$A3}{$A3}"
85 ?"                   {$DD}"

90 ac=0: goto 300 rem acceleration

100 rem show the background. This is at line 100 to make it faster.
100 print "{home}{down}{down}{down}{down}{down}{down}"
110 as=a+1:ab=0:if as+w>ml then ab=(as+w)-ml: rem we need to get more from the front
120 for i = 0 to al: a$=mid$(a$(i),as,w1) :if ab > 0 then a$=a$+left$(a$(i),ab)
131 if i=1 then a$=left$(a$,19)+"{$DD}"+right$(a$,19):goto 135
132 if i=2 then a$=left$(a$,17)+"{164}{164}{$DD}{164}{164}"+right$(a$,17):goto 135
133 if i=3 then a$=left$(a$,17)+"{$A5}   {$A7}"+right$(a$,17)
135 ? a$
140 next i
141 rem print "{home}{down}{down}{down}{down}{down}{down}{down}{164}{164}{$DD}{164}{164}"
141 rem if i=0 then a$=left$(a$,19)+"{$DD}"+right$(a$,19)
141 rem if i=1 then a$=left$(a$,17)+"{164}{164}{$DD}{164}{164}"+right$(a$,17)
141 rem if i=2 then a$=left$(a$,17)+"{$A5}   {$A7}"+right$(a$,17)
150 rem redraw the top reticle
151 rem poke 33107,93
152 rem poke 33145, 100: poke 33146, 100: poke 33147,93:poke 33148, 100: poke 33149, 100
153 rem poke 33185, 101: poke 33189, 103
199 return

300 rem MAIN LOOP:
300 get d$: rem keeps turning in the current direction
310 if d$="j" then ac=ac+2: goto 330
315 if d$="l" then ac=ac-2: goto 330
320 if d$="," then ac=ac+1: goto 330
325 if d$="." then ac=ac-1
330 if ac > 4 then ac = 4
340 if ac < -4 then ac = -4
350 a=a+ac
355 if a >= ml then a = a - ml: goto 370
360 if a < 0 then a = a + ml
370 if ac <> 0 then gosub 100
390 goto 300
