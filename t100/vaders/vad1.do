0 cls:t=300:f=40:fori=0to7:a(i)=52+3*(imod4)+f*(i\4):next:d=1:?chr$(27)"V
10 ifa(7)modf>30ora(0)modf<11thenfori=0to7:?@a(i)," ":a(i)=a(i)+f:next:d=-d:h=0
20 ?@a(h)," ":a(h)=a(h)+d:?@a(h),chr$(144+c):h=h+1:ifh=8thenc=1-c:h=0
30 ifbthen?@b," ":b=b-f:ifb<0thenb=0else?@b,"*
40 k$=inkey$:ifk$<>""thenm$=k$:?@t0,"  
50 ifm$="j"orm$="l"then?@t,"  ":t=t+(m$="j")-(m$="l")elseifm$=" "andb=0thenb=t-f
60 t0=t:t=t-(t<290)+(t>310):?@t,"/\":ifm$=" "ort0<>tthenm$=""
70 goto10
99 rem attempting to use h as a counter
