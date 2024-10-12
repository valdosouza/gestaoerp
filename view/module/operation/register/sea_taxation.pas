unit sea_taxation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerTributacao, System.StrUtils;

type
  TSeaTaxation = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Busca_NCM: TLabel;
    CHBX_BUSCA_CONSUMIDOR: TCheckBox;
    E_Busca_NCM: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchNAT_CFOP: TStringField;
    cds_searchUFE_SIGLA: TStringField;
    cds_searchTRB_CONSUMIDOR: TStringField;
    cds_searchTRB_MICRO: TStringField;
    cds_searchTRB_CST: TStringField;
    cds_searchTRB_ST_CIMS: TStringField;
    cds_searchOBS_DESCRICAO: TStringField;
    cds_searchTRB_CODIGONCM: TStringField;
    cds_searchTRB_RD_AQ_ICMS: TFloatField;
    cds_searchTRB_RD_BS_ICMS: TFloatField;
    cds_searchTRB_AQ_ICMS: TFloatField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    taxation : TControllerTributacao;
  end;

var
  SeaTaxation: TSeaTaxation;

implementation

uses reg_taxation, env;

{$R *.dfm}

procedure TSeaTaxation.CriarVariaveis;
begin
  inherited;
  taxation := TControllerTributacao.create(self);
end;

procedure TSeaTaxation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxation);
end;

procedure TSeaTaxation.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxation.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxation;
begin
  Lc_form := TRegTaxation.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxation.Search;
var
  i: Integer;
begin
  taxation.Clear;

  taxation.Parametros.FieldName.Estabelecimento := Gb_CodMha;
  taxation.Parametros.FieldName.NCM := E_Busca_NCM.Text;
  taxation.Parametros.FieldName.Consumidor :=  IfThen(CHBX_BUSCA_CONSUMIDOR.Checked, SIGLA_S, SIGLA_N);

  taxation.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(taxation.Lista.Count) do
    cds_search.AppendRecord([taxation.Lista[i].Codigo, taxation.Lista[i].NAT_CFOP, taxation.Lista[i].UFE_SIGLA,
                             taxation.Lista[i].Consumidor, taxation.Lista[i].MicroEmpresa, taxation.Lista[i].TRB_CST,
                             taxation.Lista[i].TemST, taxation.Lista[i].AliqICMS, taxation.Lista[i].RedBCICMS,
                             taxation.Lista[i].RedAliqICMS, taxation.Lista[i].OBS_DESCRICAO, taxation.Lista[i].NCM]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxation.SetRegister;
begin
  openRegister(0);
end;

end.
