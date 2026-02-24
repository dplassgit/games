0 REM FARKLE! for Tandy 200 by David Plass
10 R$=CHR$(27)+"p":N$=CHR$(27)+"q": REM reverse, normal video
20 CLS:DEFINTA-Z:?@6,R$" F A R K L E !"N$:Z=RND(-VAL(RIGHT$(TIME$,2)))
30 DIMC(6),D(6),D$(6),H(6),S(6),T(6): REM die count, count count, dice strings, hand dice, selected dice, table dice
40 NT=6:NH=0:S=0:RT=0:ST=0:R=1: REM number on table, number in hand, score, running total, selected total, # rolls
50 FORI=0TO6:READD$(I):NEXT: REM read dice strings
60 ?@360,CHR$(27)"VKept:":L=189:FORI=1TO12:READS$:?@L,S$:L=L+40:NEXT: REM scoring values (display only)
99 REM main loop
100 GOSUB600: GOSUB650: REM draw scores
110 IFR=11THEN700
120 FORI=1TO6:S(I)=0:NEXT:GOSUB2000:D=0:L=80:FORI=1TO6:GOSUB1000:NEXT: REM draw indexes, erase table dice
130 L=80:FORI=1TONT:T(I)=INT(6*RND(1)+1):D=T(I):GOSUB1000:NEXT: REM randomize the first nt dice
140 A=1:GOSUB5000:F=ST:ST=0:A=0:IFF=0THENGOSUB800:GOTO100
199 REM Input loop
200 ?@280,"Keep ("R$"1"N$"-"R$CHR$(48+NT)N$"), "R$"R"N$"oll, "R$"B"N$"ank:  ";
210 K$=INKEY$:IFK$=""THEN210
220 ?@304,K$;:K=VAL(K$):IFK>0ANDK<=NTTHEN500: REM selected a die
230 IFK$="r"ORK$="R"THEN300: REM roll
240 IFK$="b"ORK$="B"THEN400: REM bank
290 GOTO200
299 REM Roll: NOT A SUBROUTINE
300 IFST=0THENBEEP:GOTO200: REM selected total is 0, cannot roll
310 C=0:FORI=1TONT:C=C+S(I):NEXT:IFC=NTTHEN400: REM If selected all table dice, it's the same as bank.
319 REM copy selected dice to H(hand) array TODO: only copy dice that are in a meld
320 N=NT:FORI=1TON:IFS(I)THENNH=NH+1:H(NH)=T(I):NT=NT-1
330 NEXT:GOSUB3000:RT=RT+ST:ST=0: REM draw new hand, update running total
390 GOTO100
399 REM Bank: NOT A SUBROUTINE
400 IFRT+ST=0THENBEEP:GOTO200: REM If no running total, cannot bank
410 S=S+ST+RT:ST=0:RT=0:NT=6:NH=0:R=R+1:GOSUB3000: REM bump score, clear hand
420 GOTO100
499 REM Toggle selected die from the table. Draw indexes, calc potential score. NOT A SUBROUTINE
500 S(K)=1-S(K):GOSUB2000:GOSUB5000:GOSUB600
510 GOTO200
599 REM Draw scores subroutine
600 ?@600,"Running total:"ST+RT"  ":RETURN
650 ?@26,R$" SCORE:"S:?@66," ROLLS:"R;N$:RETURN
699 REM game over
700 ?@280,R$"GAME OVER!"N$SPACE$(17)
710 ?:?R$"YOU ";:IFS<5000THEN?"LOST!"ELSE?"WON!"
720 ?CHR$(27)"W"N$;
790 END
799 REM farkle subroutine
800 ?@280,"FARKLE!!"SPACE$(17):FORT=1TO1000:NEXT
810 R=R+1:RT=0:NT=6:NH=0:GOSUB3000: REM bump # of rolls, clear stuff, erase hand.
890 RETURN
999 REM draw die D at location L. updates L=L+5
1000 D$=D$(D):?@L,LEFT$(D$,3):?@L+40,MID$(D$,4,3):?@L+80,RIGHT$(D$,3)
1010 L=L+5:RETURN
1999 REM Draw indexes subroutine. Erases numbers after NT
2000 FORI=1TO6:?@195+I*5,"";:IFI>NTTHEN?"  ":GOTO2090
2010 ?CHR$(32+10*S(I))CHR$(48+I): REM space or star if selected, then index
2090 NEXT:RETURN
2999 REM Draw hand subroutine
3000 L=440:FORI=1TO6:D=-H(I)*(I<=NH):GOSUB1000:NEXT
3090 RETURN
4999 REM Calculates "Selected total" in ST. If A=1 then all table dice are counted, otherwise just selected dice in S()
5000 ST=0:FORI=1TO6:C(I)=0:D(I)=0:NEXT
5010 FORI=1TONT:IFAORS(I)THENC(T(I))=C(T(I))+1
5020 NEXT
5030 FORI=1TO6:D(C(I))=D(C(I))+1:NEXT: REM D(I)=how many of each count, i.e., D(2) is how many doubles
5040 IFD(1)=6ORD(2)=3OR(D(2)ANDD(4))THENST=ST+1500:GOTO5200: REM straight, xxyyzz, xxxxyy
5050 IFD(3)=2THENST=ST+2500:GOTO5200: REM xxxyyy
5060 ST=ST+1000*D(4)+2000*D(5)+3000*D(6): REM 4, 5, 6 of a kind
5070 IFD(6)THEN5200: REM 6 of a kind, done
5099 REM find triples (except xxxyyy, already taken care of) and solo 1 & 5s
5100 FORI=1TO6:IFC(I)=3THENST=ST+I*100-900*(I=1): REM xxx (111 scores 1000)
5110 IFC(I)<=2THENST=ST-C(I)*(50*(I=5)+100*(I=1)): REM 1, 11, 5, 55
5190 NEXT
5200 RETURN
10000 DATA"         ","    o    ","o       o","o   o   o","o o   o o","o o o o o","o oo oo o"
10010 DATA" Scoring:",  "     1: 100","     5:  50","   111:1000","   xxx: x00","  xxxx:1000"
10020 DATA" xxxxx:2000","xxxxxx:3000","xxyyzz:1500","xxxxyy:1500","xxxyyy:2500","123456:1500"
