unit tblAdicaoImportacao;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ADIC_IMP')]
  TAdicaoImportacao = Class(TGenericEntity)
  private
    FADC_CODFAB: String;
    FADC_SEQUENCIA: String;
    FADC_CODDIM: Integer;
    FADC_VL_DESC: String;
    FADC_ITMCPA: String;
    FADC_CODIGO: Integer;
    FADC_NUMERO: String;
    FADC_PEDCPA: String;

    procedure setFADC_CODIGO(Value :   INTEGER);
    procedure setFADC_CODDIM(Value :     INTEGER);
    procedure setFADC_NUMERO(Value : String);
    procedure setFADC_SEQUENCIA(Value :String);
    procedure setFADC_CODFAB(Value :String);
    procedure setFADC_VL_DESC(Value :String);
    procedure setFADC_PEDCPA(Value :String);
    procedure setFADC_ITMCPA(Value :String);

  public

    [KeyField('ADC_CODIGO')]
    [FieldName('ADC_CODIGO')]
    property Codigo: Integer read FADC_CODIGO write setFADC_CODIGO;

    [FieldName('ADC_CODDIM')]
    property CodigoImportacao: Integer read FADC_CODDIM write setFADC_CODDIM;

    [FieldName('ADC_NUMERO')]
    property Numero: String read FADC_NUMERO write setFADC_NUMERO;

    [FieldName('ADC_SEQUENCIA')]
    property Sequencia: String read FADC_SEQUENCIA write setFADC_SEQUENCIA;

    [FieldName('ADC_CODFAB')]
    property CodigoFabricante: String read FADC_CODFAB write setFADC_CODFAB;

    [FieldName('ADC_VL_DESC')]
    property ValorDesconto: String read FADC_VL_DESC write setFADC_VL_DESC;

    [FieldName('ADC_PEDCPA')]
    property CodigoCompra: String read FADC_PEDCPA write setFADC_PEDCPA;

    [FieldName('ADC_ITMCPA')]
    property CodigoItemCompra: String read FADC_ITMCPA write setFADC_ITMCPA;

  End;

implementation

{ TAdicaoImportacao }

procedure TAdicaoImportacao.setFADC_CODDIM(Value: INTEGER);
begin
  FADC_CODDIM := Value;
end;

procedure TAdicaoImportacao.setFADC_CODFAB(Value: String);
begin
  FADC_CODFAB := Value;
end;

procedure TAdicaoImportacao.setFADC_CODIGO(Value: INTEGER);
begin
  FADC_CODIGO := Value;
end;

procedure TAdicaoImportacao.setFADC_ITMCPA(Value: String);
begin
  FADC_ITMCPA := Value;
end;

procedure TAdicaoImportacao.setFADC_NUMERO(Value: String);
begin
  FADC_NUMERO := Value;
end;

procedure TAdicaoImportacao.setFADC_PEDCPA(Value: String);
begin
  FADC_PEDCPA := Value;
end;

procedure TAdicaoImportacao.setFADC_SEQUENCIA(Value: String);
begin
  FADC_SEQUENCIA := Value;
end;

procedure TAdicaoImportacao.setFADC_VL_DESC(Value: String);
begin
  FADC_VL_DESC := Value;
end;

end.
