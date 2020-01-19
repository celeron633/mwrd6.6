unit MC32_24p;

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
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  data1,data2,hexdata1,hexdata2:Array[0..128]of char;
  icdev: longint;
  st:smallint;
  length:integer;
  offset:integer;
  status:integer;

  source,dest:array[0..16]of char;

  //use 24 function
  function chk_24c01a(icdev:longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'chk_24c01a';
  function swr_24c01a(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_24c01a';
  function srd_24c01a(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_24c01a';

  function chk_24c02(icdev:longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'chk_24c02';
  function swr_24c02(icdev: longint;offset:smallint;length:smallint;var data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_24c02';
  function srd_24c02(icdev: longint;offset:smallint;length:smallint;var data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_24c02';

  function chk_24c04(icdev:longint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'chk_24c04';
  function swr_24c04(icdev: longint;offset:smallint;length:smallint;var data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_24c04';
  function srd_24c04(icdev: longint;offset:smallint;length:smallint;var data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_24c04';

  //use general function
  function auto_init(port: smallint;baud:longint): longint;stdcall;
  far;external 'MWIC_32.DLL' name 'auto_init';
  function ic_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'ic_init';
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


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
st:=chk_24c01a(icdev);           //检测是否24c01a卡
if st<>0 then
  begin
    listbox1.items.add('chk error');
    exit;
  end
else
  listbox1.items.add('chk ok');

                                //以ASC码读写数据
offset:=0;
length:=15;
data1:='MWRD_1234567890';
st:=swr_24c01a(icdev,offset,length,data1);
if st<>0 then
  begin
    listbox1.items.add('write error');
    exit;
  end
else
  listbox1.items.add('write ok');

st:=srd_24c01a(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  listbox1.items.add('read ok');
  listbox1.items.add(data2);


                                //以十六进制读写数据
offset:=48;
length:=10;
data1:='12345678901234567890';

st:=asc_hex(data1,hexdata1,10);
if st<>0 then
  begin
    listbox1.items.add('asc_hex error.');
    exit;
  end ;

st:=swr_24c01a(icdev,offset,length,hexdata1);
if st<>0 then
  begin
    listbox1.items.add('write_hex error');
    exit;
  end
else
  listbox1.items.add('write_hex ok');

st:=srd_24c01a(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  st:=hex_asc(data2,hexdata2,10);
  if st<>0 then
    begin
        listbox1.items.add('asc_hex error.');
        exit;
    end ;

 listbox1.items.add('read_hex ok ');
 listbox1.items.add(data1);

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


procedure TForm1.FormShow(Sender: TObject);
begin
listbox1.Items.clear;

icdev:=auto_init(0,9600);  //初始化串口一，并将读写器波特率设置为9600
//icdev:=ic_init(0,9600);
if icdev<=0 then
       begin
         listbox1.items.Add('init error');
         exit;
       end
     else
       listbox1.items.add('Init OK');

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

procedure TForm1.FormCreate(Sender: TObject);
begin
st:=ic_exit(icdev);          //退出串口
end;

end.
