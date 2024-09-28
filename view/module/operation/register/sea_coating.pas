unit sea_coating;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCoating;

type
  TSeaCoating = class(TBaseSearch)
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    Lb_Codigo: TLabel;
    E_BuscaCodigo: TEdit;
    Lb_Descricao: TLabel;
    E_BuscaDescricao: TEdit;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    coating : TControllerCoating;
  end;

var
  SeaCoating: TSeaCoating;

implementation

uses reg_coating;

{$R *.dfm}

procedure TSeaCoating.CriarVariaveis;
begin
  inherited;
  coating := TControllerCoating.create(self);
end;

procedure TSeaCoating.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(coating);
end;

procedure TSeaCoating.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCoating.openRegister(pCodigo: Integer);
var
  Lc_form : TRegCoating;
begin
  Lc_form := TRegCoating.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCoating.Search;
var
  i: Integer;
begin
  coating.Clear;

  coating.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  coating.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  coating.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(coating.Lista.Count) do
    cds_search.AppendRecord([coating.Lista[i].Codigo, coating.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaCoating.SetRegister;
begin
  openRegister(0);
end;

end.
