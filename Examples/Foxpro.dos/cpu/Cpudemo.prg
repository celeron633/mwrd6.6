SET TALK Off
wdata=space(100)
str=space(100)

set libr to mwic.plb    

port=1
baud=9600

&&icdev=auto_init(port,baud)       
icdev=ic_init(port,baud)
if icdev<=0
   ?"ic_init error!"
   retu
endif

  st=get_status(icdev)
  if st <>1
      ?"status error!"
  endif

str=cpu_reset(icdev)
if asc(substr(str,1,1))<>0
    ?"cpu_reset error!"
    retu
endif

str=hex_asc(substr(str,2,18),18)
if asc(substr(str,1,1))<>0
    ?"asc_hex error"
    retu
endif
?"Reset:",substr(str,2,40)

wdata=chr(0)+chr(64)+chr(5)+chr(0)+chr(132)+chr(0)+chr(0)+chr(8)+chr(201)
&&    nad    pcb    length  get random                             bcc

str=cpu_ptl(icdev,9,wdata)
if asc(substr(str,1,1))<>0
    ?"cpu_ptl error!"
    retu
endif

str=hex_asc(substr(str,2,13),13)
if asc(substr(str,1,1))<>0
    ?"asc_hex error"
    retu
endif
?"Random:",substr(str,2,26)

RETU
