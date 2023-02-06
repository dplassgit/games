1 cls:L=10:c=15:w=10:fori=1to100:?space$(l);"*";space$(c-l-1);"C";space$(L+w-C-1);"*"
3 ifimod10=0thenw=w-1
4 r=rnd(1):if r<0.33 then L=L-1: else if r>0.67thenL=L+1
5 ifL<0thenL=0
6 d$=inkey$:ifd$="h"thenc=c-1:elseifd$="l"thenc=c+1
7 if c<=l or c>=l+w then9
8 next:?"You win!":end
9 ?"CRASH! Score is ";i
