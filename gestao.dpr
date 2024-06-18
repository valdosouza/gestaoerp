program gestao;

uses
  Vcl.Forms,
  main in 'main.pas' {FrMain},
  un_dm in 'un_dm.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrMain, FrMain);
  Application.Run;
end.
