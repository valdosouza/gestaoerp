unit sea_users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  ControllerUsuario, base_search;

type
  TSeaUsers = class(TBaseSearch)
    Gbx_Parametros: TGroupBox;
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
  protected
    procedure openRegister(pCodigo: Integer);Override;
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

uses reg_users;

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

  users.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
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
