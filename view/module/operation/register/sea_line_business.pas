unit sea_line_business;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerLineBusiness;

type
  TSeaLineBusiness = class(TBaseSearch)
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    GroupBox1: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    LineBusiness : TControllerLineBusiness;
  end;

var
  SeaLineBusiness: TSeaLineBusiness;

implementation

uses reg_line_business;

{$R *.dfm}

{ TSeaLineBusiness }

procedure TSeaLineBusiness.CriarVariaveis;
begin
  inherited;
  LineBusiness := TControllerLineBusiness.create(self);
end;

procedure TSeaLineBusiness.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(LineBusiness);
end;

procedure TSeaLineBusiness.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaLineBusiness.openRegister(pCodigo: Integer);
var
  Lc_form : TRegLineBusiness;
begin
  Lc_form := TRegLineBusiness.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaLineBusiness.Search;
var
  i: Integer;
begin
  LineBusiness.Clear;

  LineBusiness.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  LineBusiness.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  LineBusiness.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(LineBusiness.Lista.Count) do
    cds_search.AppendRecord([LineBusiness.Lista[i].Codigo, LineBusiness.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaLineBusiness.SetRegister;
begin
  openRegister(0);
end;

end.
