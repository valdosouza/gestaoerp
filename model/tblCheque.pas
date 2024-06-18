unit tblCheque;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_cheques')]
  TCheque = Class(TGenericEntity)
  private
    FCHQ_CODFOR: Integer;
    FCHQ_CODMHA: Integer;
    FCHQ_RETORNO: TDate;
    FCHQ_VALOR: Real;
    FCHQ_QT_PAG: Integer;
    FCHQ_CODIGO: Integer;
    FCHQ_CONTA: String;
    FCHQ_DEVOLVIDO: String;
    FCHQ_EMITENTE: String;
    FCHQ_NUMERO: String;
    FCHQ_NR_BANCO: Integer;
    FCHQ_QT_REC: Integer;
    FCHQ_VL_AMORT: Real;
    FCHQ_AGENCIA: String;
    FCHQ_TIPO: String;
    FCHQ_ESTADO: String;
    FCHQ_DATA: TDate;
    FCHQ_DT_QUITACAO: TDate;

    procedure setFCHQ_CODIGO( Value : INTEGER);
    procedure setFCHQ_EMITENTE( Value : String);
    procedure setFCHQ_NR_BANCO( Value : INTEGER);
    procedure setFCHQ_AGENCIA( Value : String);
    procedure setFCHQ_NUMERO( Value : String);
    procedure setFCHQ_VALOR( Value : Real);
    procedure setFCHQ_DATA( Value : TDate);
    procedure setFCHQ_DEVOLVIDO( Value : String);
    procedure setFCHQ_DT_QUITACAO( Value : TDate);
    procedure setFCHQ_TIPO( Value : String);
    procedure setFCHQ_ESTADO( Value : String);
    procedure setFCHQ_RETORNO( Value : TDate);
    procedure setFCHQ_VL_AMORT( Value : Real);
    procedure setFCHQ_QT_REC( Value : INTEGER);
    procedure setFCHQ_QT_PAG( Value : INTEGER);
    procedure setFCHQ_CODFOR( Value : INTEGER);
    procedure setFCHQ_CONTA( Value : String);
    procedure setFCHQ_CODMHA( Value : INTEGER);


  public

    [KeyField('CHQ_CODIGO')]
    [FieldName('CHQ_CODIGO')]
    property Codigo: Integer read FCHQ_CODIGO write setFCHQ_CODIGO;

    [FieldName('CHQ_EMITENTE')]
    property Emitente: String read FCHQ_EMITENTE write setFCHQ_EMITENTE;

    [FieldName('CHQ_NR_BANCO')]
    property NumeroBanco: Integer read FCHQ_NR_BANCO write setFCHQ_NR_BANCO;

    [FieldName('CHQ_AGENCIA')]
    property Agencia: String read FCHQ_AGENCIA write setFCHQ_AGENCIA;

    [FieldName('CHQ_NUMERO')]
    property Numero: String read FCHQ_NUMERO write setFCHQ_NUMERO;

    [FieldName('CHQ_VALOR')]
    property Valor: Real read FCHQ_VALOR write setFCHQ_VALOR;

    [FieldName('CHQ_DATA')]
    property Data: TDate read FCHQ_DATA write setFCHQ_DATA;

    [FieldName('CHQ_DEVOLVIDO')]
    property Devolvido: String read FCHQ_DEVOLVIDO write setFCHQ_DEVOLVIDO;

    [FieldName('CHQ_DT_QUITACAO')]
    property DataQuitacao: TDate read FCHQ_DT_QUITACAO write setFCHQ_DT_QUITACAO;

    [FieldName('CHQ_TIPO')]
    property Tipo: String read FCHQ_TIPO write setFCHQ_TIPO;

    [FieldName('CHQ_ESTADO')]
    property Estado: String read FCHQ_ESTADO write setFCHQ_ESTADO;

    [FieldName('CHQ_RETORNO')]
    property DataRetorno: TDate read FCHQ_RETORNO write setFCHQ_RETORNO;

    [FieldName('CHQ_VL_AMORT')]
    property ValorAmortizado: Real read FCHQ_VL_AMORT write setFCHQ_VL_AMORT;

    [FieldName('CHQ_QT_REC')]
    property QuitacaoRecebimento: Integer read FCHQ_QT_REC write setFCHQ_QT_REC;

    [FieldName('CHQ_QT_PAG')]
    property QuitacaoPagamento: Integer read FCHQ_QT_PAG write setFCHQ_QT_PAG;

    [FieldName('CHQ_CODFOR')]
    property CodigoFornecedor: Integer read FCHQ_CODFOR write setFCHQ_CODFOR;

    [FieldName('CHQ_CONTA')]
    property ContaCorrente: String read FCHQ_CONTA write setFCHQ_CONTA;

    [KeyField('CHQ_CODMHA')]
    [FieldName('CHQ_CODMHA')]
    property CodigoEstabelecimento: Integer read FCHQ_CODMHA write setFCHQ_CODMHA;

  End;

implementation

{ TCheque }

procedure TCheque.setFCHQ_AGENCIA(Value: String);
begin
  FCHQ_AGENCIA := Value;
end;

procedure TCheque.setFCHQ_CODFOR(Value: INTEGER);
begin
  FCHQ_CODFOR := Value;
end;

procedure TCheque.setFCHQ_CODIGO(Value: INTEGER);
begin
  FCHQ_CODIGO := Value;
end;

procedure TCheque.setFCHQ_CODMHA(Value: INTEGER);
begin
  FCHQ_CODMHA := Value;
end;

procedure TCheque.setFCHQ_CONTA(Value: String);
begin
  FCHQ_CONTA := Value;
end;

procedure TCheque.setFCHQ_DATA(Value: TDate);
begin
  FCHQ_DATA := Value;
end;

procedure TCheque.setFCHQ_DEVOLVIDO(Value: String);
begin
  FCHQ_DEVOLVIDO := Value;
end;

procedure TCheque.setFCHQ_DT_QUITACAO(Value: TDate);
begin
  FCHQ_DT_QUITACAO := Value;
end;

procedure TCheque.setFCHQ_EMITENTE(Value: String);
begin
  FCHQ_EMITENTE := Value;
end;

procedure TCheque.setFCHQ_ESTADO(Value: String);
begin
  FCHQ_ESTADO := Value;
end;

procedure TCheque.setFCHQ_NR_BANCO(Value: INTEGER);
begin
  FCHQ_NR_BANCO := Value;
end;

procedure TCheque.setFCHQ_NUMERO(Value: String);
begin
  FCHQ_NUMERO := Value;
end;

procedure TCheque.setFCHQ_QT_PAG(Value: INTEGER);
begin
  FCHQ_QT_PAG := Value;
end;

procedure TCheque.setFCHQ_QT_REC(Value: INTEGER);
begin
  FCHQ_QT_REC := Value;
end;

procedure TCheque.setFCHQ_RETORNO(Value: TDate);
begin
  FCHQ_RETORNO := Value;
end;

procedure TCheque.setFCHQ_TIPO(Value: String);
begin
  FCHQ_TIPO := Value;
end;

procedure TCheque.setFCHQ_VALOR(Value: Real);
begin
  FCHQ_VALOR := Value;
end;

procedure TCheque.setFCHQ_VL_AMORT(Value: Real);
begin
  FCHQ_VL_AMORT := Value;
end;

end.
