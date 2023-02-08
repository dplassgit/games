10 cls:c=120:p=0:m=208:r=rnd(val(right$(time$,2))):a$=chr$(144):x=0:a=0: rem alien location
20 z=31:g$=inkey$:p=c:ifg$=" "then gosub 90 elseif g$="q"then stop
30 c=c+10*((g$="h")-(g$="l"))+(g$="j")-(g$="k"):ifc<zthenc=zelseifc>mthenc=m
40 line(p,27)-(p,35),-(p=c):line(p-4,z)-(p+4,z),-(p=c):
50 line(c,27)-(c,35):line(c-4,31)-(c+4,z): rem draw new cross hairs
60 ?@a," ":x=(x+1):?@x,a$:a=x:ifx=319then?"You lose!":end
70 rem do something here, or line 100-ish
80 goto20 :rem can do something else here too.
90 fori=1to4:line(c-z,0)-(c+z,62),i:line(c+z,0)-(c-z,62),i:next
100 return:rem test for hit alien and score
