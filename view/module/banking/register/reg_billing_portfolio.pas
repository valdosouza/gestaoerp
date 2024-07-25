unit reg_billing_portfolio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, System.StrUtils,
  base_registry, ControllerCarteiraCobranca;

type
  TRegBillingPortfolio = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    L_Numero: TLabel;
    L_Banco: TLabel;
    L_Descricao: TLabel;
    E_Numero: TEdit;
    CB_Banco: TComboBox;
    E_Descricao: TEdit;
    Rg_Emissao: TRadioGroup;
  private
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
    carteiraCobranca : TControllerCarteiraCobranca;
  end;

var
  RegBillingPortfolio: TRegBillingPortfolio;

implementation

uses UN_MSG;

{$R *.dfm}

{ TRegBillingPortfolio }

procedure TRegBillingPortfolio.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegBillingPortfolio.CriarVariaveis;
begin
  inherited;
  carteiraCobranca := TControllerCarteiraCobranca.create(self);
end;

procedure TRegBillingPortfolio.Delete;
begin
  carteiraCobranca.delete;
  inherited;
end;

procedure TRegBillingPortfolio.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(carteiraCobranca);
end;

procedure TRegBillingPortfolio.IniciaVariaveis;
begin
  MontaComboBoxBanco;
  if Self.CodigoRegistro > 0 then
  Begin
    carteiraCobranca.Registro.Codigo := Self.CodigoRegistro;
    carteiraCobranca.getbyId;
  End;
  inherited;
end;

procedure TRegBillingPortfolio.Insert;
begin
  inherited;
  CB_Banco.ItemIndex := -1;
  E_Descricao.SetFocus;
end;

procedure TRegBillingPortfolio.MontaComboBoxBanco;
Var
  I : Integer;
begin
  with carteiraCobranca do
  Begin
    Banco.search;
    CB_Banco.Items.Clear;
    for I := 0 to Banco.lista.Count-1 do
    Begin
      CB_Banco.Items.Add(Banco.lista[I].NumeroNome);
    End;
  End;
end;

procedure TRegBillingPortfolio.Save;
begin
  with carteiraCobranca do
  Begin
    Registro.CodigoBanco := carteiraCobranca.Banco.getCodigoBancoLista(CB_Banco.Text);     //ajustarrrrrrrrrrrrrrrrrrr
    Registro.Numero := E_Numero.Text ;
    Registro.Descricao := E_Descricao.Text;
    Registro.TipoEmissao := IfThen(Rg_Emissao.ItemIndex = 0, 'C', 'B');
    salva;
  End;
  CodigoRegistro := carteiraCobranca.Registro.Codigo;
  inherited;
end;

procedure TRegBillingPortfolio.ShowData;
Var
  Lc_Aux : String;
begin
  with carteiraCobranca do
  Begin
    Lc_Aux := carteiraCobranca.Banco.getNumeroNomeLista(Registro.CodigoBanco);
    CB_Banco.ItemIndex := CB_Banco.Items.IndexOf(Lc_Aux);
    E_Numero.Text := Registro.Numero;
    E_Descricao.Text  := Registro.Descricao;
    if Registro.TipoEmissao = 'C' then
      Rg_Emissao.ItemIndex := 0
    else
      Rg_Emissao.ItemIndex := 1;
  End;
  inherited;
end;

procedure TRegBillingPortfolio.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegBillingPortfolio.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemExcluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegBillingPortfolio.ValidateSave: boolean;
begin
  Result := True;

  if CB_Banco.Text = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Banco.Caption);
    Result := False;
    CB_Banco.SetFocus;
    Exit;
  end;

  if (Trim(E_Numero.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Numero.Caption);
    Result := False;
    E_Numero.SetFocus;
    Exit;
  end;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
