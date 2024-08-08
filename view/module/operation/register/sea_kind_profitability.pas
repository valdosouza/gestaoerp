unit sea_kind_profitability;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerKindLucratividade, base_search;

type
  TSeakindprofitability = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Descricao: TLabel;
    L_Codigo: TLabel;
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
  public
    KindLucratividade : TControllerKindLucratividade;
  end;

var
  Seakindprofitability: TSeakindprofitability;

implementation

uses reg_kind_profitability;

{$R *.dfm}

procedure TSeakindprofitability.CriarVariaveis;
begin
  inherited;
  KindLucratividade := TControllerKindLucratividade.create(self);
end;

procedure TSeakindprofitability.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(KindLucratividade);
end;

procedure TSeakindprofitability.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeakindprofitability.openRegister(pCodigo: Integer);
var
  Lc_form : TRegKindProfitability;
begin
  Lc_form := TRegKindProfitability.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeakindprofitability.Search;
var
  i: Integer;
begin
  KindLucratividade.Clear;

  KindLucratividade.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  KindLucratividade.Parametros.FieldName.descricao := E_BuscaDescricao.Text;

  KindLucratividade.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(KindLucratividade.Lista.Count) do
    cds_search.AppendRecord([KindLucratividade.Lista[i].Codigo, KindLucratividade.Lista[i].descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeakindprofitability.SetRegister;
begin
  openRegister(0);
end;

end.
