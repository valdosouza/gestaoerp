unit reg_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  base_registry, ControllerBoletoEletronico, Un_Fm_ListaEspecieDoc,
  Un_Fm_ListaContaBancaria, System.StrUtils,
  ACBrBoleto, ACBrBoletoConversao, TypInfo, reg_billing_portfolio;

type
  TRegElectronicSlip = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    L_Carteira: TLabel;
    Sb_Carteira: TSpeedButton;
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
    cb_Carteira: TComboBox;
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
    L_Tx_Mora: TLabel;
    Fm_ListaContaBancaria: TFm_ListaContaBancaria;
    Fm_ListaEspecieDoc: TFm_ListaEspecieDoc;
    OpenDialog: TOpenDialog;
    procedure Sb_CarteiraClick(Sender: TObject);
    procedure Sb_Path_remessaClick(Sender: TObject);
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
    boletoEletronico : TControllerBoletoEletronico;
  end;

var
  RegElectronicSlip: TRegElectronicSlip;

implementation

{$R *.dfm}

uses UN_MSG;

{ TRegElectronicSlip }

procedure TRegElectronicSlip.Change;
begin
  inherited;
  cb_Carteira.SetFocus;
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

procedure TRegElectronicSlip.IniciaVariaveis;
var
  Lc_I : TACBrBolLayOut ;
begin
  Cb_Modelo_Boleto.Items.Clear ;
   For Lc_I := Low(TACBrBolLayOut) to High(TACBrBolLayOut) do
      Cb_Modelo_Boleto.Items.Add( GetEnumName(TypeInfo(TACBrBolLayOut), integer(Lc_I) ) ) ;
   Cb_Modelo_Boleto.ItemIndex := 0 ;

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
  cb_Carteira.SetFocus;
end;

procedure TRegElectronicSlip.Save;
begin
  with boletoEletronico do
  Begin
    //Fm_ListaContaBancaria1

    //cb_Carteira
    //BLE_CODCTR
    //Registro.CodigoCarteira := 0; //////////

    //Fm_ListaEspecieDoc1

    //RG_Aceite
    Registro.Aceite := IfThen(RG_Aceite.ItemIndex = 0, SIM, NAO); //BLE_ACEITE

//E_Cedente_Convenio
//BLE_CONVENIO
    Registro.Convenio := E_Cedente_Convenio.Text;

//E_CodTransmissao
//BLE_COD_TRANS
    Registro.CodTrans := E_CodTransmissao.Text;

//E_Varia_Carteira
//BLE_VAR_CART
    Registro.VarCart := StrToIntDef(E_Varia_Carteira.Text, 0);

//Cb_LayoutRemessa
//  Tb_BoletoEletronico.FieldByName('BLE_LAY_REMESSA').AsString := Cb_LayoutRemessa.Text;
    Registro.LayRemessa := Cb_LayoutRemessa.Text;

//Cb_Protesto
//  Tb_BoletoEletronico.FieldByName('BLE_PROTESTO').AsString := IntToStr(Cb_Protesto.ItemIndex);
    Registro.Protesto := IntToStr(Cb_Protesto.ItemIndex);

//E_Dias_Protesto
//BLE_DIAS_PROTESTO
    Registro.DiasProtesto := StrToIntDef(E_Dias_Protesto.Text, 0);

//Cb_Negativacao
//Tb_BoletoEletronico.FieldByName('BLE_NEGATIVACAO').AsString := Cb_Negativacao.Text;
    Registro.Negativacao := Cb_Negativacao.Text;

//E_Dias_Negativacao
//BLE_DIAS_NEGATIVACAO
    Registro.DiasNegativacao := StrToIntDef(E_Dias_Negativacao.Text, 0);

