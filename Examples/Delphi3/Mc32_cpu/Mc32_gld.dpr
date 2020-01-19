program MC32_GLd;

uses
  Forms,
  MC32_GLP in 'MC32_GLP.pas' {MC32_GL};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMC32_GL, MC32_GL);
  Application.Run;
end.
