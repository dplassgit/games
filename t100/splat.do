0cls:r=rnd(peek(63795)):c=180:p=c:z=163:m=196:a=60:s$=" ":?chr$(27)"V
1b(0)=39:b(1)=-41:b(2)=-39:b(3)=41:lc=65024:g$="Game over!":?@0,"SPLAT!
2?@9,"Score:"s"   Firepower:"f:f=f-(f<3):k$=inkey$:iff=3andk$=" "thengosub8:f=0
3p=c:c=c+2*((k$="h")-(k$="l"))+(k$="H")-(k$="L"):ifc<zthenc=zelseifc>mthenc=m
4?@p,s$:?@c,chr$(169):?@a,s$:a=fix(a-3+9*rnd(1)):ifa<0thena=0
5ifa<320then?@a,chr$(144):goto1else?@175,g$:end
8fori=1to3:forj=0to3:t=c+b(j)*i:h=230-jmod2:ifpeek(lc+t)=144thens=s+1:h=255:a=60
9?@t,chr$(h):next:next:fori=1to3:forj=0to3:t=c+b(j)*i:?@t,s$:next:next:return
