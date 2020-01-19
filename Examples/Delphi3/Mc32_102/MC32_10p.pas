unit MC32_10p;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  icdev:longint;
  st:integer;
  data1,data2,hexdata1,hexdata2:Array[0..64]of char;
  password,password1:Array[0..3]of char;
  zone,length,offset:smallint;
  counter:smallint;
  status:integer;
  proval:pchar;

  dest,source:array[0..16]of char;

//  operate sle 102
function swr_102(icdev: longint;zone:smallint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'swr_102';
function srd_102(icdev: longint;zone:smallint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'srd_102';
function ser_102(icdev: longint;zone:smallint;offset:smallint;length:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'ser_102';

function csc_102(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'csc_102';
function wsc_102(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'wsc_102';
function rsc_102(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsc_102';
function rsct_102(icdev: longint;counter:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsct_102';

function cesc_102(icdev: longint;zone:smallint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'cesc_102';
function wesc_102(icdev: longint;zone:smallint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'wesc_102';
function resc_102(icdev: longint;zone:smallint;length:smallint;vpassword:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'resc_102';
function resct_102(icdev: longint;zone:smallint;counter:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'resct_102';

function clrpr_102(icdev: longint;zone:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'clrpr_102';
function clrrd_102(icdev: longint;zone:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'clrrd_102';

function fakefus_102(icdev: longint;mode:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'fakefus_102';
function blow_102(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'blow_102';
function chk_102(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'chk_102';

  //use general function
function ic_init(port: smallint;baud:longint): longint; stdcall;
far;external 'MWIC_32.DLL' name 'ic_init';
function auto_init(port: smallint;baud:longint): longint; stdcall;
far;external 'MWIC_32.DLL' name 'auto_init';
function ic_exit(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll' name 'ic_exit';
function get_status(icdev: longint; status:pchar):smallint;stdcall;
far;external 'MWIC_32.dll' name 'get_status';

function cmp_dvsc(icdev:longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll' name 'cmp_dvsc';
function setsc_md(icdev: longint;mode:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'setsc_md';
function srd_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'srd_dvsc'
function swr_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'swr_dvsc';
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

procedure TForm1.FormShow(Sender: TObject);
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

st:=get_status(icdev,@status);   //检测读写器内是否有卡,satus=1表示有卡
if st<>0 then
       begin
         listbox1.items.Add('Status error');
         exit;
       end
     else
       listbox1.items.add('Status OK');

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
st:=ic_exit(icdev);     //退出串口；
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
st:=chk_102(icdev);                         //检测是否102卡
if st<>0 then
  begin
    listbox1.items.add('chk error');
    exit;
  end
else
  listbox1.items.add('chk ok');

//password1:=chr($F0)+chr($F0);                //校验总密码
password:='F0F0';
st:=asc_hex(password,password1,2);

st:=csc_102(icdev,2,password1);
if st<>0 then
  begin
    listbox1.items.add('csc error');
    exit;
  end
else
  listbox1.items.add('csc ok');


st:=rsc_102(icdev,2,password);           //读密码
if st<>0 then
  begin
    listbox1.items.add('rsc error');
    exit;
  end
else
  listbox1.items.add('rsc ok');

//st:=wsc_102(icdev,2,password1);         //改写密码
if st<>0 then
  begin
    listbox1.items.add('wcs error');
    exit;
  end
else
  listbox1.items.add('wsc ok');

st:=rsct_102(icdev,@counter);              //读错误计数器
if st<>0 then
  begin
    listbox1.items.add('rsct error');
    exit;
  end
else
  listbox1.items.add('rsct ok.count='+inttostr(counter));

zone:=1;
offset:=0;                                   //先擦后写
length:=64;
st:=ser_102(icdev,zone,offset,length);       //擦除操作
if st<>0 then
  begin
    listbox1.items.add('ser error');
    exit;
  end
else
  listbox1.items.add('ser ok');

offset:=1;                                 //以ASC方式读写数据
length:=15;
data1:='MWRD_1234567890';
st:=swr_102(icdev,zone,offset,length,data1);
if st<>0 then
  begin
    listbox1.items.add('write error');
    exit;
  end
else
  listbox1.items.add('write ok');

st:=srd_102(icdev,zone,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  listbox1.items.add('read ok: '+ data2);

offset:=48;                                 //以十六进制方式读写数据
length:=10;
data1:='01234567890123456789';
st:=asc_hex(data1,hexdata1,10);

st:=swr_102(icdev,zone,offset,length,hexdata1);
if st<>0 then
  begin
    listbox1.items.add('write_hex error');
    exit;
  end
else
  listbox1.items.add('write_hex ok');

st:=srd_102(icdev,zone,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  st:=hex_asc(data2,hexdata2,10);
  listbox1.items.add('read_hex ok: '+ hexdata2);


st:=clrpr_102(icdev,1);                  //清写保护位为0
if st<>0 then
  begin
    listbox1.items.add('clrpr error');
    exit;
  end
else
  listbox1.items.add('clrpr ok');

st:=clrrd_102(icdev,1);                 //清读保护位为0
if st<>0 then
  begin
    listbox1.items.add('clrrd error');
    exit;
  end
else
  listbox1.items.add('clrrd ok');

//st:=resc_102(icdev,1,2,password);     //读一区擦除密码
if st<>0 then
  begin
    listbox1.items.add('resc error');
    exit;
  end
else
  listbox1.items.add('resc ok');

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

end.
