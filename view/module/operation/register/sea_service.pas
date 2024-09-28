unit sea_service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerService;

type
  TSeaService = class(TBaseSearch)
    GroupBox1: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    ChBx_Inativos: TCheckBox;
    cds_searchcodigo: TIntegerField;
    cds_searchPRC_VL_VDA: TCurrencyField;
    cds_searchdescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    service : TControllerService;
  end;

var
  SeaService: TSeaService;

implementation

uses reg_service, Env;

{$R *.dfm}

procedure TSeaservice.CriarVariaveis;
begin
  inherited;
  service := TControllerservice.create(self);
end;

procedure TSeaservice.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(service);
end;

procedure TSeaservice.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaservice.openRegister(pCodigo: Integer);
var
  Lc_form : TRegservice;
begin
  Lc_form := TRegservice.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaservice.Search;
var
  i: Integer;
begin
  service.Clear;

  service.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  service.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  if ChBx_Inativos.Checked then
    service.Parametros.FieldName.Ativo := SIGLA_N
  else
    service.Parametros.FieldName.Ativo := SIGLA_S;

  service.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(service.Lista.Count) do
    cds_search.AppendRecord([service.Lista[i].Codigo, service.Lista[i].Descricao, service.Lista[i].PrecoVenda]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaservice.SetRegister;
begin
  openRegister(0);
end;

end.
