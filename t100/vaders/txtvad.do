0 cls:n=9:fori=0ton:a(i)=3*(imod5)+80*(i\5)+40:next:l$="XXX":?chr$(27)"VXXX 0
10 fori=0ton:?@a(i)," ":a(i)=a(i)+1:?@a(i),chr$(144+c):next
30 ifb=0then50else?@b," ":b=b-40:ifb<40thenb=0:goto50
40 ifpeek(b-512)=32then?@b,"*":goto50:else?@0,L$;s+10:?@b," "
45 s=s+10:fori=0ton:ifa(i)=bthena(i)=a(n):next:elsenext:n=n-1:b=0
50 h=h+1:k$=inkey$:ifk$<>""thenm$=k$:ifm$=" "andb=0thenb=t+260
60 ifm$="j"orm$="l"then?@t+300,"  ":t=t+(m$="j")-(m$="l")
70 t0=t:t=t-(t<-20)+(t>18):?@t+300,"/\":ifm$=" "ort0<>tthenm$=""
80 ifh>n*2thenc=1-c:h=0:goto10else30
