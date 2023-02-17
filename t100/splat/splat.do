0cls:poke-902,peek(-1745):c=180:p=c:w=279:s$=" ":b(0)=39:?chr$(27)"VSPLATS:
1b(1)=-39:b(2)=41:b(3)=-41:fori=0to9:v%(i)=1+3*rnd(1):a%(i)=w*rnd(1):next:x=163
2u=65024:ac=144:m=196:?@7,s:?@15,"Time: "chr$(57-fix(b)):k$=inkey$:L$="You lost!
3b=b+.2:ifb>9then?:?L$:endelseifs>9then?:?"You won!":endelseifk$<>" "then7
4fori=1to3:forj=0to3:t=c+b(j)*i:h=230+(j>1):ifpeek(u+t)=32then?@t,chr$(h):goto6
5s=s+1:?@t,chr$(255):fork=0to9:ift=a%(k)+40thena%(k)=0:next:elsenext
6next:next:fori=1to3:forj=0to3:t=c+b(j)*i:?@t,s$:next:next:goto2
7p=c:c=c+2*((k$="h")-(k$="l"))+(k$="H")-(k$="L"):ifc<xthenc=xelseifc>mthenc=m
8?@p,s$:?@c,chr$(169):fori=0to9:ifa%(i)=0thennext:goto2
9?@a%(i)+40,s$:a%(i)=1+(a%(i)+v%(i)+w)modw:?@a%(i)+40,chr$(ac):next:goto2
