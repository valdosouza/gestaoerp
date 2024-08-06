unit sea_package;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerEmbalagem, base_search;

type
  TSeaPackage = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_Descricao: TLabel;
    Lb_Codigo: TLabel;
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
    embalagem : TControllerEmbalagem;
  end;

var
  SeaPackage: TSeaPackage;

implementation

uses reg_package;

{$R *.dfm}

{ TSeaPackage }

procedure TSeaPackage.CriarVariaveis;
begin
  inherited;
  embalagem := TControllerEmbalagem.create(self);
end;

procedure TSeaPackage.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(embalagem);
end;

procedure TSeaPackage.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaPackage.openRegister(pCodigo: Integer);
var
  Lc_form : TRegPackage;
begin
  Lc_form := TRegPackage.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaPackage.Search;
var
  i: Integer;
begin
  embalagem.Clear;

  embalagem.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  embalagem.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  embalagem.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(embalagem.Lista.Count) do
    cds_search.AppendRecord([embalagem.Lista[I].Codigo, embalagem.Lista[I].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaPackage.SetRegister;
begin
  openRegister(0);
end;

end.
