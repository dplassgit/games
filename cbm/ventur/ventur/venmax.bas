0 rem number of: rooms, aliases, verbs, objects, blockages, object aliases.
5 printchr$(147)"initializing...":nr=35:na=10:nv=20:no=28:nb=5:oa=11:gosub 10000
10 r=1:printchr$(147)chr$(18)"uss ventur ncc-73209"chr$(146)
15 print:print"yellow alert. the ventur is dead in"
20 print"space. we must make repairs and --"a$:print
22 print"hit a key to start..."
25 get x$:if x$="" then 25
29 rem show location in reverse; if still in quarters, show "red alert"
30 print:printchr$(18)r$(r)chr$(146):if q1=0 then printa$
35 if s(1)<>3 then print"you are in your skivvies."
40 ifr=12 then print"the turbolift says":print"'please state your destination'."
50 if aand(v=1orv>4) then gosub 1100:rem autolook
60 d$="":input "your orders";d$:if d$="" then 60
70 v=0:gosub 500:if v=0 then print"i don't know how to '"d$"'.": goto 30
80 print:if v<11 then onvgosub 1000,1200,1200,1300,1300,1400,1400,1500,1500,1500
90 if v>10 then on v-10 gosub 1900,2100,2200,2300,2500,2500,2600,2400,2700,9500
100 goto 30
199 rem subroutine converts i$ to ou$ via direction aliases
200 for ii=1 to na:if i$=a$(ii,jj) then ou$=a$(ii,1-jj):return
210 next:ou$=i$:return
499 rem look up shortcut. break d$ into verb v$andobject o$.
500 v=0:o$="":ob=0:for i=1 to na:if d$=a$(i,0)ord$=a$(i,1) then 510
505 next:goto 515
510 v=1:o$=a$(i,0):return: rem "go" verb, short direction
515 for i=1 to nv:v$=v$(i):if left$(d$,len(v$))<>v$ then 530
520 if mid$(d$,len(v$)+1,1)<>" "andlen(d$)>len(v$) then 530
525 goto 540
530 next:v$=d$:return: rem if never found then just return.
535 rem found the verb. optionally look up the object.
540 v=i:if len(v$)>=len(d$) then return: rem too small
545 t$=mid$(d$,len(v$)+1):if left$(t$,1)<>" " then v=0:return
550 o$=mid$(t$,2): rem strip leading space
555 if o$=o$(10)andr>=13andr<=19 then ob=10:return: rem viewscreen
560 rem the (j=28andf) means "if power button and you have the phaser"
565 f=s(4)=3:for j=1 to no:if o$(j)<>o$ then 575
570 if l(j)=rors(j)=3or(j=28andf) then ob=j:return
575 next:for j=1 to oa:if oa$(j)<>o$ then 590
580 k=oa(j):if l(k)=rors(k)=3or(k=28andf) then ob=k:o$=o$(ob):return
590 next:return
999 rem "go" subroutine. expects destination direction in o$
1000 i$=o$:jj=1:gosub 200:i$=ou$:d=0:for i=1 to nd(r)
1010 if i$=d$(r,i) then d=d(r,i):goto 1030
1020 next: rem look up direction
1030 if d=0 then print"you can't go that way.":return
1039 rem check for blockage
1040 for i=1 to nb:if b(i)=randb$(i,0)=i$ then printb$(i,1):return
1050 next
1060 r=d:jj=0:gosub 200:print"you go "ou$".":return: rem short to long
1100 print"you can go: ";:for i=1 to nd(r):jj=0:i$=d$(r,i):gosub 200
1110 printou$" ";:next
1120 print:print"you see: ";:n$="nothing special.":c$="":for i=1 to no
1130 if l(i)=rands(i) then printc$o$(i);:c$=", ":n$=""
1140 next:if r>=13andr<=19 then printc$"viewscreen":n$=""
1150 if r>=13andr<=19ands(11)=7 then 1170
1160 goto 1190
1170 print:print"all the consoles on the bridge are dark.";
1180 print"the computer must still be offline.";
1190 printn$:return
1200 if o$="" then 1100: rem "look". todo: refactor this
1205 gosub 3000:if f then return
1210 if s(ob)=5 then print"it looks like it can be opened.":return
1215 if ob=2ands(2)=6ands(3)=1andl(3)=1 then 3200
1220 if s(ob)=6andob>=15andob<=18 then 3100: rem eps manifold
1225 if ob>=12andob<=14ands(11)=7 then print"it is offline.":return
1230 if ob=11ands(11)=7 then print"it displays 'tap here to start'.":return
1235 if s(ob)=6 then print"it is open.":return
1236 if s(ob)=7 then print"it is deactivated.":return
1240 if ob=9orob=10 then print"you see billions and billions of stars.":return
1245 if ob=4 then print"on top you see a power level button.":return
1250 if ob=5ands(11)=7 then 1252
1251 goto 1255
1252 print"it shows 'no connection'. the computer must still be offline..."
1253 return
1255 ifob=5andpcthenprint"it displays the coordinates of the uss ventur.":return
1260 if ob=14ands(11)<>7 then 1262
1261 goto 1265
1262 print"it displays: 'uss ventur, starbase 73 acknowledges your sos.";
1263 print" transmit your coordinates and we will send a rescue team.'":return
1265 if ob=12ands(11)<>7andpc=0 then 1267
1266 goto 1270
1267 print"it shows a bunch of data, including the ventur's coordinates.";
1268 print" the location is too complicated to remember; maybe you";
1269 print" can use a padd to record itprint":return
1270 if s(11)<>7and((ob=5andpc=0)or(ob>=11andob<=14)) then 1272
1271 goto 1275
1272 print"it shows a typical l-cars interface.":return
1275 if ob=7 then print"it is set to 'detect plasma'.":return
1290 print"it looks like a standard-issue "o$".":return
1300 gosub 3000:if f then return:rem take
1310 if s(ob)<>1 then print"you can't take that!":return
1320 print"you take the "o$".":l(ob)=0:s(ob)=3:ifob=1 then print"you put it on."
1325 if ob=4andq2=0 then s(28)=2:q2=1:s=s+10:goto 4500: rem phaser
1330 if ob=3ands(1)=3 then print"you attach the combadge to your uniform."
1340 if (ob=1orob=3)ands(1)=3ands(3)=3 then 1355: rem rewrite this
1350 return
1355 f=1:b(1)=0:s=s+10:q1=1:goto 4500: rem remove blockage
1399 rem drop
1400 gosub 3000:if f then return:rem drop
1420 print"you drop the "o$".":l(ob)=r:s(ob)=1
1425 if (ob=1orob=3)and(s(1)<>3ors(3)<>3) then 1435
1430 goto 1490
1435 b(1)=1:s=s-10: rem add blockage (not in uniform)
1490 return
1499 rem use, shoot, fire
1500 gosub 3000:if f then return:rem use, shoot, fire
1505 if s(ob)<>3 then print"you don't have that.":return
1510 if (ob=8orob=4)ands(ob)=3 then 1600
1515 if ob=7ands(7)=3 then 4000: rem use tricorder
1520 if ob=6ands(6)=3 then 5000: rem use hyperspanner
1530 if ob=5andr=16ands(11)<>7 then 1540
1535 goto 1545
1540 s=s+10:print"the coordinates are copied to the padd.":pc=1:return
1545 if ob=5andr=19andpc=1 then 1555
1550 goto 1590
1555 print"the coordinates are sent from the padd to starbase 73."
1560 print"the ventur is saved! you win!":s=s+1000:goto 9500
1590 print"nothing happens.":return:rem note: this line # is used in many places
1599 rem use hyposprayorphaser on a borg drone
1600 if ob=8andh=2 then print"the hypospray is empty.":return
1605 for b=24 to 27:if l(b)=rands(b)=2 then 1615
1610 next:print"there is nothing to shoot at here.":return
1615 if ob=4andpp>=pr then 1640
1620 if ob=4 then print"you shoot the drone but nothing happens.":print"the ";
1625 if ob=4 then print"borg have adapted to the phaser's power level!":return
1640 if ob=4 then s=s+100*pr:pr=pr+1:print"you shoot the drone with the phaser."
1650 if ob=8 then s=s+100:h=h+1:print"you inject the drone with the hypospray."
1660 s(b)=7:o$(b)="a deactivated borg drone"
1665 print"the drone is deactivated and collapses.
1670 for i=1 to nb:if b(i)=r then b(i)=0:return
1680 next:return
1900 if o$="" then print"say something!":return
1905 if r<>12 then 1590
1910 if o$<>"help"ando$<>"directory" then 1945
1915 print"the turbolift says 'you are ";:d=d(12,1)
1920 if d=7 then print"on deck 3";
1925 if d=13 then print"on the bridge";
1930 if d=31 then print"on deck 2";
1935 if d=20 then print"in engineering";
1940 print". you can say bridge, deck 2, deck 3, or engineering'.":return
1945 if o$="deck 3" then d(12,1)=7:goto 1985
1950 if o$="deck 2" then d(12,1)=31:goto 1985
1955 if o$="engineering" then d(12,1)=20:goto 1985
1960 if o$="bridge" then 1970
1965 print"the turbolift says '"o$" is not a valid destination'.":return
1970 if q2*q3 then d(12,1)=13: goto 1985
1975 print"the turbolift says 'you are not (yet)
1980 print"authorized to go to the bridge.'":return
1985 if u=0 then s=s+10:u=1: rem first time usage
1990 print"the doors swish close. you feel the turbolift move. a few seconds";
1995 print" later the doors swish open.":return
2100 gosub 3000:if f then return: rem tap
2105 if ob=28ands(4)=3andpp<4 then print"the power level increases to"pp+1
2110 if ob=28ands(4)=3andpp<4 then pp=pp+1:return
2120 if ob=28ands(4)=3 then print"the power level is already at maximum.":return
2130 if r=18andob=11ands(11)=7andq3 then 2150
2140 goto 2175
2150 s=s+50:print"all the consoles on the bridge come to life! you hear an";
2160 print" urgent beeping from the comms station.
2170 s(11)=2:s(12)=2:s(13)=2:s(14)=2:return
2175 if r=18andob=11ands(11)=7andq3=0 then 2185
2180 goto 1590: rem "nothing happens"
2185 print"nothing happens. perhaps there is an issue in engineering?":return
2199 rem open
2200 gosub 3000:if f then return:rem open
2205 if s(ob)=6 then print"it's already open.":return
2210 if s(ob)<>5 then print"you can't open that!":return
2220 s(ob)=6:print"you open the "o$".":if ob<>2 then 2240: rem skip non desk
2225 if s(3)=0 then s(3)=1:goto 3200: rem open desk, see combadge
2230 print"it is empty.":return: rem desk is empty
2240 if ob>=15andob<=18 then s(ob+4)=2:goto 3100: rem access panel
2250 if ob<>23 then return
2255 s=s-1000:print"antimatter shoots out, annihilating everything in its path!"
2260 print"the ship blows up! everybody dies!":goto 9500
2300 gosub 3000:if f then return:rem close
2310 if s(ob)=5 then print"it's already closed.":return
2320 if s(ob)<>6 then print"you can't close that.":return
2330 s(ob)=5:print"you close the "o$"."
2340 if ob=2ands(3)=1andl(3)=1 then s(3)=0: rem close desk, hide combadge
2350 if ob>=15andob<=18 then s(ob+4)=0: rem access panel
2390 return
2400 a=1-a:print"auto-look turned o";:if a then print"n.":return
2405 print"ff.": return
2499 rem inventory
2500 print"you have: ";:n$="nothing":fori=1tono:ifs(i)=3thenprinto$(i)" ";:n$=""
2510 next:printn$:return
2600 t=val(o$):if t>0andt<=nr then r=t:print"transporting to "r$(t):return
2610 print"commands: ":for i=1 to nv:printv$(i)" ";:next:print:return
2700 print"current score:"s:return
2999 rem double check ob.
3000 f=0:if (ob=0ando$<>"")or(ob<>0ands(ob)=0) then 3010
3005 goto 3020
3010 print"i don't know what that is.":f=1:return: rem bad object or invisible
3020 if ob=0 then print"you must '"v$"' something!":f=1:return: rem no object
3090 return
3100 print"you see an eps manifold inside.":return: rem inside access panel
3200 print"you see a combadge inside.":return: rem inside desk
3999 rem "use" tricorder
4000 if r=25ands(18)=6and s(22)=2thenprint"it reports 'plasma detected'.":return
4090 print"it reports 'no plasma detected'.":return
4499 rem show a quest based on existing quests
4500 if (q2*q3*q4)=0 then print"your combadge beeps. 'ensign, report to"
4510 if q2=0 thenprint"the armory on deck 2. prepare to repel boarders!'":return
4520ifq3=0thenprint"engineering to fix a plasma leak in an eps manifold.'":reT
4530ifq4=0then print"the bridge and re-establish comms with":print"starbase 73.'
4590 return
4999 rem "use" hyperspanner
5000 if r=25ands(18)=6ands(22)=2 then 5010
5005 goto 1590
5010 q3=1:s(22)=4:s=s+200:print"the hyperspanner seals the eps manifold."
5011 print"the plasma leak is fixed!":goto 4500
9500 print:print"game over. final score:"s:end
10000 dim nd(35),d(35,4),d$(35,4),r$(35),a$(10,1),v$(20)
10005 rem num exits, path, dir names, rooms, aliases, verbs
10010 dim o$(28),l(28),s(28),b(5),b$(5,1),oa$(11),oa(11)
10015 rem objects, locs, status, blockage, desc, obj aliases
10020 rem read room, number directions, direction name & destination:
10030 for i=1 to nr:read r$(i),nd(i):for j=1 to nd(i):read d$(i,j),d(i,j):next
10035 next
10040 rem verbs, directional aliases
10050 for i=1 to nv:read v$(i):next:for i=1 to na:read a$(i,0),a$(i,1):next
10055 rem objects, object aliases
10070 for i=1 to no:read o$(i):next:for i=1 to oa:read oa$(i),oa(i):next
10075 rem object location, status
10080 for i=1 to no:read l(i):next:for i=1 to no:read s(i):next
10085 rem blockages, direction, what to say
10100 for i=1 to nb:read b(i),b$(i,0),b$(i,1):next
10110 a$="red alert! prepare to repel boarders!":pp=1:pr=1:return
19999 rem 35 rooms: name, number of exits, direction, destination
20000 data your quarters,3,i,4,p,2,s,3,closet,1,s,1,head,1,p,1
20005 data passageway,3,o,1,cw,5,ccw,11,passageway,2,cw,6,ccw,4
20010 data passageway,2,cw,7,ccw,5,deck 3 lobby,3,i,12,cw,8,ccw,6
20015 data passageway,2,cw,9,ccw,7,passageway,2,cw,10,ccw,8
20020 data passageway,2,cw,11,ccw,9,passageway,2,cw,4,ccw,10
20025 data turbolift,1,out,7,bridge/command dais,4,f,14,p,18,s,19,a,12
20030 data bridge/center,3,p,15,s,16,a,13,bridge/helm,2,s,14,a,18
20035 data bridge/navigation,2,p,14,a,19,unused,1,p,17,bridge/ops,2,f,15,s,13
20040 data bridge/comms,2,p,13,f,16,main engineering,2,f,12,a,21
20045 data warp core,3,f,20,p,22,s,24,jeffries tube,2,s,21,p,23
20050 data jeffries tube,1,s,22,jeffries tube,2,p,21,s,25,jeffries tube,1,p,24
20055 data armory,1,o,29,sick bay,1,i,28,passageway,3,o,27,cw,29,ccw,35
20060 data passageway,3,i,26,cw,30,ccw,28,passageway,2,cw,31,ccw,29
20065 data deck 2 lobby,3,i,12,cw,32,ccw,30,passageway,2,cw,33,ccw,31
20070 data passageway,2,cw,34,ccw,32,passageway,2,cw,35,ccw,33
20075 data passageway,2,cw,28,ccw,34
20999 rem 20 verbs
21000datago,look,examine,get,take,drop,leave,use,fire,shoot,say,tap,open,close
21010 data inventory,inv,help,autolook,score,quit
21998 rem 10 direction aliases
22000 data cw,clockwise,ccw,counterclockwise,i,inboard,o,outboard,p,port
22010 data s,starboard,a,aft,f,forward,out,out,s,sb
22999 rem 28 objects
23000 data uniform,desk,combadge,phaser,padd,hyperspanner,tricorder,hypospray
23010 data porthole,viewscreen,computer console,nav console,helm console
23015 data comms console,access panel,access panel,access panel,access panel
23020 data eps manifold,eps manifold,eps manifold,eps manifold,warp core
23025 data borg drone,borg drone,borg drone,borg drone,power level
23099 rem 11 object aliases
23100 data communicator,3,padd,5,hyper-spanner,6,hypo-spray,8,computer,11
23110 data power level button,28,power button,28,panel,15,panel,16,panel,17
23120 data panel,18
23199 rem 28 object locations
23200 data 2,1,1,26,15,20,21,27,1,0,18,16,15,19,22,23,24,25,22,23,24,25,21
23210 data 29,13,16,20,0
23299 rem 28 object status
23300 data 1,5,0,1,1,1,1,1,2,2,7,7,7,7,5,5,5,5,0,0,0,0,5,2,2,2,2,0
23999 rem 4 blockages
24000 data 1,i,you need to be in full uniform first!,29,i
24005 data a borg drone blocks your path!,13,p,a borg drone blocks your path.
24010 data 16,a,a borg drone blocks your path...,20,a
24015 data a borg drone blocks your path!