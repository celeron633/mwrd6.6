SET TALK OFF
load MWIC
*******************init com,This is COM2.********
str1='C2'
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'ok'
else
    ?'bad'
      release module ic4442
      quit
endif
*******************Test IC_device is OK ?********
str1='Q'
call ic4442 with str1
p=asc(substr(str1,1,1))
if p<>48.and.p<>134
    ? 'IC-device is wrong !'    
      release module ic4442
      quit
endif
********************* test    begin **************
do while .T.
disflag=0
DO WHILE .T.
str1='Q'
call ic4442 with str1
p=asc(substr(str1,1,1))
if p=48
  ? 'have card,ok!'
  EXIT
else
     if disflag=0
     ? 'No card,please input card. <press any key to quit>'
        disflag=1
      endif
       kk=inkey(1)
       if kk<>0
       release module ic4442
       quit
       endif
endif
ENDDO

*******************READ WRONG COUNT*****************
str1='U'+space(2)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'read count ok'
else
    ?'read count bad'
    LOOP
endif
?str1
p=asc(substr(str1,2,1))

********************* CHECK PASSWORD***************
str1='S'+chr(1)+chr(1)+chr(3)+chr(182)+chr(35)+chr(7)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'password ok'
else
    ?'password bad'
    LOOP
endif

**********************READ PASSWORD **************
str1='p'+CHR(1)+CHR(1)+chr(3)+space(3)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'readpass ok'
else
    ?'readpass bad'
     LOOP
endif
?str1
p2=asc(substr(str1,2,2))
p3=asc(substr(str1,3,2))
p4=asc(substr(str1,4,2))
p5=asc(substr(str1,5,1))
?p2
?p3
?p4
?p5
*********************READ PROTECTED BIT******************
str1='r'+chr(1)+chr(1)+chr(32)+space(32)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'readp ok'
else
    ?'readp bad'
      LOOP
endif
?str1

********************* WRITE CARD *******************
str1='W'+chr(33)+chr(1)+chr(224)+REPLICATE('S',224)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'Write card  ok'
else
    ?'Write card  bad'
      LOOP
endif

**********************READ  CARD *******************
str1='R'+chr(33)+chr(1)+chr(224)+space(224)
call ic4442 with str1
if substr(str1,1,1)='0'
    ?'read ok'
else
    ?'read bad'
      LOOP
endif
?str1

*********************  AUTO PULL CARD *************
str1='G'+space(2)
call ic4442 with str1
enddo

