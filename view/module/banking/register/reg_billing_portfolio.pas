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
    E_Banco: TEdit;
    E_Descricao: TEdit;
    Rg_Emissao: TRadioGroup;
  private

  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ClearAllFields;Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure EditionControl;override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    CarteiraCobranca : TControllerCarteiraCobranca;
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

procedure TRegBillingPortfolio.ClearAllFields;
begin
  inherited;
  CarteiraCobranca.Clear;
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

procedure TRegBillingPortfolio.EditionControl;
begin
  inherited;
  E_Banco.ReadOnly := True;
end;

procedure TRegBillingPortfolio.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(carteiraCobranca);
end;

procedure TRegBillingPortfolio.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    carteiraCobranca.Registro.Codigo := Self.CodigoRegistro;
    carteiraCobranca.getbyId;
  End;
  inherited;
end;

procedure TRegBillingPortfolio.Insert;
Var
  Lc_Banco : String;
begin
  Lc_Banco := E_Banco.Text;
  inherited;
  E_Banco.Text := Lc_Banco;
  E_Descricao.SetFocus;
end;


procedure TRegBillingPortfolio.Save;
begin
  with carteiraCobranca do
  Begin
    Registro.CodigoBanco := CarteiraCobranca.Banco.getCodigoBancoLista(E_Banco.Text);
    Registro.Numero := E_Numero.Text ;
    Registro.Descricao := E_Descricao.Text;
    Registro.TipoEmissao := IfThen(Rg_Emissao.ItemIndex = 0, 'C', 'B');
    salva;
  End;
  CodigoRegistro := carteiraCobranca.Registro.Codigo;
  inherited;
end;

procedure TRegBillingPortfolio.ShowData;
begin
  with carteiraCobranca do
  Begin
    Banco.search;
    E_Banco.Text := Banco.getNumeroNomeLista(Registro.CodigoBanco);
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
  with carteiraCobranca do
  Begin
    Banco.search;
    E_Banco.Text :=  Banco.getNumeroNomeLista(Registro.CodigoBanco);
  End;
  E_Descricao.clear;
end;

function TRegBillingPortfolio.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegBillingPortfolio.ValidateSave: boolean;
begin
  Result := True;

  if E_Banco.Text = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Banco.Caption);
    Result := False;
    E_Banco.SetFocus;
    Exit;
  end;

  if (Trim(E_Numero.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Numero.Caption);
    Result := False;
    E_Numero.SetFocus;
    Exit;
  end;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
