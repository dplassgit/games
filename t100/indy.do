0cls:s=15:c=20:p=c:w=11:?"INDY!":?:?"Make it past all 10 checkpoints to win!
1?:?"Use 'a' to steer left, 'd' for right.":?:?"Hit any key to start...
2s$=" ":x$=chr$(132):b$=chr$(255):r=rnd(peek(63795)):call4811:h=w\2
3fori=0to110:ifi<10then?tab(s)b$;space$(h-1);10-i;space$(h-1)b$;i:c=s+h:goto6
4?@p+240,s$;:?@s+280,b$;space$(w)b$;i;:?@c+280,x$;:ifc<=sorc>s+wthen9
5ifi>19andimod10=0thenw=w+(i<80):?@285+s+w,"Ck"(i-10)\10:else?
6r=rnd(1):s=s+(r<.3)-(r>.7):s=s-(s<0):ifs>=(35-w)thens=35-w
7p=c:ifi>9thend$=inkey$:c=c+(d$="h"ord$="a")-(d$="l"ord$="d")
8next:?@p+240,s$;:?@s+280,b$;string$(w,b$)b$;:?@c+280,x$:?"You win!":end
9?:?"CRASH! Final score is:"i-10
