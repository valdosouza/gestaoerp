unit tblrecibo;

interface

Uses GenericEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RECIBO')]
  TRecibo = Class(TGenericEntity)
  private
    FREC_CODQTC: Integer;
    FREC_OBS: String;
    FREC_SACADO: String;
    FREC_VALOR: Real;
    FREC_CODIGO: Integer;
    FREC_EMITENTE: String;
    FREC_NUMERO: Integer;
    FREC_CODMHA: Integer;
    FREC_DATA: TDate;
    procedure setFREC_CODIGO(const Value: Integer);
    procedure setFREC_CODMHA(const Value: Integer);
    procedure setFREC_CODQTC(const Value: Integer);
    procedure setFREC_DATA(const Value: TDate);
    procedure setFREC_EMITENTE(const Value: String);
    procedure setFREC_NUMERO(const Value: Integer);
    procedure setFREC_OBS(const Value: String);
    procedure setFREC_SACADO(const Value: String);
    procedure setFREC_VALOR(const Value: Real);

  public
    [KeyField('REC_CODIGO')]
    [FieldName('REC_CODIGO')]
    property Codigo: Integer read FREC_CODIGO write setFREC_CODIGO;

    [KeyField('REC_CODMHA')]
    [FieldName('REC_CODMHA')]
    property Estabelecimento: Integer read FREC_CODMHA write setFREC_CODMHA;

    [FieldName('REC_DATA')]
    property Data: TDate read FREC_DATA write setFREC_DATA;

    [FieldName('REC_NUMERO')]
    property Numero: Integer read FREC_NUMERO write setFREC_NUMERO;

    [FieldName('REC_VALOR')]
    property Valor: Real read FREC_VALOR write setFREC_VALOR;

    [FieldName('REC_SACADO')]
    property Sacado: String read FREC_SACADO write setFREC_SACADO;

    [FieldName('REC_EMITENTE')]
    property Emitente: String read FREC_EMITENTE write setFREC_EMITENTE;

    [FieldName('REC_CODQTC')]
    property CodigoQuitacao: Integer read FREC_CODQTC write setFREC_CODQTC;

    [FieldName('REC_OBS')]
    property Referencia: String read FREC_OBS write setFREC_OBS;

  End;

implementation


{ TRecibo }

procedure TRecibo.setFREC_CODIGO(const Value: Integer);
begin
  FREC_CODIGO := Value;
end;

procedure TRecibo.setFREC_CODMHA(const Value: Integer);
begin
  FREC_CODMHA := Value;
end;

procedure TRecibo.setFREC_CODQTC(const Value: Integer);
begin
  FREC_CODQTC := Value;
end;

procedure TRecibo.setFREC_DATA(const Value: TDate);
begin
  FREC_DATA := Value;
end;

procedure TRecibo.setFREC_EMITENTE(const Value: String);
begin
  FREC_EMITENTE := Value;
end;

procedure TRecibo.setFREC_NUMERO(const Value: Integer);
begin
  FREC_NUMERO := Value;
end;

procedure TRecibo.setFREC_OBS(const Value: String);
begin
  FREC_OBS := Value;
end;

procedure TRecibo.setFREC_SACADO(const Value: String);
begin
  FREC_SACADO := Value;
end;

procedure TRecibo.setFREC_VALOR(const Value: Real);
begin
  FREC_VALOR := Value;
end;

end.
