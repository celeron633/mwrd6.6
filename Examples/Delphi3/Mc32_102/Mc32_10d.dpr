program MC32_10d;

uses
  Forms,
  MC32_10p in 'MC32_10p.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
