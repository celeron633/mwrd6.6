program MC32_93d;

uses
  Forms,
  MC32_93p in 'MC32_93p.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
