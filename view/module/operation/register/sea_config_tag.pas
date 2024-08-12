unit sea_config_tag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerCfgEtiqueta, base_search;

type
  TSeaConfigTag = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Lb_Descricao: TLabel;
    Lb_Codigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    cds_searchCodigo: TIntegerField;
    cds_searchDescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    cfgEtiqueta : TControllerCfgEtiqueta;
  end;

var
  SeaConfigTag: TSeaConfigTag;

implementation

uses reg_config_tag;

{$R *.dfm}

procedure TSeaConfigTag.CriarVariaveis;
begin
  inherited;
  cfgEtiqueta := TControllerCfgEtiqueta.create(self);
end;

procedure TSeaConfigTag.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cfgEtiqueta);
end;

procedure TSeaConfigTag.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaConfigTag.openRegister(pCodigo: Integer);
var
  Lc_form : TRegConfigTag;
begin
  Lc_form := TRegConfigTag.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaConfigTag.Search;
var
  i: Integer;
begin
  cfgEtiqueta.Clear;

  cfgEtiqueta.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  cfgEtiqueta.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  cfgEtiqueta.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(cfgEtiqueta.Lista.Count) do
    cds_search.AppendRecord([cfgEtiqueta.Lista[i].Codigo, cfgEtiqueta.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaConfigTag.SetRegister;
begin
  openRegister(0);
end;

end.
