0 cls:n=9:fori=0ton:a(i)=3*(imod4)+40*(i\4)+55:next:?3-l;schr$(27)"V
10 fori=0ton:?@a(i)," ":a(i)=a(i)+1:?@a(i),chr$(144+c):next
20 ifb=0then50elseifpeek(b-512)=42then?@b," ":b=b-40:ifb<40thenb=0:goto50
30 ifpeek(b-512)=32then?@b,"*":goto50:else?@b,"x":fori=0ton
35 ifa(i)=bthena(i)=a(n):?@b," ":s=s+10:?@0,3-l;s
40 next:b=0:n=n-1:ifn=-1thenL=L-1:goto0
50 h=h+1:k$=inkey$:ifk$<>""thenm$=k$:ifm$=" "andb=0thenb=t+260:?@b,"*"
60 t0=t:t=t+(m$="j")-(m$="l"):ift<>t0then?@t0+300, "  ";
70 t0=t:t=t-(t<-20)+(t>18):?@t+300,"/\";:ifb<>0ort0<>tthenm$=""
80 ifh>nthenc=1-c:h=0:goto10else20
