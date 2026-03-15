0 rem number of: rooms, aliases, verbs, objects, blockages, object aliases. r=current room #
5 cls:?"Initializing...":definta-z:nr=35:na=10:nv=20:no=28:nb=5:oa=11:gosub10000:cls:r=1:e$=chr$(27):?e$"pUSS Ventur NCC-73209"e$"q
10 ?:?"Yellow alert. The Ventur is dead in":?"space. We must make repairs and --":?a$:?:?"Hit a key to start...
15 if inkey$="" then 15
20 ?:?e$"p"r$(r)e$"q":if q1=0 then ?a$: rem show location in reverse; if still in quarters, show "red alert"
40 if s(1)<>3 then ?"You are in your skivvies.
50 if r=12 then ?"The turbolift says 'Please state your":?"destination'.
60 if aand(v=1orv>4) then gosub1100:rem autolook if didn't just look
70 d$="":input"Your orders";d$:ifd$=""then70
80 v=0:gosub500:if v=0 then ?"I don't know how to '"d$"'." else ?: rem break up input
90 onvgosub1000,1200,1200,1300,1300,1400,1400,1500,1500,1500,1900,2100,2200,2300,2500,2500,2600,2400,2700,9500:goto20
199 rem subroutine converts i$ to ou$ via direction aliases
200 for ii=1 to na:if i$=a$(ii,jj) then ou$=a$(ii,1-jj):return
210 next:ou$=i$:return
499 rem look up shortcut. break d$ into verb v$ and object o$. Sets verb # in v and optional object # in ob
500 v=0:o$="":ob=0:for i=1 to na:if d$=a$(i,0)ord$=a$(i,1) then v=1:o$=a$(i,0):return: rem "go" verb, short direction
510 next:for i=1 to nv:v$=v$(i):j=instr(d$,v$):ifj<>1 then next:v$=d$:return: rem if never found then just return.
529 rem found the verb. optionally look up the object.
530 v=i:if len(v$)>=len(d$) then return: rem too small
540 t$=mid$(d$,len(v$)+1):if left$(t$,1)<>" " then v=0:return else o$=mid$(t$,2): rem strip leading space if there is one.
560 if o$=o$(10)andr>=13andr<=19 then ob=10:return: rem special case for viewscreen because you can see it from multiple places
568 rem TODO: make "parent/child" relationships so it's easier to deal with the phaser/power button and other relationships
569 rem the (j=28 and f) means "if power button and you have the phaser"
570 f=-(s(4)=3):for j=1 to no:if o$(j)=o$ then if l(j)=rors(j)=3or(j=28andf) then ob=j:return: rem else object must be in this room or in inventory
580 next:for j=1 to oa:if oa$(j)=o$ then k=oa(j):if l(k)=rors(k)=3or(k=28andf) then ob=k:o$=o$(ob):return: rem look in aliases
590 next:return
999 rem "go" subroutine. expects destination direction in o$
1000 i$=o$:jj=1:gosub200:i$=ou$:d=0:for i=1 to nd(r):ifi$=d$(r,i) then d=d(r,i) else next: rem look up direction
1010 if d=0 then ?"You can't go that way.":return
1019 rem check for blockage
1020 for i=1 to nb:if b(i)=randb$(i,0)=i$ then ?b$(i,1):return else next
1030 r=d:jj=0:gosub200:?"You go "ou$".":return: rem convert from short to long
1100 ?"You can go: ";:for i=1 to nd(r):jj=0:i$=d$(r,i):gosub200:?ou$" ";:next: rem convert from short to long
1105 ?:?"You see: ";:n$="Nothing special.":c$="":for i=1 to no:if l(i)=rands(i) then ?c$o$(i);:c$=", ":n$=""
1110 next:if r>=13andr<=19 then ?c$"viewscreen":n$="":if s(11)=7 then ?"All the consoles on the bridge are dark.";
1120 ?n$:return
1200 if o$="" then 1100: rem "look". TODO: Refactor this; it's so specific to each item and its state..
1205 gosub3000:iff then return
1210 if s(ob)=5 then ?"It looks like it can be opened.":return
1215 if ob=2ands(2)=6ands(3)=1andl(3)=1 then 3200: rem desk/combadge
1220 if s(ob)=6andob>=15andob<=18 then 3100: rem EPS manifold inside the access panel
1225 if ob>=12andob<=14ands(11)=7 then ?"It is offline.":return: rem bridge console
1230 if ob=11 then if s(11)=7 then ?"It displays 'Tap here to start'.":return: rem computer
1235 if s(ob)=6 then ?"It is open.":return else if s(ob)=7 then ?"It is deactivated.":return: rem any random thing that is open or dead
1240 if ob=9orob=10 then ?"You see billions and billions of stars.":return
1245 if ob=4 then ?"On top you see a power level button.":return
1250 if ob=5ands(11)=7 then ?"It shows 'No connection'. The computer":?"must still be offline...":return
1255 if ob=5andpc then ?"It displays the coordinates of the USS":?"Ventur.":return
1260 if ob=14ands(11)<>7 then ?"It displays: 'USS Ventur, Starbase 73":?"acknowledges your SOS. Transmit your":?"coordinates and we will send a rescue":?"team.'":return
1265 if ob=12ands(11)<>7andpc=0 then ?"It shows a bunch of data, including the Ventur's coordinates. The location is":?"too complicated to remember; maybe you":?"can use a PADD to record it?":return
1270 if s(11)<>7and((ob=5andpc=0)or(ob>=11andob<=14)) then ?"It shows a typical L-CARS interface.":return
1275 if ob=7 then ?"It is set to 'Detect plasma'.":return
1290 ?"It looks like a standard-issue "o$".":return
1300 gosub3000:iff then return:rem take
1310 if s(ob)<>1 then ?"You can't take that!":return
1320 ?"You take the "o$".":l(ob)=0:s(ob)=3:if ob=1 then ?"You put it on.
1340 if ob=3ands(1)=3 then ?"You attach the combadge to your uniform.
1350 if (ob=1orob=3)ands(1)=3ands(3)=3 then f=1:b(1)=0:s=s+10:q1=1:goto4500:rem remove blockage (now that we're in full uniform)
1360 if ob=4andq2=0 then s(28)=2:q2=1:s=s+10:goto4500: rem got the phaser: make button visible; quest 2 done
1390 return
1400 gosub3000:iff then return:rem drop
1420 ?"You drop the "o$".":l(ob)=r:s(ob)=1:if (ob=1orob=3)and(s(1)<>3ors(3)<>3) then b(1)=1:s=s-10:rem add blockage (not in full uniform)
1490 return
1500 gosub3000:iff then return:rem use, shoot, fire
1510 if s(ob)<>3 then ?"You don't have that.":return
1520 if (ob=8orob=4)ands(ob)=3 then gosub1600:return: rem use hypospray or phaser
1530 if ob=7ands(7)=3 then gosub4000:return: rem use tricorder
1540 if ob=6ands(6)=3 then gosub5000:return: rem use hyperspanner
1550 if ob=5andr=16ands(11)<>7 then s=s+10:?"The coordinates are copied to the PADD.":pc=1:return: rem pc=indicates PADD has the coordinates
1560 if ob=5andr=19andpc=1 then ?"The coordinates are sent from the PADD":?"to Starbase 73. The Ventur is saved! Youwin!":s=s+1000:goto9500
1590 ?"Nothing happens.":return: rem NOTE: this line # is used in many places
1599 rem use hypospray or phaser on a Borg drone
1600 if ob=8andh=2 then ?"The hypospray is empty.":return
1610 for b=24 to 27:if l(b)=rands(b)=2 then 1630: rem live drone is here
1620 next:?"There is nothing to shoot at here.":return
1630 if ob=4andpp<pr then ?"You shoot the drone but nothing happens.The Borg have adapted to the phaser's":?"power level!":return
1640 if ob=4 then pr=pr+1:s=s+100*pr:?"You shoot the drone with the phaser.
1650 if ob=8 then s=s+100:h=h+1:?"You inject the drone with the hypospray.";
1660 s(b)=7:o$(b)="a deactivated Borg drone":?"The drone is deactivated and collapses.
1670 for i=1 to nb:if b(i)=r then b(i)=0:return:rem remove blockage at this location (ignores direction)
1690 next:return
1900 if o$="" then ?"Say something!":return: rem "say"
1910 if r<>12 then 1590
1920 if o$<>"help"ando$<>"directory" then 1950
1930 ?"The turbolift says 'You are ";:d=d(12,1):if d=7 then ?"on deck 3"; else if d=13 then ?"the bridge"; else if d=31 then ?"on deck 2"; else if d=20 then ?"in engineering";
1940 ?". You can go to the bridge, deck 2, deck 3, or engineering'.":return
1950 f=0:if o$="deck 3" then f=1:d(12,1)=7 else if o$="deck 2" then f=1:d(12,1)=31 else if o$="engineering" then f=1:d(12,1)=20
1960 if o$="bridge" then if(q2*q3)=0 then ?"The turbolift says 'You are not (yet)":?"authorized to go to the bridge.'":return else f=1:d(12,1)=13
1970 if u=0andf=1 then s=s+10:u=1: rem first time using turbolift, you get 10 points.
1980 if f then ?"The doors swish close. You feel the":?"turbolift move. A few seconds later the doors swish open.":return
1990 ?"The turbolift says '"o$" is not a valid destination'.":return
2100 gosub3000:iff then return: rem tap
2110 if ob=28ands(4)=3andpp<4 then pp=pp+1:?"The power level increases to"pp:return
2120 if ob=28ands(4)=3 then ?"The power level is already at maximum.":return
2140 if r=18andob=11ands(11)=7andq3 then s=s+50:?"All the consoles on the bridge come to life!":s(11)=2:s(12)=2:s(13)=2:s(14)=2:return
2150 if r=18andob=11ands(11)=7andq3=0 then ?"Nothing happens. Perhaps there is an":?"issue in engineering?":return
2190 goto1590: rem "Nothing happens"
2200 gosub3000:iff then return:rem open
2210 if s(ob)=6 then ?"It's already open.":return
2220 if s(ob)<>5 then ?"You can't open that!":return
2230 s(ob)=6:?"You open the "o$".":if ob=2 then if s(3)=0 then s(3)=1:goto 3200 else ?"It is empty.":return: rem open desk, see combadge if it's there
2240 if ob>=15andob<=18 then s(ob+4)=2:goto3100: rem eps manifold inside the access panel
2250 if ob=23 then s=s-1000:?"Antimatter shoots out, annihilating":?"everything in its path! The ship blows":?"up! Everybody dies!":goto9500
2290 return
2300 gosub3000:iff then return:rem close
2310 if s(ob)=5 then ?"It's already closed.":return
2320 if s(ob)<>6 then ?"You can't close that.":return
2330 s(ob)=5:?"You close the "o$".":if ob=2ands(3)=1andl(3)=1 then s(3)=0: rem desk; toggle combadge visibility
2350 if ob>=15andob<=18 then s(ob+4)=0: rem access panel; toggle power conduit visibility
2390 return
2400 a=1-a:?"Auto-look turned o";:if a then ?"n." else ?"ff.
2410 return
2500 ?"You have: ";:n$="Nothing":for i=1 to no:if s(i)=3 then ?o$(i)" ";:n$="":rem inventory
2510 next:?n$:return
2600 t=val(o$):if t>0andt<=nr then r=t:?"Transporting to "r$(t):return
2610 ?"Commands: ":for i=1 to nv:?v$(i)" ";:next:?:return
2700 ?"Current score:"s:return
2999 rem double check ob. TODO: make this better, so we can more easily deal with power button
3000 f=0:if (ob=0ando$<>"")or(ob<>0ands(ob)=0) then ?"I don't know what that is.":f=1:return: rem bad object or invisible
3010 if ob=0 then ?"You must '"v$"' something!":f=1:return: rem no object
3090 return
3100 ?"You see an EPS manifold inside.":return: rem inside access panel
3200 ?"You see a combadge inside.":return: rem inside desk
3999 rem "use" tricorder
4000 if r=25ands(18)=6ands(22)=2 then ?"It reports 'Plasma detected'.":return: rem TODO randomize this location
4090 ?"It reports 'No plasma detected'.":return
4499 rem show a quest based on existing quests: q2=get phaser, q3=fix plasma leak, q4=fix computer
4500 if (q2*q3*q4)=0then?"Your combadge beeps. 'Ensign, report to
4510 if q2=0 then ?"the armory on deck 2. PREPARE TO REPEL":?"BOARDERS!'":return
4520 if q3=0 then ?"engineering to fix a plasma leak in":?"an EPS manifold.'":return
4530 if q4=0 then ?"the bridge.'
4590 return
4999 rem "use" hyperspanner
5000 if r=25ands(18)=6ands(22)=2 then q3=1:s(22)=4:s=s+200:?"The hyperspanner seals the EPS manifold.The plasma leak is fixed!":goto4500
5090 goto1590: rem "Nothing happens"
9500 ?:?"Game over. Final score:"s:end
10000 dim nd(nr),d(nr,4),d$(nr,4),r$(nr),a$(na,1),v$(nv):rem number exits,path(source,direction),direction names,rooms,aliases,verbs
10010 dim o$(no),l(no),s(no),b(nb),b$(nb,1),oa$(oa),oa(oa):rem objects,locations,status,blockage,blockage direction,description,object aliases
10030 for i=1 to nr:read r$(i),nd(i):for j=1 to nd(i):read d$(i,j),d(i,j):next:next: rem room name, number of exits, exit direction, destination
10050 for i=1 to nv:read v$(i):next:for i=1 to na:read a$(i,0),a$(i,1):next:rem verbs, directional aliases
10070 for i=1 to no:read o$(i):next:for i=1 to oa: read oa$(i),oa(i):next: rem objects, object aliases
10080 for i=1 to no:read l(i):next:for i=1 to no:read s(i):next:rem object location, status
10100 for i=1 to nb:read b(i),b$(i,0),b$(i,1):next:rem blockages, direction, what to say
10110 a$="RED ALERT! PREPARE TO REPEL BOARDERS!":pp=1:pr=1:return: rem phaser power, power required
19999 rem 35 rooms: name, number of exits, direction, destination #n
20000 data Your Quarters,3,i,4,p,2,s,3,Closet,1,s,1,Head,1,p,1,Passageway,3,o,1,cw,5,ccw,11,Passageway,2,cw,6,ccw,4
20010 data Passageway,2,cw,7,ccw,5,Deck 3 Lobby,3,i,12,cw,8,ccw,6,Passageway,2,cw,9,ccw,7,Passageway,2,cw,10,ccw,8,Passageway,2,cw,11,ccw,9
20020 data Passageway,2,cw,4,ccw,10,Turbolift,1,out,7,Bridge/Command Dais,4,f,14,p,18,s,19,a,12,Bridge/Center,3,p,15,s,16,a,13
20030 data Bridge/Helm,2,s,14,a,18,Bridge/Navigation,2,p,14,a,19,Unused,1,p,17,Bridge/Ops,2,f,15,s,13,Bridge/Comms,2,p,13,f,16
20040 data Main Engineering,2,f,12,a,21,Warp core,3,f,20,p,22,s,24,Jeffries Tube,2,s,21,p,23,Jeffries Tube,1,s,22
20050 data Jeffries Tube,2,p,21,s,25,Jeffries Tube,1,p,24,Armory,1,o,29,Sick bay,1,i,28,Passageway,3,o,27,cw,29,ccw,35
20060 data Passageway,3,i,26,cw,30,ccw,28,Passageway,2,cw,31,ccw,29,Deck 2 Lobby,3,i,12,cw,32,ccw,30,Passageway,2,cw,33,ccw,31
20070 data Passageway,2,cw,34,ccw,32,Passageway,2,cw,35,ccw,33,Passageway,2,cw,28,ccw,34
20999 rem 20 verbs
21000 data go,look,examine,get,take,drop,leave,use,fire,shoot,say,tap,open,close,inventory,inv,help,autolook,score,quit
21998 rem 10 direction aliases. Both sb and starboard map back to s. But since the short-to-long aliases are read
21999 rem left to right (line 1100), s only maps to starboard.
22000 data cw,clockwise,ccw,counterclockwise,i,inboard,o,outboard,p,port,s,starboard,a,aft,f,forward,out,out,s,sb
22999 rem 28 objects
23000 data uniform,desk,combadge,phaser,PADD,hyperspanner,tricorder,hypospray,porthole,viewscreen,computer console,nav console
23010 data helm console,comms console,access panel,access panel,access panel,access panel,EPS manifold,EPS manifold
23020 data EPS manifold,EPS manifold,warp core,Borg drone,Borg drone,Borg drone,Borg drone,power level
23099 rem 11 object aliases: alias, object id
23100 data communicator,3,padd,5,hyper-spanner,6,hypo-spray,8,computer,11,power level button,28,power button,28
23110 data panel,15,panel,16,panel,17,panel,18
23199 rem 28 object initial locations
23200 data 2,1,1,26,15,20,21,27,1,,18,16,15,19,22,23,24,25,22,23,24,25,21,29,13,16,20,
23299 rem 28 object status: 0=invisible,1=visible&gettable,2=visible&not gettable,3=gotten,4=used,5=openable,6=open,7=dead
23300 data 1,5,,1,1,1,1,1,2,2,7,7,7,7,5,5,5,5,,,,,5,2,2,2,2,
23999 rem 4 blockages: from room, direction, message
24000 data 1,i,You need to be in full uniform first!,29,i,A Borg drone blocks your path!,13,p,A Borg drone blocks your path.
24010 data 16,a,A Borg drone blocks your path...,20,a,A Borg drone blocks your path!
