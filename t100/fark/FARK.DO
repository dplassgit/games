0 REM FARKLE! for Tandy 200 by David Plass
5 GOSUB1000:GOTO100: REM Set up
39 REM Calculate "Selected total" in ST. If A=1 then all table dice are counted, otherwise just selected dice in S()
40 ST=0:FORI=1TO6:C(I)=0:D(I)=0:NEXT:FORI=1TONT:IFAORS(I)THENC(T(I))=C(T(I))+1:NEXTELSENEXT
41 FORI=1TO6:D(C(I))=D(C(I))+1:NEXT: REM D(I)=how many of each count, i.e., D(2) is how many doubles
42 IFD(1)=6ORD(2)=3OR(D(2)ANDD(4))THENST=ST+1500:RETURN: REM straight, xxyyzz, xxxxyy
43 IFD(3)=2THENST=ST+2500:RETURN: REM xxxyyy
44 ST=ST+1000*D(4)+2000*D(5)+3000*D(6): REM 4, 5, 6 of a kind
45 IFD(6)THENRETURN: REM 6 of a kind, done
46 FORI=1TO6:IFC(I)=3THENST=ST+I*100-900*(I=1): REM xxx (111 scores 1000)
47 IFC(I)<=2THENST=ST-C(I)*(50*(I=5)+100*(I=1)): REM 1, 11, 5, 55
48 NEXT:RETURN
59 REM Draw running total subroutine
60 ?@614,ST+RT"  ":RETURN
69 REM Draw indexes subroutine. Erases numbers after NT
70 L=200:FORI=1TO6:?@L,"";:L=L+5:IFI>NTTHEN?"  "ELSE?CHR$(32+10*S(I))CHR$(48+I): REM space or star if selected, then index
71 NEXT:RETURN
79 REM Draw die D at location L. Updates L=L+5
80 D$=D$(D):?@L,LEFT$(D$,3):?@L+40,MID$(D$,4,3):?@L+80,RIGHT$(D$,3):L=L+5:RETURN
99 REM Main loop: show score, roll dice
100 GOSUB60:?@26,R$" SCORE:"S:?@66," ROLLS:"R;N$
110 IFR=11THEN700: REM Game over
120 FORI=1TO6:S(I)=0:NEXT:GOSUB70:D=0:L=80:FORI=1TO6:GOSUB80:NEXT: REM clear selected, draw indexes, erase table dice
130 L=80:FORI=1TONT:T(I)=INT(6*RND(1)+1):D=T(I):GOSUB80:NEXT: REM randomize the first nt dice
140 A=1:GOSUB40:F=ST:ST=0:A=0:IFF=0THENGOSUB800:GOTO100: REM Farkle!
190 ?@280,P$CHR$(48+NT)Q$: REM prompt "Keep (1-" number of table dice "), Roll, Bank"
199 REM Input loop
200 K$=INKEY$:IFK$=""THEN200
210 ?@304,K$:K=VAL(K$):IFKANDK<=NTTHENS(K)=1-S(K):?@195+K*5,CHR$(32+10*S(K))CHR$(48+K):GOSUB40:GOSUB60: REM selected a die
220 B=0:IFK$="r"ORK$="R"THENGOSUB300: REM Roll
230 IFK$="b"ORK$="B"THENGOSUB400: REM Bank
240 ?@304," ":IFBTHEN100ELSE200: REM Erase keystroke, B=flag to roll or not
299 REM Roll subroutine
300 IFST=0THENBEEP:RETURN: REM Selected total is 0, cannot roll
310 C=0:FORI=1TONT:C=C+S(I):NEXT:IFC=NTTHEN400: REM If selected all table dice, it's the same as bank.
319 REM Copy selected dice to H(hand) array TODO: only copy dice that are in a meld
320 N=NT:FORI=1TON:IFS(I)THENNH=NH+1:H(NH)=T(I):NT=NT-1
330 NEXT:GOSUB900:RT=RT+ST:ST=0: REM Draw new hand, update running total with selected total
390 B=1:RETURN: REM b=1 indicates we want to roll next
399 REM Bank subroutine
400 IFRT+ST=0THENBEEP:RETURN: REM If no running total, cannot bank
410 S=S+ST+RT:ST=0:RT=0:NT=6:NH=0:R=R+1:GOSUB900:B=1:RETURN: REM bump score, clear hand, roll all
700 ?@280,R$CHR$(27)"WGAME OVER!"N$SPACE$(17)
710 ?:?R$"YOU ";:IFS<5000THEN?"LOST!"N$ELSE?"WON!"N$
790 END
799 REM Farkle subroutine
800 ?@280,R$"FARKLE!!"N$SPACE$(17):FORI=1TO1000:NEXT:R=R+1:RT=0:NT=6:NH=0:REM bump # of rolls, clear stuff
810 ?@280,SPACE$(8): REM FALL THROUGH: (It will clear the hand because NH is 0)
899 REM Draw hand subroutine
900 L=440:FORI=1TO6:D=-H(I)*(I<=NH):GOSUB80:NEXT:RETURN
999 REM set up
1000 CLS:DEFINTA-Z:R$=CHR$(27)+"p":N$=CHR$(27)+"q": REM reverse, normal video
1020 ?@6,R$CHR$(27)"V F A R K L E !"N$:Z=RND(-VAL(RIGHT$(TIME$,2))):A=0:B=0:D=0: REM local variables
1030 DIMC(6),D(6),D$(6),H(6),S(6),T(6): REM die count, count count, dice strings, hand dice, selected dice, table dice
1040 NT=6:NH=0:S=0:RT=0:ST=0:R=1: REM number on table, number in hand, score, running total, selected total, # rolls
1050 FORI=0TO6:READD$(I):NEXT: REM read dice strings (0th entry is blank)
1060 ?@360,"Kept:":L=189:FORI=1TO12:READS$:?@L,S$:L=L+40:NEXT: REM Print scoring values
1070 ?@600,"Running total:
1080 P$="Keep ("+R$+"1"+N$+"-"+R$:Q$=N$+"), "+R$+"R"+N$+"oll, "+R$+"B"+N$+"ank:  "
1090 RETURN
2000 DATA"         ","    o    ","o       o","o   o   o","o o   o o","o o o o o","o oo oo o"
2010 DATA" Scoring:",  "     1: 100","     5:  50","   111:1000","   xxx: x00","  xxxx:1000"
2020 DATA" xxxxx:2000","xxxxxx:3000","xxyyzz:1500","xxxxyy:1500","xxxyyy:2500","123456:1500"
