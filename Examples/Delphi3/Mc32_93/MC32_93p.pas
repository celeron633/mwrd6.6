unit MC32_93p;

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
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure BitBtn2Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  data1,hexdata1:Array[0..128]of char;
  data2,hexdata2:Array[0..128]of char;
  icdev:longint;
  st:integer;
  length:smallint;
  offset:smallint;
  status:integer;

  dest,source:array[0..16]of char;

//  函数申明
  function srd_93c46(icdev: longint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_93c46';
  function swr_93c46(icdev: longint;offset:smallint;length:smallint; data2:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_93c46';
  function eral_93c46(icdev:longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'eral_93c46';
  function chk_93c46(icdev:longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'chk_93c46';

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


procedure TForm1.FormShow(Sender: TObject);
begin
listbox1.Items.clear;
icdev:=auto_init(0,9600);     //初始化串口一，并将读写器波特率设为9600
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

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
st:=ic_exit(icdev);             //退出串口
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
st:=chk_93c46(icdev);           //检测是否是93c46
if st<>0 then
  begin
    listbox1.items.add('chk error');
    exit;
  end
else
  listbox1.items.add('chk ok');

st:=eral_93c46(icdev);          //擦除操作
if st<>0 then
  begin
    listbox1.items.add('eral error');
    exit;
  end
else
  listbox1.items.add('eral ok');

offset:=0;                    //以ASC码形式读写数据
length:=15;
data1:='MWRD_1234567890';
st:=swr_93c46(icdev,offset,length,data1);
if st<>0 then
  begin
    listbox1.items.add('write error');
    exit;
  end
else
  listbox1.items.add('write ok');


st:=srd_93c46(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
    listbox1.items.add('read ok');
    listbox1.items.add(data2);


offset:=48;                    //以十六进制形式读写数据
length:=10;
data1:='01234567890123456789';
st:=asc_hex(data1,hexdata1,10);
if st<>0 then
  begin
    listbox1.items.add('asc_hex error');
    exit;
  end;

st:=swr_93c46(icdev,offset,length,hexdata1);
if st<>0 then
  begin
    listbox1.items.add('write_hex error');
    exit;
  end
else
  listbox1.items.add('write_hex ok');


st:=srd_93c46(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
    st:=hex_asc(data2,hexdata2,10);
    if st<>0 then
       begin
         listbox1.items.add('hex_asc error');
         exit;
       end;
    listbox1.items.add('read_hex ok');
    listbox1.items.add(hexdata2);


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

