unit reg_taxation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, ControllerTributacao, System.StrUtils;

type
  TRegTaxation = class(TBaseRegistry)
    pl_fundo: TPanel;
    L_Aq_ICMS: TLabel;
    L_Red_Base: TLabel;
    Label7: TLabel;
    Sb_Observacao: TSpeedButton;
    L_Red_Aliq: TLabel;
    Label9: TLabel;
    SB_Natureza: TSpeedButton;
    L_Situacao_Tributaria: TLabel;
    L_Modal_ICMS_ST: TLabel;
    L_Modal_ICMS: TLabel;
    L_Desoneracao: TLabel;
    L_Simples_Nacional: TLabel;
    Sb_Sit_Trib_ICMS: TSpeedButton;
    Sb_Sit_Trib_CSOSN: TSpeedButton;
    Sb_Modal_ICMS: TSpeedButton;
    Sb_Desoneracao: TSpeedButton;
    Sb_Modal_ICMS_St: TSpeedButton;
    L_Origem: TLabel;
    E_Aq_ICMS: TEdit;
    E_Red_Base: TEdit;
    DBLCB_Observacao: TComboBox;
    E_Red_Aliq: TEdit;
    DBLCB_Natureza: TComboBox;
    Pnl_Outros: TGroupBox;
    L_Transacao_Produto: TLabel;
    L_CodigoNCM: TLabel;
    Sb_Classificacao: TSpeedButton;
    dbcbx_sit_trb: TCheckBox;
    chbx_Consumidor: TCheckBox;
    chbx_micro: TCheckBox;
    chbx_diferido: TCheckBox;
    chbx_destaque: TCheckBox;
    CHBX_ST_ICMS: TCheckBox;
    Cb_Transacao_Produto: TComboBox;
    E_CodigoNCM: TEdit;
    Chbx_Sentido: TCheckBox;
    Dblcb_Situacao_tributaria: TComboBox;
    Dblcb_Modal_ICMS_ST: TComboBox;
    Dblcb_Modal_ICMS: TComboBox;
    Dblcb_Desoneracao: TComboBox;
    Dblcb_Simples_Nacional: TComboBox;
    Pg_Outros: TPageControl;
    tbs_ipi: TTabSheet;
    Panel2: TPanel;
    L_Aq_IPI: TLabel;
    L_Situacao_tributaria_IPI: TLabel;
    Sb_Sit_Trib_IPI: TSpeedButton;
    E_Aq_IPI: TEdit;
    Dblcb_Situacao_tributaria_IPI: TComboBox;
    tbs_pis: TTabSheet;
    Panel3: TPanel;
    L_Aq_PIS: TLabel;
    L_Situacao_tributaria_PIS: TLabel;
    Sb_Sit_Trib_PIS: TSpeedButton;
    E_Aq_Pis: TEdit;
    Dblcb_Situacao_tributaria_PIS: TComboBox;
    tbs_cofins: TTabSheet;
    Panel4: TPanel;
    L_Aq_Cofins: TLabel;
    L__Situacao_tributaria_CFS: TLabel;
    Sb_Sit_Trib_CFS: TSpeedButton;
    E_Aq_Cofins: TEdit;
    Dblcb_Situacao_tributaria_CFS: TComboBox;
    tbs_outros: TTabSheet;
    Panel5: TPanel;
    L_Aq_IRPJ: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Siscomex: TLabel;
    L_Aq_Tec: TLabel;
    L_Aq_ISS: TLabel;
    L_AQ_AFRMM: TLabel;
    E_Aq_IRPJ: TEdit;
    E_Aq_CSLL: TEdit;
    E_Aq_Siscomex: TEdit;
    E_Aq_Tec: TEdit;
    E_Aq_ISS: TEdit;
    E_AQ_AFRMM: TEdit;
    Cb_Origem: TComboBox;
    Chbx_Red_Base_ST: TCheckBox;
  private
    { Private declarations }
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
    taxation : TControllerTributacao;
  end;

var
  RegTaxation: TRegTaxation;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegTaxation.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxation.ClearAllFields;
begin
  inherited;
  taxation.clear;
end;

