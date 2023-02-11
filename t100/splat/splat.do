0cls:r=rnd(peek(63795)):c=180:p=c:w=279:s$=" ":b(0)=39:?"SPLAT!"chr$(27)"V
1b(1)=-39:b(2)=41:b(3)=-41:fori=0to9:v%(i)=1+3*rnd(1):a%(i)=w*rnd(1):next
2u=65024:ac=144:g$="Game over!":z=163:m=196:?@9,"Score:"s:k$=inkey$:ifk$<>" "then6
3fori=1to3:forj=0to3:t=c+b(j)*i:h=230+(j>1):ifpeek(u+t)=32then?@t,chr$(h):goto5
4s=s+1:?@t,chr$(255):fork=0to9:ift=a%(k)+40thena%(k)=0:next:elsenext
5next:next:fori=1to3:forj=0to3:t=c+b(j)*i:?@t,s$:next:next:ifs=10then?@145,g$:end
6p=c:c=c+2*((k$="h")-(k$="l"))+(k$="H")-(k$="L"):ifc<zthenc=zelseifc>mthenc=m
7?@p,s$:?@c,chr$(169):fori=0to9:ifa%(i)=0thennext:goto2
8?@a%(i)+40,s$:a%(i)=1+(a%(i)+v%(i)+w)modw:?@a%(i)+40,chr$(ac):next:goto2
