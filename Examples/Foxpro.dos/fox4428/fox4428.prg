SET TALK off
PRIVATE ST,PASSWD,ICDEV,hex,asc
DATA=SPACE(16)
databuff1=space(16)
databuff2=space(16)

set libr to c:\mwrd\mwrd6.3\driver\foxpro.dos\mwic.plb   &&please set path to your default path

ICDEV=auto_INIT(0,115200)  &&please initcom with your compter's com and bound 
IF ICDEV<=0
  ?"IC_INIT COM1 ERROR."
  RETURN
ENDIF

ST=GET_STATUS(ICDEV)       &&please insert your 4442 card now
IF ST<0
  ?"GET_STATUS ERR"
  return
ENDIF

ST=CHK_4428(ICDEV)
IF ST<>0
 ?"CHK_4428 ERR"
 return
ENDIF

PASSWD=chr(103)+chr(198)
ST=CSC_4428(ICDEV,2,PASSWD)
If ST<>0
  ?"CSC_4442 ERR"
  return
ENDIF

st=rsc_4428(icdev,2)
x=substr(st,1,1)
if x<>chr(0)
   ?"rsc_4428 err"
   return
endi
password=substr(st,1,4)

st=rsct_4428(icdev)
If ST<0
  ?"rsct_4428 ERR"
  return
ENDIF
?st
&&********************write by asc**************
databuff1="0123456789abcdef"
st=swr_4428(icdev,56,16,databuff1)
if st<>0
   ?"swr_4428 err"
   return
endi

st=srd_4428(icdev,56,16)
x=substr(st,1,1)
if x<>chr(0)
   ?"srd_4428 err"
   return
endi
databuff2=substr(st,1,16)
?databuff2
   
&&********************write by hex**************
DATA="1234567890abcdef"

st=asc_hex(data,16)
hex=substr(st,2,8)
 
ST=SWR_4428(ICDEV,32,8,hex)
IF ST<>0
  ?"SWR_4428_hex ERR"
  return
ENDIF

ST=SRD_4428(ICDEV,32,8)
icdev=substr(st,2,8)
asc=hex_asc(icdev,8)
?asc
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_4442_hex ERR"
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
   
  