//Cb_Modelo_Boleto
//Tb_BoletoEletronico.FieldByName('BLE_LEIAUTE').AsString := IntToStr(Cb_Modelo_Boleto.ItemIndex);
//Cb_Modelo_Boleto.ItemIndex := StrToIntDef(Tb_BoletoEletronico.FieldByName('BLE_LEIAUTE').AsString,0);
    Registro.Leiaute := Cb_Modelo_Boleto.ItemIndex;

//E_POSTO_BENEF
//BLE_POSTO_BENEF
    Registro.PostoBenef := E_POSTO_BENEF.Text;

//E_Tx_Juros
//BLE_TX_JUROS
    Registro.TxJuros := StrToFloatDef(E_Tx_Juros.Text, 0);

//E_Tx_Mora
//BLE_TX_MORA
    Registro.TxMora := StrToFloatDef(E_Tx_Mora.Text, 0);

//E_VL_MORA_MIN
//VlMoraMin BLE_VL_MORA_MIN
    Registro.VlMoraMin := StrToFloatDef(E_VL_MORA_MIN.Text, 0);

//E_Tx_Desconto
//BLE_TX_DESCONTO
    Registro.TxDesconto := StrToFloatDef(E_Tx_Desconto.Text, 0);

//E_Tx_Multa
//BLE_TX_MULTA
    Registro.TxMulta := StrToFloatDef(E_Tx_Multa.Text, 0);

//E_VL_Tarifa
//VlTarifa  BLE_VL_TARIFA
    Registro.VlTarifa := StrToFloatDef(E_VL_Tarifa.Text, 0);

//E_Local_Pagamento
//BLE_LOCALPAG
    Registro.LocalPag := E_Local_Pagamento.Text;

//E_Inst_Pagamento_1
//BLE_INSTR_1
    Registro.Instr1 := E_Inst_Pagamento_1.Text;

//E_Inst_Pagamento_2
//BLE_INSTR_2
    Registro.Instr2 := E_Inst_Pagamento_2.Text;

//M_InstrucaoAdic
//BLE_INSTRUCOES
  Registro.Instrucoes := M_IntrucaoAdicional.Lines.Text;

//E_Path_Remessa_Retorno
//BLE_PATH_ARQUIVOS
    Registro.PathArquivos := E_Path_Remessa_Retorno.Text;

    salva;
  End;
  CodigoRegistro := boletoEletronico.Registro.Codigo;
  inherited;
end;

procedure TRegElectronicSlip.Sb_CarteiraClick(Sender: TObject);
//Var
  //Lc_Form : TFr_Carteira_Cobranca;
var
  Lc_Form : TRegBillingPortfolio;
