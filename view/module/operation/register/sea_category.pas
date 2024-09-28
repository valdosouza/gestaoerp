unit sea_category;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCategory;

type
  TSeaCategory = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_Descricao: TLabel;
    Lb_BuscaCodigo: TLabel;
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
    category : TControllerCategory;
  end;

var
  SeaCategory: TSeaCategory;

implementation

uses reg_category;

{$R *.dfm}

{ TSeaCategory }

procedure TSeaCategory.CriarVariaveis;
begin
  inherited;
  category := TControllercategory.create(self);
end;

procedure TSeaCategory.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(category);
end;

procedure TSeaCategory.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCategory.openRegister(pCodigo: Integer);
var
  Lc_form : TRegCategory;
begin
  Lc_form := TRegCategory.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
    Search;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCategory.Search;
var
  i: Integer;
begin
  category.Clear;

  category.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  category.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  category.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(category.Lista.Count) do
    cds_search.AppendRecord([category.Lista[i].Codigo, category.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaCategory.SetRegister;
begin
  openRegister(0);
end;

end.
