SET TALK OFF
PRIVATE ST,PASSWD,NEWPASSWD,ICDEV
DATA=SPACE(200)
set libr to c:\mwrd\mwrd6.3\driver\foxpro.dos\mwic.plb

ICDEV=IC_INIT(0,9600)
IF ICDEV<=0
  ?"IC_INIT COM2 ERROR."
  RETURN
ENDIF

ST=GET_STATUS(ICDEV)
IF ST<0
  ?"GET_STATUS ERR"
  RETURN 
ENDIF

ST=CHK_4442(ICDEV)    
IF ST<>0
  ?"CHK_4442 ERR"
  RETU
ENDIF

PASSWD=CHR(182)+CHR(35)+CHR(7)
ST=CSC_4442(ICDEV,3,PASSWD)
If ST<>0
  ?"CSC_4442 ERR"
  RETURN
ENDIF

*NEWPASSWD=CHR(255)+CHR(255)+CHR(255)
*ST=WSC_4442(ICDEV,3,NEWPASSWD)
If ST<>0
  ?"WSC_4442 ERR"
  RETURN
ENDIF

ST=RSC_4442(ICDEV,3)
If ASC(SUBSTR(ST,1,1))<>0
  ?"RSC_4442 ERR"
  RETURN
ENDIF
?"THE PASSWORD IS:",ASC(SUBSTR(ST,2,1)),ASC(SUBSTR(ST,3,1)),ASC(SUBSTR(ST,4,1))

ST=RSCT_4442(ICDEV)
If ST<0
  ?"RSCT_4442 ERR"
  RETURN
ENDIF

*ST=PRD_4442(ICDEV,4)
*If ASC(SUBSTR(ST,1,1))<>0
*  ?"PRD_4442 ERR"
*  RETURN
*ENDIF
*?"DATA IS:",ASC(SUBSTR(ST,2,1)),ASC(SUBSTR(ST,3,1)),ASC(SUBSTR(ST,4,1)),ASC(SUBSTR(ST,5,1))

DATA="SANNY520"
ST=SWR_4442(ICDEV,32,8,DATA)
IF ST<>0
  ?"SWR_4442 ERR"
  RETURN
ENDIF

ST=SRD_4442(ICDEV,32,8)
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_4442 ERR"
  RETURN
ENDIF
? 'DATA:'+SUBS(ST,2,8) 

&&*********************write by hex***********
DATA="abcdef0123456789"

ST=asc_hex(data,16)
hex=substr(st,2,8)
 
ST=SWR_4442(ICDEV,48,8,hex)
IF ST<0
  ?"SWR_4442 ERR"
  return
ENDIF

ST=SRD_4442(ICDEV,48,8)
icdev=substr(st,2,8)
asc=hex_asc(icdev,8)
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_4442 ERR"
  return
ENDIF
? "HEXDATA:"+SUBS(ST,2,8)

************************** des encrypt*************
dest=space(16)
source=space(16)
ST=ic_encrypt("12345678","abcdefghabcdefgh",16)
if subs(st,1,1)<>chr(0) 
  ? "encrypt error."
  retu
endif
dest=subs(st,2,16)
? "dest:"+dest

************************** des decrypt *************
st=ic_decrypt("12345678",dest,16)
if subs(st,1,1)<>chr(0)
   ? "decrypt error."
   retu
endif
source=subs(st,2,16)
? "source:"+source

retu
   
  


     
