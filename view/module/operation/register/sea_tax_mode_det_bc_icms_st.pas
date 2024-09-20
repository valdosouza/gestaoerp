unit sea_tax_mode_det_bc_icms_st;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerTaxModeDetBcIcmsSt;

type
  TSeaTaxModeDetBcIcmsSt = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    TaxModeDetBcIcmsSt : TControllerTaxModeDetBcIcmsSt;
  end;

var
  SeaTaxModeDetBcIcmsSt: TSeaTaxModeDetBcIcmsSt;

implementation

uses reg_tax_mode_det_bc_icms_st;

{$R *.dfm}

procedure TSeaTaxModeDetBcIcmsSt.CriarVariaveis;
begin
  inherited;
  TaxModeDetBcIcmsSt := TControllerTaxModeDetBcIcmsSt.create(self);
end;

procedure TSeaTaxModeDetBcIcmsSt.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxModeDetBcIcmsSt);
end;

procedure TSeaTaxModeDetBcIcmsSt.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxModeDetBcIcmsSt.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxModeDetBcIcmsSt;
begin
  Lc_form := TRegTaxModeDetBcIcmsSt.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxModeDetBcIcmsSt.Search;
var
  i: Integer;
begin
  TaxModeDetBcIcmsSt.Clear;

  TaxModeDetBcIcmsSt.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  TaxModeDetBcIcmsSt.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  TaxModeDetBcIcmsSt.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(TaxModeDetBcIcmsSt.Lista.Count) do
    cds_search.AppendRecord([TaxModeDetBcIcmsSt.Lista[i].Codigo, TaxModeDetBcIcmsSt.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxModeDetBcIcmsSt.SetRegister;
begin
  openRegister(0);
end;

end.
