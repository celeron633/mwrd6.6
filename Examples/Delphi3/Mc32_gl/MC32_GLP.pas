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

  function cmp_dvsc(icdev:longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'cmp_dvsc';
  function setsc_md(icdev: longint;mode:smallint):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'setsc_md';
  function srd_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_dvsc';
  function swr_dvsc(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_dvsc';
//function val_set(icdev: longint;value:longint):smallint;stdcall;
//far;external 'MWIC_32.dll'name 'val_set';
//function val_inc(icdev: longint;value:longint):smallint;stdcall;
//far;external 'MWIC_32.dll'name 'val_inc';
//function val_dec(icdev: longint;value:longint):smallint;stdcall;
//far;external 'MWIC_32.dll'name 'val_dec';
//function val_read(icdev: longint;var value:longint):smallint;stdcall;
//far;external 'MWIC_32.dll'name 'val_read';
  function swr_eeprom(icdev: longint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'swr_eeprom';
  function srd_eeprom(icdev: longint;offset:smallint;length:smallint;data2:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll'name 'srd_eeprom';

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
   password:array[0..2] of char;
begin

st:=setsc_md(icdev,1);                   //设置读写器密码有效；
if st<>0 then
  begin
    listbox1.items.add('set mode error');
    exit;
  end
else
  listbox1.items.add('set mode ok');

password:=chr(255)+chr(255)+chr(255);        //校验读写器密码；
st:=cmp_dvsc(icdev,3,password);
if st<>0 then
  begin
    listbox1.items.add('cmp password error');
    exit;
  end
else
  listbox1.items.add('cmp password ok');

st:=srd_dvsc(icdev,3,password);             //读出读写器密码；
if st<>0 then
  begin
    listbox1.items.add('read password error');
    exit;
  end
else
  listbox1.items.add('read password ok');

password:=chr(255)+chr(255)+chr(255);      //改写读写器密码；
st:=swr_dvsc(icdev,3,password);
if st<>0 then
  begin
    listbox1.items.add('write password error');
    exit;
  end
else
  listbox1.items.add('write password ok');

end;
procedure TMC32_GL.BitBtn4Click(Sender: TObject);
var
  ver:pchar;
begin
ver:=stralloc(20);
st:=srd_ver(icdev,10,ver);                    //读出读写器设备版本号；
if st<>0 then
  begin
    listbox1.items.add('read version error');
    exit;
  end
else
  listbox1.items.add('read version ok');
  listbox1.items.add('version:'+ver);


st:=turn_off(icdev);                         //对卡下电；
  if st<>0 then
  begin
    listbox1.items.add('turn off error');
    exit;
  end
else
  listbox1.items.add('turn off ok');

st:=turn_on(icdev);                        //对卡上电；
if st<>0 then
  begin
    listbox1.items.add('turn on error');
    exit;
  end
else
  listbox1.items.add('turn on ok');

st:=dv_beep(icdev,10);                    //设备蜂鸣；
if st<>0 then
  begin
    listbox1.items.add('beep error');
    exit;
  end
else
  listbox1.items.add('beep ok');

st:=auto_pull(icdev);                     //自动弹卡，只适用于自弹读写器；
if st<>0 then
  begin
    listbox1.items.add('auto pull error');
    exit;
  end
else
  listbox1.items.add('auto pull ok');

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

