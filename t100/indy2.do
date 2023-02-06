5 onerrorgoto90:L=15:c=20:oc=c:w=10:r=rnd(val(right$(time$,2))):rc$=chr$(132)
20 cls:fori=1to110:if i<9 then?space$(l);"*";space$(w);"*":goto50
30 ?@(oc+240)," ";:?@(L+280),"*";space$(C-L-1);rc$;space$(L+W-C-1);"*";
40 ifi>19andimod10=0thenw=w+(i<50):?" Ck ";(i-10)\10:else?
50 r=rnd(1):L=L+(r<.25)-(r>.75):L=L-(L<0):ifL>=(40-W)then L=40-W
60 oc=c:if i>8 then d$=inkey$:c=c+(d$="h")-(d$="l")
80 next:?"You win!":end
90 ?:?"CRASH! Final score is:";i-10:end
