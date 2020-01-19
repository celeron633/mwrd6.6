program MC32_24d;

uses
  Forms,
  MC32_24p in 'MC32_24p.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
