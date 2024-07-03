program Gestao;

uses
  Vcl.Forms,
  main in 'main.pas' {FrMain},
  un_dm in 'un_dm.pas' {DM: TDataModule},
  Un_Base in 'view\inheritable\Un_Base.pas' {Fr_Base},
  base_search in 'view\inheritable\base_search.pas' {BaseSearch},
  base_registry in 'view\inheritable\base_registry.pas' {BaseRegistry},
  UN_TabelasEmListas in 'UN_TabelasEmListas.pas' {DM_ListaConsultas: TDataModule},
  sea_job_position in 'view\module\human_resource\register\sea_job_position.pas' {SeaJobPosition},
  prm_job_position in 'parameter\prm_job_position.pas',
  reg_job_position in 'view\module\human_resource\register\reg_job_position.pas' {RegJobPosition};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDM_ListaConsultas, DM_ListaConsultas);
  Application.CreateForm(TFrMain, FrMain);
  Application.Run;
end.
