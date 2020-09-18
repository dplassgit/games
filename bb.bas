5 bat$="{$c0}{$ce}{$dd}{$cd}{$dd}{$ce}{$c0}"

10 v$="nyy": input "visiting team (3-letters)"; v$
20 if len(v$)<>3 then print "wrong length, sorry!": goto 10
30 h$="nym": input "home team"; h$
40 if len(h$)<>3 then print "wrong length, sorry!": goto 30

100 print field
100 gosub 5000
110 gosub 6000
120 rem strikes, balls, outs, inning, team (0=vis,1=home)
120 s=0:b=0:ou=0:in=1:t=0
130 gosub 1200
140 rem hits, runs, errors (per team)
140 dim h(2), r(2), e(2)

200 rem main loop
200 hit=0: sw=1: gosub 1600: gosub 1000: rem pitch
210 on hit+1 goto 500, 220, 300: rem no swing, swing&miss, contact

220 rem strike
220 rem TODO: identify strike
220 poke 32768,19: rem strike TEMPORARY
230 s=s+1: gosub 1200
240 if s<3 goto 299: rem else strikeout

250 rem an out
250 s=0:b=0:ou=ou+1: gosub 1200: if ou=3 then s=0:b=0:ou=0: gosub 1200
260 if ou=0 then t=1-t: if t=0 then in = in + 1: if in<10 then gosub 1200
299 goto 900

300 rem made contact - may be a hit or an out
300 if rnd(0) <= 0.3 goto 400
310 rem out
310 rem TODO: identify type of out
320 poke 32768,15: rem out TEMPORARY
330 goto 250

400 rem actual hit
400 rem TODO: identify type of hit
410 nb=int(4*rnd(0))+1: poke 32768,nb+asc("0"): rem TEMPORARY
420 gosub 1300
430 s=0:b=0:h(t)=h(t)+1: gosub 1200
499 goto 900

500 rem didn't swing - ball or strike?
500 if rnd(0) < 0.5 goto 220: rem strike
510 rem ball
510 rem TODO: identify ball
510 poke 32768,2: rem ball TEMPORARY
520 b=b+1: gosub 1200
530 if b < 4 goto 499
540 rem walked
540 s=0: b=0: gosub 1200: nb=1: gosub 1300
599 goto 900

900 poke 32769,42: rem TEMPORARY wait indicator
910 rem pause between pitches
920 for j=1 to 1000: next
930 rem clear indicators
940 poke 32769,32: poke 32768,32
950 goto 200

1000 rem pitch/bat loop. Sets "hit" (0=no swing, 1=miss, ...10=hit)
1000 get c$: if c$ >= "1" then if c$ <= "3" goto 1030
1020 goto 1000
1030 delay=20+40*(asc(c$)-asc("1"))
1040 bc=19: rem ball column
1045 pc=peek(32768+14*40+bc): rem stash prev character (pc)
1050 for br = 0 to 8: rem relative row of ball
1060 poke 32768+(14+br)*40+bc, pc
1070 pc=peek(32768 + (15+br)*40+bc)
1080 rem todo: curve ball
1080 poke 32768+(15+br)*40+bc, 46
1100 for j = 1 to de: next j
1120 if sw=1 then get c$: if c$ <>"s" goto 1170
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
1210 poke 32768+1*40+37,b+asc("0")
1220 poke 32768+2*40+37,s+asc("0")
1230 poke 32768+3*40+37,ou+asc("0")
1299 return

1300 rem advance base runners. # of bases=nb
1300 if nb>1 then for ba=0 to nb-2: gosub 1700: for j=1 to 500: next j: gosub 1800: next ba
1310 ba=nb-1: gosub 1700
1320 rem todo: fix base running.
1399 return

1500 rem swing. param: sw
1500 if sw < len(bat$) then sw=sw+1: gosub 1600
1510 rem decide if hit the ball. for now, if s=2 when br=7, it's contact
1520 rem 1=miss, 2=hit, for now. eventually we'll have different strengths/levels
1520 hit=1: if sw=2 then if br=7 then hit=2
1599 return

1600 rem move bat. param: sw
1600 poke 32768+23*40+18, asc(mid$(bat$,sw,1))-128
1610 return

1700 rem light a base. base number in ba(0=first, 3=home)
1700 b0=233: b1=223: b2=95: b3=105
1710 if ba=3 then b0=160: b1=160: rem home, override
1720 goto 1900

1800 rem unlight a base. base number in ba
1800 b0=78: b1=77: b2=77: b3=78
1810 if ba=3 then b0=79: b1=80: rem home, override

1900 rem light or unlight a base. base in ba, chars in b0-b3
1900 if ba=3 then y=21: x=18: rem home
1910 if ba=0 then y=14: x=25: rem first
1915 if ba=1 then y=7: x=18: rem second
1920 if ba=2 then y=14: x=11: rem third
1930 poke 32768+y*40+x,b0: poke 32768+y*40+x+1,b1: poke 32768+(y+1)*40+x,b2: poke 32768+(y+1)*40+x+1,b3:return

5000 print "{CLS}"
5010 rem print "         this bud's for you!|"
5010 print "         {$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}"
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
5140 print "         M  N     NM    QM  N"
5150 print "          MNMQ   {167} Q{165}    NMN"
5160 print "           MN     MN     MN"
5170 print "            M            N"
5180 print "             M          N"
5190 print "              M        N"
5200 print "               M      N"
5210 print "                M    N       r  h  e"
5220 print "                 MOPN      {176}{192}{192}{178}{192}{192}{178}{192}{192}{174}"    
5230 print "                  MN   ";v$;":{221} 0{221} 0{221} 0{221}"
5240 print "                 W     ";h$;":{221} 0{221} 0{221} 0{221}"
5250 print "                   Q       {173}{192}{192}{177}{192}{192}{177}{192}{192}{189}{HOME}";
5999 return

6000 ba=0: gosub 1700
6001 ba=1: gosub 1700
6002 ba=2: gosub 1700
6003 ba=3: gosub 1700
6005 for i = 1 to 500: next
6010 ba=0: gosub 1800
6011 ba=1: gosub 1800
6012 ba=2: gosub 1800
6013 ba=3: gosub 1800
6999 return
