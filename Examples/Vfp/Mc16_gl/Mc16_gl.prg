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
dv_beep=RegFn("dv_beep","II","I","mwic_16.dll") 

st=0
snr=0
icdev=0 
status=0
ver=space(10)
 
&&icdev=callfn(auto_init,1,9600)   
icdev=callfn(ic_init,1,9600)  
st=callfn(get_status,icdev,@status)
if st<>0
  ?"init error"
  st=callfn(ic_exit,icdev)
  retu
endi
?status

st=callfn(setsc_md,icdev,1)
if st<>0 
   ?"setsc mode error"
   st=callfn(ic_exit,icdev)
   retu
endi

password="789"
st=callfn(cmp_dvsc,icdev,3,@password)
if st<>0 
   ?"cmp dvsc error"
   st=callfn(ic_exit,icdev)
   retu
endi

pass=Chr(255)+Chr(255)+Chr(255)
*st=callfn(swr_dvsc,icdev,3,@pass)
if st<>0 
   ?"swr dvsc error"
   st=callfn(ic_exit,icdev)
   retu
endi

pass=space(3)
st=callfn(srd_dvsc,icdev,3,@pass)
if st<>0 
   ?"srd dvsc error"
   st=callfn(ic_exit,icdev)
   retu
endi
&&?pass

st=callfn(dv_beep,icdev,20)
if st<>0
   ?"beep error"
   st=callfn(ic_exit,icdev)
   retu
endi

st=callfn(turn_on,icdev)
if st<>0
   ?"turn on error"
   st=callfn(ic_exit,icdev)
   retu
endi

st=callfn(turn_off,icdev)
if st<>0
   ?"turn off error"
   st=callfn(ic_exit,icdev)
   retu
endi

&&st=callfn(auto_pull,icdev)
if st<>0
   ?"auto pull error"
   st=callfn(ic_exit,icdev)
   retu
endi

st=callfn(srd_ver,icdev,10,@ver)
if st<>0
   ?"srd ver error"
   st=callfn(ic_exit,icdev)
   retu
endi
?ver

&& st=callfn(set_baud,icdev,9600)
if st<>0 
 ?"error set baud"
  st=callfn(ic_exit,icdev)
  retu    
endi

st=callfn(ic_exit,icdev)
