unit tblBoletoBancario;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_Boleto_Bancario')]
  TBoletoBancario = Class(TGenericEntity)
  private
    FBLT_CODIGO : Integer;
    FBLT_CODEMP : Integer;
    FBLT_NUMERO : String;
    FBLT_DATA : TDate;
    FBLT_CODCTB : Integer;
    FBLT_TX_DESCONTO : Real;
    FBLT_BAIXA : String;
    FBLT_VALOR : Real;
    FBLT_CODQTC : Integer;
    FBLT_TX_JUROS : Real;
    FBLT_TX_MORA : Real;
    FBLT_VL_MORA : Real;
    FBLT_VL_DESCONTO : Real;
    FBLT_TX_MULTA : Real;
    FBLT_VL_TARIFA : Real;
    FBLT_CODBLE : Integer;
    FBLT_DT_VENCIMENTO : TDate;
    FBLT_DT_PROCESSAMENTO : TDate;
    FBLT_ACEITE : String;
    FBLT_PARCELA : String;
    FBLT_INSTRUCOES : String;
    FBLT_REMESSA : Integer;
    FBLT_CODRET : Integer;
    FBLT_STATUS : String;
    FBLT_NOSSONUMERO : String;
    FBLT_DT_PROTESTO : TDate;
    FBLT_DT_DESC_VENC : TDate;
    FBLT_MSG_RETORNO : String;
    FBLT_NR_REMESSA : Integer;
    FBLT_DIAS_PROTESTO : Integer;
    FBLT_TIPO_DIA : String;
    FBLT_DIA_NEGATIVACAO: Integer;
    FBLT_DT_NEGATIVACAO: TDate;


    procedure setFBLT_CODIGO( Value  : Integer);
    procedure setFBLT_CODEMP( Value  : Integer);
    procedure setFBLT_NUMERO( Value  : String);
    procedure setFBLT_DATA( Value  : TDate);
    procedure setFBLT_CODCTB( Value  : Integer);
    procedure setFBLT_TX_DESCONTO( Value  : Real);
    procedure setFBLT_BAIXA( Value  : String);
    procedure setFBLT_VALOR( Value  : Real);
    procedure setFBLT_CODQTC( Value  : Integer);
    procedure setFBLT_TX_JUROS( Value  : Real);
    procedure setFBLT_TX_MORA( Value  : Real);
    procedure setFBLT_VL_MORA( Value  : Real);
    procedure setFBLT_VL_DESCONTO( Value  : Real);
    procedure setFBLT_TX_MULTA( Value  : Real);
    procedure setFBLT_VL_TARIFA( Value  : Real);
    procedure setFBLT_CODBLE( Value  : Integer);
    procedure setFBLT_DT_VENCIMENTO( Value  : TDate);
    procedure setFBLT_DT_PROCESSAMENTO( Value  : TDate);
    procedure setFBLT_ACEITE( Value  : String);
    procedure setFBLT_PARCELA( Value  : String);
    procedure setFBLT_INSTRUCOES( Value  : String);
    procedure setFBLT_REMESSA( Value  : Integer);
    procedure setFBLT_CODRET( Value  : Integer);
    procedure setFBLT_STATUS( Value  : String);
    procedure setFBLT_NOSSONUMERO( Value  : String);
    procedure setFBLT_DT_PROTESTO( Value  : TDate);
    procedure setFBLT_DT_DESC_VENC( Value  : TDate);
    procedure setFBLT_MSG_RETORNO( Value  : String);
    procedure setFBLT_NR_REMESSA( Value  : Integer);
    procedure setFBLT_DIAS_PROTESTO( Value  : Integer);
    procedure setFBLT_TIPO_DIA( Value  : String);
    procedure setFBLT_DIAS_NEGATIVACAO(const Value: Integer);
    procedure setFBLT_DT_NEGATIVACAO(const Value: TDate);

  public
    [KeyField('BLT_CODIGO')]
    [FieldName('BLT_CODIGO')]
    property Codigo: Integer read FBLT_CODIGO write setFBLT_CODIGO;
    [FieldName('BLT_CODEMP')]
    property CodigoEmpresa: Integer read FBLT_CODEMP write setFBLT_CODEMP;
    [FieldName('BLT_NUMERO')]
    property Numero: String read FBLT_NUMERO write setFBLT_NUMERO;
    [FieldName('BLT_DATA')]
    property Data: TDate read FBLT_DATA write setFBLT_DATA;
    [FieldName('BLT_CODCTB')]
    property CodigoContaCorrente: Integer read FBLT_CODCTB write setFBLT_CODCTB;
    [FieldName('BLT_TX_DESCONTO')]
    property TaxaDesconto: Real read FBLT_TX_DESCONTO write setFBLT_TX_DESCONTO;

    [FieldName('BLT_BAIXA')]
    property Baixado: String read FBLT_BAIXA write setFBLT_BAIXA;
    [FieldName('BLT_VALOR')]
    property Valor: Real read FBLT_VALOR write setFBLT_VALOR;
    [FieldName('BLT_CODQTC')]
    property CodigoQuitacao: Integer read FBLT_CODQTC write setFBLT_CODQTC;
    [FieldName('BLT_TX_JUROS')]
    property TaxaJuros: Real read FBLT_TX_JUROS write setFBLT_TX_JUROS;
    [FieldName('BLT_TX_MORA')]
    property TaxaMora: Real read FBLT_TX_MORA write setFBLT_TX_MORA;
    [FieldName('BLT_VL_MORA')]
    property ValorMora: Real read FBLT_VL_MORA write setFBLT_VL_MORA;
    [FieldName('BLT_VL_DESCONTO')]
    property ValorDesconto: Real read FBLT_VL_DESCONTO write setFBLT_VL_DESCONTO;
    [FieldName('BLT_TX_MULTA')]
    property TaxaMulta: Real read FBLT_TX_MULTA write setFBLT_TX_MULTA;
    [FieldName('BLT_VL_TARIFA')]
    property ValorTarifa: Real read FBLT_VL_TARIFA write setFBLT_VL_TARIFA;
    [FieldName('BLT_CODBLE')]
    property CodigoBoletoEletronica: Integer read FBLT_CODBLE write setFBLT_CODBLE;
    [FieldName('BLT_DT_VENCIMENTO')]
    property DataVencimento: TDate read FBLT_DT_VENCIMENTO write setFBLT_DT_VENCIMENTO;
    [FieldName('BLT_DT_PROCESSAMENTO')]
    property DataProcessamento: TDate read FBLT_DT_PROCESSAMENTO write setFBLT_DT_PROCESSAMENTO;
    [FieldName('BLT_ACEITE')]
    property Aceite: String read FBLT_ACEITE write setFBLT_ACEITE;
    [FieldName('BLT_PARCELA')]
    property Parcela: String read FBLT_PARCELA write setFBLT_PARCELA;
    [FieldName('BLT_INSTRUCOES')]
    property Instrucao: String read FBLT_INSTRUCOES write setFBLT_INSTRUCOES;
    [FieldName('BLT_REMESSA')]
    property CodigoRemessa: Integer read FBLT_REMESSA write setFBLT_REMESSA;
    [FieldName('BLT_CODRET')]
    property CodigoRetorno: Integer read FBLT_CODRET write setFBLT_CODRET;
    [FieldName('BLT_STATUS')]
    property Status: String read FBLT_STATUS write setFBLT_STATUS;
    [FieldName('BLT_NOSSONUMERO')]
    property NossoNumero: String read FBLT_NOSSONUMERO write setFBLT_NOSSONUMERO;

    [FieldName('BLT_DT_PROTESTO')]
    property DataProtesto: TDate read FBLT_DT_PROTESTO write setFBLT_DT_PROTESTO;

    [FieldName('BLT_DIAS_PROTESTO')]
    property DiasProtesto: Integer read FBLT_DIAS_PROTESTO write setFBLT_DIAS_PROTESTO;

    [FieldName('BLT_DT_NEGATIVACAO')]
    property DataNegativacao: TDate read FBLT_DT_NEGATIVACAO write setFBLT_DT_NEGATIVACAO;

    [FieldName('BLT_DIAS_NEGATIVACAO')]
    property DiasNegativacao: Integer read FBLT_DIA_NEGATIVACAO write setFBLT_DIAS_NEGATIVACAO;

    [FieldName('BLT_DT_DESC_VENC')]
    property DataDescVencimento: TDate read FBLT_DT_DESC_VENC write setFBLT_DT_DESC_VENC;

    [FieldName('BLT_MSG_RETORNO')]
    property MensagemRetorno: String read FBLT_MSG_RETORNO write setFBLT_MSG_RETORNO;
    [FieldName('BLT_NR_REMESSA')]
    property NumeroRemessa: Integer read FBLT_NR_REMESSA write setFBLT_NR_REMESSA;


    [FieldName('BLT_TIPO_DIA')]
    property TipoDiaProtesto: String read FBLT_TIPO_DIA write setFBLT_TIPO_DIA;

  End;

