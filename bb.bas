1 print "{cls}"
5 bat$="{$c0}{$ce}{$dd}{$cd}{$dd}{$ce}{$c0}":v$="nyy":h$="nym"
6 ix$(1)="1st":ix$(2)="2nd":ix$(3)="3rd"
7 ht$(1)="single":ht$(2)="double!":ht$(3)="triple!!":ht$(4)="home run!!!"
10 dim h(2), r(2), e(2)
19 goto 100

20 v$="nyy": input "visiting team (3-letters)"; v$
30 if len(v$)<>3 then print "wrong length, sorry!": goto 20
40 h$="nym": input "home team"; h$
50 if len(h$)<>3 then print "wrong length, sorry!": goto 40

100 rem print field
100 gosub 5000: gosub 6000
120 rem strikes, balls, outs, inning, team (0=vis,1=home)
120 s=0:b=0:ou=0:in=1:gosub 1620: t=0
130 gosub 1200: gosub 1250

200 rem main loop
200 hit=0: sw=1: gosub 1600: gosub 1000: rem pitch
210 on hit+1 goto 500, 220, 300: rem no swing, swing&miss, contact

220 rem strike
220 me$="strike "+str$(s+1)+"!": gosub 2000
230 s=s+1: gosub 1200
240 if s<3 goto 299: rem else strikeout
245 me$="strikeout!": gosub 2000

250 rem an out
250 s=0:b=0:ou=ou+1: gosub 1200
260 if ou<>3 goto 299
270 rem 3 outs, switch sides, clear men on base
270 s=0:b=0:ou=0: gosub 1200: for ba=1 to 4: gosub 1800: next
280 t=1-t: gosub 1250
285 if t=1 then me$="middle of "+in$: gosub 2000
290 if t=0 then me$="end of "+in$: gosub 2000: in=in+1: gosub 1620:if in<10 then gosub 1200
299 rem fix extra innings, end of game, etc.
299 goto 900

300 rem made contact - may be a hit or an out
300 if rnd(0) <= 0.5 goto 400: yes this is a really good batting average
310 rem out
310 rem line drive = 21%. ground ball = 44%. fly ball=35%. infield fly=11% of the 35%
315 ot=rnd(0): rem out type
320 if ot<=0.44 then me$="ground out": gosub 2000: goto 399: rem ground out, oppty for double play
330 if ot<=0.65 then me$="line drive out!": gosub 2000: goto 399
340 if ot>0.99 then me$="infield pop up": gosub 2000: goto 399
345 if ot>0.98 then me$="fouled out": gosub 2000: goto 399
350 if ou<2 and peek(33339)=233 and rnd(0)<0.75 then me$="sac fly!": gosub 2000: gosub 1610: goto 399
360 me$="fly ball...out!": gosub 2000: goto 399
399 goto 250

400 rem actual hit
400 nb=int(4*rnd(0))+1: rem todo: change % of each type of hit
410 if nb=4 then print "{home}         {rvs}this bud's for you! {roff}"
420 me$=ht$(nb): gosub 2000
430 gosub 1300: rem move baserunners
440 s=0:b=0:h(t)=h(t)+1: gosub 1200: gosub 1250
450 if nb=4 then print "{home}         {rvs}{233} a plass program  {223}{roff}"
499 goto 900

500 rem didn't swing - ball or strike?
500 if rnd(0) < 0.5 goto 220: rem strike (mlb average 62% strikes)
510 rem ball
510 b=b+1: gosub 1200
520 me$="ball"+str$(b): gosub 2000
530 if b < 4 goto 599
540 rem walked
540 me$="walk": gosub 2000
550 s=0: b=0: gosub 1200: walk=1:nb=1: gosub 1300: walk=0
599 goto 900

900 rem poke 32769,42: rem temporary wait indicator
940 rem poke 32769,32:poke 32768,32: rem clear indicators temporary
950 goto 200

1000 rem pitch/bat loop. Sets "hit" (0=no swing, 1=miss, 2..10=hit)
1000 get c$: if c$ >= "1" and c$ <= "3" goto 1030
1020 goto 1000
1030 delay=10+40*(asc(c$)-asc("1"))
1040 bc=18: rem ball column
1045 pc=peek(32768+14*40+bc): rem stash prev character (pc)

1050 for br = 0 to 8: rem relative row of ball
1060 poke 32768+(14+br)*40+bc, pc
1070 pc=peek(32768 + (15+br)*40+bc)
1080 rem todo: curve ball
1080 poke 32768+(15+br)*40+bc, 46
1100 for j = 1 to de: next j
1120 if sw=1 then get c$: if c$ <> "s" goto 1170
1130 rem swing & if on the right row decide if hit
1130 rem the br=br+1 is so that the prev char is put back in the right place.
1130 gosub 1500: if hit>1 then br=br+1: goto 1180
1170 next br

1180 rem pitch is over
1180 poke 32768+(14+br)*40+bc, pc
1190 sw=1: gosub 1600: rem reset bat
1199 return

1200 rem update in,b,s,o
1200 print "{home}{down}{right}{right}{right}{right}";in
1205 poke 32845,b+asc("0"):  rem poke 32768+   40+37,b+asc("0")
1210 poke 32885,s+asc("0"):  rem poke 32768+ 2*40+37,s+asc("0")
1215 poke 32925,ou+asc("0"): rem poke 32768+ 3*40+37,ou+asc("0")
1219 return