procedure TRegTaxation.CriarVariaveis;
begin
  inherited;
  taxation := TControllerTributacao.create(self);
end;

procedure TRegTaxation.Delete;
begin
  taxation.delete;
  inherited;
end;

procedure TRegTaxation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxation);
end;

procedure TRegTaxation.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    taxation.Registro.Codigo := Self.CodigoRegistro;
    taxation.getbyId;
  End;
  inherited;
end;

procedure TRegTaxation.Insert;
begin
  inherited;
  //E_Descricao.SetFocus;
end;

procedure TRegTaxation.Save;
begin
  with taxation do
  Begin
    //Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := taxation.Registro.Codigo;
  inherited;
end;

procedure TRegTaxation.ShowData;
begin
  with taxation do
  Begin
    //E_Codigo.Text     := Registro.Codigo.ToString;
    //E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegTaxation.ShowNoData;
begin
  //E_Codigo.clear;
  //E_Descricao.clear;
end;

function TRegTaxation.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxation.ValidateSave: boolean;
begin
  Result := True;

  {if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end; }

{
function TFr_Tributacao.Fc_ValidaGravacao: Boolean;
begin
  Result:= True;
  Fm_ListaEditaEstadoDBLCB_UFExit(Self);

  if Tb_TributacaoTRB_AQ_IPI.IsNull       then Tb_TributacaoTRB_AQ_IPI.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_PIS.IsNull       then Tb_TributacaoTRB_AQ_PIS.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_COFINS.IsNull    then Tb_TributacaoTRB_AQ_COFINS.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_IRPJ.IsNull      then Tb_TributacaoTRB_AQ_IRPJ.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_CSLL.IsNull      then Tb_TributacaoTRB_AQ_CSLL.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_SISCOMEX.IsNull  then Tb_TributacaoTRB_AQ_SISCOMEX.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_II.IsNull        then Tb_TributacaoTRB_AQ_II.AsFloat := 0;
  if Tb_TributacaoTRB_AQ_ISS.IsNull       then Tb_TributacaoTRB_AQ_ISS.AsFloat := 0;

  IF (It_Cd_CRT  = 3) or (It_Cd_CRT  = 2) then
  Begin
    if TRIM(Dblcb_Situacao_tributaria.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     ' Campo Situação Tributária Normal não informado.'+EOLN+
                     ' Preencha Situação Tributária Normal para esta tributação.'+EOLN,
                    [' OK'],[bEscape],mpErro);
      IF Dblcb_Situacao_tributaria.CanFocus then Dblcb_Situacao_tributaria.SetFocus;
      Result:=False;
      Exit;
    end;
  end
  else
  Begin
    if TRIM(Dblcb_Simples_Nacional.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     ' Campo Código de Situação da Operação Simples Nacional não informado.'+EOLN+
                     ' Preencha este campo para esta tributação.'+EOLN,
                    [' OK'],[bEscape],mpErro);
      IF Dblcb_Situacao_tributaria.CanFocus then Dblcb_Situacao_tributaria.SetFocus;
      Result:=False;
      Exit;
    end;
  end;

  if TRIM(Dblcb_Modal_ICMS.Text) = '' then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   ' Campo Determinação de Base ICMS não informado.'+EOLN+
                   ' Preencha Determinação de Base ICMS para esta tributação.'+EOLN,
                  [' OK'],[bEscape],mpErro);
    IF Dblcb_Modal_ICMS.CanFocus then Dblcb_Modal_ICMS.SetFocus;
    Result:=False;
    Exit;
  end;

  if dbcbx_sit_trb.Checked then
  Begin
    if TRIM(Dblcb_Modal_ICMS_ST.Text) = '' then
    begin
      MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     ' Campo Determinação de Base ICMS S.T. não informado.'+EOLN+
                     ' Preencha Determinação de Base ICMS S.T. para esta tributação.'+EOLN,
                    [' OK'],[bEscape],mpErro);
      IF Dblcb_Modal_ICMS_ST.CanFocus then Dblcb_Modal_ICMS_ST.SetFocus;
      Result:=False;
      Exit;
    end;
  end;

  if TRIM(DBLCB_Natureza.Text) = '' then
    begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   ' Campo Natureza não informado.'+EOLN+
                   ' Preencha Natureza para esta tributação.'+EOLN,
                  [' OK'],[bEscape],mpErro);
    IF DBLCB_Natureza.CanFocus then DBLCB_Natureza.SetFocus;
    Result:=False;
    Exit;
   end;
  //os campos de valores não podem ser brancos
  if Length(Trim(Tb_TributacaoTRB_AQ_ICMS.AsAnsiString))=0     then Tb_TributacaoTRB_AQ_ICMS.AsFloat     := 0;
  if Length(Trim(Tb_TributacaoTRB_RD_AQ_ICMS.AsAnsiString))=0  then Tb_TributacaoTRB_RD_AQ_ICMS.AsFloat  := 0;
  if Length(Trim(Tb_TributacaoTRB_RD_BS_ICMS.AsAnsiString))=0  then Tb_TributacaoTRB_RD_BS_ICMS.AsFloat  := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_IPI.AsAnsiString))=0      then Tb_TributacaoTRB_AQ_IPI.AsFloat      := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_PIS.AsAnsiString))=0      then Tb_TributacaoTRB_AQ_PIS.AsFloat      := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_COFINS.AsAnsiString))=0   then Tb_TributacaoTRB_AQ_COFINS.AsFloat   := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_IRPJ.AsAnsiString))=0     then Tb_TributacaoTRB_AQ_IRPJ.AsFloat     := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_CSLL.AsAnsiString))=0     then Tb_TributacaoTRB_AQ_CSLL.AsFloat     := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_SISCOMEX.AsAnsiString))=0 then Tb_TributacaoTRB_AQ_SISCOMEX.AsFloat := 0;
  if Length(Trim(Tb_TributacaoTRB_AQ_II.AsAnsiString))=0       then Tb_TributacaoTRB_AQ_II.AsFloat       := 0;

  if (StrToFloatDef(E_Aq_IPI.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_IPI.Text) ='') then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   ' Aliquota de IPI maior que zero.'+EOLN+
                   ' Situação de IPI não pode ser nulo.'+EOLN,
                  [' OK'],[bEscape],mpErro);
    Pg_Outros.ActivePage:= tbs_ipi;
    IF Dblcb_Situacao_tributaria_IPI.CanFocus then Dblcb_Situacao_tributaria_IPI.SetFocus;
    Result:=False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Cofins.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_CFS.Text) ='') then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   ' Aliquota de COFINS maior que zero.'+EOLN+
                   ' Situação de COFINS não pode ser nulo.'+EOLN,
                  [' OK'],[bEscape],mpErro);
    Pg_Outros.ActivePage:= tbs_cofins;
    IF Dblcb_Situacao_tributaria_CFS.CanFocus then Dblcb_Situacao_tributaria_CFS.SetFocus;
    Result:=False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Pis.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_PIS.Text) ='') then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   ' Aliquota de PIS maior que zero.'+EOLN+
                   ' Situação de PIS não pode ser nulo.'+EOLN,
                  [' OK'],[bEscape],mpErro);
    Pg_Outros.ActivePage:= tbs_pis;
    IF Dblcb_Situacao_tributaria_PIS.CanFocus then Dblcb_Situacao_tributaria_PIS.SetFocus;
    Result:=False;
    Exit;
  end;

  if Fc_VerificaRegraExistente then
  Begin
    MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   'Já existe uma regra com os dados informados.'+EOLN+
                   'Verifique e tente novamente com dados diferente.'+EOLN,
                    [' OK'],[bEscape],mpAlerta);
    Result:=False;
    Exit;
  end;

  if Cb_Transacao_Produto.ItemIndex =6 then
  Begin
    if StrToFloatDef(E_Aq_ISS.Text,0) = 0 then
    Begin
      MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     'Para o Tipo de Transação Prestação de Serviço informa a alíquota I.S.S..'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                      [' OK'],[bEscape],mpAlerta);
      Result:=False;
      Pg_Outros.ActivePageIndex := 3;
      IF E_Aq_ISS.CanFocus then E_Aq_ISS.SetFocus;
      Exit;
    end;
  end;
end;
}
end;

end.
