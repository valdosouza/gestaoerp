unit sea_banking_account;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerContaBancaria;

type
  TSeaBankingAccount = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_BuscaAgencia: TLabel;
    Lb_BuscaConta: TLabel;
    Lb_BuscaBanco: TLabel;
    E_BuscaAgencia: TEdit;
    E_BuscaConta: TEdit;
    E_BuscaBanco: TEdit;
    cds_searchagencia: TStringField;
    cds_searchconta: TStringField;
    cds_searchnumerobanco: TStringField;
    cds_searchcodigo: TIntegerField;
  private
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    { Public declarations }
    contaBancaria : TControllerContaBancaria;
  end;

var
  SeaBankingAccount: TSeaBankingAccount;

implementation

uses reg_banking_account;

{$R *.dfm}

procedure TSeaBankingAccount.CriarVariaveis;
begin
  inherited;
  contaBancaria := TControllerContaBancaria.create(self);
end;

procedure TSeaBankingAccount.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(contaBancaria);
end;

procedure TSeaBankingAccount.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaBankingAccount.openRegister(pCodigo: Integer);
var
  Lc_form : TRegBankingAccount;
begin
  Lc_form := TRegBankingAccount.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaBankingAccount.Search;
var
  i: Integer;
begin
  contaBancaria.Clear;

  contaBancaria.Parametros.FieldName.Agencia := E_BuscaAgencia.Text;
  contaBancaria.Parametros.FieldName.Conta := E_BuscaConta.Text;
  contaBancaria.Parametros.FieldName.NomeBanco := E_BuscaBanco.Text;

  contaBancaria.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(contaBancaria.Lista.Count) do
    cds_search.AppendRecord([contaBancaria.Lista[I].Codigo, contaBancaria.Lista[I].Agencia, contaBancaria.Lista[I].Conta, contaBancaria.Lista[I].NomeBanco]);

  inherited;
end;

procedure TSeaBankingAccount.SetRegister;
begin
  openRegister(0);
end;

end.
