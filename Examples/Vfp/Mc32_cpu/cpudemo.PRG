declare integer auto_init in c:\windows\system\mwic_32.dll short port,integer baud
declare integer  ic_init in c:\windows\system\mwic_32.dll short port,integer baud
declare short get_status in c:\windows\system\mwic_32.dll integer icdev,short @status
declare short ic_exit in c:\windows\system\mwic_32.dll  integer icdev
declare short cpu_reset in c:\windows\system\mwic_32.dll integer icdev,string @receive_data
declare short cpu_protocol in c:\windows\system\mwic_32.dll integer icdev, short len,string @send_data,string @recive_data
declare short hex_asc in c:\windows\system\mwic_32.dll string @hexdata, string @ascdata,integer len

dimension tbcc(100)
wdata=space(100)

icdev=auto_init(0,9600)
&&icdev=ic_init(0,9600)
if icdev<0
    ? "init error."
    retu
endif
? "init ok."

status=0
st=get_status(icdev,@status)
if st<>0
    ?"status error."
endif


  rdata=space(20)
  st=cpu_reset(icdev,@rdata)
  if st<>0
      ? "cpu_reset error."
  else
      ? "reset ok."
  endif
 
  hexdata=space(40)
  st=hex_asc(@rdata,@hexdata,20)
  if st<>0
      ? "hex_asc error." 
  else
      ?hexdata
  endif
  
   && bcc calculation 
   tbcc(1)=0
   tbcc(2)=64
   tbcc(3)=5
   tbcc(4)=0
   tbcc(5)=132
   tbcc(6)=0
   tbcc(7)=0
   tbcc(8)=8
   tbcc(9)=0 
   i=1
   do while i<9
       tbcc(9)=bitxor(tbcc(9),tbcc(i))
       i=i+1
   enddo
   
   le=9
   wdata=chr(0)+chr(64)+chr(5)+chr(0)+chr(132)+chr(0)+chr(0)+chr(8)+chr(tbcc(9))
   &&    nad    pcb     len    get random          ....              bcc
   
  st=cpu_protocol(icdev,le,@wdata,@rdata)   
  if st<>0
      ? "cpu_protocol error."
  else
      ? "tansfer ok"
  endif
  
   
  st=hex_asc(@rdata,@hexdata,13)
  if st<>0
      ? "hex_asc error." 
  else
      ?  substr(hexdata,1,26)
      ?" nad:",substr(hexdata,1,2)
      ?" pcb:",substr(hexdata,3,2)
      ?" len:",substr(hexdata,5,2)
      ?" random:",substr(hexdata,7,16)
      ?" sw1sw2:",substr(hexdata,23,4)
  endif  

  st=ic_exit(icdev)
  if st<>0
      ? "exit error."
      retu
  endif

  retu
