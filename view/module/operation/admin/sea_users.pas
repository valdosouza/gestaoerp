unit sea_users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerUsuario, reg_users;

type
  TSeaUsers = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    E_BuscaCodigo: TEdit;
    E_BuscaNome: TEdit;
    Label22: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBGrid1: TDBGrid;
    ChBx_Inativos: TCheckBox;
    cds_searchcodigo: TIntegerField;
    cds_searchnome: TStringField;
  private
    procedure openRegister(pCodigo: Integer);
  protected
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    { Public declarations }
    users : TControllerUsuario;
  end;

var
  SeaUsers: TSeaUsers;

implementation

{$R *.dfm}

procedure TSeaUsers.CriarVariaveis;
begin
  inherited;
  users := TControllerUsuario.create(self);
end;

procedure TSeaUsers.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(users);
end;

procedure TSeaUsers.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaUsers.openRegister(pCodigo: Integer);
var
  Lc_form : TRegUsers;
begin
  Lc_form := TRegUsers.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaUsers.Search;
var
  i: Integer;
begin
  users.Clear;

  if E_BuscaCodigo.Text <> EmptyStr then
    users.Parametros.FieldName.Codigo := StrToInt(E_BuscaCodigo.Text);

  if e_BuscaNome.Text <> EmptyStr then
    users.Parametros.FieldName.Nome := e_BuscaNome.Text;

  users.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(users.Lista.Count) do
    cds_search.AppendRecord([users.Lista[I].Codigo, users.Lista[I].Nome]);

  inherited;
end;

procedure TSeaUsers.SetRegister;
begin
  openRegister(0);
end;

end.
