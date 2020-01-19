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

******93c46*********
srd_93c46=RegFn("srd_93c46","III@C","I","mwic_16.dll")
swr_93c46=RegFn("swr_93c46","III@C","I","mwic_16.dll")
chk_93c46=RegFn("chk_93c46","I","I","mwic_16.dll")
eral_93c46=RegFn("eral_93c46","I","I","mwic_16.dll")
wral_93c46=RegFn("wral_93c46","I","I","mwic_16.dll")

st=0
icdev=0 
status=0

&&icdev=callfn(auto_init,1,9600) 
icdev=callfn(ic_init,1,9600)  
st=callfn(get_status,icdev,@status)
if st<>0 
  icdev=callfn(ic_init,0,9600)
  st=callfn(get_status,icdev,@status)
endi
if st<>0
  ?"init error"
  st=callfn(ic_exit,icdev)
  retu
endi
?status

st=callfn(chk_93c46,icdev)
if st<>0 
 ?"chk error"
  st=callfn(ic_exit,icdev)
  retu    
endi

offset=10
le=12
data1="RD0123456789"
st=callfn(swr_93c46,icdev,offset,le,@data1)
if st<>0 
   ?"swr error"
    st=callfn(ic_exit,icdev)
    retu    
endi

data2=space(12)
st=callfn(srd_93c46,icdev,offset,le,@data2)
if st<>0 
   ?"srd error"
    st=callfn(ic_exit,icdev)
    retu    
endi
?data2

&&st=callfn(eral_93c46,icdev)
if st<>0 
   ?"eral error"
    st=callfn(ic_exit,icdev)
    retu    
endi

st=callfn(ic_exit,icdev)

? " Test Ok !"