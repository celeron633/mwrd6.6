unit MC32_Glp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TMC32_GL = class(TForm)
    ListBox1: TListBox;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Button1: TButton;
    Bevel2: TBevel;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  icdev: longint;
  st:smallint;

  MC32_GL: tMC32_GL;
  function ic_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'ic_init';
  function auto_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'auto_init';
  function ic_exit(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'ic_exit';
  function get_status(icdev: longint; status:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'get_status';

  function asc_hex(asc:pchar;hex:pchar;len:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'asc_hex';
  function hex_asc(var hex:byte;asc:pchar;len:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'hex_asc';


  function cpu_reset(icdev:longint;var databuff:byte):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'cpu_reset';
  function cpu_protocol(icdev: longint;len:smallint;var send_cmd:byte;var rece_cmd:byte):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'cpu_protocol';

implementation

{$R *.DFM}

procedure TMC32_GL.BitBtn1Click(Sender: TObject);
var

//  data1:pchar;
    status:smallint;
//  data2:pchar;
//  length:integer;
//  offset:integer;


begin
icdev:=auto_init(0,9600);  //初始化串口一，并将读写器波特率设为9600；
//icdev:=ic_init(0,9600);
if icdev<=0 then
      begin
         listbox1.items.Add('init error');
         exit;
       end
     else
       listbox1.items.add('init OK');

st:=get_status(icdev,@status);       //检测读写器中是否有卡，
if st=0 then                         //status=0表示无卡，=1表示有卡；
  begin
  listbox1.items.Add('get status OK');
  if status<>1 then
      listbox1.items.add ('no card');
  end
else
  begin
  listbox1.items.add('get status error');
  exit;
  end;

bitbtn1.enabled:=false;
bitbtn3.enabled:=true;
bitbtn4.Enabled :=true;
button1.enabled:=true;
end;


procedure TMC32_GL.Button1Click(Sender: TObject);
begin
 st:=ic_exit(icdev);       //退出串口；
 close;
end;

procedure TMC32_GL.BitBtn3Click(Sender: TObject);
var
   data:array[0..20] of byte;
   hexdata:array[0..40] of char;
begin

st:=cpu_reset(icdev,data[0]);                   //复位；
if st<>0 then
  begin
    listbox1.items.add('reset error');
    exit;
  end
else
   st:=hex_asc(data[0],hexdata,20);
   listbox1.items.add('reset ok');
   listbox1.items.add('ATR:'+hexdata);
end;

procedure TMC32_GL.BitBtn4Click(Sender: TObject);
var
  i:integer;
  wdata:array[0..8] of byte;
  rdata:array[0..13] of byte;
  hexdata:array[0..26] of char;
begin                                  //取随机数
  wdata[0]:=$0;
  wdata[1]:=$40;
  wdata[2]:=$5;
  wdata[3]:=$0;
  wdata[4]:=$84;
  wdata[5]:=$0;
  wdata[6]:=$0;
  wdata[7]:=$8;
  wdata[8]:=$0;
  for i:=0 to 7 do
    wdata[8]:=wdata[i] XOR Wdata[8];     //计算BCC

  st:=cpu_protocol(icdev,9,wdata[0],rdata[0]);
  if st<>0 then
     begin
      listbox1.items.add('get message error');
      exit;
     end
  else
    st:=hex_asc(rdata[0],hexdata,13);
    if st<>0 then
      begin
       listbox1.items.add('hex_asc error');
       exit;
      end;

    listbox1.items.add(hexdata);
    listbox1.items.add('NAD:'+copy(hexdata,1,2));
    listbox1.items.add('pcb:'+copy(hexdata,3,2));
    listbox1.items.add('length:'+copy(hexdata,5,2));
    listbox1.items.add('random:'+copy(hexdata,7,16));
    listbox1.items.add('sw1 sw2:'+copy(hexdata,23,4));
    
end;
procedure TMC32_GL.FormShow(Sender: TObject);
begin
bitbtn1.Enabled :=true;
bitbtn3.enabled:=false;
bitbtn4.Enabled :=false;
button1.enabled:=false;
listbox1.Items.clear;
end;

procedure TMC32_GL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
st:=ic_exit(icdev);                    //退出串口；
end;

end.

