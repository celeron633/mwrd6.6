unit MC32_42p;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TMC32_42 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    ListBox1: TListBox;
    BitBtn4: TBitBtn;
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MC32_42: TMC32_42;
  data1,data2:Array[0..256]of char;
  hexdata1,hexdata2:Array[0..256]of char;

  password1:Array[0..3]of char;
  password:array[0..6]of char;

  icdev:longint;
  st:integer;
 // password:pchar;
  length:smallint;
  offset:smallint;
  counter:smallint;
  proval:array[0..3]of char;//pchar;
  status:integer;
  dest,source:array[0..16]of char;

  proval1:array[0..7]of char;

//  operate sle 4442
function swr_4442(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'swr_4442';
function srd_4442(icdev: longint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'srd_4442';
function prd_4442(icdev: longint;length:smallint;data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'prd_4442';
function pwr_4442(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'pwr_4442';
function chk_4442(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'chk_4442';

function csc_4442(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'csc_4442';
function wsc_4442(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'wsc_4442';
function rsc_4442(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsc_4442';
function rsct_4442(icdev: longint;counter:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsct_4442';

  //use general function
  function ic_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'ic_init';
  function auto_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'auto_init';
  function ic_exit(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'ic_exit';
  function get_status(icdev: longint;status:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'get_status';

  function cmp_dvsc(icdev:longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'cmp_dvsc';
  function setsc_md(icdev: longint;mode:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'setsc_md';
  function srd_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_dvsc'
  function swr_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_dvsc';

  function turn_off(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'turn_off';
  function turn_on(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'turn_on';
  function auto_pull(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'auto_pull';
  function srd_ver(icdev: longint;length:smallint;ver:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_ver';
  function dv_beep(icdev: longint;time:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'dv_beep';

  function asc_hex(asc:pchar;hex:pchar;len:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'asc_hex';
  function hex_asc(hex:pchar;asc:pchar;len:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'hex_asc';

  function ic_encrypt(key:pchar;source:pchar;len:smallint;dest:pchar):smallint;
  stdcall;far;external 'MWIC_32.dll'name 'ic_encrypt';
  function ic_decrypt(key:pchar;dest:pchar;len:smallint;source:pchar):smallint;
  stdcall;far;external 'MWIC_32.dll'name 'ic_decrypt';


implementation

{$R *.DFM}


procedure TMC32_42.BitBtn4Click(Sender: TObject);
begin
st:=chk_4442(icdev);               //检测是否4442卡
if st<>0 then
  begin
    listbox1.items.add('chk error');
    exit;
  end
else
  listbox1.items.add('chk ok');


//password1:=chr($B6)+chr($23)+chr($07);   //校验密码
password:='b62307';
st:=asc_hex(password,password1,3);
st:=csc_4442(icdev,3,password1);
if st<>0 then
  begin
    listbox1.items.add('csc error');
    exit;
  end
else
  listbox1.items.add('csc ok');


st:=rsc_4442(icdev,3,password);                   //读密码
if st<>0 then
  begin
    listbox1.items.add('rsc error');
    exit;
  end
else
  listbox1.items.add('rsc ok');

password:=chr($b6)+chr($23)+chr($07);            //改写密码
st:=wsc_4442(icdev,3,password);
if st<>0 then
  begin
    listbox1.items.add('wcs error');
    exit;
  end
else
  listbox1.items.add('wsc ok');

counter:=0;
st:=rsct_4442(icdev,@counter);               //读密码错误计数器
if st<>0 then
  begin
    listbox1.items.add('rsct error');
    exit;
  end
else
  listbox1.items.add('rsct ok，count='+inttostr(counter));

offset:=32;                            //以ASC形式读写
length:=15;
data1:='MWRD_1234567890';
st:=swr_4442(icdev,offset,length,data1);
if st<>0 then
  begin
    listbox1.items.add('write error');
    exit;
  end
else
  listbox1.items.add('write ok');


st:=srd_4442(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  listbox1.items.add('read ok');
  listbox1.items.add('data:'+data2);

offset:=48;                            //以十六进制形式读写
length:=10;
data1:='1234567890aabbccddee';

st:=asc_hex(data1,hexdata1,10);
if st<>0 then
  begin
    listbox1.items.add('asc_hex error.');
    exit;
  end ;

st:=swr_4442(icdev,offset,length,hexdata1);
if st<>0 then
  begin
    listbox1.items.add('write_hex error');
    exit;
  end
else
  listbox1.items.add('write_hex ok');


st:=srd_4442(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  st:=hex_asc(data2,hexdata2,10);
  listbox1.items.add('read_hex ok');
  listbox1.items.add('hexdata:'+hexdata2);


//st:=pwr_4442(icdev,9,1,'3');          //保护指定地址的数据
if st<>0 then                            //所带的数据必须和卡上数据相同
  begin
    listbox1.items.add('pwr error');
    exit;
  end
else
  listbox1.items.add('pwr ok');

st:=prd_4442(icdev,4,proval);       //读保护标志，为0表示对应字节已保护
if st<>0 then                             //      为1表示未置保护
  begin
    listbox1.items.add('prd error');
    exit;
  end
else
  st:=hex_asc(proval,proval1,4);
  listbox1.items.add('prd ok');
  listbox1.items.add('prd byte:'+proval1);


st:=ic_encrypt('12345678','明华技术开发中心',16,dest); //DES加密
if st<>0 then
   begin
    listbox1.items.add('encrypt error');
    exit;
  end
else
  listbox1.items.add('encrypt ok');
  listbox1.items.add('Ciphertext:'+dest);

st:=ic_decrypt('12345678',dest,16,source);             //DES解密
if st<>0 then
   begin
    listbox1.items.add('decrypt error');
    exit;
  end
else
  listbox1.items.add('decrypt ok');
  listbox1.items.add('Plaintext:'+source);

end;


procedure TMC32_42.FormShow(Sender: TObject);
begin
listbox1.Items.clear;
icdev:=auto_init(0,9600); //初始化串口一，并将读写器波特率设为9600
//icdev:=ic_init(0,9600);
if icdev<=0 then
  begin
         listbox1.items.Add('init error');
         exit;
  end
  else
       listbox1.items.add('init OK');

status:=0;
st:=get_status(icdev,@status); //检测读写器中是否有卡，status=1 有卡
if st<>0 then
       begin
         listbox1.items.Add('status error');
         exit;
       end
     else
       listbox1.items.add('Status OK');
end;

procedure TMC32_42.FormClose(Sender: TObject; var Action: TCloseAction);
begin
st:=ic_exit(icdev);
end;


end.
