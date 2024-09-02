unit sea_profile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerPerfilUsuario, base_search;

type
  TSeaProfile = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
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
  private
    perfilUsuario : TControllerPerfilUsuario;
  end;

var
  SeaProfile: TSeaProfile;

implementation

uses reg_profile;

{$R *.dfm}

{ TSeaPackage }

procedure TSeaProfile.CriarVariaveis;
begin
  inherited;
  perfilUsuario := TControllerPerfilUsuario.create(self);
end;

procedure TSeaProfile.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(perfilUsuario);
end;

procedure TSeaProfile.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaProfile.openRegister(pCodigo: Integer);
var
  Lc_form : TRegProfile;
begin
  Lc_form := TRegProfile.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaProfile.Search;
var
  i: Integer;
begin
  perfilUsuario.Clear;

  perfilUsuario.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  perfilUsuario.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  perfilUsuario.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(perfilUsuario.Lista.Count) do
    cds_search.AppendRecord([perfilUsuario.Lista[i].Codigo, perfilUsuario.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaProfile.SetRegister;
begin
  openRegister(0);
end;

end.
