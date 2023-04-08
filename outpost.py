# Based on outpost.prg
# https://www.commodoregames.net/Outpost_Commodore_PET_437.html
# Original author unknown
# Python version Copyright 2023 David Plass

from operator import *
from random import random
from math import *
from time import sleep

def randint(x):
  return int(random()*x+1)

def SPC(c):
    return ' '*c

class Outpost:
    #note, 5 = Supply
    #shipType(0..5) = enemy type
    shipType=[0,0,0,0,0,0]
    #EX,EY= enemy x, y
    EX = [0,0,0,0,0,0]
    EY = [0,0,0,0,0,0]
    #ED = enemy dist
    distance = [0,0,0,0,0,0]
    #EH = enemy prob
    prob = [0,0,0,0,0,0]
    #EE = enemy energy
    enemy_energy = [0,0,0,0,0,0]

    #E = your energy
    energy = 0
    #C = your charge
    charge = 0
    #M = your main
    mains = 0
    #S = your sec
    secondary = 0
    #T = your torpedo
    torps = 0

    # score
    score = 0
    # hs
    hs = 0

    # 20 DEFrandint(X)=INT(RND(1)*X+1)

    # distance to 'G' (note it ignores Z
    def calc_distance(self, G):
        dx = (self.EX[G]-6)**2
        dy = (self.EY[G]-6)**2
        return int(sqrt(dx+dy))

    # 30 DEFFNB (Z)=INT(SQR((EX(G)-6)^2+(EY[G]-6)^2))

    # probabilyt of being hit depends on distance and "C" - our computer value, note it ignores Z
    def calc_prob(self, G):
        return int(1.0/self.distance[G]*100.0+(self.charge/2.0))
    # 40 DEFFNC(Z)=INT(1/(distance[G])*100+(charge/2))

    #start off with one ship (G=1); give initial supply
    # 50 C=99:G=1:GOSUB5110:GOSUB2000
    def initialize(self):
        self.charge = 99
        self.recharge()
        self.shipType=[0,0,0,0,0,0]
        #EX,EY= enemy x, y
        self.EX = [0,0,0,0,0,0]
        self.EY = [0,0,0,0,0,0]
        #ED = enemy dist
        self.distance = [0,0,0,0,0,0]
        #EH = enemy prob
        self.prob = [0,0,0,0,0,0]
        #EE = enemy energy
        self.enemy_energy = [0,0,0,0,0,0]
        self.score = 0
        self.torps = 9
        self.makeEnemyShip(1)

    def play(self):
    # 200 GOSUB5000:GOSUB1000:GOSUB6000:GOSUB3000:GOSUB4000
    # 210 GOTO200
        while True:
            self.initialize()
            while True:
                self.newShip() # 5k
                self.print_board()  #1k
                self.get_input() #6k
                if self.move() == 1: break  #3k
                if self.enemy_attack() == 1: break #4k
            if self.print_score() == 0: break

