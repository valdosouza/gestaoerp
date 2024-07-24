unit sea_city;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  ControllerCidade, base_search;

type
  TSeaCity = class(TBaseSearch)
    Gbx_Parametros: TGroupBox;
    L_IBGE: TLabel;
    L_Descricao: TLabel;
    E_IBGE: TEdit;
    E_Descricao: TEdit;
    cds_searchCodigo: TIntegerField;
    cds_searchDescricao: TStringField;
    cds_searchUF: TStringField;
    CB_UF: TComboBox;
    L_UF: TLabel;
    cds_searchIBGE: TIntegerField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    cidade : TControllerCidade;
  end;

var
  SeaCity: TSeaCity;

implementation

uses reg_city;

{$R *.dfm}

{ TSeaCity }

procedure TSeaCity.CriarVariaveis;
begin
  inherited;
  cidade := TControllerCidade.create(self);
end;

procedure TSeaCity.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cidade);
end;

procedure TSeaCity.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCity.openRegister(pCodigo: Integer);
var
  Lc_form : TRegCity;
begin
  Lc_form := TRegCity.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCity.Search;
var
  i: Integer;
begin
  cidade.Clear;

  cidade.Parametros.FieldName.IBGE := StrToIntDef(E_IBGE.Text, 0);
  cidade.Parametros.FieldName.Descricao := E_Descricao.Text;
  cidade.Parametros.FieldName.Estado := CB_UF.Text;

  cidade.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(cidade.Lista.Count) do
    cds_search.AppendRecord([cidade.Lista[I].Codigo, cidade.Lista[I].Descricao, cidade.Lista[I].IBGE, cidade.Lista[I].Estado]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaCity.SetRegister;
begin
  openRegister(0);
end;

end.
