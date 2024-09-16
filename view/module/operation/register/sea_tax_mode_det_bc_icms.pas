unit sea_tax_mode_det_bc_icms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerTaxModeDetBcIcms;

type
  TSeaTaxModeDetBcIcms = class(TBaseSearch)
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
    TaxModeDetBcIcms : TControllerTaxModeDetBcIcms;
  end;

var
  SeaTaxModeDetBcIcms: TSeaTaxModeDetBcIcms;

implementation

uses reg_tax_mode_det_bc_icms;

{$R *.dfm}

procedure TSeaTaxModeDetBcIcms.CriarVariaveis;
begin
  inherited;
  TaxModeDetBcIcms := TControllerTaxModeDetBcIcms.create(self);
end;

procedure TSeaTaxModeDetBcIcms.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxModeDetBcIcms);
end;

procedure TSeaTaxModeDetBcIcms.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxModeDetBcIcms.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxModeDetBcIcms;
begin
  Lc_form := TRegTaxModeDetBcIcms.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxModeDetBcIcms.Search;
var
  i: Integer;
begin
  TaxModeDetBcIcms.Clear;

  TaxModeDetBcIcms.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  TaxModeDetBcIcms.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  TaxModeDetBcIcms.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(TaxModeDetBcIcms.Lista.Count) do
    cds_search.AppendRecord([TaxModeDetBcIcms.Lista[i].Codigo, TaxModeDetBcIcms.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxModeDetBcIcms.SetRegister;
begin
  openRegister(0);
end;

end.