##    1000 PRINT"ENEMY 1  2  3  4"
##    1020 PRINT"TYPE ";
##    1030 FORG=1 TO 4
##    1040 IFET(G)=0THENPRINT"--- ";
##    1050 IFET(G)=1THENPRINT"LGT ";
##    1060 IFET(G)=2THENPRINT"MDM ";
##    1070 IFET(G)=3THENPRINT"HVY ";
##    1080 NEXT
##    1100 PRINT:PRINT"DIST":PRINT"PROB                ":PRINT"ENGY                "
##    1120 FORG=1 TO 4
##    1122 X=1+G*4
##    1124 PRINT"‘‘‘‘"
##    1126 PRINTSPC(X)ED(G)
##    1128 PRINTSPC(X)EH(G)
##    1130 PRINTSPC(X)EE(G)
##    1140 NEXTG
##    1300 PRINT:PRINTSPC(12);"STATUS"
##    1305 PRINTSPC(12)" ÄÄÄÄÄÄ"
##    1310 PRINTSPC(11)" ENGY:    ���";E
##    1320 PRINTSPC(11)" COMP:    ���";C
##    1330 PRINTSPC(11)" MAIN:    ���";M
##    1340 PRINTSPC(11)" SECN:    ���";S
##    1350 PRINTSPC(11)" TORP:";T
##    1360 PRINTSPC(11)"  VP :";VP
##    1400 PRINT:PRINTSPC(11);"  C=CHARGE":PRINT:PRINT
##    1500 PRINT""
##    1510 A=0
##    1520 FORY=1 TO 11
##    1530 FORX=1 TO 11
##    1540 FORG=1 TO 5
##    1550 IFY<>EY(G)THEN1620
##    1560 IFX<>EX(G)THEN1620
##    1570 A=1:IFG=1THENPRINT"1";
##    1580 IFG=2THENPRINT"2";
##    1590 IFG=3THENPRINT"3";
##    1600 IFG=4THENPRINT"4";
##    1610 IFG=5THENPRINT"S";
##    1620 NEXTG
##    1630 IFX=6ANDY=6THENPRINT"Ñ";:A=1
##    1640 IFA=1THENA=0:GOTO1660
##    1650 PRINT"+";
##    1660 NEXTX
##    1670 PRINT
##    1680 NEXTY
##    1690 PRINT""
    def print_board(self):
        print("")
        print("ENEMY 1   2   3   4")
        print("TYPE  ",end='')
        for G in range(1,5): # note, range 1-5 not 1-6 for the HUD
            if self.shipType[G]==0: print( "---",end=' ')
            if self.shipType[G]==1: print( "LGT",end=' ')
            if self.shipType[G]==2: print( "MDM",end=' ')
            if self.shipType[G]==3: print( "HVY",end=' ')
        print("")
        line = "DIST  "
        for G in range(1,5):
            line = line  + str(self.distance[G]) + SPC(2)
            if self.distance[G]<10: line= line + ' '
        print(line)
        line = "PROB  "
        for G in range(1,5):
            line = line  + str(self.prob[G])+ SPC(2)
            if self.prob[G]<10: line= line + ' '
        print(line)
        line = 'ENGY  '
        for G in range(1,5):
            line = line  + str(self.enemy_energy[G])+ SPC(2)
            if self.enemy_energy[G]<10: line= line + ' '
        print(line)
        print("")

        for y in range(1,12):
            line=''
            for x in range(1,12):
                if x==6 and y == 6:
                    ship ='O'
                else:
                    ship = '+'
                for G in range(1,6): # note range 1-6 for the main
                    if y != self.EY[G]: continue
                    if x != self.EX[G]: continue
                    if G!=5:
                        ship = str(G)
                    else:
                        ship ='S'
                line = line + ship
            print(line,end=' ')
            if y == 1: print("STATUS")
            if y == 2: print("======")
            if y == 3: print("ENGY:", self.energy)
            if y == 4: print("COMP:", self.charge)
            if y == 5: print("MAIN:", self.mains)
            if y == 6: print("SECN:", self.secondary)
            if y == 7: print("TORP:", self.torps)
            if y == 8: print(" VP :", self.score)
            if y > 8: print("")
        print("")


    # resupply/recharge
    # 2000 ET(5)=0:EX(5)=0:EY(5)=0
    # 2010 energy=99:M=99:secondary=99
    # 2020 torps=torps+5:IF torps>9 THEN torps=9
    # 2030 RETURN
    def recharge(self):
        self.shipType[5]=0
        self.EX[5] = 0
        self.EY[5] = 0
        self.energy = 99
        self.mains = 99
        self.secondary = 99
        self.torps = min(9, self.torps + 5)

    # move ships positions, test for supply ship, test for die
    # 3000 FORG=1 TO 5:IFET(G)>0THEN3100
    # 3010 NEXTG:RETURN
    # 3100 IFG<5ANDFNA(9)>5THEN3010
    # 3200 IF EX(G)>6THENEX(G)=EX(G)-1
    # 3210 IF EX(G)<6THENEX(G)=EX(G)+1
    # 3220 IFEY(G)<6THENEY(G)=EY(G)+1
    # 3230 IFEY(G)>6THENEY(G)=EY(G)-1
    # 3240 IFET(5)=5ANDEY(5)=6ANDEX(5)=6THENGOSUB2000
    # 3250 IFEY(G)=6ANDEX(G)=6THEN9500
    # 3265 IFG<5ANDEX(G)=EX(5)ANDEY(G)=EY(5)THENET(5)=0:EX(5)=0:EY(5)=0
    # 3300 ED(G)=FNB(1)
    # 3330 EH(G)=FNC(0):IFEH(G)>99THENEH(G)=99
    # 3400 GOTO 3010

    def move(self):
        for G in range(1, 6):
            if self.shipType[G] > 0:
                if G < 5 and randint(9) > 5: continue
                #    move towards 6,6
                if self.EX[G] > 6:
                    self.EX[G] -= 1
                if self.EY[G] > 6:
                    self.EY[G] -= 1
                if self.EX[G] < 6:
                    self.EX[G] +=1
                if self.EY[G] < 6:
                    self.EY[G] +=1
                if self.shipType[G]==5 and self.EY[5]==6 and self.EX[5]==6:
                    self.recharge() #the supply ship got here
                else:
                    if self.EY[G]==6 and self.EX[G]==6: return 1 # die, he got me
                # enemy killed supply ship
                if G < 5 and self.EX[G]==self.EX[5] and self.EY[G] == self.EY[5]:
                    self.shipType[5] = 0
                    self.EX[5] = 0
                    self.EY[5] = 0
                self.distance[G] = self.calc_distance(G) # recompute distance
                self.prob[G] = min(99, self.calc_prob(G)) # probability
        return 0

    # enemy attack (moving is really in 3k)
    # 4000 PRINT"‘ENEMY FIRING & MOVING"
    #  4010 FOR G=1 TO 4:IF ET(G)<>0 THEN 4100
    #  4020 NEXT G:RETURN
    #  4100 IF FNA(99)>(EE(G)+FNA(30)) OR EE(G)<10 THEN 4020
    #  4110 E=E-FNA(5)*ET(G)
    #  4150 EE(G)=EE(G)-FNA(10)
    #  4160 IF FNA(10)=1 THEN C=C-FNA(25):IF C<1 THEN 9500
    #  4170 IF FNA(10)=1 THEN M=M-FNA(25):IF M<0 T HEN M=0
    #  4180 IF FNA(10)=1 THEN S=S-FNA(25):IF S<0 THEN S=0
    #  4200 IF E<0 THEN 9500
    #  4210 GOTO 4020
    def enemy_attack(self):
        print("ENEMY FIRING & MOVING")
        for G in range(1, 5):
            if self.shipType[G] != 0:
                if randint(99) > (self.enemy_energy[G]+randint(30)) or self.enemy_energy[G]<10: continue
                self.energy -= randint(5)*self.shipType[G]  #decrease our energy by randomness * this enemy's energy
                self.enemy_energy[G] -= randint(10)  #decrease enemy's energy by random
                if randint(10) == 1:
                    self.charge -= randint(25)
                    if self.charge < 1: return 1 # decrease charge - might die
                if randint(10) == 1:
                    self.mains = max(0, self.mains - randint(25)) # decrease mains
                if randint(10) == 1:
                    self.secondary = max(0, self.secondary - randint(25)) # decrease secondary
                if self.energy < 0: return 1 # die, our energy too low
        return 0

    # make ships appear
    # 5000 G=FNA(5)
    # 5005 IFG=5ANDET(5)=0ANDFNA(4)>1THENET(5)=5:GOTO5160
    # 5010 IFG=5ORET(G)<>0ORFNA(9)>4THEN5400
    def newShip(self):
        G=randint(5)
        if G==5 and self.shipType[5]==0 and randint(4)>1:
            # add a supply ship
            self.shipType[5]=5
            self.makeAnyShip(G)
        else:
            if G==5 or self.shipType[G]!=0 or randint(9)>4:
                # no ship
                G = 5
            else:
                self.makeEnemyShip(G)

    # 5110 A=4-INT(LOG(FNA(50)+2))
    # 5120 ET(G)=A:EE(G)=99
    def makeEnemyShip(self, G):
        A=4-int(log(randint(50)+2))
        self.shipType[G] = A
        self.enemy_energy[G] = 99
        self.makeAnyShip(G)

