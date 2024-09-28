unit sea_measure;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerMedida;

type
  TSeaMeasure = class(TBaseSearch)
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
  public
    medida : TControllerMedida;

    procedure SearchMeasure;
  end;

var
  SeaMeasure: TSeaMeasure;

implementation

uses reg_measure;

{$R *.dfm}

procedure TSeaMeasure.CriarVariaveis;
begin
  inherited;
  medida := TControllerMedida.create(self);
end;

procedure TSeaMeasure.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(medida);
end;

procedure TSeaMeasure.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaMeasure.openRegister(pCodigo: Integer);
var
  Lc_form : TRegMeasure;
begin
  Lc_form := TRegMeasure.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaMeasure.Search;
begin
  SearchMeasure;

  inherited;
end;

procedure TSeaMeasure.SearchMeasure;
var
  i: Integer;
begin
  medida.Clear;

  medida.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  medida.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  medida.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(medida.Lista.Count) do
    cds_search.AppendRecord([medida.Lista[i].Codigo, medida.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;


procedure TSeaMeasure.SetRegister;
begin
  openRegister(0);
end;

end.
