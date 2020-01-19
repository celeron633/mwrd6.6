program MC32_42d;

uses
  Forms,
  MC32_42p in 'MC32_42p.pas' {MC32_42};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMC32_42, MC32_42);
  Application.Run;
end.