# 5160 EX(G)=FNA(11)
# 5170 EY(G)=FNA(11)
# 5180 A=FNA(4):IFA=1THENEY(G)=1
# 5190 IFA=2THENEY(G)=11
# 5200 IFA=3THENEX(G)=11
# 5210 IFA=4THENEX(G)=1
# 5300 ED(G)=FNB(1)
# 5320 EH(G)=FNC(0):IFEH(G)>99THENEH(G)=99
# 5400 RETURN
    # initial location is random
    def makeAnyShip(self, G):
        self.EX[G]=randint(11)
        self.EY[G]=randint(11)
        #pick starting quadrant
        A=randint(4)
        if A==1: self.EY[G]=1
        if A==2: self.EY[G]=11
        if A==3: self.EX[G]=1
        if A==4: self.EX[G]=11
        # calculate distance
        self.distance[G] = self.calc_distance(G)
        # calculate probability
        self.prob[G]=min(self.calc_prob(G),99)

    #get input and fire weapons
## 6000 PRINT "WEAPON:                  "
## 6010 GET A$:IFA$=""THEN6010
## 6020 IFA$="M"ANDM>0THENA=6:M=M-FNA(5):IFM<0THENM=0
## 6025 IFA$="C"THENE=E+FNA(20):IFE>99THENE=99
## 6030 IFA$="C"THENRETURN
## 6035 IFA$="S"ANDS>0THENA=4:S=S-FNA(5):IFS<0THENS=0
## 6040 IFA$="T"ANDT>0THENA=9:T=T-1
## 6060 IFA<3THENPRINT"‘BAD INPUT! WEAPON:":GOTO6010
## 6100 PRINT"‘TARGET NO:          "
## 6120 GET B$:IFB$=""THEN6120
## 6125 B=VAL(B$)
## 6130 IFET(B)=0THENPRINT"‘BAD DATA! TARGET:":GOTO6120
## 6200 IFFNA(99)>EH(B)THENPRINT"‘MISSED!          ":FORZ=1TO1000:NEXT:RETURN
## 6210 EE(B)=INT(EE(B)-((A*FNA(15))/ET(B)))
## 6215 PRINT"‘TARGET HIT!            ":FORZ=1TO1000:NEXT
## 6220 IFEE(B)<1THEN6500
## 6230 E=E-FNA(5)
## 6300 RETURN
## 6350 REM  PRINT:PRINT:PRINT
## 6500 VP=VP+ET(B)
## 6505 EX(B)=0:EY(B)=0
## 6510 ET(B)=0:EH(B)=0:ED(B)=0:EE(B)=0
## 6570 PRINT"‘  TARGET DESTROYED!  "
## 6575 FORA=1TO1000:NEXTA
## 6580 RETURN
    def get_input(self):
        while True:
            damage = 0
            print("WEAPON (MSTC):")
            A = input()
            if A == '':
                print("BAD INPUT!")
                continue
            A = A.upper()
            # charge - increase energy
            if A == 'C':
                self.energy = min(99, self.energy+randint(20))
                return
            # shoot mains at one of the ships if we can
            if A == 'M' and self.mains > 0:
                damage = 6
                self.mains = max(self.mains - randint(5), 0)
            # shoot at secondaries at one of the ships if we can
            if A == 'S' and self.secondary>0:
                damage = 4
                self.secondary=max(self.secondary-randint(5),0)
            # fire torps if we can
            if A == 'T' and self.torps > 0:
                damage = 9
                self.torps = self.torps - 1
            if damage < 3:
                print("BAD INPUT!")
                continue
            break
        while True:
            print("TARGET NO:")
            br = input()
            if br == '' or not br.isdigit():
                print("BAD DATA!")
                continue
            B = int(br)
            if self.shipType[B]==0:
                print("BAD DATA!")
                continue
            break
        if randint(99)>self.prob[B]:
            print("MISSED!")
            sleep(1)
            return
        # A is 6 for main, 4 for secondary, 9 for torps
        self.enemy_energy[B]=int(self.enemy_energy[B]-((damage*randint(15))/self.shipType[B]))
        print("TARGET HIT!")
        sleep(1)
        if self.enemy_energy[B]<1:
            print("  TARGET DESTROYED!  ")
            # increase score based on type of ship
            self.score=self.score+self.shipType[B]
            #    erase ship
            self.EX[B]=0
            self.EY[B]=0
            self.shipType[B]=0
            self.prob[B]=0
            self.distance[B]=0
            self.enemy_energy[B]=0
            sleep(1)
        else:
            # decrease our energy if we didn't destroy him
            self.energy=self.energy-randint(5)
        return

##    9500 POKE36879,110
##    9510 PRINT "        DESTROYED!!!!!"
##    9550 PRINT "    SCORE= ";this.score:PRINT :PRINT
##    9560 IF this.score>HS THEN HS=score
##    9580 PRINT "*****************"
##    9590 PRINT  "HIGH SCORE= ";HS
##    9600 PRINT  "*****************"
##    9605 PRINT "    ANOTHER GAME?"
##    9610 GETA$:IF A$="" THEN 9610
##    9620 IF A$="Y"  THEN  RUN
##    9630 STOP
    def print_score(self):
        print(" DESTROYED!!!!!")
        print("SCORE= ",self.score)
        self.hs = max(self.hs, self.score)
        print("*****************")
        print("HIGH SCORE= ",self.hs)
        print("*****************")
        print("Another game?")
        A = input().upper()
        return A=='Y'

o = Outpost()
o.play()

