0 CLS: DEFINTA-Z: M1=520: M2=560: M3=600: ?"  OUTPOST": Z=RND(-VAL(RIGHT$(TIME$,2)))
1 REM Based on outpost.prg https://www.commodoregames.net/CommodorePET/Outpost-437.html
2 REM Original author unknown
3 REM T200 Version Copyright 2026 David Plass
5 GOTO50
20 FA=1+Z*RND(1): RETURN
50 DIM M%(11,11): REM map; value (Y,X) contains the asc of the ship number there.
60 FORY=1TO11: FORX=1TO11: M%(Y,X)=46: NEXT: NEXT: M%(6,6)=157: REM outpost
70 C=99: G=1: GOSUB5110: GOSUB2000: REM start off with one ship (G=1); give initial supply
80 E$(0)="---": E$(1)="LGT": E$(2)="MDM": E$(3)="HVY
90 CL$=CHR$(13)+SPACE$(39)+CHR$(13)			   ' Clear Line
200 GOSUB5000: GOSUB1000: GOSUB6000: GOSUB3000: GOSUB4000: REM main loop
210 GOTO200
999 REM Redraw screen
1000 P=13: ?@P,"ENEMY  1   2   3   4": P=P+40
1010 ?@P,"---------------------": P=P+40
1020 ?@P,"TYPE: ";
1030 FOR G=1 TO 4: ?E$(ET(G))" ";: NEXT
1100 P=P+40: ?@P,"DIST:": P=P+40: ?@P,"PROB:": P=P+40: ?@P,"ENGY:
1120 FOR G=1 TO 4
1125 P=135+G*4: ?@P,ED(G): REM distance
1130 P=P+40: ?@P,EH(G): REM proability
1135 P=P+40: ?@P,EE(G): REM energy
1140 NEXT
1300 P=293: ?@P,"STATUS": P=P+40
1305 ?@P,"--------": P=P+40
1310 ?@P,"ENGY:"E: P=P+40
1320 ?@P,"COMP:"C: P=P+40
1330 ?@P,"PTS: "VP
1340 P=304: ?@P,"WEAPONS": P=P+40
1345 ?@P,"--------": P=P+40
1350 ?@P,"MAIN:"M: P=P+40
1360 ?@P,"SECN:"S: P=P+40
1370 ?@P,"TORP:"T: P=P+40
1380 ?@40,;
1500 FORY=1TO11: FORX=1TO11: ?CHR$(M%(Y,X));: NEXT: ?: NEXT
1600 RETURN
1999 REM resupply/recharge
2000 ET(5)=0: EX(5)=0: EY(5)=0: E=99: M=99: S=99: C=99
2020 T=T+5: IF T>9 THEN T=9
2030 RETURN
2999 REM Move ship positions, test for supply ship, test for die
3000 ?@M1,CL$;"ENEMY FIRING & MOVING
3010 ?@M2,CL$
3020 FOR G=1 TO 5: IF ET(G)=0 THEN 3400: REM no ship at this index
3030 Z=9: GOSUB20: IF G<5 AND FA>5 THEN 3340: REM didn't move
3100 M%(EY(G), EX(G))=46: REM clear this spot /dot
3200 EX(G)=EX(G)+(EX(G)>6)-(EX(G)<6): REM move towards 6,6
3220 EY(G)=EY(G)+(EY(G)>6)-(EY(G)<6)
3240 IF ET(5)=5 AND EY(5)=6 AND EX(5)=6 THEN GOSUB2000: REM supply ship got to you.
3250 IF EY(G)=6 AND EX(G)=6 THEN 9500 : REM you died
3265 IF G<5 AND EX(G)=EX(5) AND EY(G)=EY(5) THEN ET(5)=0: EX(5)=0: EY(5)=0: REM supply ship killed
3300 ED(G)=INT(SQR((EX(G)-6)^2+(EY(G)-6)^2))
3330 EH(G)=INT(1/(ED(G))*100+(C/2)): IF EH(G)>99 THEN EH(G)=99
3340 M%(EY(G), EX(G))=48+G-30*(G=5)
3400 NEXT: RETURN
3999 REM enemy attack (moving is really in 3k)
4000 FOR G=1 TO 4: IF ET(G)=0 THEN 4100
4030 Z=99: GOSUB20: F9=FA: Z=30: GOSUB20: IF F9>(EE(G)+FA) OR EE(G)<10 THEN 4100
4040 Z=5: GOSUB20: E=E-FA*ET(G): IF E<0 THEN 9500: REM you died
4050 Z=10: GOSUB20: EE(G)=EE(G)-FA
4060 Z=10: GOSUB20: IF FA=1 THEN Z=25: GOSUB20: C=C-FA: IF C<1 THEN 9500: REM you died
4070 Z=10: GOSUB20: IF FA=1 THEN Z=25: GOSUB20: M=M-FA: IF M<0 THEN M=0
4080 Z=10: GOSUB20: IF FA=1 THEN Z=25: GOSUB20: S=S-FA: IF S<0 THEN S=0
4100 NEXT: RETURN
4999 REM make a ship appear
5000 Z=5: GOSUB20: G=FA: REM G=ship number
5005 Z=4: GOSUB20: IF G=5 AND ET(5)=0 AND FA>1 THEN ET(5)=5: GOTO5160: REM add supply ship
5010 Z=9: GOSUB20: IF G=5 OR ET(G)<>0 OR FA>4 THEN 5400
5110 Z=50: GOSUB20: A=4-INT(LOG(FA+2))
5120 ET(G)=A: EE(G)=99
5159 REM pick x, y location, override with quadrant edge
5160 Z=11: GOSUB20: EX(G)=FA
5170 Z=11: GOSUB20: EY(G)=FA
5180 Z=4: GOSUB20: A=FA: IF A=1 THEN EY(G)=1
5190 IF A=2 THEN EY(G)=11
5200 IF A=3 THEN EX(G)=11
5210 IF A=4 THEN EX(G)=1
5220 REM TODO: if there's already something at that spot, skip it
5300 ED(G)=INT(SQR((EX(G)-6)^2+(EY(G)-6)^2))
5320 EH(G)=INT(1/(ED(G))*100+(C/2)): IF EH(G)>99 THEN EH(G)=99
5330 M%(EY(G), EX(G))=48+G-30*(G=5)
5400 RETURN
5999 REM Get input and fire weapon
6000 ?@M1,CL$"WEAPON (M/S/T/C): ";
6010 A$=INKEY$: IF A$="" THEN6010
6015 A=0
6020 IF (A$="M" OR A$="m") AND M>0 THEN ?"MAIN BATTERY": A=6: Z=5: GOSUB20: M=M-FA: IF M<0 THEN M=0

