0 CLS:?CHR$(27)"U";:T=RND(-VAL(RIGHT$(TIME$,2))):INPUT"Players (1/2)";N:IFN>2ORN<1THENBEEP:GOTO0
5 IFN=1THENINPUT"Difficulty (1=easy, 2=medium, 3=difficult)";LV:IFLV<1ORLV>3THEN5
10 DIMV(6,6),P(6,6),M(6,6): REM value, player, max
20 DIMQX(199),QY(199):N=0: REM queue
30 C$(0)=CHR$(27)+"q":C$(1)=C$(0):C$(2)=CHR$(27)+"p": REM color per player
35 SC=1-(PEEK(1)=171): REM scale (i.e., Tandy 200=2, everything else=1)
40 ?"Setting up...":FORR=0TO6:FORC=0TO6:M(R,C)=4+((R=0)OR(R=6))+((C=0)OR(C=6)):NEXT:NEXT
50 X=0:Y=0:T=1:CLS:GOSUB1000:GOSUB500: REM draw board, scors
100 IFLV>0ANDT=2THENGOSUB6000:X=CX:Y=CY:GOSUB300: REM pick computer spot, update value
110 XX=X:YY=Y:V$="*":GOSUB4000
120 A$=INKEY$:GOSUB2000: REM draw at location
125 IFA$=""THEN110
200 A=ASC(A$):IFA$="j"ORA=31THENY=(Y+1)MOD7
210 IFA$="k"ORA=30THENY=(Y+6)MOD7
220 IFA$="h"ORA=29THENX=(X+6)MOD7
230 IFA$="l"ORA=28THENX=(X+1)MOD7
240 IFA=13ORA=32THENGOSUB300
290 GOTO100
299 REM process attempt to drop pellet
300 IFP(Y,X)=3-TTHENBEEP:RETURN: REM no available
310 IFP(Y,X)=0THENS(T)=S(T)+1:P(Y,X)=T
320 V(Y,X)=V(Y,X)+1:XX=X:YY=Y:GOSUB2000
340 IFV(Y,X)<M(Y,X)THEN490: REM boom
350 S(T)=S(T)-1:P(Y,X)=0:V(Y,X)=0
359 REM seed queue
360 N=0:GOSUB5000:GOSUB2000:NN=0
399 REM process queue
400 IFNN=NTHEN490
410 XX=QX(NN):YY=QY(NN)
415 IFP(YY,XX)<>TTHENS(T)=S(T)+1: REM we captured one
420 IFP(YY,XX)=3-TTHENS(3-T)=S(3-T)-1: REM they lost one
425 P(YY,XX)=T:V(YY,XX)=V(YY,XX)+1
430 GOSUB2000
440 IFV(YY,XX)>=M(YY,XX)THENV(YY,XX)=0:P(YY,XX)=0:S(T)=S(T)-1:GOSUB5000:GOSUB2000
480 NN=NN+1:GOTO400
490 T=3-T:GOSUB500:GOSUB550:RETURN: REM switch turns, print score, test for win
499 REM Print scores:
500 LOCATE25,0:?C$(1);:IFT=1THEN?"*";ELSE?" ";
510 ?"White:"S(1)
515 LOCATE25,1:?C$(2);:IFT=2THEN?"*";ELSE?" ";
520 ?"Black:"S(2)c$(0)
530 RETURN
549 REM Test for Win (if at least one piece has been played)
550 LOCATE25,2
560 IFS(1)>0ANDS(2)=0AND(S(1)+S(2))>1THEN?"White wins!":END
570 IFS(2)>0ANDS(1)=0AND(S(1)+S(2))>1THEN?"Black wins!":END
580 RETURN
999 REM print the empty board
1000 IFSC=1THEN1050
1009 REM t200 board
1010 FORR=1TO7:GOSUB1100:?"| | | | | | | |":NEXT:GOSUB1100:RETURN
1049 REM t100 board
1050 FORR=1TO7:?"|.......|":NEXT:RETURN
1099 REM print a long line
1100 ?"+-+-+-+-+-+-+-+":RETURN
1999 REM print value at its spot xx,yy
2000 C=32-14*(SC=1):IFP(YY,XX)>0THENC=48+V(YY,XX)
2010 V$=C$(P(YY,XX))+CHR$(C)+C$(0):GOSUB4000:RETURN
3999 REM print v$ at xx, yy scaled by sc
4000 LOCATEXX*SC+1,YY*SC+(SC-1):?V$;
4100 RETURN
4999 REM enqueue xx,yy
5000 IFXX>0THENQX(N)=XX-1:QY(N)=YY:N=N+1
5010 IFXX<6THENQX(N)=XX+1:QY(N)=YY:N=N+1
5020 IFYY>0THENQX(N)=XX:QY(N)=YY-1:N=N+1
5030 IFYY<6THENQX(N)=XX:QY(N)=YY+1:N=N+1
5100 RETURN
6000 REM AI subroutine (written mostly by Google Gemini)
6010 IFS(1)+S(2)=49THENRETURN: REM check for full board
6020 IFLV>1THEN6050
6030 CX=INT(7*RND(1)):CY=INT(7*RND(1))
6040 IFP(CY,CX)=1THEN6030: REM Re-try if owned by human
6045 RETURN
6050 MS=-999:CX=0:CY=0:FORI=0TO6:FORJ=0TO6:IFP(I,J)=1THEN6130
6069 REM Pick near the edge and even better if it's almost critical
6070 S=(4-M(I,J))*10+V(I,J)*2:IFV(I,J)+1>=M(I,J)THENS=S+50
6080 IFLV<3THEN6120: REM don't consider adjacent cells
6089 REM Don't place next to human if it is almost critical
6090 IFJ>0THENIFP(I,J-1)=1ANDV(I,J-1)=M(I,J-1)-1THENS=S-60
6100 IFJ<6THENIFP(I,J+1)=1ANDV(I,J+1)=M(I,J+1)-1THENS=S-60
6110 IFI>0THENIFP(I-1,J)=1ANDV(I-1,J)=M(I-1,J)-1THENS=S-60
6115 IFI<6THENIFP(I+1,J)=1ANDV(I+1,J)=M(I+1,J)-1THENS=S-60
6119 REM pick best value
6120 IFS>MSTHENMS=S:CX=J:CY=I
6130 NEXT:NEXT:RETURN
