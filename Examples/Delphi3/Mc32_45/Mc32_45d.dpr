program MC32_45d;

uses
  Forms,
  MC32_45p in 'MC32_45p.pas' {MC32_45};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMC32_45, MC32_45);
  Application.Run;
end.
