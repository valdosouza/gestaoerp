program Gestao;

uses
  Vcl.Forms,
  main in 'main.pas' {FrMain},
  un_dm in 'un_dm.pas' {DM: TDataModule},
  Un_Base in 'view\inheritable\Un_Base.pas' {Fr_Base},
  base_search in 'view\inheritable\base_search.pas' {BaseSearch},
  base_registry in 'view\inheritable\base_registry.pas' {BaseRegistry},
  UN_TabelasEmListas in 'UN_TabelasEmListas.pas' {DM_ListaConsultas: TDataModule},
  reg_users in 'view\module\operation\admin\reg_users.pas' {RegUsers},
  sea_users in 'view\module\operation\admin\sea_users.pas' {SeaUsers},
  reg_job_position in 'view\module\human_resource\register\reg_job_position.pas' {RegJobPosition},
  sea_job_position in 'view\module\human_resource\register\sea_job_position.pas' {SeaJobPosition},
  env in 'env.pas',
  prm_receipt in 'parameter\prm_receipt.pas',
  ControllerCargo in 'controller\ControllerCargo.pas',
  ControllerUsuario in 'controller\ControllerUsuario.pas',
  ControllerCidade in 'controller\ControllerCidade.pas',
  tblCargo in 'model\tblCargo.pas',
  tblcidade in 'model\tblcidade.pas',
  tblusuario in 'model\tblusuario.pas',
  prm_job_position in 'parameter\prm_job_position.pas',
  prm_users in 'parameter\prm_users.pas',
  prm_city in 'parameter\prm_city.pas',
  sea_city in 'view\module\operation\register\sea_city.pas' {SeaCity},
  reg_city in 'view\module\operation\register\reg_city.pas' {RegCity};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDM_ListaConsultas, DM_ListaConsultas);
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(TRegUsers, RegUsers);
  Application.CreateForm(TSeaUsers, SeaUsers);
  Application.CreateForm(TRegJobPosition, RegJobPosition);
  Application.CreateForm(TSeaJobPosition, SeaJobPosition);
  Application.CreateForm(TSeaCity, SeaCity);
  Application.CreateForm(TSeaCity, SeaCity);
  Application.CreateForm(TRegCity, RegCity);
  Application.Run;
end.
