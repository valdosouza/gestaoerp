unit reg_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  base_registry, ControllerBoletoEletronico, Un_Fm_ListaEspecieDoc,
  Un_Fm_ListaContaBancaria, System.StrUtils,
  ACBrBoleto, ACBrBoletoConversao, TypInfo, reg_billing_portfolio,
  un_fm_billing_portfolio, base_frame_list;

type
  TRegElectronicSlip = class(TBaseRegistry)
    OpenDialog: TOpenDialog;
    L_Cedente_Convenio: TLabel;
    L_Varia_Carteira: TLabel;
    L_Modelo_Boleto: TLabel;
    L_Local_Pagamneto: TLabel;
    L_Inst_Pagamento_1: TLabel;
    L_Inst_Pagamento_2: TLabel;
    L_IntrucaoAdicional: TLabel;
    L_Remessa_Retorno: TLabel;
    Sb_Path_remessa: TSpeedButton;
    L_Tx_Multa: TLabel;
    L_Tx_Juros: TLabel;
    L_Protesto: TLabel;
    L_Vl_Tarifa: TLabel;
    L_Dias_Protesto: TLabel;
    L_Tx_Desconto: TLabel;
    L_Vl_Mora_Min: TLabel;
    L_LayoutRemessa: TLabel;
    L_CodTransmissao: TLabel;
    L_Posto_Benef: TLabel;
    L_Negativacao: TLabel;
    L_Dias_Negativacao: TLabel;
    L_Tx_Mora: TLabel;
    E_Cedente_Convenio: TEdit;
    E_Varia_Carteira: TEdit;
    Cb_Modelo_Boleto: TComboBox;
    E_Local_Pagamento: TEdit;
    E_Inst_Pagamento_1: TEdit;
    E_Inst_Pagamento_2: TEdit;
    E_Path_Remessa_Retorno: TEdit;
    E_Tx_Multa: TEdit;
    E_Tx_Juros: TEdit;
    Cb_Protesto: TComboBox;
    M_IntrucaoAdicional: TMemo;
    E_Tx_Mora: TEdit;
    E_VL_Tarifa: TEdit;
    E_Dias_Protesto: TEdit;
    RG_Aceite: TRadioGroup;
    E_Tx_Desconto: TEdit;
    E_VL_MORA_MIN: TEdit;
    Cb_LayoutRemessa: TComboBox;
    E_CodTransmissao: TEdit;
    E_POSTO_BENEF: TEdit;
    Cb_Negativacao: TComboBox;
    E_Dias_Negativacao: TEdit;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    Fm_ListaEspecieDoc: TFm_ListaEspecieDoc;
    Fm_BillingPortfolio: TFmBillingPortfolio;
    procedure Sb_Path_remessaClick(Sender: TObject);
    procedure Fm_ListaContaBancariaDBLCB_ContaBancariaClick(Sender: TObject);
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
    boletoEletronico : TControllerBoletoEletronico;
  end;

var
  RegElectronicSlip: TRegElectronicSlip;

implementation

{$R *.dfm}

uses UN_MSG, env;

{ TRegElectronicSlip }

procedure TRegElectronicSlip.Change;
begin
  inherited;
  Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
end;

procedure TRegElectronicSlip.ClearAllFields;
begin
  inherited;
  boletoEletronico.Clear;
end;

procedure TRegElectronicSlip.CriarVariaveis;
begin
  inherited;
  boletoEletronico := TControllerboletoEletronico.create(self);
end;

procedure TRegElectronicSlip.Delete;
begin
  boletoEletronico.delete;
  inherited;
end;

procedure TRegElectronicSlip.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(boletoEletronico);
end;

procedure TRegElectronicSlip.Fm_ListaContaBancariaDBLCB_ContaBancariaClick(
  Sender: TObject);
begin
  if Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text <> EmptyStr then
  Begin
    Fm_BillingPortfolio.CodigoBanco := Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_CODIGO').AsInteger;
    Fm_BillingPortfolio.Listar;
  End;
end;

procedure TRegElectronicSlip.IniciaVariaveis;
var
  Lc_I : TACBrBolLayOut ;
