5cls:?"Initializing...":definta-z:nr=35:na=10:nv=20:no=28:nb=5:gosub10000:cls:r=1:e$=chr$(27):?e$"pUSS Ventur NCC-73209"e$"q
10?:?"Yellow alert. The Ventur is dead in":?"space. We must make repairs and --":?a$:?:?"Hit a key to start...
15ifinkey$=""then15
20?:?e$"p"r$(r)e$"q":ifq1=0then?a$
40ifs(1)<>3then?"You are in your skivvies.
50ifr=12then?"The turbolift says 'Please state your":?"destination'.
60ifaand(v=1orv>4)thengosub1100
70d$="":input"Your orders";d$:ifd$=""then70
80v=0:gosub500:ifv=0then?"I don't know how to '"d$"'."else?
90onvgosub1000,1200,1200,1300,1300,1400,1400,1500,1500,1500,1900,2100,2200,2300,2500,2500,2600,2400,2700,9500:goto20
200forii=1tona:ifi$=a$(ii,jj)thenou$=a$(ii,1-jj):return
210next:ou$=i$:return
500v=0:o$="":ob=0:fori=1tona:ifd$=a$(i,0)ord$=a$(i,1)thenv=1:o$=a$(i,0):return
510next:fori=1tonv:v$=v$(i):j=instr(d$,v$):ifj<>1thennext:v$=d$:return
530v=i:iflen(v$)>=len(d$)thenreturn
540t$=mid$(d$,len(v$)+1):ifleft$(t$,1)<>" "thenv=0:returnelseo$=mid$(t$,2)
550ifo$=o$(28)ands(4)=3thenob=28:return
560ifo$=o$(10)andr>=13andr<=19thenob=10:return
570forj=1tono:ifo$(j)=o$and(l(j)=rors(j)=3)thenob=jelsenext
590return
1000i$=o$:jj=1:gosub200:i$=ou$:d=0:fori=1tond(r):ifi$=d$(r,i)thend=d(r,i)elsenext
1010ifd=0then?"You can't go that way.":return
1020fori=1tonb:ifb(i)=randb$(i,0)=i$then?b$(i,1):returnelsenext
1030r=d:jj=0:gosub200:?"You go "ou$".":return
1100?"You can go: ";:fori=1tond(r):jj=0:i$=d$(r,i):gosub200:?ou$" ";:next
1105?:?"You see: ";:n$="Nothing special.":c$="":fori=1tono:ifl(i)=rands(i)then?c$o$(i);:c$=", ":n$=""
1110next:ifr>=13andr<=19then?c$"viewscreen":n$="":ifs(11)=7then?"All the consoles on the bridge are dark.";
1120?n$:return
1200ifo$=""then1100elseifob=0then?"I don't know what that is.":return
1210?"You look at the "o$".":ifs(ob)=5then?"It looks like it can be opened.":return
1215ifob=2ands(2)=6ands(3)=1andl(3)=1then3200
1220ifs(ob)=6andob>=15andob<=18then3100
1225if(ob=12orob=13orob=14)ands(11)=7then?"It is offline.":return
1230ifs(ob)=6then?"It is open.":returnelseifs(ob)=7then?"It is deactivated.":return
1235ifob=9orob=10then?"You see billions and billions of stars.":return
1240ifob=4then?"On top you see a power level button.":return
1245ifob=5ands(11)=7then?"It shows 'No connection'. The computer":?"must still be offline...":return
1250ifs(11)<>7and((ob=5andpc=0)orob=11orb=13)then?"It shows a typical L-CARS interface.":return
1255ifob=5andpcthen?"It displays the coordinates of the USS":?"Ventur.":return
1260ifob=14ands(11)<>7then?"It displays: 'USS Ventur, Starbase 73":?"acknowledges your SOS. Transmit your":?"coordinates and we will send a rescue":?"team.'":return
1265ifob=12ands(11)<>7then?"It shows a bunch of data, including the Ventur's coordinates. The location is":?"too complicated to remember; maybe you":?"can use a PADD to record it?":return
1270ifob=7then?"It is set to 'Detect plasma'.":return
1290?"It looks like a standard-issue "o$".":return
1300gosub3000:iffthenreturn
1310ifs(ob)<>1then?"You can't take that!":return
1320?"You take the "o$".":l(ob)=0:s(ob)=3:ifob=1then?"You put it on.
1340ifob=3ands(1)=3then?"You attach the combadge to your uniform.
1350if(ob=1orob=3)ands(1)=3ands(3)=3thenf=1:b(1)=0:s=s+10:q1=1:goto4500
1360ifob=4andq2=0thenq2=1:s=s+10:goto4500
1390return
1400gosub3000:iffthenreturn
1410ifs(ob)<>3then?"You don't have that.":return
1420?"You drop the "o$".":l(ob)=r:s(ob)=1:if(ob=1orob=3)and(s(1)<>3ors(3)<>3)thenb(1)=1:s=s-10
1490return
1500gosub3000:iffthenreturn
1510ifs(ob)<>3then?"You don't have that.":return
1520if(ob=8orob=4)ands(ob)=3thengosub1600:return
1530ifob=7ands(7)=3thengosub4000:return
1540ifob=6ands(6)=3thengosub5000:return
1550ifob=5andr=16thens=s+10:?"The coordinates are copied to the PADD.":pc=1:return
1560ifob=5andr=19andpc=1then?"The coordinates are sent from the PADD":?"to Starbase 73. The Ventur is saved! Youwin!":s=s+1000:goto9500
1590?"Nothing happens.":return
1600ifob=8andh=2then?"The hypospray is empty.":return
1610forb=24 to 27:ifl(b)=rands(b)=2then1630
1620next:?"There is nothing to shoot at here.":return
1630ifob=4andpp<prthen?"You shoot the drone but nothing happens.The Borg have adapted to the phaser's":?"power level!":return
1640ifob=4thenpr=pp+1:s=s+100*pp:?"You shoot the drone with the phaser.
1650ifob=8thens=s+100:h=h+1:?"You inject the drone with the hypospray.";
1660s(b)=7:o$(b)="a deactivated Borg drone":?"The drone is deactivated and collapses.
1670fori=1tonb:ifb(i)=rthenb(i)=0:return
1690next:return
1900ifo$=""then?"Say something!":return
1910ifr<>12then1590
1920ifo$<>"help"ando$<>"directory"then1950
1930?"The turbolift says 'You are ";:d=d(12,1):ifd=7then?"on deck 3";elseifd=13then?"the bridge";elseifd=31then?"on deck 2";elseifd=20then?"in engineering";
1940?". You can go to the bridge, deck 2, deck 3, or engineering'.":return
1950f=0:ifo$="deck 3"thenf=1:d(12,1)=7elseifo$="deck 2"thenf=1:d(12,1)=31elseifo$="engineering"thenf=1:d(12,1)=20
1960ifo$="bridge"thenif(q2*q3)=0then?"The turbolift says 'You are not (yet)":?"authorized to go to the bridge.'":returnelsef=1:d(12,1)=13
1970ifu=0andf=1thens=s+10:u=1
1980iffthen?"The doors swish close. You feel the":?"turbolift move. A few seconds later the doors swish open.":return
1990?"The turbolift says '"o$" is not a valid destination'.":return
2100ifo$<>""then?"You tap the "o$"."else1590
2110ifob=28ands(4)=3andpp<4thenpp=pp+1:?"The power level increases to"pp:return
2120ifob=28ands(4)=3then?"The power level is already at maximum.":return
2130ifob=28ands(4)<>3then?"I don't know what that is.":return
2140ifr=18andob=11ands(11)=7andq3then?"All the consoles around the bridge come to life!":s(11)=2:s(12)=2:s(13)=2:s(14)=2:return
2150ifr=18andob=11ands(11)=7andq3=0then?"Nothing happens. Perhaps there is an":?"issue in engineering?":return
2190goto1590
2200gosub3000:iffthenreturn
2210ifs(ob)=6then?"It's already open.":return
2220ifs(ob)<>5then?"You can't open that!":return
2230s(ob)=6:?"You open the "o$".":ifob=2thenifs(3)=0thens(3)=1:goto3200else?"It is empty.":return
2240ifob>=15andob<=18thens(ob+4)=2:goto3100
2250ifob=23thens=s-1000:?"Antimatter shoots out, annihilating":?"everything in its path! The ship blows":?"up! Everybody dies!":goto9500
2290return
2300gosub3000:iffthenreturn
2310ifs(ob)=5then?"It's already closed.":return
2320ifs(ob)<>6then?"You can't close that.":return
2330s(ob)=5:?"You close the "o$".":ifob=2ands(3)=1andl(3)=1thens(3)=0
2350ifob>=15andob<=18thens(ob+4)=0
2390return
2400a=1-a:?"Auto-look turned o";:ifathen?"n."else?"ff.
2410return
2500?"You have: ";:n$="Nothing":fori=1tono:ifs(i)=3then?o$(i)" ";:n$=""
2510next:?n$:return
2600t=val(o$):ift>0andt<=nrthenr=t:?"Transporting to "r$(t):return
2610?"Commands: ":fori=1tonv:?v$(i)" ";:next:?:return
2700?"Current score:"s:return
3000f=0:if(ob=0ando$<>"")or(ob<>0ands(ob)=0)then?"I don't know what that is.":f=1:return
3010ifob=0then?"You must '"v$"' something!":f=1:return
3020ifs(ob)=3or(ob=10andr>=13andr<=19)thenreturn
3030ifl(ob)<>rthen?"That's not here.":f=1
3090return
3100?"You see an EPS manifold inside.":return
3200?"You see a combadge inside.":return
4000ifr=25ands(18)=6ands(22)=2then?"It reports 'Plasma detected'.":return
4090?"It reports 'No plasma detected'.":return
4500if(q2*q3*q4)=0then?"Your combadge beeps. 'Ensign, report to
4510ifq2=0then?"the armory on deck 2. PREPARE TO REPEL":?"BOARDERS!'":return
4520ifq3=0then?"engineering to fix a plasma leak in":?"an EPS manifold.'":return
4530ifq4=0then?"the bridge.'
4590return
5000ifr=25ands(18)=6ands(22)=2thenq3=1:s(22)=4:s=s+100:?"The hyperspanner seals the EPS manifold.The plasma leak is fixed!":goto4500
5090goto1590
9500?:?"Game over. Final score:"s:end
10000dimnd(nr),d(nr,4),d$(nr,4),r$(nr),a$(na,1),v$(nv)
10010dimo$(no),l(no),s(no),b(nb),b$(nb,1)
10030fori=1tonr:readr$(i),nd(i):forj=1tond(i):readd$(i,j),d(i,j):next:next
10050fori=1tonv:readv$(i):next:fori=1tona:reada$(i,0),a$(i,1):next
10070fori=1tono:reado$(i):next:fori=1tono:readl(i):next:fori=1tono:reads(i):next
10100fori=1tonb:readb(i),b$(i,0),b$(i,1):next
10110a$="RED ALERT! PREPARE TO REPEL BOARDERS!":pp=1:pr=1:return
20000dataYour Quarters,3,i,4,p,2,s,3,Closet,1,s,1,Head,1,p,1,Passageway,3,o,1,cw,5,ccw,11,Passageway,2,cw,6,ccw,4
20010dataPassageway,2,cw,7,ccw,5,Deck 3 Lobby,3,i,12,cw,8,ccw,6,Passageway,2,cw,9,ccw,7,Passageway,2,cw,10,ccw,8,Passageway,2,cw,11,ccw,9
20020dataPassageway,2,cw,4,ccw,10,Turbolift,1,out,7,Bridge/Command Dais,4,f,14,p,18,s,19,a,12,Bridge/Center,3,p,15,s,16,a,13
20030dataBridge/Helm,2,s,14,a,18,Bridge/Navigation,2,p,14,a,19,Unused,1,p,17,Bridge/Ops,2,f,15,s,13,Bridge/Comms,2,p,13,f,16
20040dataMain Engineering,2,f,12,a,21,Warp core,3,f,20,p,22,s,24,Jeffries Tube,2,s,21,p,23,Jeffries Tube,1,s,22
20050dataJeffries Tube,2,p,21,s,25,Jeffries Tube,1,p,24,Armory,1,o,29,Sick bay,1,i,28,Passageway,3,o,27,cw,29,ccw,35
20060dataPassageway,3,i,26,cw,30,ccw,28,Passageway,2,cw,31,ccw,29,Deck 2 Lobby,3,i,12,cw,32,ccw,30,Passageway,2,cw,33,ccw,31
20070dataPassageway,2,cw,34,ccw,32,Passageway,2,cw,35,ccw,33,Passageway,2,cw,28,ccw,34
21000datago,look,examine,get,take,drop,leave,use,fire,shoot,say,tap,open,close,inv,inventory,help,autolook,score,quit
22000datacw,clockwise,ccw,counterclockwise,i,inboard,o,outboard,p,port,s,starboard,a,aft,f,forward,out,out,s,sb
23000datauniform,desk,combadge,phaser,PADD,hyperspanner,tricorder,hypospray,porthole,viewscreen,computer console,nav console
23010datahelm console,comms console,access panel,access panel,access panel,access panel,EPS manifold,EPS manifold
23020dataEPS manifold,EPS manifold,warp core,Borg drone,Borg drone,Borg drone,Borg drone,power level
23100data2,1,1,26,15,20,21,27,1,,18,16,15,19,22,23,24,25,22,23,24,25,21,29,13,16,20,
23200data1,5,,1,1,1,1,1,2,2,7,7,7,7,5,5,5,5,,,,,5,2,2,2,2,
24000data1,i,You need to be in full uniform first!,29,i,A Borg drone blocks your path!,13,p,A Borg drone blocks your path.
24010data16,a,A Borg drone blocks your path...,20,a,A Borg drone blocks your path!
