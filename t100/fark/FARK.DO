0 REM FARKLE! for Tandy 200 by David Plass
10 CLS:?@17,CHR$(27)"VFARKLE":Z=RND(-VAL(RIGHT$(TIME$,2))):DEFINTA-Z:DIMC(6),D(6),D$(6),H(6),S(6),T(6)
20 FORI=0TO6:READD$(I):NEXT: REM read dice strings
30 ?@360,"Kept:":?@191,"SCORING:":L=229:FORI=1TO11:READS$:?@L,S$:L=L+40:NEXT: REM scoring values (display only)
50 NT=6:NH=0:S=0:RT=0:REM number on table, number in hand, score, running total (not banked)
99 REM main loop
100 GOSUB500
105 L=80:FORI=1TO6:S(I)=0:NEXT:GOSUB2000:D=0:FORI=1TO6:GOSUB1000:NEXT: REM erase table dice
110 L=80:FORI=1TONT:T(I)=INT(6*RND(1)+1):D=T(I):GOSUB1000:NEXT:GOSUB2000: REM randomize the first nt dice
120 A=1:GOSUB5000:F=ST:ST=0:A=0:IFF=0THEN?@280,"FARKLED!"SPACE$(17):FORT=1TO1000:NEXT:RT=0:NT=6:NH=0:GOSUB3000:GOTO100
199 REM Input loop
200 ?@280,"Keep (1-"CHR$(48+NT)"), Roll, Bank:  ";
210 K$=INKEY$:IFK$=""THEN210
220 ?@304,K$;:K=VAL(K$):IFK>0ANDK<=NTTHENS(K)=1-S(K):GOSUB2000:GOSUB5000:GOSUB500: REM draw indexes, calc & show score
230 IFK$="r"ORK$="R"THEN300: REM roll
240 IFK$="b"ORK$="B"THEN400: REM bank
290 GOTO200
299 REM Roll
300 IFST=0THENBEEP:GOTO200: REM selected total is 0, cannot roll
310 C=0:FORI=1TONT:C=C+S(I):NEXT:IFC=NTTHEN400: REM If selected all table dice, it's the same as bank.
319 REM copy selected dice to H(hand) array TODO: only copy dice that are in a meld
320 N=NT:FORI=1TON:IFS(I)THENNH=NH+1:H(NH)=T(I):NT=NT-1
330 NEXT:GOSUB3000:RT=RT+ST:ST=0:GOSUB500: REM draw new hand, update running total
390 GOTO100
399 REM bank.
400 IFRT+ST=0THENBEEP:GOTO200: REM If no running total, cannot bank
410 S=S+ST+RT:ST=0:RT=0:NT=6:NH=0:GOSUB3000: REM bump score, clear hand
420 GOTO100
499 REM Draw scores
500 ?@600,"Running total:"ST+RT"  ":?@27,"Score:"S;:RETURN
999 REM draw die D at location L. updates L=L+5
1000 D$=D$(D):?@L,LEFT$(D$,3):?@L+40,MID$(D$,4,3):?@L+80,RIGHT$(D$,3)
1010 L=L+5:RETURN
1999 REM draw indexes
2000 FORI=1TO6:?@195+I*5,"";:IFI>NTTHEN?"  ":GOTO2090
2010 ?CHR$(32+10*S(i))CHR$(48+I)
2090 NEXT:RETURN
2999 REM Draw hand
3000 L=440:FORI=1TO6:D=-H(I)*(I<=NH):GOSUB1000:NEXT
3090 RETURN
4999 REM Calculate "selected total" in st. If A=1 then all table dice are counted
5000 ST=0:FORI=1TO6:C(I)=0:D(I)=0:NEXT
5010 FORI=1TONT:IFAORS(I)THENC(T(I))=C(T(I))+1:NEXTELSENEXT
5015 FORI=1TO6:D(C(I))=D(C(I))+1:NEXT: REM D(I)=how many of each count, i.e., D(2) is how many doubles
5020 IFD(1)=6ORD(2)=3OR(D(2)ANDD(4))THENST=ST+1500:GOTO5200: REM straight, xxyyzz, xxxxyy
5050 IFD(3)=2THENST=ST+2500:GOTO5200: REM xxxyyy
5060 ST=ST+1000*D(4)+2000*D(5)+3000*D(6): REM 4, 5, 6 of a kind
5070 IFD(6)THEN5200: REM 6 of a kind, done
5099 REM find triples and solo 1 & 5s
5100 FORI=1TO6:IFC(I)=3THENST=ST+I*100-900*(I=1): REM xxx (111 scores 1000)
5120 IFC(I)<=2THENST=ST-C(I)*(50*(I=5)+100*(I=1)): rem 1, 11, 5, 55
5150 NEXT
5200 RETURN
10000 DATA"         ","    o    ","o       o","o   o   o","o o   o o","o o o o o","o oo oo o"
10010 DATA"     1: 100","     5:  50","   111:1000","   xxx: x00","  xxxx:1000"," xxxxx:2000","xxxxxx:3000"
10020 DATA"xxyyzz:1500","xxxxyy:1500","xxxyyy:2500","123456:1500"
