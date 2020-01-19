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

******operate 42*********
srd_4442=RegFn("srd_4442","III@C","I","mwic_16.dll")
swr_4442=RegFn("swr_4442","III@C","I","mwic_16.dll")
chk_4442=RegFn("chk_4442","I","I","mwic_16.dll")
prd_4442=RegFn("swr_4442","III@C","I","mwic_16.dll")
pwr_4442=RegFn("swr_4442","III@C","I","mwic_16.dll")

csc_4442=RegFn("csc_4442","II@C","I","mwic_16.dll")
wsc_4442=RegFn("wsc_4442","II@C","I","mwic_16.dll")
rsc_4442=RegFn("rsc_4442","II@C","I","mwic_16.dll")
rsct_4442=RegFn("rsct_4442","I@I","I","mwic_16.dll")

st=0
icdev=0 
status=0

&&icdev=callfn(auto_init,1,9600) 
icdev=callfn(ic_init,1,9600)  
st=callfn(get_status,icdev,@status)
if st<>0
    ?"init error"
    st=callfn(ic_exit,icdev)
    retu
endi
?status

st=callfn(chk_4442,icdev)
if st<>0 
   ?"chk error"
    st=callfn(ic_exit,icdev)
    retu    
endi

****** √‹¬Î hex b6 23 07 *****
password=chr(182)+chr(35)+chr(7)
st=callfn(csc_4442,icdev,3,@password)
if st<>0 
   ?"csc error"
    st=callfn(ic_exit,icdev)
    retu    
endi


password=chr(182)+chr(35)+chr(7) 
st=callfn(wsc_4442,icdev,3,@password)
if st<>0 
   ?"wsc error"
    st=callfn(ic_exit,icdev)
    retu    
endi

st=callfn(rsc_4442,icdev,3,@password)
if st<>0 
 ?"rsc error"
  st=callfn(ic_exit,icdev)
  retu    
endi
&&?password

counter=0
st=callfn(rsct_4442,icdev,@counter)
if st<>0 
   ?"rsct error"
    st=callfn(ic_exit,icdev)   
endi
&&?counter

offset=32
le=12 
data1="RD0123456789"
st=callfn(swr_4442,icdev,offset,le,@data1)
if st<>0 
   ?"swr error"
    st=callfn(ic_exit,icdev)
    retu    
endi

data2=space(12)
st=callfn(srd_4442,icdev,offset,le,@data2)
if st<>0 
 ?"srd error"
  st=callfn(ic_exit,icdev)
  retu    
endi
?data2
 
 data2="mwrd"
&& st=callfn(pwr_4442,icdev,10,4,@data2)
if st<>0 
 ?"pwr error"
  st=callfn(ic_exit,icdev)
  retu    
endi

&& st=callfn(prd_4442,icdev,10,4,@data2)
if st<>0 
 ?"prd error"
  st=callfn(ic_exit,icdev)
  retu    
endi

st=callfn(ic_exit,icdev)
?" Test Ok!"