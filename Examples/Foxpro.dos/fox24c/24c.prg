SET TALK off
PRIVATE ST,PASSWD,ICDEV,hex,asc
DATA=SPACE(16)
databuff1=space(16)
databuff2=space(16)

set libr to c:\mwrd\mwrd6.3\driver\foxpro.dos\mwic.plb   &&please set path to your default path

ICDEV=auto_INIT(0,9600)    &&com1,9600 
IF ICDEV<=0
  ?"IC_INIT COM1 ERROR."
  RETURN
ENDIF

ST=GET_STATUS(ICDEV)       &&check you machine now
IF ST<0
  ?"GET_STATUS ERR"
  return
ENDIF

ST=CHK_24c01a(ICDEV)
IF ST<0
  ?"CHK_4442 ERR"
  return
ENDIF

&&*********************write by asc***********
databuff1="0123456789abcdef"
ST=swr_24c01a(icdev,0,16,databuff1)
if ST<0
   ?"swr_24c01a err"   
   return
endi
 
ST=srd_24c01a(icdev,0,16)
X=substr(ST,1,1)
    if X<>chr(0)
     ?"srd_24c01a err"
    return
endi
databuff2=substr(st,2,16)
?databuff2
&&*********************write by hex***********
DATA="abcdef0123456789"

ST=asc_hex(data,16)
hex=substr(st,2,8)
 
ST=SWR_24c01a(ICDEV,20,8,hex)
IF ST<0
  ?"SWR_4442 ERR"
  return
ENDIF

ST=SRD_24c01a(ICDEV,20,8)
icdev=substr(st,2,8)
asc=hex_asc(icdev,8)
?asc
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_4442 ERR"
  return
ENDIF

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
   
  