begin
  Cb_Modelo_Boleto.Items.Clear ;
   For Lc_I := Low(TACBrBolLayOut) to High(TACBrBolLayOut) do
      Cb_Modelo_Boleto.Items.Add( GetEnumName(TypeInfo(TACBrBolLayOut), integer(Lc_I) ) ) ;
   Cb_Modelo_Boleto.ItemIndex := 0 ;

  Fm_ListaContaBancaria.Listar;
  Fm_ListaEspecieDoc.Listar;

  if Self.CodigoRegistro > 0 then
  Begin
    boletoEletronico.Registro.Codigo := Self.CodigoRegistro;
    boletoEletronico.getbyId;
  End;
  inherited;
end;

procedure TRegElectronicSlip.Insert;
begin
  inherited;
  Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
end;

procedure TRegElectronicSlip.Save;
begin
  with boletoEletronico do
  Begin
    Registro.ContaCorrente    := Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue;
    Registro.CodigoCarteira   := Fm_BillingPortfolio.Dblcb_Lista.KeyValue;
    Registro.EspecieDoc       := Fm_ListaEspecieDoc.Dblcb_Especie_Doc.KeyValue;
    Registro.Aceite           := IfThen(RG_Aceite.ItemIndex = 0, SIGLA_S, SIGLA_N);
    Registro.Convenio         := E_Cedente_Convenio.Text;
    Registro.CodTrans         := E_CodTransmissao.Text;
    Registro.VariacaoCarteira := StrToIntDef(E_Varia_Carteira.Text, 0);
    Registro.LayRemessa       := Cb_LayoutRemessa.Text;
    Registro.Protesto         := IntToStr(Cb_Protesto.ItemIndex);
    Registro.DiasProtesto     := StrToIntDef(E_Dias_Protesto.Text, 0);
    Registro.Negativacao      := Cb_Negativacao.Text;
    Registro.DiasNegativacao  := StrToIntDef(E_Dias_Negativacao.Text, 0);
    Registro.Leiaute          := Cb_Modelo_Boleto.ItemIndex;
    Registro.PostoBenef       := E_POSTO_BENEF.Text;
    Registro.TxJuros          := StrToFloatDef(E_Tx_Juros.Text, 0);
    Registro.TxMora           := StrToFloatDef(E_Tx_Mora.Text, 0);
    Registro.VlMoraMin        := StrToFloatDef(E_VL_MORA_MIN.Text, 0);
    Registro.TxDesconto       := StrToFloatDef(E_Tx_Desconto.Text, 0);
    Registro.TxMulta          := StrToFloatDef(E_Tx_Multa.Text, 0);
    Registro.VlTarifa         := StrToFloatDef(E_VL_Tarifa.Text, 0);
    Registro.LocalPag         := E_Local_Pagamento.Text;
    Registro.Instr1           := E_Inst_Pagamento_1.Text;
    Registro.Instr2           := E_Inst_Pagamento_2.Text;
    Registro.Instrucoes       := M_IntrucaoAdicional.Lines.Text;
    Registro.PathArquivos     := E_Path_Remessa_Retorno.Text;
    salva;
  End;
  CodigoRegistro := boletoEletronico.Registro.Codigo;
  inherited;
end;

procedure TRegElectronicSlip.Sb_Path_remessaClick(Sender: TObject);
var
  Dir: string;