implementation

{ TBoletoBancario }

procedure TBoletoBancario.setFBLT_ACEITE(Value: String);
begin
  FBLT_ACEITE := Value;
end;

procedure TBoletoBancario.setFBLT_BAIXA(Value: String);
begin
  FBLT_BAIXA := Value;
end;

procedure TBoletoBancario.setFBLT_CODBLE(Value: Integer);
begin
  FBLT_CODBLE := Value;
end;

procedure TBoletoBancario.setFBLT_CODCTB(Value: Integer);
begin
  FBLT_CODCTB := Value;
end;

procedure TBoletoBancario.setFBLT_CODEMP(Value: Integer);
begin
  FBLT_CODEMP := Value;
end;

procedure TBoletoBancario.setFBLT_CODIGO(Value: Integer);
begin
  FBLT_CODIGO := Value;
end;

procedure TBoletoBancario.setFBLT_CODQTC(Value: Integer);
begin
  FBLT_CODQTC := Value;
end;

procedure TBoletoBancario.setFBLT_CODRET(Value: Integer);
begin
  FBLT_CODRET := Value;
end;

procedure TBoletoBancario.setFBLT_DATA(Value: TDate);
begin
  FBLT_DATA := Value;
end;

procedure TBoletoBancario.setFBLT_DIAS_NEGATIVACAO(const Value: Integer);
begin
  FBLT_DIA_NEGATIVACAO := Value;
