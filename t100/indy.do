10 cls:L=10:c=15:w=10:r=rnd(val(right$(time$,2)))
20 fori=1to100:?space$(l);"*";space$(c-l-1);"C";space$(L+w-C-1);"*";
30 ifimod10=0thenw=w+(i<50):?" Checkpt ";i\10:else?
40 r=rnd(1):if r<0.33 then L=L-1: else if r>0.67thenL=L+1
50 ifL<0thenL=0 else if L >= (40-W) then L=40-W
60 d$=inkey$:ifd$="h"thenc=c-1:elseifd$="l"thenc=c+1
70 if c<=l or c>=l+w then ?"CRASH! Final score is:";i:end
80 next:?"You win!":end
