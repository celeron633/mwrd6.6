SET LIBRARY TO SYS(2004)+"FOXTOOLS.FLL" ADDITIVE
SET TALK ON
auto_init=RegFn("auto_init","IL","I","mwic_16.dll")
ic_init=RegFn("ic_init","IL","I","mwic_16.dll")
ic_exit=RegFn("ic_exit","I","I","mwic_16.dll")
get_status=RegFn("get_status","I@I","I","mwic_16.dll") 
set_baud=RegFn("set_baud","II","I","mwic_16.dll")

cmp_dvsc=RegFn("cmp_dvsc","II@C","I","mwic_16.dll")
srd_dvsc=RegFn("srd_dvsc","II@C","I","mwic_16.dll")
swr_dvsc=RegFn("swr_dvsc","II@C","I","mwic_16.dll")
setsc_md=RegFn("setsc_md","II","I","mwic_16.dll")
 
turn_on=RegFn("turn_on","I","I","mwic_16.dll") 
turn_off=RegFn("turn_off","I","I","mwic_16.dll") 
srd_ver=RegFn("srd_ver","II@C","I","mwic_16.dll")
auto_pull=RegFn("auto_pull","I","I","mwic_16.dll") 
ic_beep=RegFn("dv_beep","II","I","mwic_16.dll") 

*******24c01*********
srd_24c01a=RegFn("srd_24c01a","III@C","I","mwic_16.dll")
swr_24c01a=RegFn("swr_24c01a","III@C","I","mwic_16.dll")
chk_24c01a=RegFn("chk_24c01a","I","I","mwic_16.dll")


st=0
snr=0
icdev=0 
status=0
ver=space(10)

icdev=callfn(auto_init,1,9600) 
&&icdev=callfn(ic_init,1,9600)  
st=callfn(get_status,icdev,@status)
if st<>0
  ?"init error"
  st=callfn(ic_exit,icdev)
  retu
endi
?"status:",status


st=callfn(chk_24c01a,icdev)
if st<>0 
 ?"chk error"
  st=callfn(ic_exit,icdev)
  retu    
endi
?" Check Card OK"

offset=10
le=12
data1="RD0123456789"
st=callfn(swr_24c01a,icdev,offset,le,@data1)
if st<>0 
 ?"swr error"
  st=callfn(ic_exit,icdev)
  retu    
endi
?" Write OK"

data2=space(12)
st=callfn(srd_24c01a,icdev,offset,le,@data2)
if st<>0 
 ?"srd error"
  st=callfn(ic_exit,icdev)
  retu    
endi
?" Read OK"
? data2

st=callfn(ic_exit,icdev)
