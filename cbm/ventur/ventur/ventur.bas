5printchr$(147)"initializing...":nr=35:na=10:nv=20:no=28:nb=5:oa=11:gosub10000
10r=1:printchr$(147)chr$(18)"uss ventur ncc-73209"chr$(146)
15print:print"yellow alert. the ventur is dead in"
20print"space. we must make repairs and --"a$:print
22print"hit a key to start..."
25get x$:ifx$=""then25
30print:printchr$(18)r$(r)chr$(146):ifq1=0thenprinta$
35ifs(1)<>3thenprint"you are in your skivvies."
40ifr=12thenprint"the turbolift says":print"'please state your destination'."
50ifaand(v=1orv>4)thengosub1100
60d$="":input "your orders";d$:ifd$=""then60
70v=0:gosub500:ifv=0thenprint"i don't know how to '"d$"'.":goto30
80print:ifv<11thenonvgosub1000,1200,1200,1300,1300,1400,1400,1500,1500,1500
90ifv>10thenonv-10gosub1900,2100,2200,2300,2500,2500,2600,2400,2700,9500
100goto30
200forii=1tona:ifi$=a$(ii,jj)thenou$=a$(ii,1-jj):return
210next:ou$=i$:return
500v=0:o$="":ob=0:fori=1tona:ifd$=a$(i,0)ord$=a$(i,1)then510
505next:goto515
510v=1:o$=a$(i,0):return
515fori=1tonv:v$=v$(i):ifleft$(d$,len(v$))<>v$then530
520ifmid$(d$,len(v$)+1,1)<>" "andlen(d$)>len(v$)then530
525goto540
530next:v$=d$:return
540v=i:iflen(v$)>=len(d$)thenreturn
545t$=mid$(d$,len(v$)+1):ifleft$(t$,1)<>" "thenv=0:return
550o$=mid$(t$,2)
555ifo$=o$(10)andr>=13andr<=19thenob=10:return
565f=s(4)=3:forj=1tono:ifo$(j)<>o$then575
570ifl(j)=rors(j)=3or(j=28andf)thenob=j:return
575next:forj=1tooa:ifoa$(j)<>o$then590
580k=oa(j):ifl(k)=rors(k)=3or(k=28andf)thenob=k:o$=o$(ob):return
590next:return
1000i$=o$:jj=1:gosub200:i$=ou$:d=0:fori=1tond(r)
1010ifi$=d$(r,i)thend=d(r,i):goto1030
1020next
1030ifd=0thenprint"you can't go that way.":return
1040fori=1tonb:ifb(i)=randb$(i,0)=i$thenprintb$(i,1):return
1050next
1060r=d:jj=0:gosub200:print"you go "ou$".":return
1100print"you can go: ";:fori=1tond(r):jj=0:i$=d$(r,i):gosub200
1110printou$" ";:next
1120print:print"you see: ";:n$="nothing special.":c$="":fori=1tono
1130ifl(i)=rands(i)thenprintc$o$(i);:c$=", ":n$=""
1140next:ifr>=13andr<=19thenprintc$"viewscreen":n$=""
1150ifr>=13andr<=19ands(11)=7then1170
1160goto1190
1170print:print"all the consoles on the bridge are dark.";
1180print"the computer must still be offline.";
1190printn$:return
1200ifo$=""then1100
1205gosub3000:iffthenreturn
1210ifs(ob)=5thenprint"it looks like it can be opened.":return
1215ifob=2ands(2)=6ands(3)=1andl(3)=1then3200
1220ifs(ob)=6andob>=15andob<=18then3100
1225ifob>=12andob<=14ands(11)=7thenprint"it is offline.":return
1230ifob=11ands(11)=7thenprint"it displays 'tap here to start'.":return
1235ifs(ob)=6thenprint"it is open.":return
1236ifs(ob)=7thenprint"it is deactivated.":return
1240ifob=9orob=10thenprint"you see billions and billions of stars.":return
1245ifob=4thenprint"on top you see a power level button.":return
1250ifob=5ands(11)=7then1252
1251goto1255
1252print"it shows 'no connection'. the computer must still be offline..."
1253return
1255ifob=5andpcthenprint"it displays the coordinates of the uss ventur.":return
1260ifob=14ands(11)<>7then1262
1261goto1265
1262print"it displays: 'uss ventur, starbase 73 acknowledges your sos.";
1263print" transmit your coordinates and we will send a rescue team.'":return
1265ifob=12ands(11)<>7andpc=0then1267
1266goto1270
1267print"it shows a bunch of data, including the ventur's coordinates.";
1268print" the location is too complicated to remember; maybe you";
1269print" can use a padd to record itprint":return
1270ifs(11)<>7and((ob=5andpc=0)or(ob>=11andob<=14))then1272
1271goto1275
1272print"it shows a typical l-cars interface.":return
1275ifob=7thenprint"it is set to 'detect plasma'.":return
1290print"it looks like a standard-issue "o$".":return
1300gosub3000:iffthenreturn
1310ifs(ob)<>1thenprint"you can't take that!":return
1320print"you take the "o$".":l(ob)=0:s(ob)=3:ifob=1thenprint"you put it on."
1325ifob=4andq2=0thens(28)=2:q2=1:s=s+10:goto4500
1330ifob=3ands(1)=3thenprint"you attach the combadge to your uniform."
1340if(ob=1orob=3)ands(1)=3ands(3)=3then1355
1350return
1355f=1:b(1)=0:s=s+10:q1=1:goto4500
1400gosub3000:iffthenreturn
1420print"you drop the "o$".":l(ob)=r:s(ob)=1
1425if(ob=1orob=3)and(s(1)<>3ors(3)<>3)then1435
1430goto1490
1435b(1)=1:s=s-10
1490return
1500gosub3000:iffthenreturn
1505ifs(ob)<>3thenprint"you don't have that.":return
1510if(ob=8orob=4)ands(ob)=3then1600
1515ifob=7ands(7)=3then4000
1520ifob=6ands(6)=3then5000
1530ifob=5andr=16ands(11)<>7then1540
1535goto1545
1540s=s+10:print"the coordinates are copied to the padd.":pc=1:return
1545ifob=5andr=19andpc=1then1555
1550goto1590
1555print"the coordinates are sent from the padd to starbase 73."
1560print"the ventur is saved! you win!":s=s+1000:goto9500
1590print"nothing happens.":return
1600ifob=8andh=2thenprint"the hypospray is empty.":return
1605forb=24 to 27:ifl(b)=rands(b)=2then1615
1610next:print"there is nothing to shoot at here.":return
1615ifob=4andpp>=prthen1640
1620ifob=4thenprint"you shoot the drone but nothing happens.":print"the ";
1625ifob=4thenprint"borg have adapted to the phaser's power level!":return
1640ifob=4thens=s+100*pr:pr=pr+1:print"you shoot the drone with the phaser."
1650ifob=8thens=s+100:h=h+1:print"you inject the drone with the hypospray."
1660s(b)=7:o$(b)="a deactivated borg drone"
1665print"the drone is deactivated and collapses.
1670fori=1tonb:ifb(i)=rthenb(i)=0:return
1680next:return
1900ifo$=""thenprint"say something!":return
1905ifr<>12then1590
1910ifo$<>"help"ando$<>"directory"then1945
1915print"the turbolift says 'you are ";:d=d(12,1)
1920ifd=7thenprint"on deck 3";
1925ifd=13thenprint"on the bridge";
1930ifd=31thenprint"on deck 2";
1935ifd=20thenprint"in engineering";
1940print". you can say bridge, deck 2, deck 3, or engineering'.":return
1945ifo$="deck 3"thend(12,1)=7:goto1985
1950ifo$="deck 2"thend(12,1)=31:goto1985
1955ifo$="engineering"thend(12,1)=20:goto1985
1960ifo$="bridge"then1970
1965print"the turbolift says '"o$" is not a valid destination'.":return
1970ifq2*q3thend(12,1)=13:goto1985
1975print"the turbolift says 'you are not (yet)
1980print"authorized to go to the bridge.'":return
1985ifu=0thens=s+10:u=1
1990print"the doors swish close. you feel the turbolift move. a few seconds";
1995print" later the doors swish open.":return
2100gosub3000:iffthenreturn
2105ifob=28ands(4)=3andpp<4thenprint"the power level increases to"pp+1
2110ifob=28ands(4)=3andpp<4thenpp=pp+1:return
2120ifob=28ands(4)=3thenprint"the power level is already at maximum.":return
2130ifr=18andob=11ands(11)=7andq3then2150
2140goto2175
2150s=s+50:print"all the consoles on the bridge come to life! you hear an";
2160print" urgent beeping from the comms station.
2170s(11)=2:s(12)=2:s(13)=2:s(14)=2:return
2175ifr=18andob=11ands(11)=7andq3=0then2185
2180goto1590
2185print"nothing happens. perhaps there is an issue in engineering?":return
2200gosub3000:iffthenreturn
2205ifs(ob)=6thenprint"it's already open.":return
2210ifs(ob)<>5thenprint"you can't open that!":return
2220s(ob)=6:print"you open the "o$".":ifob<>2then2240
2225ifs(3)=0thens(3)=1:goto3200
2230print"it is empty.":return
2240ifob>=15andob<=18thens(ob+4)=2:goto3100
2250ifob<>23thenreturn
2255s=s-1000:print"antimatter shoots out, annihilating everything in its path!"
2260print"the ship blows up! everybody dies!":goto9500
2300gosub3000:iffthenreturn
2310ifs(ob)=5thenprint"it's already closed.":return
2320ifs(ob)<>6thenprint"you can't close that.":return
2330s(ob)=5:print"you close the "o$"."
2340ifob=2ands(3)=1andl(3)=1thens(3)=0
2350ifob>=15andob<=18thens(ob+4)=0
2390return
2400a=1-a:print"auto-look turned o";:ifathenprint"n.":return
2405print"ff.": return
2500print"you have: ";:n$="nothing":fori=1tono:ifs(i)=3thenprinto$(i)" ";:n$=""
2510next:printn$:return
2600t=val(o$):ift>0andt<=nrthenr=t:print"transporting to "r$(t):return
2610print"commands: ":fori=1tonv:printv$(i)" ";:next:print:return
2700print"current score:"s:return
3000f=0:if(ob=0ando$<>"")or(ob<>0ands(ob)=0)then3010
3005goto3020
3010print"i don't know what that is.":f=1:return
3020ifob=0thenprint"you must '"v$"' something!":f=1:return
3090return
3100print"you see an eps manifold inside.":return
3200print"you see a combadge inside.":return
4000ifr=25ands(18)=6and s(22)=2thenprint"it reports 'plasma detected'.":return
4090print"it reports 'no plasma detected'.":return
4500if(q2*q3*q4)=0thenprint"your combadge beeps. 'ensign, report to"
4510ifq2=0thenprint"the armory on deck 2. prepare to repel boarders!'":return
4520ifq3=0thenprint"engineering to fix a plasma leak in an eps manifold.'":reT
4530ifq4=0thenprint"the bridge and re-establish comms with":print"starbase 73.'
4590return
5000ifr=25ands(18)=6ands(22)=2then5010
5005goto1590
5010q3=1:s(22)=4:s=s+200:print"the hyperspanner seals the eps manifold."
5011print"the plasma leak is fixed!":goto4500
9500print:print"game over. final score:"s:end
10000dimnd(35),d(35,4),d$(35,4),r$(35),a$(10,1),v$(20)
10010dimo$(28),l(28),s(28),b(5),b$(5,1),oa$(11),oa(11)
10030fori=1tonr:readr$(i),nd(i):forj=1tond(i):readd$(i,j),d(i,j):next
10035next
10050fori=1tonv:readv$(i):next:fori=1tona:reada$(i,0),a$(i,1):next
10070fori=1tono:reado$(i):next:fori=1tooa:readoa$(i),oa(i):next
10080fori=1tono:readl(i):next:fori=1tono:reads(i):next
10100fori=1tonb:readb(i),b$(i,0),b$(i,1):next
10110a$="red alert! prepare to repel boarders!":pp=1:pr=1:return
20000datayour quarters,3,i,4,p,2,s,3,closet,1,s,1,head,1,p,1
20005datapassageway,3,o,1,cw,5,ccw,11,passageway,2,cw,6,ccw,4
20010datapassageway,2,cw,7,ccw,5,deck 3 lobby,3,i,12,cw,8,ccw,6
20015datapassageway,2,cw,9,ccw,7,passageway,2,cw,10,ccw,8
20020datapassageway,2,cw,11,ccw,9,passageway,2,cw,4,ccw,10
20025dataturbolift,1,out,7,bridge/command dais,4,f,14,p,18,s,19,a,12
20030databridge/center,3,p,15,s,16,a,13,bridge/helm,2,s,14,a,18
20035databridge/navigation,2,p,14,a,19,unused,1,p,17,bridge/ops,2,f,15,s,13
20040databridge/comms,2,p,13,f,16,main engineering,2,f,12,a,21
20045datawarp core,3,f,20,p,22,s,24,jeffries tube,2,s,21,p,23
20050datajeffries tube,1,s,22,jeffries tube,2,p,21,s,25,jeffries tube,1,p,24
20055dataarmory,1,o,29,sick bay,1,i,28,passageway,3,o,27,cw,29,ccw,35
20060datapassageway,3,i,26,cw,30,ccw,28,passageway,2,cw,31,ccw,29
20065datadeck 2 lobby,3,i,12,cw,32,ccw,30,passageway,2,cw,33,ccw,31
20070datapassageway,2,cw,34,ccw,32,passageway,2,cw,35,ccw,33
20075datapassageway,2,cw,28,ccw,34
21000datago,look,examine,get,take,drop,leave,use,fire,shoot,say,tap,open,close
21010datainventory,inv,help,autolook,score,quit
22000datacw,clockwise,ccw,counterclockwise,i,inboard,o,outboard,p,port
22010datas,starboard,a,aft,f,forward,out,out,s,sb
23000datauniform,desk,combadge,phaser,padd,hyperspanner,tricorder,hypospray
23010dataporthole,viewscreen,computer console,nav console,helm console
23015datacomms console,access panel,access panel,access panel,access panel
23020dataeps manifold,eps manifold,eps manifold,eps manifold,warp core
23025databorg drone,borg drone,borg drone,borg drone,power level
23100datacommunicator,3,padd,5,hyper-spanner,6,hypo-spray,8,computer,11
23110datapower level button,28,power button,28,panel,15,panel,16,panel,17
23120datapanel,18
23200data2,1,1,26,15,20,21,27,1,0,18,16,15,19,22,23,24,25,22,23,24,25,21
23210data29,13,16,20,0
23300data1,5,0,1,1,1,1,1,2,2,7,7,7,7,5,5,5,5,0,0,0,0,5,2,2,2,2,0
24000data1,i,you need to be in full uniform first!,29,i
24005dataa borg drone blocks your path!,13,p,a borg drone blocks your path.
24010data16,a,a borg drone blocks your path...,20,a
24015dataa borg drone blocks your path!