end;

procedure TBoletoBancario.setFBLT_DIAS_PROTESTO(Value: Integer);
begin
  FBLT_DIAS_PROTESTO := Value;
end;

procedure TBoletoBancario.setFBLT_DT_DESC_VENC(Value: TDate);
begin
  FBLT_DT_DESC_VENC := Value;
end;

procedure TBoletoBancario.setFBLT_DT_NEGATIVACAO(const Value: TDate);
begin
  FBLT_DT_NEGATIVACAO := Value;
end;

procedure TBoletoBancario.setFBLT_DT_PROCESSAMENTO(Value: TDate);
begin
  FBLT_DT_PROCESSAMENTO := Value;
end;

procedure TBoletoBancario.setFBLT_DT_PROTESTO(Value: TDate);
begin
  FBLT_DT_PROTESTO := Value;
end;

procedure TBoletoBancario.setFBLT_DT_VENCIMENTO(Value: TDate);
begin
  FBLT_DT_VENCIMENTO := Value;
end;

procedure TBoletoBancario.setFBLT_INSTRUCOES(Value: String);
begin
  FBLT_INSTRUCOES := Value;
end;

procedure TBoletoBancario.setFBLT_MSG_RETORNO(Value: String);
begin
  FBLT_MSG_RETORNO := Value;
end;

procedure TBoletoBancario.setFBLT_NOSSONUMERO(Value: String);
begin
  FBLT_NOSSONUMERO := Value;
end;

procedure TBoletoBancario.setFBLT_NR_REMESSA(Value: Integer);
begin
  FBLT_NR_REMESSA := Value;
end;

procedure TBoletoBancario.setFBLT_NUMERO(Value: String);
begin
  FBLT_NUMERO := Value;
end;

procedure TBoletoBancario.setFBLT_PARCELA(Value: String);
begin
  FBLT_PARCELA := Value;
end;

procedure TBoletoBancario.setFBLT_REMESSA(Value: Integer);
begin
  FBLT_REMESSA := Value;
end;

procedure TBoletoBancario.setFBLT_STATUS(Value: String);
begin
  FBLT_STATUS := Value;
end;

procedure TBoletoBancario.setFBLT_TIPO_DIA(Value: String);
begin
  FBLT_TIPO_DIA := Copy(Value,1,1);
end;

procedure TBoletoBancario.setFBLT_TX_DESCONTO(Value: Real);
begin
  FBLT_TX_DESCONTO := Value;
end;

procedure TBoletoBancario.setFBLT_TX_JUROS(Value: Real);
begin
  FBLT_TX_JUROS := Value;
end;

procedure TBoletoBancario.setFBLT_TX_MORA(Value: Real);
begin
  FBLT_TX_MORA := Value;
end;

procedure TBoletoBancario.setFBLT_TX_MULTA(Value: Real);
begin
  FBLT_TX_MULTA := Value;
end;

procedure TBoletoBancario.setFBLT_VALOR(Value: Real);
begin
  FBLT_VALOR := Value;
end;

procedure TBoletoBancario.setFBLT_VL_DESCONTO(Value: Real);
begin
  FBLT_VL_DESCONTO := Value;
end;

procedure TBoletoBancario.setFBLT_VL_MORA(Value: Real);
begin
  FBLT_VL_MORA := Value;
end;

procedure TBoletoBancario.setFBLT_VL_TARIFA(Value: Real);
begin
  FBLT_VL_TARIFA := Value;
end;

end.
