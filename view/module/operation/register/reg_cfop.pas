unit reg_cfop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, ControllerNatureza;

type
  TRegCfop = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Desc_Abreviada: TLabel;
    L_Descricao: TLabel;
    L_CFOP: TLabel;
    L_Registro: TLabel;
    L_Codigo: TLabel;
    L_Aplicacao: TLabel;
    E_Codigo: TEdit;
    E_Desc_Abreviada: TEdit;
    E_Descricao: TEdit;
    E_CFOP: TEdit;
    Rgp_Sentido: TRadioGroup;
    Rgp_Alcada: TRadioGroup;
    E_Registro: TEdit;
    Rgp_Ativo: TRadioGroup;
    mmoAplicacao: TMemo;
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
  public
    natureza : TControllerNatureza;
  end;

var
  RegCfop: TRegCfop;

implementation

uses UN_MSG, env;

{$R *.dfm}

procedure TRegCfop.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCfop.ClearAllFields;
begin
  inherited;
  natureza.clear;
end;

procedure TRegCfop.CriarVariaveis;
begin
  inherited;
  natureza := TControllernatureza.create(self);
end;

procedure TRegCfop.Delete;
begin
  natureza.delete;
  inherited;
end;

procedure TRegCfop.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(natureza);
end;

procedure TRegCfop.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    natureza.Registro.Codigo := Self.CodigoRegistro;
    natureza.getbyId;
  End;
  inherited;
end;

procedure TRegCfop.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCfop.Save;
begin
  with natureza do
  Begin
    Registro.Cfop := E_CFOP.Text;
    Registro.Resumido := E_Desc_Abreviada.Text;
    Registro.Descricao := E_Descricao.Text;
    Registro.Registro := StrToIntDef(E_Registro.Text, 0);

    if Rgp_Sentido.ItemIndex = 0 then
      Registro.Sentido := SENTIDO_ENTRADA
    else
      Registro.Sentido := SENTIDO_SAIDA;

    case Rgp_Alcada.ItemIndex of
      0: Registro.Alcada := ALCADA_ESTADUAL;
      1: Registro.Alcada := ALCADA_NACIONAL;
      2: Registro.Alcada := ALCADA_EXTERIOR;
    end;

    case Rgp_Ativo.ItemIndex of
      0: Registro.Ativo := SIGLA_S;
      1: Registro.Ativo := SIGLA_N;
    end;

    Registro.Aplicacao := mmoAplicacao.Lines.Text;
    salva;
  End;
  CodigoRegistro := natureza.Registro.Codigo;
  inherited;
end;

procedure TRegCfop.ShowData;
begin
  with natureza do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_CFOP.Text := Registro.Cfop;
    E_Desc_Abreviada.Text := Registro.Resumido;
    E_Descricao.Text := Registro.Descricao;
    E_Registro.Text := IntToStr(Registro.Registro);

    if Registro.Sentido = SENTIDO_ENTRADA then
      Rgp_Sentido.ItemIndex := 0
    else
      Rgp_Sentido.ItemIndex := 1;

    if Registro.Alcada = ALCADA_ESTADUAL then
      Rgp_Alcada.ItemIndex := 0
    else if Registro.Alcada = ALCADA_NACIONAL then
      Rgp_Alcada.ItemIndex := 1
    else
      Rgp_Alcada.ItemIndex := 2;

    if Registro.Ativo = SIGLA_S then
      Rgp_Ativo.ItemIndex := 0
    else
      Rgp_Ativo.ItemIndex := 1;

    mmoAplicacao.Lines.Text := Registro.Aplicacao;
  End;
  inherited;
end;

procedure TRegCfop.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegCfop.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCfop.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_CFOP.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_CFOP.Caption);
    Result := False;
    E_CFOP.SetFocus;
    Exit;
  end;

  if natureza.Fc_BuscaCFOP(E_CFOP.Text) and (Self.CodigoRegistro = 0) then
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!'+EOLN+EOLN+
                   'C.F.O.P já cadastrado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result := False;
    E_CFOP.SetFocus;
    exit;
  end;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(E_Desc_Abreviada.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Desc_Abreviada.Caption);
    Result := False;
    E_Desc_Abreviada.SetFocus;
    Exit;
  end;
end;

end.