1250 rem update r,h,e
1250 loc=32768+22*40+28: va=r(0): gosub 1280
1255 loc=loc+40: va=r(1): gosub 1280
1260 loc=32768+22*40+31: va=h(0): gosub 1280
1265 loc=loc+40: va=h(1): gosub 1280

1270 rem change the star
1275 poke 32768+(t+22)*40+37,42: poke 32768+(23-t)*40+37,32
1279 return

1280 rem draw an up-to-2-digit number. params: loc, va
1280 if va>9 then tens=int(va/10): poke loc,tens+asc("0"): va=va-10*tens
1285 poke loc+1, va+asc("0"): return

1300 rem advance base runners. # of bases=nb. todo: walk=walk
1300 m1=peek(33353)=233: rem first
1305 rem only move players first is occupied
1305 if m1=-1 then gosub 1400
1310 rem bb=batter base. light first
1310 bb=1: ba=1: gosub 1700
1320 rem move the batter until they've gone the right number of bases
1320 if bb<>nb then bb=bb+1: gosub 1400: goto 1320
1340 rem randomly move player home or a player to a next base
1399 rem todo: how to deal with steals or moving too far
1399 return

1400 rem all move players one base each. 
1400 rem in the future make it random (only move if they have to)
1400 m3=peek(33339)=233:m2=peek(33066)=233:m1=peek(33353)=233
1410 rem if man on 3rd, clear 3rd, light home, update score, clear home
1410 if m3=-1 then gosub 1610: rem score
1420 rem else if man on 2nd, clear 2nd, light 3rd
1420 if m2=-1 then ba=2: gosub 1800: ba=3: gosub 1700
1430 rem else if man on 1st, clear 1st, light 2nd
1430 if m1=-1 then ba=1: gosub 1800: ba=2: gosub 1700
1499 return

1500 rem swing. param: sw
1500 if sw<len(bat$) then sw=sw+1: gosub 1600
1510 rem decide if hit the ball. for now, if s=2 when br=7, it's contact
1520 rem 1=miss, 2=hit, for now. eventually we'll have different strengths/levels
1520 hit=1: if sw=2 and br=7 then hit=2
1599 return

1600 rem move bat. param: sw rem poke 32768+23*40+18, asc(mid$(bat$,sw,1))-128
1600 poke 33706, asc(mid$(bat$,sw,1))-128: return

1610 rem score from 3rd
1610 ba=3: gosub 1800: ba=4: gosub 1700: r(t)=r(t)+1: gosub 1250: gosub 1800: return

1620 rem update the inning string in$
1620 if in<=3 then in$=ix$(in): return
1621 in$=str$(in)+"th": return

1700 rem light a base. base number in ba
1700 b0=233: b1=223: b2=95: b3=105
1710 if ba=4 then b0=160: b1=160: rem home, override
1720 goto 1900

1800 rem unlight a base. base number in ba
1800 b0=78: b1=77: b2=77: b3=78
1810 if ba=4 then b0=79: b1=80: rem home, override

1900 rem light or unlight a base. base in ba, chars in b0-b3.
1901 if ba=1 then ul=33353: rem: 32768+14*40+25: rem first
1902 if ba=2 then ul=33066: rem: 32768+ 7*40+18: rem second
1903 if ba=3 then ul=33339: rem: 32768+14*40+11: rem third
1904 if ba=4 then ul=33626: rem: 32768+21*40+18: rem home
1910 poke ul,b0: poke ul+1,b1: poke ul+40,b2: poke ul+41,b3:return

2000 rem show message. param: me$
2000 print "{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}";me$
2005 for i=0 to 1000: next
2010 print "{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}                 "
2015 return

5000 print "{clr}"
5010 print "         {$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}"
5010 print "         {rvs}{233} a plass program  {223}{off}"
5020 print "inn: 0  N                    M    b: 0"
5030 print "       N           Q          M   s: 0"
5040 print "      N                        M  o: 0"
5050 print "     N                          M"
5060 print "    N                            M"
5070 print "   N     Q                        M"
5080 print "   M              NM        Q     N"
5090 print "    M            NMNM            N"
5100 print "     M          N    MQ         N"
5110 print "      M       QN      M        N"
5120 print "       M      N        M      N"
5130 print "        M    N          M    N"
5140 print "         M  N     NM     MQ N"
5150 print "          MNMQ   {167}Q {165}    NMN"
5160 print "           MN     MN     MN"
5170 print "            M            N"
5180 print "             M          N"
5190 print "              M        N"
5200 print "               M      N"
5210 print "                M    N       r  h  e"
5220 print "                 MOPN      {176}{192}{192}{178}{192}{192}{178}{192}{192}{174}"    
5230 print "                  MN   ";v$;":{221} 0{221} 0{221} 0{221}"
5240 print "                 W     ";h$;":{221} 0{221} 0{221} 0{221}"
5250 print "                  Q        {173}{192}{192}{177}{192}{192}{177}{192}{192}{189}{HOME}";
5999 return

6000 ba=1: gosub 1700
6001 ba=2: gosub 1700
6002 ba=3: gosub 1700
6003 ba=4: gosub 1700
6005 for i = 1 to 500: next
6010 ba=1: gosub 1800
6011 ba=2: gosub 1800
6012 ba=3: gosub 1800
6013 ba=4: gosub 1800
6999 return
