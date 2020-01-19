declare integer auto_init in c:\windows\system\mwic_32.dll short port,integer baud
declare integer  ic_init in c:\windows\system\mwic_32.dll short port,integer baud
declare short ic_exit in c:\windows\system\mwic_32.dll  integer icdev
declare short get_status in c:\windows\system\mwic_32.dll integer icdev,integer @status

declare short chk_1604  in c:\windows\system\mwic_32.dll integer icdev
declare short srd_1604  in c:\windows\system\mwic_32.dll integer icdev, short zone,short offset,short len,string @buffer
declare short swr_1604  in c:\windows\system\mwic_32.dll integer icdev, short zone,short offset,short len,string @buffer
declare short ser_1604  in c:\windows\system\mwic_32.dll integer icdev, short zone,short offset,short len
declare short csc_1604   in c:\windows\system\mwic_32.dll integer icdev, short zone,short len,string @buffer
declare short  wsc_1604   in c:\windows\system\mwic_32.dll integer icdev, short zone,short len,string @buffer
declare short   rsc_1604   in c:\windows\system\mwic_32.dll integer icdev, short  zone ,short len,string @buffer
declare short  rsct_1604   in c:\windows\system\mwic_32.dll integer icdev, short  zone,integer @counter

declare short ic_encrypt in c:\windows\system\mwic_32.dll  string @buffer, string buffer1,short len,string @buffer2
declare short ic_decrypt in c:\windows\system\mwic_32.dll  string @buffer, string @buffer1,short len,string @buffer2

declare short asc_hex in c:\windows\system\mwic_32.dll string @buffer, string @buffer1,integer  len
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


st=chk_1604(icdev)     &&测卡函数仅供参考,
if st<>0                &&建议:在应用中请根据自行设计的发行商代码来检测卡
    ? "chk card error."
     retu
endif
? "chk card ok."

&&password1=chr(240)+chr(240)   &&=F0F0

password="F0F0"                     &&  校验密码
password1=space(2)
st=asc_hex(password,@password1,2)
st=csc_1604(icdev,0,2,password1)
if st<>0
    ? "check password error."
    retu
endif
? "check password ok."  

counter=0                                  && 读出总密码错误计数器
st=rsct_1604(icdev,0,@counter)
if st<>0 then
   ? "rest_1604 error."
   retu
endif
? "counter="+str(counter)


st=ser_1604(icdev,1,0,256)        && 擦除操作
if st<>0
   ? "ser_1604 error."
   retu
endif
? "ser_1604 ok."


zone=1
offset=2                          && 以ASC形式进行读、写；          
le=8
data1="abcdefgh"
st=swr_1604(icdev,zone,offset,le,@data1)
if st<>0
    ? "write error."
   retu
endif
? "write ok."

data2=space(8)
st=srd_1604(icdev,zone,offset,le,@data2)   
if st<>0
    ? "read error."
   retu
endif
? "read ok"
? 'data: '+data2   


offset=12                          &&以十六进制形式进行读、写；          
le=10
data1="31323334353637383930"
hexdata1=space(20)
st=asc_hex(data1,@hexdata1,10)
st=swr_1604(icdev,zone,offset,le,@hexdata1)
if st<>0
    ? "write_hex error."
   retu
endif
? "write_hex ok."


data3=space(10)
hexdata3=space(20)
st=srd_1604(icdev,zone,offset,le,@data3)   
if st<>0
    ? "read error."
   retu
endif

st=hex_asc(@data3,@hexdata3,10)
? "read_hex ok"
? "hexdata3: "+hexdata3   

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
