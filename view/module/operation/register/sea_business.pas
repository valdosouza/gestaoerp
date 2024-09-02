unit sea_business;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerNegocio;

type
  TSeaBusiness = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_Descricao: TEdit;
    E_Codigo: TEdit;
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
    Negocio : TControllerNegocio;
  end;

var
  SeaBusiness: TSeaBusiness;

implementation

{$R *.dfm}

{ TSeaBusiness }

uses reg_business;

procedure TSeaBusiness.CriarVariaveis;
begin
  inherited;
  Negocio := TControllerNegocio.create(self);
end;

procedure TSeaBusiness.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Negocio);
end;

procedure TSeaBusiness.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaBusiness.openRegister(pCodigo: Integer);
var
  Lc_form : TRegBusiness;
begin
  Lc_form := TRegBusiness.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaBusiness.Search;
var
  i: Integer;
begin
  negocio.Clear;

  if E_Codigo.Text <> EmptyStr then
    negocio.Parametros.FieldName.Codigo := StrToInt(E_Codigo.Text);

  negocio.Parametros.FieldName.Descricao := E_Descricao.Text;

  negocio.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(negocio.Lista.Count) do
    cds_search.AppendRecord([negocio.Lista[I].Codigo, negocio.Lista[I].Descricao]);

  inherited;
end;

procedure TSeaBusiness.SetRegister;
begin
  openRegister(0);
end;

end.
