SET TALK off
PRIVATE ST,PASSWD,ICDEV
DATA=SPACE(10)
set libr to c:\mwrd\mwrd6.3\driver\foxpro.dos\mwic.plb   &&please set path to your default path

ICDEV=auto_INIT(0,9600)  &&init com1,9600 
IF ICDEV<=0
  ?"IC_INIT COM1 ERROR."
  RETURN
ENDIF

ST=GET_STATUS(ICDEV)       
IF ST<0
  ?"GET_STATUS ERR"
  return
ENDIF

ST=CHK_102(ICDEV)         &&check 102 card
IF ST<>0
  ?"CHK_102 ERR"
  return
ENDIF

PASSWD=chr(240)+chr(240)  &&check password
&&passwd="f0f0"
ST=CSC_102(ICDEV,2,PASSWD)
If ST<>0
  ?"CSC_102 ERR"
  return
ENDIF

fqpass="ffffffffffff"     &&check zone password
st=asc_hex(fqpass,12)
hex1=substr(st,2,6)
st=cesc_102(icdev,1,6,hex1)
If ST<>0
  ?"Cesc_102 ERR"
  return
ENDIF
**************************write by asc*************
data="abcdef0123456789"
st=swr_102(icdev,1,10,16,data)
if st<>0
   ?"SWR_102 ERR"
  return
ENDIF

ST=SRD_102(ICDEV,1,10,16)
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_102 ERR"
  return
ENDIF
data1=substr(st,2,16)
?data1
**************************write by hex*************
DATABUFF="0123456789abcdef"

st=asc_hex(data,16)
databuff1=substr(st,2,8)
 
ST=SWR_102(ICDEV,1,1,8,databuff1)
IF ST<>0
  ?"SWR_102_hex ERR"
  return
ENDIF

ST=SRD_102(ICDEV,1,1,8)
databuff2=substr(st,2,8)
databuff3=hex_asc(databuff2,8)
If ASC(SUBSTR(ST,1,1))<>0
  ?"SRD_102_hex ERR"
  return
ENDIF
? SUBS(ST,2,16)

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
