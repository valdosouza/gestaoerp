unit reg_electronic_card;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, System.StrUtils,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, ControllerCartaoEletronico;

type
  TRegElectronicCard = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    E_Codigo: TEdit;
    grbx_vista: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    E_Aliq_Cred: TEdit;
    E_Prz_Cred: TEdit;
    grbx_parcela: TGroupBox;
    Label9: TLabel;
    Label5: TLabel;
    E_Aliq_Debi: TEdit;
    E_Prz_DEbi: TEdit;
    E_Contato: TEdit;
    E_Fone: TEdit;
    E_Validade: TEdit;
    dbrg_tipo: TRadioGroup;
    E_Descricao: TEdit;
    L_Descricao: TLabel;
  protected
    procedure ClearAllFields; Override;
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
  private
    EletronicCard : TControllerCartaoEletronico;
  end;

var
  RegElectronicCard: TRegElectronicCard;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegElectronicCard.Change;
begin
  inherited;
  dbrg_tipo.SetFocus;
end;

procedure TRegElectronicCard.ClearAllFields;
begin
  inherited;
  //
end;

procedure TRegElectronicCard.CriarVariaveis;
begin
  inherited;
  EletronicCard := TControllerCartaoEletronico.create(self);
end;

procedure TRegElectronicCard.Delete;
begin
  EletronicCard.delete;
  inherited;
end;

procedure TRegElectronicCard.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(EletronicCard);
end;

procedure TRegElectronicCard.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    EletronicCard.Registro.Codigo := Self.CodigoRegistro;
    EletronicCard.getbyId;
  End;
  inherited;
end;

procedure TRegElectronicCard.Insert;
begin
  inherited;
  dbrg_tipo.SetFocus;
end;

procedure TRegElectronicCard.Save;
begin
  with EletronicCard do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Tipo := ifthen(dbrg_tipo.ItemIndex = 0, 'C', 'D');
    Registro.AliqCredito := StrToFloatDef(E_Aliq_Cred.Text, 0);
    Registro.PrazoCredito := StrToIntDef(E_Prz_Cred.Text, 0);
    Registro.AliqDebito := StrToFloatDef(E_Aliq_Debi.Text, 0);
    Registro.PrazoDebito := StrToIntDef(E_Prz_DEbi.Text, 0);
    Registro.Contato := E_Contato.Text;
    Registro.Fone := E_Fone.Text;
    if E_Validade.Text <> EmptyStr then
      registro.Validade := StrToDate(E_Validade.Text);
    salva;
  End;
  CodigoRegistro := EletronicCard.Registro.Codigo;
  inherited;
end;

procedure TRegElectronicCard.ShowData;
begin
  with EletronicCard do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    if Registro.Tipo = 'C' then
      dbrg_tipo.ItemIndex := 0
    else
      dbrg_tipo.ItemIndex := 1;
    E_Aliq_Cred.Text := FloatToStrF(Registro.AliqCredito, ffFixed, 10, 2);
    E_Prz_Cred.Text := IntToStr(Registro.PrazoCredito);
    E_Aliq_Debi.Text := FloatToStrF(Registro.AliqDebito, ffFixed, 10, 2);
    E_Prz_DEbi.Text := IntToStr(Registro.PrazoDebito);
    E_Contato.Text := Registro.Contato;
    E_Fone.Text := Registro.Fone;
    E_Validade.Text := DateToStr(registro.Validade);
  End;
  inherited;
end;

procedure TRegElectronicCard.ShowNoData;
begin
  //
end;

function TRegElectronicCard.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegElectronicCard.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if dbrg_tipo.ItemIndex < 0 then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(dbrg_tipo.Caption);
    Result := False;
    dbrg_tipo.SetFocus;
    Exit;
  end;
end;

end.
