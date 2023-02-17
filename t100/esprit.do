0 goto 5000

9 rem print the current cell. inputs: c,r. priority is string, then if it has a formula, print the value.
10 if s$(r,c)<>"" then ?using"\   \";s$(r,c); else if f$(r,c)<>"" then ?using"#.###";v#(r,c); else ?"     ";
11 return

99 rem main loop:
100 K$=INKEY$:IF K$=""THEN 100
110 IF K$="j" THEN CR=CR+1:GOSUB 1000:GOTO 100
120 IF K$="k" THEN CR=CR-1:GOSUB 1000:GOTO 100
130 IF K$="l" THEN CC=CC+1:GOSUB 1000:GOTO 100
140 IF K$="h" THEN CC=CC-1:GOSUB 1000:GOTO 100
150 IF K$="q" THEN 9000: rem quit
160 IF K$="0" THEN CC=0:cr=0:GOSUB 1000:GOTO 100
170 rem e for edit, g for goto, slash for menu, s for save, r for retrieve
300 GOTO 100

999 rem todo: figure out if need to move origin
1000 REM draw previous cursor in regular
1010 C=(PC MOD 7)+1:R=(PR MOD 6)+2
1020 rem C=PC+1:R=PR+2
1030 PRINT@C*5+R*40,nv$;
1039 rem print the value of this cell. 
1040 r=pr:c=pc:gosub10

1100 rem ?@0,"cr=";cr;"cc=";cc
1105 rem this is where we would adjust the origin coords
1110 IF CR<0 THEN CR=0 else IF CR>25 THEN CR=25
1130 IF CC<0 THEN CC=0 else IF CC>25 THEN CC=25 : rem 25=z
1150 rem ?@20,"ncr=";cr;"ncc=";cc

1200 REM show cursor in reverse
1210 C=(CC MOD 7)+1:R=(CR MOD 6)+2
1220 rem C=CC +1:SR=CR +2
1230 PRINT @(C*5+R*40),rv$;
1239 rem print the value of this cell. priority is string, then if it has a formula, print the value.
1240 r=cr:c=cc:gosub10
1250 ?nv$

1279 rem print location in upper left. i don't love this.
1280 ?@40,chr$(65+cc);:if cr<9then?using"#";cr+1;: ?" ";else ?using"##";cr+1
1289 rem print the formula or value in the top row. 
1290 ?@7,space$(31);:?@7,"";:if s$(cr,cc)<>"" then ?s$(cr,cc) else if f$(cr,cc)<>"" then ?f$(cr,cc)

1400 PC=CC: PR=CR: rem save cursor location
1500 rem todo: if origin moved, redraw the headers 
1900 return

2000 PRINT @45,"";: REM redraw the headers
2010 FOR C=RC TO RC+6:PRINT rv$;"  ";CHR$(65+C);"  ";:NEXT
2030 FOR R=RR TO RR+5:?@80+(r-rr)*40,rv$;: ? using" ##  ";r+1;:?nv$;
2040 for c=rc to rc+6:gosub10: next : rem print each cell
2050 next
2100 RETURN

5000 DEFINT A-Z:rv$=chr$(27)+"p":nv$=chr$(27)+"q": rem reverse, normal video
5010 CLS:PRINT nv$;CHR$(27);"VInitializing..."
5020 dim f$(25,25),v#(25,25),s$(25,25): rem formulas, values, strings. row, column
5040 CC=0:CR=0: REM cursor col, row (zero-based)
5050 PC=0:PR=0: REM previous cursor col, row (zero-based)
5060 RC=0:RR=0: rem origin col, row (zero-based)
5065 cls
5070 PRINT @0,"Value:"
5100 rem temporarily fill cells
5110 f$(0,0)="=a2+1":v#(0,0)=2.2:f$(0,1)="1.2":v#(0,1)=1.2:s$(1,0)="Hello"
5120 s$(2,2)="hi":s$(3,2)="Hello there a very long value"
5800 GOSUB 2000: rem draw the indexes
5810 gosub 1200: rem draw the initial cursor
5900 goto 100

9000 PRINT nv$
9010 PRINT @0,"";
9020 PRINT CHR$(27);"W": REM allow scroll
9030 stop
9040 CLS:PRINT CHR$(27);"V": goto 5070
