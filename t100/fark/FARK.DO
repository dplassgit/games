0 REM FARKLE! for Tandy 200 by David Plass
5 GOSUB1000:GOSUB30000:GOTO100: REM Set up
39 REM Calculate "Selected total" in ST. If A=1 then all table dice are counted, otherwise just selected dice in S()
40 ST=0:FORI=1TO6:C(I)=0:D(I)=0:NEXT:FORI=1TONT:IFAORS(I)THENT=T(I):C(T)=C(T)+1:NEXTELSENEXT
41 FORI=1TO6:D(C(I))=D(C(I))+1:NEXT: REM D(I)=how many of each count, i.e., D(2) is how many doubles
42 IFD(1)=6ORD(2)=3OR(D(2)ANDD(4))THENST=ST+1500:RETURN: REM straight, xxyyzz, xxxxyy
43 IFD(3)=2THENST=ST+2500:RETURN: REM xxxyyy
44 IFD(6)THENST=ST+3000:RETURN: REM 6 of a kind
45 ST=ST+1000*D(4)+2000*D(5): REM 4, 5 of a kind
47 FORI=1TO6:IFC(I)=3THENST=ST+I*100-900*(I=1): REM xxx (111 scores 1000)
48 IFC(I)<=2THENST=ST-C(I)*(50*(I=5)+100*(I=1)): REM 1, 11, 5, 55
49 NEXT:RETURN
79 REM Draw die D at location L. Updates L=L+5
80 ?@L,;:GOSUB 30100:?@L+40,;:GOSUB30200:?@L+80,;:GOSUB30300: L=L+5: RETURN
99 REM Main loop: show score, roll dice
100 ?@614,ST+RT"  ";:?@26,R$" SCORE:"S:?@66," ROLLS:"R;N$
110 IFR=11THEN700: REM Game over
115 L=80:IL=200:D=0:FORI=1TO6:S(I)=0:GOSUB80:?@IL," ";:IL=IL+5:IFI>NTTHEN?" ":NEXTELSE?CHR$(48+I):NEXT
120 REM D=0:L=80:FORI=1TO6:S(I)=0:GOSUB80:NEXT: REM clear selected, draw indexes, erase table dice
130 L=80:FORI=1TONT:T(I)=INT(6*RND(1)+1):D=T(I):GOSUB80:NEXT: REM randomize the first nt dice
140 A=1:GOSUB40:F=ST:ST=0:A=0:IFF=0THENGOSUB800:GOTO100: REM Farkle!
190 ?@280,P$CHR$(48+NT)Q$: REM prompt "Keep (1-" number of table dice "), Roll, Bank"
199 REM Input loop
200 Z=RND(1):K$=INKEY$:IFK$=""THEN200
210 ?@304,K$:K=VAL(K$):IFKANDK<=NTTHENS(K)=1-S(K):?@195+K*5,CHR$(32+10*S(K)):GOSUB40:?@614,ST+RT"  ";: REM selected a die
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
700 ?@280,R$"GAME OVER!"N$SPACE$(17)
710 ?:?R$"YOU ";:IFS<5000THEN?"LOST!"N$ELSE?"WON!"N$
790 END
799 REM Farkle subroutine
800 ?@280,R$"FARKLE!!"N$SPACE$(17):FORI=1TO1000:NEXT:R=R+1:RT=0:NT=6:NH=0:REM bump # of rolls, clear stuff
810 ?@280,SPACE$(8): REM FALL THROUGH: (It will clear the hand because NH is 0)
899 REM Draw hand subroutine
900 L=440:FORI=1TO6:D=-H(I)*(I<=NH):GOSUB80:NEXT:RETURN
999 REM set up
1000 CLS:DEFINTA-Z:R$=CHR$(27)+"p":N$=CHR$(27)+"q": REM reverse, normal video
1010 NS$=CHR$(27)+"V": SC$=CHR$(27)+"W": REM no scroll, scrolling last line
1020 ?@6,R$" F A R K L E !"N$:Z=RND(-VAL(RIGHT$(TIME$,2))):A=0:B=0:D=0: REM local variables
1030 DIMC(6),D(6),H(6),S(6),T(6): REM die count, count count, hand dice, selected dice, table dice
1040 NT=6:NH=0:S=0:RT=0:ST=0:R=1: REM number on table, number in hand, score, running total, selected total, # rolls
1060 ?@360,NS$"Kept:";:L=189:FORI=1TO12:READS$:?@L,S$;:L=L+40:NEXT:?@0,SC$: REM Print scoring values
1070 ?@600,"Running total:";
1080 P$="Keep ("+R$+"1"+N$+"-"+R$:Q$=N$+"), "+R$+"R"+N$+"oll, "+R$+"B"+N$+"ank:  "
1090 RETURN
2010 DATA" Scoring:",  "     1: 100","     5:  50","   111:1000","   xxx: x00","  xxxx:1000"
2020 DATA" xxxxx:2000","xxxxxx:3000","xxyyzz:1500","xxxxyy:1500","xxxyyy:2500","123456:1500"
30000 REM Define dots for the dice
30002 'ML routines by Jim Irwin (72346,1020)
30010 RESTORE 30000
30020 FOR I!=64000 TO 64007:READ N:POKE I!,N:NEXT
30025 DIM CD(4)
30030 FOR J=0 TO 3:READ X,Y:CD(J)=X+256*Y-32768 :NEXT
30040 RETURN
30050 REM Print dot current location
30060 CALL 64000,0,VARPTR(CD(0))  '       Find address of desired pixel image
30070 CALL 64004,0,CSRLIN*320+POS(0)     'Set @ cursor position
30080 ? CHR$(27);"C";'Escape-C to update cursor
30090 RETURN
30100 REM Print first line of dots by input D
30105 IF D=0 THEN ?"   ";: RETURN
30110 IF D=1 THEN RETURN
30120 IF D=2 OR D=3 THEN ?"  ";:GOSUB30050:RETURN
30130 GOSUB30050:?" ";:GOSUB30050:RETURN
30200 REM Print 2nd line
30205 IF D=0 THEN ?"   ";: RETURN
30210 IF D=1 OR D=3 OR D=5 THEN ?" ";:GOSUB 30050:RETURN
30220 IF D=6 THEN GOSUB30050:?" ";:GOSUB 30050:RETURN
30290 RETURN
30300 REM print 3rd line
30305 IF D=0 THEN ?"   ";: RETURN
30310 IF D=1 THEN RETURN
30320 IF D=2 OR D=3 THEN GOSUB 30050: RETURN
30330 GOSUB 30050:?" ";:GOSUB30050:RETURN
30390 RETURN
33000 'ML Routine by Jim Irwin
33010 DATA 34,164,254,201,235,195,215,141
33019 'DOT
33020 DATA 0,14,31,31,31,14,0,0
