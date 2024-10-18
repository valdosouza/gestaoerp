unit sea_tax_icms_sn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, controllertaxicmssn, Vcl.ExtCtrls;

type
  TSeaTaxIcmsSn = class(TBaseSearch)
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
    taxicmssn : Tcontrollertaxicmssn;
  end;

var
  SeaTaxIcmsSn: TSeaTaxIcmsSn;

implementation

uses reg_tax_icms_sn;

{$R *.dfm}

{ TSeaTaxIcmsSn }

procedure TSeaTaxIcmsSn.CriarVariaveis;
begin
  inherited;
  taxicmssn := TControllertaxicmssn.create(self);
end;

procedure TSeaTaxIcmsSn.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxicmssn);
end;

procedure TSeaTaxIcmsSn.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaTaxIcmsSn.openRegister(pCodigo: Integer);
var
  Lc_form : TRegTaxIcmsSn;
begin
  Lc_form := TRegTaxIcmsSn.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaTaxIcmsSn.Search;
var
  i: Integer;
begin
  taxicmssn.Clear;

  taxicmssn.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  taxicmssn.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  taxicmssn.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(taxicmssn.Lista.Count) do
    cds_search.AppendRecord([taxicmssn.Lista[i].Codigo, taxicmssn.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaTaxIcmsSn.SetRegister;
begin
  openRegister(0);
end;

end.
