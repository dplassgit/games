0 cls:t=300:f=40:n=8:fori=0to9:a(i)=f+3*(imod5)+f*(i\5):next:d=1:?chr$(27)"V
10 remifa(7)modf>30ora(0)modf<11thenfori=0to7:ifb(i)then?@a(i)," ":a(i)=a(i)+f:next:else:next:d=-d
20 fori=0to9:ifb(i)=0then?@a(i)," ":a(i)=a(i)+d:?@a(i),chr$(144+c):next:elsenext
30 ifb=0then50else?@b," ":b=b-f:ifb<40thenb=0:goto50
40 ifpeek(b-512)=32then?@b,"*":goto50
45 ?@b," ":s=s+10:n=n-1:fori=0to9:b(i)=b(i)ora(i)=b:next:b=0
47 rem ifa(i)=bbthen?@a(i)," ":b(i)=-1:next:elsenext
50 k$=inkey$:ifk$<>""thenm$=k$:?@t0,"  
60 ifm$="j"orm$="l"then?@t,"  ":t=t+(m$="j")-(m$="l")elseifm$=" "andb=0thenb=t-f
70 t0=t:t=t-(t<280)+(t>318):?@t,"/\":ifm$=" "ort0<>tthenm$=""
80 ?@0,"Score:"s;"Lives:"L:h=h+1:ifh>n*2thenc=1-c:h=0:goto10else30
