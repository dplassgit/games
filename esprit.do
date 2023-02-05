0 CLS:PRINTCHR$(27);"V";CHR$(27);"q
5 DEFINTA-Z
10 CC=0:CR=0: REM cursor col, row
12 PC=0:PR=0: REM previous cursor col, row
15 RC=0:RR=0: rem origin col, row
20 PRINT@(0),"Command:"
30 GOSUB 2000: rem draw the indexes
35 gosub 1200: rem draw the initial cursor

39 rem main loop:
40 K$=INKEY$:IFK$=""GOTO40
50 IF K$="j" THEN CR=CR+1:GOSUB 1000:GOTO 40
60 IF K$="k" THEN CR=CR-1:GOSUB 1000:GOTO 40
70 IF K$="l" THEN CC=CC+1:GOSUB 1000:GOTO 40
80 IF K$="h" THEN CC=CC-1:GOSUB 1000:GOTO 40
90 IF K$="q" THEN 9000: rem quit
100 GOTO40

999 rem todo: figure out if need to move origin
1000 REM draw previous cursor in regular
1010 SC=(PC MOD 7)+1:SR=(PR MOD 6)+2
1020 rem SC=PC+1:SR=PR+2
1030 PRINT@(SC*5+SR*40),"     ";

1100 rem ?@(0),"cr=";cr;"cc=";cc
1110 IF CR<0 THEN CR=0
1120 IF CR>25 THEN CR=25
1130 IF CC<0 THEN CC=0
1140 IF CC>26 THEN CC=26
1150 rem ?@(20),"ncr=";cr;"ncc=";cc

1200 REM show cursor in reverse
1210 SC=(CC MOD 7)+1:SR=(CR MOD 6)+2
1220 rem SC=CC +1:SR=CR +2
1230 PRINT @(SC*5+SR*40),CHR$(27);"p     ";CHR$(27);"q

1290 PC=CC: PR=CR: rem save cursor location
1300 rem todo: if origin moved, redraw the headers 
1310 return

2000 PRINT @(45),"";: REM redraw the headers
2010 FORC=RC TO RC+6:PRINTCHR$(27);"p  ";CHR$(65+C);"  ";:NEXT
2020 PRINT @(80),"";:FORR=RR TO RR+5:PRINT" ";R+1;" ":NEXT
2030 PRINTCHR$(27);"q
2100 RETURN

9000 PRINT CHR$(27);"q
9010 PRINT @(0),"";
9020 PRINT CHR$(27);"W": REM allow scroll
9030 stop
9040 CLS:PRINT CHR$(27);"V";CHR$(27);"q": goto 20
