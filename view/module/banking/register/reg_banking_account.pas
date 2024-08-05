unit reg_banking_account;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerContaBancaria, Vcl.ComCtrls;

type
  TRegBankingAccount = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    Lb_DtAbert: TLabel;
    Lb_Banco: TLabel;
    Lb_Agencia: TLabel;
    Lb_Conta: TLabel;
    Lb_Fone: TLabel;
    Lb_Fax: TLabel;
    Lb_Gerente: TLabel;
    Lb_Limite: TLabel;
    Lb_DataVencto: TLabel;
    Lb_Empresa: TLabel;
    Lb_AgenciaDv: TLabel;
    Lb_ContaDv: TLabel;
    E_Codigo: TEdit;
    E_agencia: TEdit;
    E_conta: TEdit;
    E_fone: TEdit;
    E_Fax: TEdit;
    E_Gerente: TEdit;
    E_Limite: TEdit;
    CB_Banco: TComboBox;
    CB_Empresa: TComboBox;
    E_AgenciaDv: TEdit;
    E_ContaDv: TEdit;
    E_DtAbert: TEdit;
    E_DtVencto: TEdit;
  private
    procedure MontaComboBoxEmpresa;
    procedure MontaComboBoxBanco;
  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    contaBancaria : TControllerContaBancaria;
  end;

var
  RegBankingAccount: TRegBankingAccount;

implementation

uses UN_MSG, biblioteca;

{$R *.dfm}

procedure TRegBankingAccount.Change;
begin
  inherited;
  CB_Empresa.SetFocus;
end;

procedure TRegBankingAccount.CriarVariaveis;
begin
  inherited;
  contaBancaria := TControllerContaBancaria.create(self);
end;

procedure TRegBankingAccount.Delete;
begin
  contaBancaria.delete;
  inherited;
end;

procedure TRegBankingAccount.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(contaBancaria);
end;

procedure TRegBankingAccount.IniciaVariaveis;
begin
  MontaComboBoxEmpresa;
  MontaComboBoxBanco;
  if Self.CodigoRegistro > 0 then
  Begin
    contaBancaria.Registro.Codigo := Self.CodigoRegistro;
    contaBancaria.getbyId;
  End;
  inherited;
end;

procedure TRegBankingAccount.Insert;
begin
  inherited;
  CB_Empresa.SetFocus;
end;

procedure TRegBankingAccount.Save;
begin
  with contaBancaria do
  Begin
    Registro.Empresa := Empresa.getCodigoEmpresaLista(CB_Empresa.Text);

    if E_DtAbert.Text <> EmptyStr then
      Registro.DataAbertura := StrToDate(E_DtAbert.Text);

    Registro.CodigoBanco := Banco.getCodigoBancoLista(CB_Banco.Text);

    Registro.Agencia := E_agencia.Text;
    Registro.DigitoAgencia := E_AgenciaDv.Text;
    Registro.Conta := E_conta.Text;
    Registro.DigitoContaCorrente := E_ContaDv.Text;

    Registro.Fone := E_fone.Text;

    Registro.Fax := E_Fax.Text;

    Registro.Gerente := E_Gerente.Text;

    Registro.ValorLimite := StrToFloatDef(E_Limite.Text, 0);

    if E_DtVencto.Text <> EmptyStr then
      Registro.DataVencto := StrToDate(E_DtVencto.Text);
    salva;
  End;
  CodigoRegistro := contaBancaria.Registro.Codigo;
  inherited;
end;

procedure TRegBankingAccount.ShowData;
Var
  Lc_Aux : String;
begin
  with contaBancaria do
  Begin
    Lc_Aux := Empresa.getNumeroNomeLista(Registro.Empresa);
    CB_Empresa.ItemIndex := CB_Empresa.Items.IndexOf(Lc_Aux);

    if Registro.DataAbertura <> 0 then
      E_DtAbert.Text := DateTimeToStr(Registro.DataAbertura);

    Lc_Aux := Banco.getNumeroNomeLista(Registro.CodigoBanco);
    CB_Banco.ItemIndex := CB_Banco.Items.IndexOf(Lc_Aux);

    E_agencia.Text := Registro.Agencia;
    E_AgenciaDv.Text := Registro.DigitoAgencia;
    E_conta.Text := Registro.Conta;
    E_ContaDv.Text := Registro.DigitoContaCorrente;

    E_fone.Text := Registro.Fone;
    E_Fax.Text := Registro.Fax;
    E_Gerente.Text := Registro.Gerente;

    E_Limite.Text := FloatToStrF(Registro.ValorLimite, ffFixed, 10, 2);

    if Registro.DataVencto <> 0 then
      E_DtVencto.Text := DateTimeToStr(Registro.DataVencto)
  End;
  inherited;
end;

procedure TRegBankingAccount.ShowNoData;
begin
  E_Codigo.clear;
  //E_Descricao.clear;
end;

function TRegBankingAccount.ValidateDelete: boolean;
begin
  Result := True;
  if (TMsgSetes.Excluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegBankingAccount.ValidateSave: boolean;
begin
  Result := True;

  if (Trim(CB_Empresa.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Empresa.Caption);
    Result := False;
    CB_Empresa.SetFocus;
    Exit;
  end;

  if E_DtAbert.Text <> EmptyStr then
  begin
    if not TValidar.Data(E_DtAbert.Text) then
    begin
      TMsgSetes.ErroCampo(Lb_DtAbert.Caption, MSG_DATA_INVALIDA);
      Result := False;
      E_DtAbert.SetFocus;
      Exit;
    end;
  end;

  if (Trim(CB_Banco.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(LB_Banco.Caption);
    Result := False;
    CB_Banco.SetFocus;
    Exit;
  end;

  if (Trim(E_agencia.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(LB_agencia.Caption);
    Result := False;
    E_agencia.SetFocus;
    Exit;
  end;

  if (Trim(E_conta.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(LB_conta.Caption);
    Result := False;
    E_conta.SetFocus;
    Exit;
  end;

  if E_DtVencto.Text <> EmptyStr then
  begin
    if not TValidar.Data(E_DtVencto.Text) then
    begin
      TMsgSetes.ErroCampo(Lb_DataVencto.Caption, MSG_DATA_INVALIDA);
      Result := False;
      E_DtVencto.SetFocus;
      Exit;
    end;
  end;
end;

procedure TRegBankingAccount.MontaComboBoxEmpresa;
Var
  i : Integer;
begin
  with contaBancaria do
  Begin
    Empresa.search;
    CB_Empresa.Items.Clear;
    for i := 0 to Pred(Empresa.lista.Count) do
      CB_Empresa.Items.Add(Empresa.lista[i].NumeroNome);
  End;
end;

procedure TRegBankingAccount.MontaComboBoxBanco;
Var
  i : Integer;
begin
  with contaBancaria do
  Begin
    Banco.search;
    CB_Banco.Items.Clear;
    for i := 0 to Pred(Banco.lista.Count) do
      CB_Banco.Items.Add(Banco.lista[i].NumeroNome);
  End;
end;

end.
