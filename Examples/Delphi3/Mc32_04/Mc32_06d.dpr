program MC32_06d;

uses
  Forms,
  MC32_06p in 'MC32_06p.pas' {MC32_06};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMC32_06, MC32_06);
  Application.Run;
end.
