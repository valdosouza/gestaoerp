unit sea_tax_relieves_icms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerTaxRelievesIcms;

type
  TSeaTaxRelievesIcms = class(TBaseSearch)
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
    TaxRelievesIcms : TControllerTaxRelievesIcms;
  end;

var
  SeaTaxRelievesIcms: TSeaTaxRelievesIcms;

implementation

uses reg_tax_relieves_icms;

{$R *.dfm}

procedure TSeaTaxRelievesIcms.CriarVariaveis;
begin
  inherited;
  TaxRelievesIcms := TControllerTaxRelievesIcms.create(self);
end;

procedure TSeaTaxRelievesIcms.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxRelievesIcms);
end;

procedure TSeaTaxRelievesIcms.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxRelievesIcms.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxRelievesIcms;
begin
  Lc_form := TRegTaxRelievesIcms.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxRelievesIcms.Search;
var
  i: Integer;
begin
  TaxRelievesIcms.Clear;

  TaxRelievesIcms.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  TaxRelievesIcms.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  TaxRelievesIcms.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(TaxRelievesIcms.Lista.Count) do
    cds_search.AppendRecord([TaxRelievesIcms.Lista[i].Codigo, TaxRelievesIcms.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxRelievesIcms.SetRegister;
begin
  openRegister(0);
end;

end.
