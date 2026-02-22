0 CLS:Z=RND(-VAL(RIGHT$(TIME$,2)))
10 PRINT@17,"FARKLE":PRINT@360,"HAND:"
20 FORI=0TO6:READD$(I):NEXT:NT=6:NH=0:REM number table, number hand
25 L=69:FORI=1TO11:READS$:PRINT@L,S$:L=L+40:NEXT
30 S=0:RT=0:REM score, running total (not banked)
99 REM main loop
100 L=80:D=0:FORI=1TO6:S(I)=0:NEXT:GOSUB2000:FORI=1TO6:GOSUB1000:L=L+5:NEXT:REM erase all dice
110 L=80:FORI=1TONT:T(I)=INT(6*RND(1)+1):D=T(I):GOSUB1000:L=L+5:NEXT:GOSUB2000:REM randomize nt dice
120 REM test for farkle
190 IFNT=0THENEND:NT=6:GOTO100
200 PRINT@280,"Pick (1-"CHR$(48+NT)"), roll, bank?"
210 K$=INKEY$:IFK$=""THEN210
220 K=VAL(K$):IFK>0ANDK<=NTTHENS(K)=1-S(K):GOSUB2000:REM TODO score selected.
230 IFK$="r"ORK$="R"THENGOSUB1500:GOSUB3000:GOTO100:REM if rt=0, error
240 IFK$="b"ORK$="B"THENS=S+RT:RT=0:NT=6:NH=0:GOSUB3000:GOTO100:REM todo add selected die to hand
900 GOTO200
998 END
999 REM draw die d at location l
1000 D$=D$(D):PRINT@L,LEFT$(D$,3):PRINT@L+40,MID$(D$,4,3):PRINT@L+80,RIGHT$(D$,3)
1010 RETURN
1500 REM copy selected dice to hand
1510 F=0:NN=NT:FORI=1TONN:F=(F)ORS(I):IFS(I)THENNH=NH+1:H(NH)=T(I):NT=NT-1
1520 NEXT
1599 RETURN
1999 REM draw indexes
2000 FORI=1TO6:PRINT@195+I*5,"";:IFI>NTTHENPRINT"  ":GOTO2090
2010 IFS(I)THENPRINT"*";ELSEPRINT" ";
2080 PRINTCHR$(48+I)
2090 NEXT:RETURN
2999 REM draw hand
3000 L=440:FORI=1TO6:D=-H(I)*(I<=NH)
3010 GOSUB1000:L=L+5:NEXT
3090 RETURN
9930 L=0:FORJ=1TO6:D=INT(6*RND(1)+1):GOSUB1000:L=L+5:NEXT:REM test dice printing routine
10000 DATA"         ","    o    ","o       o","o   o   o","o o   o o","o o o o o","o oo oo o"
10050 DATA"     1: 100","     5:  50","   111:1000","   xxx: x00","  xxxx:1000"," xxxxx:2000","xxxxxx:3000"
10100 DATA"123456:1500","xxyyzz:1500","xxxxyy:1500","xxxyyy:2500"
