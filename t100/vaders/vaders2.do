0 cls:L=3:N=8:fori=0to8:a(i)=56+i*2:a$(i)=chr$(49+i):next:c=300:oc=c:?chr$(27)"V
1 ?@0,"Score:"s;"Lives"L:ifl=0then?"Game over":end:elseifn=0then0
2 fori=0to8:ifa(i)>0then?@a(i)," ":a(i)=a(i)+1:?@a(i),a$(i):next:elsenext
3 ifd=0andrnd(1)<.1thend=a(8*rnd(1))+40
4 ifd<>0then?@d,"v":od=d:d=d+40:ifd>280thend=0:elseifd=cthen9elseifod<>0then?@od," "
5 k$=inkey$:c=c+(k$="j")-(k$="l"):c=c-(c<280)+(c>319):ifu=0andk$=" "thenu=c-40
6 ?@oc," ":?@c,"C":oc=c:ifu=0then9
7 h=peek(u+65024):ifh>48andh<57thena(h-49)=-1:n=n-1:s=s+10:u=0:goto1
8 ?@u,"^":ou=u:u=u-40:ifu<40thenu=0elseifou>0then?@ou," ":goto1else1
9 ifd=c or a(0)>280then?"Died!":k$=inkey$:l=l-1:goto1else1

