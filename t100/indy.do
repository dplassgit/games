0cls:onerrorgoto9:s=15:c=20:p=c:w=11:?"INDY! Use 'a' for left, 'd' for right."
1?"Make it past all 10 checkpoints to win!":?:?"Hit any key to start..."
2s$=" ":r=rnd(val(right$(time$,2))):x$=chr$(132):d$=inkey$:ifd$=""then2
3b$=chr$(255):fori=1to110:ifi<9then?space$(s);b$;space$(w);b$:c=s+w\2:goto6
4?@p+240,s$;:?@s+280,b$;space$(c-s-1);x$;space$(s+w-c-1);b$;
5ifi>19andimod10=0thenw=w+(i<80):?" Ck";(i-10)\10:else?
6r=rnd(1):s=s+(r<.3)-(r>.7):s=s-(s<0):ifs>=(35-w)thens=35-w
7p=c:ifi>8thend$=inkey$:c=c+(d$="h"ord$="a")-(d$="l"ord$="d")
8next:?@p+240,s$;:?@s+281,string$(p-s,b$);x$;string$(s+w-p,b$):?"You win!":end
9?:?"CRASH! Final score is:";i-10:end
