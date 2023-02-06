0 onerrorgoto9:L=15:c=20:oc=c:w=10:r=rnd(val(right$(time$,2))):x$=chr$(132)
1 b$=chr$(255):cls:fori=1to110:if i<9 then?space$(L);b$;space$(w);b$:goto4
2 ?@oc+240," ";:?@L+280,b$;space$(C-L-1);x$;space$(L+W-C-1);b$;
3 ifi>19andimod10=0thenw=w+(i<60):?" Ck ";(i-10)\10:else?
4 r=rnd(1):L=L+(r<.25)-(r>.75):L=L-(L<0):ifL>=(40-W)then L=40-W
5 oc=c:if i>8 then d$=inkey$:c=c+(d$="h")-(d$="l"):next else next
6 ?@oc+240," ";:?@L+281,string$(oC-L,b$);x$;string$(L+W-OC,b$):?"You win!":end
9 ?:?"CRASH! Final score is:";i-10:end
