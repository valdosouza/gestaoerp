unit sea_product_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerMarcaProduto;

type
  TSeaProductBrand = class(TBaseSearch)
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
    marcaProduto : TControllerMarcaProduto;
  end;

var
  SeaProductBrand: TSeaProductBrand;

implementation

uses reg_product_brand;

{$R *.dfm}

{ TSeaPackage }

procedure TSeaProductBrand.CriarVariaveis;
begin
  inherited;
  marcaProduto := TControllerMarcaProduto.create(self);
end;

procedure TSeaProductBrand.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(marcaProduto);
end;

procedure TSeaProductBrand.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaProductBrand.openRegister(pCodigo: Integer);
var
  Lc_form : TRegProductBrand;
begin
  Lc_form := TRegProductBrand.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaProductBrand.Search;
var
  i: Integer;
begin
  marcaProduto.Clear;

  marcaProduto.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  marcaProduto.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  marcaProduto.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(marcaProduto.Lista.Count) do
    cds_search.AppendRecord([marcaProduto.Lista[i].Codigo, marcaProduto.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaProductBrand.SetRegister;
begin
  openRegister(0);
end;

end.
