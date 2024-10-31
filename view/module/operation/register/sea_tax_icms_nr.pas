unit sea_tax_icms_nr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerTaxIcmsNr;

type
  TSeaTaxIcmsNr = class(TBaseSearch)
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
    TaxIcmsNr : TControllerTaxIcmsNr;
  end;

var
  SeaTaxIcmsNr: TSeaTaxIcmsNr;

implementation

uses reg_tax_icms_nr;

{$R *.dfm}

{ TSeaTaxIcmsNr }

procedure TSeaTaxIcmsNr.CriarVariaveis;
begin
  inherited;
  TaxIcmsNr := TControllerTaxIcmsNr.create(self);
end;

procedure TSeaTaxIcmsNr.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxIcmsNr);
end;

procedure TSeaTaxIcmsNr.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxIcmsNr.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxIcmsNr;
begin
  Lc_form := TRegTaxIcmsNr.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxIcmsNr.Search;
var
  i: Integer;
begin
  TaxIcmsNr.Clear;

  TaxIcmsNr.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  TaxIcmsNr.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  TaxIcmsNr.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(TaxIcmsNr.Lista.Count) do
    cds_search.AppendRecord([TaxIcmsNr.Lista[i].Codigo, TaxIcmsNr.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxIcmsNr.SetRegister;
begin
  openRegister(0);
end;

end.