begin
  OpenDialog.DefaultExt := '*.*';
  OpenDialog.Filter := 'Todos os Arquivos (*.*)|*.*';
  if Length(E_Path_Remessa_Retorno.Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := E_Path_Remessa_Retorno.Text;

  {if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then //VALDO, ver qual unit está esse método
    E_Path_Remessa_Retorno.Text := Dir; }
end;

procedure TRegElectronicSlip.ShowData;
begin
  with boletoEletronico do
  Begin
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.KeyValue := Registro.ContaCorrente;

    Fm_BillingPortfolio.CodigoBanco := Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_CODIGO').AsInteger;
    Fm_BillingPortfolio.Listar;
    Fm_BillingPortfolio.Dblcb_Lista.KeyValue := Registro.CodigoCarteira;

    Fm_ListaEspecieDoc.Dblcb_Especie_Doc.KeyValue := Registro.EspecieDoc;

    if Registro.Aceite = SIGLA_S then
      RG_Aceite.ItemIndex := 0
    else
      RG_Aceite.ItemIndex := 1;

    E_Cedente_Convenio.Text         := Registro.Convenio;
    E_CodTransmissao.Text           := Registro.CodTrans;
    E_Varia_Carteira.Text           := IntToStr(Registro.VariacaoCarteira);
    Cb_LayoutRemessa.Text           := Registro.LayRemessa;
    Cb_Protesto.ItemIndex           := StrToIntDef(Registro.Protesto, 0);
    E_Dias_Protesto.Text            := IntToStr(Registro.DiasProtesto);
    Cb_Negativacao.Text             := Registro.Negativacao;
    E_Dias_Negativacao.Text         := IntToStr(Registro.DiasNegativacao);
    Cb_Modelo_Boleto.ItemIndex      := Registro.Leiaute;
    E_POSTO_BENEF.Text              := Registro.PostoBenef;
    E_Tx_Juros.Text                 := FloatToStrF(Registro.TxJuros, ffFixed, 10, 2);
    E_Tx_Mora.Text                  := FloatToStrF(Registro.TxMora, ffFixed, 10, 2);
    E_VL_MORA_MIN.Text              := FloatToStrF(Registro.VlMoraMin, ffFixed, 10, 2);
    E_Tx_Desconto.Text              := FloatToStrF(Registro.TxDesconto, ffFixed, 10, 2);
    E_Tx_Multa.Text                 := FloatToStrF(Registro.TxMulta, ffFixed, 10, 2);
    E_VL_Tarifa.Text                := FloatToStrF(Registro.VlTarifa, ffFixed, 10, 2);
    E_Local_Pagamento.Text          := Registro.LocalPag;
    E_Inst_Pagamento_1.Text         := Registro.Instr1;
    E_Inst_Pagamento_2.Text         := Registro.Instr2;
    M_IntrucaoAdicional.Lines.Text  := Registro.Instrucoes;
    E_Path_Remessa_Retorno.Text     := Registro.PathArquivos;
  End;
  inherited;
end;

procedure TRegElectronicSlip.ShowNoData;
begin
  inherited;
end;

function TRegElectronicSlip.ValidateDelete: boolean;
begin
  Result := True;
  if (not TMsgSetes.Excluir) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegElectronicSlip.ValidateSave: boolean;
begin
  Result := True;

  if (trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Fm_ListaContaBancaria.L_ContaBancaria.Caption);
    Result := False;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;
  end;

  if (Trim(Fm_BillingPortfolio.Dblcb_Lista.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Fm_BillingPortfolio.L_Carteira.Caption);
    Result := False;
    Fm_BillingPortfolio.Dblcb_Lista.SetFocus;
    Exit;
  end;

  if (trim( Fm_ListaEspecieDoc.Dblcb_Especie_Doc.Text ) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Fm_ListaEspecieDoc.L_Especie_Doc.Caption);
    Result := False;
    Fm_ListaEspecieDoc.Dblcb_Especie_Doc.SetFocus;
    Exit;
  end;

  if (Trim(Cb_Modelo_Boleto.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(l_Modelo_Boleto.Caption);
    Result := False;
    Cb_Modelo_Boleto.SetFocus;
    Exit;
  end;

  if ((Copy(Cb_Protesto.text,1,1) = '1') or (Copy(Cb_Protesto.text,1,1) = '2')) and
    (Trim(E_Dias_Protesto.Text) = EmptyStr)   then
  begin
    MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Para campo protesto igual a 1 ou 2 torna obrigatório '+EOLN+
                   'o preenchimento do campo Nr dias'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_Dias_Protesto.SetFocus;
    Exit;
  end;

  if (Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_NUMBCO').AsString = '748') then
  begin
    if (Trim(E_POSTO_BENEF.Text) = EmptyStr) then
    begin
      MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Para Banco Sicred, favor informar campo Posto Beneficiário.'+EOLN+
                     'Preenchimento obrigatório.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      Result := False;
      E_POSTO_BENEF.SetFocus;
      Exit;
    end;
  end;
end;

end.
