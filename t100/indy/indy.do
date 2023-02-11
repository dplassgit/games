0cls:definta-z:s=15:w=11:?"INDY!":?:?"Make it past all 10 checkpoints to win!
1p=c:?:?"Use 'a' to steer left, 'd' for right.":?:?"Hit any key to start...
2c=20:p=c:h=w/2:s$=" ":x$=chr$(132):b$=chr$(255):r!=rnd(peek(63795)):call4811
3fori=0to110:ifi<10then?tab(s)b$space$(h-2)10-ispace$(h-(i>0)-1)b$:c=s+h:next
4?@p+240,s$;:?@s+280,b$space$(w)b$;:?@c+280,x$;:ifc<=sorc>s+wthen9
5ifi>19andimod10=0thenw=w+(i<80):?@285+s+w,"Ck"(i-10)\10:else?
6r!=rnd(1):s=s+(r!<.3)-(r!>.7):s=s-(s<0):ifs>=(35-w)thens=35-w
7p=c:d$=inkey$:c=c+(d$="h"ord$="a")-(d$="l"ord$="d")
8next:?@p+240,s$;:?@s+280,b$string$(w,b$)b$;:?@c+280,x$:?"You win!":end
9?:?"CRASH! Final score is:"i-10
