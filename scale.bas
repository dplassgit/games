0 rem scale an image haha
0 dim i$(25): i=0: rem this is a 40x16 'image'
1  i$(i)=".       . . . .                |       .":i=i+1
2  i$(i)=" .      |. . . .               |       .":i=i+1
3  i$(i)="  .     . . . .                |       .":i=i+1
4  i$(i)="   .    |. . . .               |       .":i=i+1
5  i$(i)="    .   . . . .                |       .":i=i+1
6  i$(i)="     .  |. . . .               |       .":i=i+1
7  i$(i)="      . . . . .                |       .":i=i+1
8  i$(i)="       . . . . .               |       .":i=i+1
9  i$(i)="................---------------|----....":i=i+1
10 i$(i)=".......                        |    ....":i=i+1
11 i$(i)="     .                         |    ....":i=i+1
12 i$(i)="    .                          |    ....":i=i+1
13 i$(i)="   .                           |    ....":i=i+1
14 i$(i)="  .                            |    ....":i=i+1
15 i$(i)=" .                             |    ....":i=i+1
16 i$(i)=".                              |    ....":i=i+1

20 rem each character is a column
20 dim ch(8,64): i=0
21 ch(5,i)=128:ch(1,i)=170:ch(2,i)=255:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
22 ch(5,i)=64::ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
23 ch(5,i)=32:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
24 ch(5,i)=16:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
25 ch(5,i)=8:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
26 ch(5,i)=4:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
27 ch(5,i)=2:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
28 ch(6,i)=1:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
30 i=0
31 ch(6,i)=1:ch(1,i)=170:ch(2,i)=255:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
32 ch(6,i)=2::ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
33 ch(6,i)=4:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
34 ch(6,i)=8:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
35 ch(6,i)=16:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
36 ch(6,i)=32:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
37 ch(6,i)=64:ch(1,i)=170:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1
38 ch(6,i)=128:ch(1,i)=85:ch(2,i)=0:ch(3,i)=15: ch(4,i)=1:ch(0,i)=0:i=i+1

90 ch$(0)=" ": ch$(5)="{205}": ch$(1)="{166}": ch$(2)="{163}": ch$(3)="{rvs on}{161}{rvs off}":ch$(4)="{167}":ch$(6)="N"

100 rem 1. break image into 8x8 somethings
100 rem 2. find a character that matches it
100 rem 3. compare. if "good enough", done. Else, wiggle the image

100 rem take every 8 "pixels" and make it into a byte (% holds 16 bits, signed).
100 dim ii(16,5): rem each row has 5 characters
105 s=ti
110 for i = 0 to 15
120 rem 1 to len(i$(i)) step 8
120 for j = 0 to 4: b=0: jj=j*8+1: je = jj+7
130 for k = jj to je: b = b * 2: if mid$(i$(i),k,1) = "." then b = b + 1
150 next k: ii(i,j)=b: next j: next i
199 ?ti-s

210 for i = 0 to 15
215 ?i;":";
220 for j = 0 to 4
260 ? ii(i,j);
270 next j
275 ?
280 next i

300 rem for each column and row, find a char that "matches" it within x%
300 for row = 0 to 15 step 8
310 for col = 0 to 4
315 found=0: bestmatch=0: bm$=" "
320 for ch = 0 to 6
325 matches=0
330 for i = 0 to 7
335 if ii(row+i,col) = ch(ch,i) then matches = matches + 1
340 next i
345 if matches>=6 and matches >bestmatch then bestmatch=match:bm$=ch$(ch)
350 if bestmatch=8 then ch=99: rem short cirsuit
360 next ch
365 ?bm$;
370 next col
375 ?
380 next row
