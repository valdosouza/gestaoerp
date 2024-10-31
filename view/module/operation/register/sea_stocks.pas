unit sea_stocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerEstoques;

type
  TSeaStocks = class(TBaseSearch)
    L_BuscaDescricao: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    L_BuscaCodigo: TLabel;
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
    stocks : TControllerEstoques;
  end;

var
  SeaStocks: TSeaStocks;

implementation

uses reg_stocks, env;

{$R *.dfm}

procedure TSeaStocks.CriarVariaveis;
begin
  inherited;
  stocks := TControllerEstoques.create(self);
end;

procedure TSeaStocks.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(stocks);
end;

procedure TSeaStocks.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaStocks.openRegister(pCodigo: Integer);
var
  Lc_form : TRegStocks;
begin
  Lc_form := TRegStocks.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaStocks.Search;
var
  i: Integer;
begin
  stocks.Clear;

  stocks.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  stocks.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;
  stocks.Parametros.FieldName.Estabelecimento := Gb_CodMha;

  stocks.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(stocks.Lista.Count) do
    cds_search.AppendRecord([stocks.Lista[i].Codigo, stocks.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaStocks.SetRegister;
begin
  openRegister(0);
end;

end.
