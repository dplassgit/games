10 print "{clear}{down}{down}"
20 w=38
30 a$(0)=",   NM                                  .   NM                                  "
40 a$(1)=",  N  MNM                  NMNM         .  N  MNM                  NMNM         "
50 a$(2)=",{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N.{163}{163}   N  M     N{163}{163}{163}M      N  M M{164}      N"
60 a$(3)=",    N    M   N     {163}M   N    M  M NM N .    N    M   N     {163}M   N    M  M NM N "
80 ml=len(a$(0)): rem max len
90 b$="": for i = 0 to w: b$=b$+"{163}": next

100 a=0: gosub 1000: ?b$

200 get d$: if d$="" then d$=p$
210 if d$="j" then a=a+2: if a >=ml then a = a - ml
220 if d$="l" then a=a-2: if a < 0 then a = a + ml
230 if d$="," then a=a+1: if a >=ml then a = a - ml
240 if d$="." then a=a-1: if a < 0 then a = a + ml
280 p$=d$
290 gosub 1000
299 goto 200

1000 rem pick a location and start showing from there.
1000 print "{home}{down}{down}"
1010 as=a+1:ab=0:if as+w>ml then ab=(as+w)-ml: rem we need to get more from the front
1020 for i = 0 to 3
1030 print mid$(a$(i),as,w+1);
1035 if ab > 0 then ? left$(a$(i),ab);
1037 ?
1040 next i
1099 return