6025 IF A$="C" OR A$="c" THEN ?"CHARGING": Z=20: GOSUB20: E=E+FA: IF E>99 THEN E=99
6030 IF A$="C" OR A$="c" THEN GOSUB1000: RETURN
6035 IF (A$="S" OR A$="s") AND S>0 THEN ?"SECONDARY BATTERY": A=4: Z=5: GOSUB20: S=S-FA: IF S<0 THEN S=0
6040 IF (A$="T" OR A$="t") AND T>0 THEN ?"TORPEDO": A=9: T=T-1
6060 IF A<3 THEN ?@M1,CL$"BAD INPUT!": FORZ=1TO500: NEXT: GOTO6000
6100 ?@M2,CL$"TARGET NO: ";
6110 B$=INKEY$: IF B$="" THEN6110
6120 ?B$" ";:B=VAL(B$): IF ET(B)=0 OR ET(B)=5 THEN ?"BAD DATA!": FORZ=1TO500: NEXT: GOTO6000
6130 FOR ZZ=1 TO 3: FOR Z=1 TO 50: NEXT: ?". ";: NEXT ZZ
6200 Z=99: GOSUB20: IF FA>EH(B) THEN ?"MISSED!": GOTO 6240
6210 ?"TARGET HIT!
6215 Z=15: GOSUB20: EE(B)=INT(EE(B)-((A*FA)/ET(B)))
6220 IF EE(B)<1 THEN6500
6230 Z=5: GOSUB20: E=E-FA: REM reduce our energy by a random amount
6240 GOSUB1000: FOR Z=1 TO 1000: NEXT: ?@M1,CL$:?@M2,CL$:?@M3,CL$;
6300 RETURN
6499 REM Enemy # B was destroyed
6500 M%(EY(B),EX(B))=46: VP=VP+ET(B): EX(B)=0: EY(B)=0: ET(B)=0: EH(B)=0: ED(B)=0: EE(B)=0
6520 FOR Z=1 TO 1000: NEXT: ?@M3,CL$"TARGET DESTROYED!";
6540 GOTO 6240
9500 ?@M2,CL$"YOU ARE DESTROYED!!!!!
9510 ?"SCORE ="VP: ?
9520 IF VP>HS THEN HS=VP
9530 ?"****************
9540 ?"HIGH SCORE ="HS
9550 ?"****************
9600 ?"ANOTHER GAME?";
9610 A$=INKEY$: IF A$="" THEN 9610
9620 IF A$="Y" OR A$="y" THEN RUN
