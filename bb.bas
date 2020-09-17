5 bat$="{$c0}{$ce}{$dd}{$cd}{$dd}{$ce}{$c0}"
100 print "{CLS}"
101 rem print "         this bud's for you!|"
101 print "         {$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}{$a4}"
102 print "        N                    M"
103 print "       N           Q          M"
104 print "      N                        M"
105 print "     N                          M"
106 print "    N                            M"
107 print "   N     Q                        M"
108 print "   M              NM        Q     N"
109 print "    M            NMNM            N"
110 print "     M          N    MQ         N"
111 print "      M       QN      M        N"
112 print "       M      N        M      N"
113 print "        M    N          M    N"
114 print "         M  N           QM  N"
115 print "          MNMQ    UQ     NMN"
116 print "           MN     JK     MN"
117 print "            M            N"
118 print "             M          N"
119 print "              M        N"
120 print "               M      N"
121 print "                M    N"
122 print "                 MOPN"
123 print "                  MN"
124 print "                 W{$c0}Q"

125 goto 170
150 ba=1: gosub 200
151 ba=2: gosub 200
152 ba=3: gosub 200
153 ba=0: gosub 200
155 for i = 1 to -1000: next
160 ba=0: gosub 250
161 ba=1: gosub 250
162 ba=2: gosub 250
163 ba=3: gosub 250

170 gosub 1000: goto 170

200 rem light a base. base number in 'ba'
200 b0=233: b1=223: b2=95: b3=105
210 if ba=0 then b0=160: b1=160: rem home, override
220 goto 300

250 rem unlight a base. base number in 'ba'
250 b0=78: b1=77: b2=77: b3=78
260 if ba=0 then b0=79: b1=80: rem home, override
270 goto 300

300 rem light or unlight a base. base in ba, chars in b0-b3
300 if ba=0 then y=21: x=18: rem home
310 if ba=1 then y=14: x=25: rem first
315 if ba=2 then y=7: x=18: rem second
320 if ba=3 then y=14: x=11: rem third
330 poke 32768+y*40+x,b0
331 poke 32768+y*40+x+1,b1
332 poke 32768+(y+1)*40+x,b2
333 poke 32768+(y+1)*40+x+1,b3
350 return

1000 rem pitch/bat, main loop
1000 get c$: if c$ >= "1" then if c$ <= "3" goto 1030
1020 goto 1000
1030 delay=20+40*(asc(c$)-asc("1"))
1035 sw=0 : rem swing state; 0 = not swung yet
1040 bc=19: rem ball column
1045 pc=peek(32768 + 14*40+bc) : rem stash prev character (pc)
1050 for br = 0 to 9: rem relative row of pitched ball
1060 poke 32768+(14+br)*40+bc, pc
1070 pc=peek(32768 + (15+br)*40+bc)
1080 rem todo: curve ball
1080 poke 32768 + (15+br)*40+bc, 46
1100 for j = 1 to delay: next j
1120 if sw=0 then get c$: if c$ <>"s" goto 1170
1130 rem swing & if on the right row decide if hit
1130 rem the br=br+1 is so that the prev char is put back in the right place.
1130 hit = 0: gosub 1500: if hit=1 then br=br+1: goto 1180
1170 next br

1180 poke 32768 +(14+br)*40+bc,pc
1190 sw=1: gosub 1600: rem reset bat
1479 poke 32769,42: rem wait
1480 for j=1 to 1000: next j : rem pause between pitches
1481 poke 32769,32: rem go
1490 poke 32768,32
1499 return

1500 rem swing. param: sw
1500 if sw < len(bat$) then sw=sw+1: gosub 1600
1510 rem decide if hit the ball. for now, if s=2 when br=7, it's contact
1520 if sw=2 then if br=7 then poke 32768,8: hit=1
1599 return

1600 rem move bat. param: sw
1600 poke 32768+23*40+18,asc(mid$(bat$,sw,1))-128
1610 return
