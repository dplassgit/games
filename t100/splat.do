5 cls:c=31:oc=0:goto55
10 g$=inkey$:ifg$=""goto10
12 ?@0,c,oc
20 oc=c:ifg$=" " then gosub 100: rem FIRE
30 if g$="h" then c=c-1
40 if g$="l" then c=c+1
50 if g$="q" then stop
52 ifoc<>c then line(oc,27)-(oc,35),0:line(oc-4,31)-(oc+4,31),0: rem erase old cross hairs
55 line(c,27)-(c,35):line(c-4,31)-(c+4,31): rem draw new cross hairs
60 goto10
100 fori=1to2:line(c-31,0)-(31+c,62),i:line(c+31,0)-(c-31,62),i
105 fort=1to100:next:next:return