begin
  if (trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(Fm_ListaContaBancaria.L_ContaBancaria.Caption);
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;
  end
  else
  Begin //reg_billing_portfolio, TRegBillingPortfolio

    try
      Lc_form := TRegBillingPortfolio.Create(Self);
      try
        Lc_form.ShowModal;
      finally
        FreeAndNil(Lc_form);
      end;
    finally

    end;

    {Try
      Lc_Form := TFr_Carteira_Cobranca.Create(Self);
      Lc_Form.It_Codbco := Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_CODIGO').AsInteger;
      Lc_Form.It_Cd_Cadastro := DM.Qr_Carteira_Cobranca.FieldByName('CTR_CODIGO').AsInteger;
      Lc_Form.ShowModal;
    Finally
      Pc_MostraListaCarteira(Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_CODIGO').AsInteger);
      Dblcb_Carteira.KeyValue := Lc_Form.It_Cd_Cadastro;
      Tb_BoletoEletronico.FieldByName('BLE_CODCTR').AsInteger := Lc_Form.It_Cd_Cadastro;
      Lc_Form.disposeof;
    End;}
   end;
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
    //Fm_ListaContaBancaria1

    //cb_Carteira
    //BLE_CODCTR
    //Registro.CodigoCarteira := 0; //////////

    //Fm_ListaEspecieDoc1

    //RG_Aceite
    //Registro.Aceite := IfThen(RG_Aceite.ItemIndex = 0, SIM, NAO); //BLE_ACEITE
    {if Registro.Aceite = SIM then
      RG_Aceite.ItemIndex = 0
    else
      RG_Aceite.ItemIndex = 1;  }

//E_Cedente_Convenio
//BLE_CONVENIO
    E_Cedente_Convenio.Text := Registro.Convenio;

//E_CodTransmissao
//BLE_COD_TRANS
    E_CodTransmissao.Text := Registro.CodTrans;

//E_Varia_Carteira
//BLE_VAR_CART
    //Registro.VarCart := StrToIntDef(E_Varia_Carteira.Text, 0);
    E_Varia_Carteira.Text := IntToStr(Registro.VarCart);

//Cb_LayoutRemessa
//  Tb_BoletoEletronico.FieldByName('BLE_LAY_REMESSA').AsString := Cb_LayoutRemessa.Text;
    Cb_LayoutRemessa.Text := Registro.LayRemessa;

//Cb_Protesto
//  Tb_BoletoEletronico.FieldByName('BLE_PROTESTO').AsString := IntToStr(Cb_Protesto.ItemIndex);
    //Registro.Protesto := IntToStr(Cb_Protesto.ItemIndex);
    Cb_Protesto.ItemIndex := StrToIntDef(Registro.Protesto, 0);

//E_Dias_Protesto
//BLE_DIAS_PROTESTO
   // Registro.DiasProtesto := StrToIntDef(E_Dias_Protesto.Text, 0);
    E_Dias_Protesto.Text := IntToStr(Registro.DiasProtesto);

//Cb_Negativacao
//Tb_BoletoEletronico.FieldByName('BLE_NEGATIVACAO').AsString := Cb_Negativacao.Text;
    //Cb_Negativacao.Text := Registro.Negativacao;
    //Registro.Negativacao := Cb_Negativacao.Text;
     Cb_Negativacao.Text := Registro.Negativacao;

//E_Dias_Negativacao
//BLE_DIAS_NEGATIVACAO
    //Registro.DiasNegativacao := StrToIntDef(E_Dias_Negativacao.Text, 0);
    E_Dias_Negativacao.Text := IntToStr(Registro.DiasNegativacao);

   //Cb_Modelo_Boleto
   //Tb_BoletoEletronico.FieldByName('BLE_LEIAUTE').AsString := IntToStr(Cb_Modelo_Boleto.ItemIndex);
   //Cb_Modelo_Boleto.ItemIndex := StrToIntDef(Tb_BoletoEletronico.FieldByName('BLE_LEIAUTE').AsString,0);
   // Registro.Leiaute := Cb_Modelo_Boleto.ItemIndex;
    Cb_Modelo_Boleto.ItemIndex := Registro.Leiaute;

   //E_POSTO_BENEF
   //BLE_POSTO_BENEF
   // Registro.PostoBenef := E_POSTO_BENEF.Text;
    E_POSTO_BENEF.Text := Registro.PostoBenef;

//E_Tx_Juros
//BLE_TX_JUROS
    //Registro.TxJuros := StrToFloatDef(E_Tx_Juros.Text, 0);
    E_Tx_Juros.Text := FloatToStrF(Registro.TxJuros, ffFixed, 10, 2);

//E_Tx_Mora
//BLE_TX_MORA
    //Registro.TxMora := StrToFloatDef(E_Tx_Mora.Text, 0);
    E_Tx_Mora.Text := FloatToStrF(Registro.TxMora, ffFixed, 10, 2);

//E_VL_MORA_MIN
//VlMoraMin BLE_VL_MORA_MIN
   // Registro.VlMoraMin := StrToFloatDef(E_VL_MORA_MIN.Text, 0);
    E_VL_MORA_MIN.Text := FloatToStrF(Registro.VlMoraMin, ffFixed, 10, 2);

//E_Tx_Desconto
//BLE_TX_DESCONTO
   // Registro.TxDesconto := StrToFloatDef(E_Tx_Desconto.Text, 0);
    E_Tx_Desconto.Text := FloatToStrF(Registro.TxDesconto, ffFixed, 10, 2);

//E_Tx_Multa
//BLE_TX_MULTA
    //Registro.TxMulta := StrToFloatDef(E_Tx_Multa.Text, 0);
    E_Tx_Multa.Text := FloatToStrF(Registro.TxMulta, ffFixed, 10, 2);

//E_VL_Tarifa
//VlTarifa  BLE_VL_TARIFA
    //Registro.VlTarifa := StrToFloatDef(E_VL_Tarifa.Text, 0);
    E_VL_Tarifa.Text := FloatToStrF(Registro.VlTarifa, ffFixed, 10, 2);

//E_Local_Pagamento
//BLE_LOCALPAG
    //Registro.LocalPag := E_Local_Pagamento.Text;
    E_Local_Pagamento.Text := Registro.LocalPag;

//E_Inst_Pagamento_1
//BLE_INSTR_1
    //Registro.Instr1 := E_Inst_Pagamento_1.Text;
    E_Inst_Pagamento_1.Text := Registro.Instr1;

//E_Inst_Pagamento_2
//BLE_INSTR_2
    //Registro.Instr2 := E_Inst_Pagamento_2.Text;
    E_Inst_Pagamento_2.Text := Registro.Instr2;

//M_InstrucaoAdic
//BLE_INSTRUCOES
 // Registro.Instrucoes := M_IntrucaoAdicional.Lines.Text;
    M_IntrucaoAdicional.Lines.Text := Registro.Instrucoes;

//E_Path_Remessa_Retorno
//BLE_PATH_ARQUIVOS
    //Registro.PathArquivos := E_Path_Remessa_Retorno.Text;
    E_Path_Remessa_Retorno.Text := Registro.PathArquivos;
  End;
  inherited;
end;

procedure TRegElectronicSlip.ShowNoData;
begin
  cb_Carteira.ItemIndex := -1;
end;

function TRegElectronicSlip.ValidateDelete: boolean;
begin
  Result := True;
  if (TMsg.Excluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
  {if (MensagemPadrao('Mensagem de Confirmação',
                     'Excluir a carteira de cobraça de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      Tb_BoletoEletronico.Delete;
      if Tb_BoletoEletronico.Transaction.InTransaction then Tb_BoletoEletronico.Transaction.CommitRetaining;
      PC_Buscar;
      Pg_Interface.ActivePage := tbs_Pesquisa;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;}

end;

function TRegElectronicSlip.ValidateSave: boolean;
begin
  Result := True;

  {if (trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(Fm_ListaContaBancaria.L_ContaBancaria.Caption);
    Result := False;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;
  end;

  if (Trim(cb_Carteira.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Carteira.Caption);
    Result := False;
    cb_Carteira.SetFocus;
    Exit;
  end;

  if (trim( Fm_ListaEspecieDoc.Dblcb_Especie_Doc.Text ) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(Fm_ListaEspecieDoc.L_Especie_Doc.Caption);
    Result := False;
    Fm_ListaEspecieDoc.Dblcb_Especie_Doc.SetFocus;
    Exit;
  end;

  if (Trim(Cb_Modelo_Boleto.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(l_Modelo_Boleto.Caption);
    Result := False;
    Cb_Modelo_Boleto.SetFocus;
    Exit;
  end;

  if ((Copy(Cb_Protesto.text,1,1) = '1') or (Copy(Cb_Protesto.text,1,1) = '2')) and
    (Trim(E_Dias_Protesto.Text) = EmptyStr)   then
  begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
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
      Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Para Banco Sicred, favor informar campo Posto Beneficiário.'+EOLN+
                     'Preenchimento obrigatório.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      Result := False;
      E_POSTO_BENEF.SetFocus;
      Exit;
    end;
  end;   }
end;

end.
