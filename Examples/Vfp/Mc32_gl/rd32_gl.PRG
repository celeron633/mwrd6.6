declare integer auto_init in c:\windows\system\mwic_32.dll short port,integer baud
declare integer  ic_init in c:\windows\system\mwic_32.dll short port,integer baud
declare short ic_exit in c:\windows\system\mwic_32.dll  integer icdev
declare short get_status in c:\windows\system\mwic_32.dll integer icdev,integer @status

declare short dv_beep in c:\windows\system\mwic_32.dll   integer icdev,integer time
declare short auto_pull in c:\windows\system\mwic_32.dll integer icdev
declare short  turn_on  in c:\windows\system\mwic_32.dll integer icdev
declare short  turn_off  in c:\windows\system\mwic_32.dll integer icdev
declare short  srd_ver  in c:\windows\system\mwic_32.dll integer icdev,integer len,string @databuff
declare short  srd_snr  in c:\windows\system\mwic_32.dll integer icdev,integer len,string @databuff

declare short  setsc_md  in c:\windows\system\mwic_32.dll integer icdev,integer mode
declare short  cmp_dvsc  in c:\windows\system\mwic_32.dll integer icdev,integer len,string @databuff
declare short  srd_dvsc  in c:\windows\system\mwic_32.dll integer icdev,integer len,string @databuff

declare short ic_encrypt in c:\windows\system\mwic_32.dll  string @buffer, string @buffer1,short len,string @buffer2
declare short ic_decrypt in c:\windows\system\mwic_32.dll  string @buffer, string @buffer1,short len,string @buffer2

declare short asc_hex in c:\windows\system\mwic_32.dll string @buffer, string @buffer1,integer len
declare short hex_asc in c:\windows\system\mwic_32.dll string @buffer, string @buffer1,integer len


icdev=auto_init(0,9600)             &&初始化串口一，设读写器波特率为9600；
&&icdev=ic_init(0,9600)
if icdev<0
    ? "init error."
    retu
endif
? "init ok."

status=0                           &&检测读写器内是否有卡，status=0表示无卡，=1表示有卡；
st=get_status(icdev,@status)
if st<>0
    ?"status error."
	retu
endif
?"status ok."+str(status)

&&ver=space(20)
&&st=srd_ver(icdev,18,@ver)
&&if st<>0
&&     ? "read ver error."
&&     retu
&&endif
&&?  "ver : "+ver 

snr=space(16)
st=srd_snr(icdev,16,@snr)
if st<>0
     ? "read snr error."
     retu
 endif
 ? "snr:"+snr
 
 st=setsc_md(icdev,0)
 if st<>0 
     ? "setsc_md  error."
     retu
 endif
 ? "set  device password ok."
 
devpass=chr(255)+chr(255)+chr(255)+chr(255)
 st=cmp_dvsc(icdev,3,devpass)
 if st<>0
   ? "device password error."
   retu
endif
? "device password ok.   ."

st=dv_beep(icdev,50)
 if st<>0
     ? "beep error."
     retu
 endif    
     

st=setsc_md(icdev,1)
if st<>0
   ? "setsc_md  mode 1 error."
   retu
endif
? "setsc_md mode 1 ok."

st=auto_pull(icdev)           
        
st=ic_exit(icdev)
if st<>0
    ? "exit comm error."
    retu
endif

retu
            



dest=space(16)
source=space(16)
st=ic_encrypt("12345678","明华公司开发中心",16,@dest)
if st<>0 
  ? "encrypt error."
  retu
endif  
? "Ciphertext: "+dest

st=ic_decrypt("12345678",@dest,16,@source)
if st<>0
   ? "decrypt error."
   retu
endif
? "Plaintext:"+ source


st=ic_exit(icdev)
if st<>0
    ? "exit error."
    retu
endif
? "exit ok."

retu
