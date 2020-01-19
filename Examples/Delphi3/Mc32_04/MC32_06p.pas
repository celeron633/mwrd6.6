unit MC32_06p;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TMC32_06 = class(TForm)
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
  MC32_06: TMC32_06;

  icdev:longint;
  st:integer;
  data1,data2:Array[0..26]of char;
  password:Array[0..5]of char;
  passwordesc:pchar;
  length,offset:smallint;
  counter,status:smallint;
  proval:pchar;

//  operate sle 4404
function swr_4404(icdev: longint;offset:smallint;length:smallint;data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'swr_4404';
function srd_4404(icdev: longint;offset:smallint;length:smallint; data1:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'srd_4404';
function ser_4404(icdev: longint;offset:smallint;length:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'ser_4404';

function csc_4404(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'csc_4404';
function wsc_4404(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'wsc_4404';
function rsc_4404(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsc_4404';
function rsct_4404(icdev: longint; counter:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'rsct_4404';

function cesc_4404(icdev: longint;length:smallint; password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'cesc_4404';
function wesc_4404(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'wesc_4404';
function resc_4404(icdev: longint;length:smallint;password:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'resc_4404';
function resct_4404(icdev: longint;var counter:pchar):smallint;stdcall;
far;external 'MWIC_32.dll'name 'resct_4404';

function fakefus_4404(icdev: longint;mode:smallint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'fakefus_4404';
function psnl_4404(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'blow_4404';
function chk_4404(icdev: longint):smallint;stdcall;
far;external 'MWIC_32.dll'name 'chk_4404';

  //use general function
  function ic_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'ic_init';
  function auto_init(port: smallint;baud:longint): longint; stdcall;
  far;external 'MWIC_32.DLL' name 'auto_init';
  function ic_exit(icdev: longint):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'ic_exit';
  function get_status(icdev: longint; status:pchar):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'get_status';
  function set_baud(icdev: longint;baud:longint):smallint;stdcall;
  far;external 'MWIC_32.dll' name 'set_baud';

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





implementation

{$R *.DFM}


procedure TMC32_06.FormShow(Sender: TObject);
begin
listbox1.Items.clear;

// icdev:=auto_init(0,9600);
icdev:=ic_init(0,9600);
if icdev<=0 then
       begin
         listbox1.items.Add('init error');
         exit;
       end
     else
       listbox1.items.add('init OK');

 st:=get_status(icdev,@status);
 if st<>0 then
       begin
         listbox1.items.Add('Status error');
         exit;
       end
     else
       listbox1.items.add('Status OK');

end;

procedure TMC32_06.FormClose(Sender: TObject; var Action: TCloseAction);
begin
st:=ic_exit(icdev);
end;

procedure TMC32_06.BitBtn1Click(Sender: TObject);
begin

password:=chr($55)+chr($55);
st:=csc_4404(icdev,2,password);
if st<>0 then
  begin
    listbox1.items.add('scs error');
    exit;
  end
else
  listbox1.items.add('csc ok');

st:=chk_4404(icdev);
if st<>0 then
  begin
    listbox1.items.add('chk error');
    exit;
  end
else
  listbox1.items.add('chk ok');

st:=rsc_4404(icdev,2,password);
if st<>0 then
  begin
    listbox1.items.add('rsc error');
    exit;
  end
else
  listbox1.items.add('rsc ok');

//st:=wsc_4404(icdev,2,password);
if st<>0 then
  begin
    listbox1.items.add('wcs error');
    exit;
  end
else
  listbox1.items.add('wsc ok');

st:=rsct_4404(icdev,@counter);
if st<>0 then
  begin
    listbox1.items.add('rsct error');
    listbox1.items.add(inttostr(counter));
    exit;
  end
else
  listbox1.items.add('rsct ok');

password:=chr($ff)+chr($ff)+chr($ff)+chr($ff);
st:=cesc_4404(icdev,4,password);
if st<>0 then
  begin
    listbox1.items.add('cesc error');
    exit;
  end
else
  listbox1.items.add('cesc ok');

offset:=15;
length:=15;
data1:='MWRD_1234567890';
st:=swr_4404(icdev,offset,length,data1);
if st<>0 then
  begin
    listbox1.items.add('write error');
    exit;
  end
else
  listbox1.items.add('write ok');

st:=srd_4404(icdev,offset,length,data2);
if st<>0 then
  begin
    listbox1.items.add('read error');
    exit;
  end
else
  listbox1.items.add('read ok:'+data2);

end;

end.
