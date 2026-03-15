0 print "{clear}";
5 w=38: w1=w+1: bl=5: rem width, background-length
10 dim th(10), r(10): ne=2: rem theta (from zero, radians), radius of each enemy.
15 bg$(0)=".UI               .                                                     .      "
20 bg$(1)=".JK                             *             .                              . "
25 bg$(2)=".   NM     .                          W    NM    .             Q               "
30 bg$(3)=".  N  MNM               .  NMNM           N  MNM                  NMNM         "
35 bg$(4)=".{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N"
40 bg$(5)=".    N    M   N     {163}M   N    M  M NM N     N    M   N     {163}M   N    M  M NM N "
41 ml=len(bg$(0)): rem max len
42 for i = 0 to ne: th(i)=2*{pi}*rnd(0): r(i)=2*rnd(0): next i

51 rem radar
51 ?"enemy in range   {$CD} {$DD} {$CE}"
52 ?"                  {$CD} {$CE}"
53 ?"                 {$C0} * {$C0}"
54 ?
55 ?"                   {$DD}"

60 a=0: rem "angle" from 0 to ml
65 ac=0: rem ac=acceleration
70 rem horizon
70 ho$="": for i = 0 to w: ho$=ho$+"{163}": next
75 gosub 100: ?ho$
80 rem bottom reticle.
80 rem alternate ?: ?"                 N   M"
80 ?: ?"                 {$A5}   {$A7}"
85 ?"                 {$A3}{$A3}{$DD}{$A3}{$A3}"
90 ?"                   {$DD}"
95 goto 300

100 rem Show the background. This is at line 100 to make it faster.
100 print "{home}{down}{down}{down}{down}{down}{down}{down}"
110 as=a+1:ab=0:if as+w>ml then ab=(as+w)-ml: rem we need to get more from the front
120 for i = 0 to bl: bg$=mid$(bg$(i),as,w1) :if ab > 0 then bg$=bg$+left$(bg$(i),ab)
131 if i=1 then bg$=left$(bg$,19)+"{$DD}"+right$(bg$,19):goto 135
132 if i=2 then bg$=left$(bg$,17)+"{164}{164}{$DD}{164}{164}"+right$(bg$,17):goto 135
133 if i=3 then bg$=left$(bg$,17)+"{$A5}   {$A7}"+right$(bg$,17)
135 ? bg$
140 next i: goto 199
141 rem redraw the top reticle
141 rem print "{home}{down}{down}{down}{down}{down}{down}{down}{164}{164}{$DD}{164}{164}"
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
370 if ac <> 0 then gosub 100: gosub 400
390 goto 300

400 rem show the radar. boy howdy is this slow
400 aw=2*{pi}*(a/ml): for i = 0 to ne
410 x = r(i)*cos(th(i)+aw): y = int(r(i)*sin(th(i)+aw))
411 rem ?"r=";r(i);" th=";th(i)
415 rem ?"x=";x;" y=";y
420 poke 32768+(2+y)*40+19+x, i
430 next i
440 return


