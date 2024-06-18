unit tblCtrlLote;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CTRL_LOTE')]
  TCtrlLote = Class(TGenericEntity)
  private
    FCLT_CODPRO: Integer;
    FCLT_CODIGO: Integer;
    FCLT_QT_SAIDA: Real;
    FCLT_DT_VENCIMENTO: TDate;
    FCLT_NUMERO: String;
    FCLT_CODEMP: Integer;
    FCLT_CODMHA: Integer;
    FCLT_QT_SALDO: REal;
    FCLT_QT_ENTRADA: Real;
    FCLT_CODMRC: Integer;
    FCLT_CERTIFICADO: String;
    FCLT_ESTOQUE: String;
    procedure setFCLT_CERTIFICADO(const Value: String);
    procedure setFCLT_CODEMP(const Value: Integer);
    procedure setFCLT_CODIGO(const Value: Integer);
    procedure setFCLT_CODMHA(const Value: Integer);
    procedure setFCLT_CODMRC(const Value: Integer);
    procedure setFCLT_CODPRO(const Value: Integer);
    procedure setFCLT_DT_VENCIMENTO(const Value: TDate);
    procedure setFCLT_NUMERO(const Value: String);
    procedure setFCLT_QT_ENTRADA(const Value: Real);
    procedure setFCLT_QT_SAIDA(const Value: Real);
    procedure setFCLT_QT_SALDO(const Value: REal);
    procedure setFCLT_ESTOQUE(const Value: String);


  public

    [KeyField('CLT_CODIGO')]
    [FieldName('CLT_CODIGO')]
    property Codigo: Integer read FCLT_CODIGO write setFCLT_CODIGO;

    [KeyField('CLT_CODMHA')]
    [FieldName('CLT_CODMHA')]
    property Estabelecimento: Integer read FCLT_CODMHA write setFCLT_CODMHA;

    [FieldName('CLT_CODEMP')]
    property Empresa: Integer read FCLT_CODEMP write setFCLT_CODEMP;

    [FieldName('CLT_NUMERO')]
    property Numero: String read FCLT_NUMERO write setFCLT_NUMERO;

    [FieldName('CLT_CERTIFICADO')]
    property Certificado: String read FCLT_CERTIFICADO write setFCLT_CERTIFICADO;

    [FieldName('CLT_CODPRO')]
    property Produto: Integer read FCLT_CODPRO write setFCLT_CODPRO;

    [FieldName('CLT_DT_VENCIMENTO')]
    property Vencimento: TDate read FCLT_DT_VENCIMENTO write setFCLT_DT_VENCIMENTO;

    [FieldName('CLT_QT_ENTRADA')]
    property QtdeEntrada: Real read FCLT_QT_ENTRADA write setFCLT_QT_ENTRADA;

    [FieldName('CLT_QT_SAIDA')]
    property QtdeSaida: Real read FCLT_QT_SAIDA write setFCLT_QT_SAIDA;

    [FieldName('CLT_QT_SALDO')]
    property Saldo: REal read FCLT_QT_SALDO write setFCLT_QT_SALDO;

    [FieldName('CLT_CODMRC')]
    property Marca: Integer read FCLT_CODMRC write setFCLT_CODMRC;

    [FieldName('CLT_ESTOQUE')]
    property AtualizaEstoque : String read FCLT_ESTOQUE write setFCLT_ESTOQUE;

  End;

implementation

{ TCtrlLote }

procedure TCtrlLote.setFCLT_CERTIFICADO(const Value: String);
begin
  FCLT_CERTIFICADO := Value;
end;

procedure TCtrlLote.setFCLT_CODEMP(const Value: Integer);
begin
  FCLT_CODEMP := Value;
end;

procedure TCtrlLote.setFCLT_CODIGO(const Value: Integer);
begin
  FCLT_CODIGO := Value;
end;

procedure TCtrlLote.setFCLT_CODMHA(const Value: Integer);
begin
  FCLT_CODMHA := Value;
end;

procedure TCtrlLote.setFCLT_CODMRC(const Value: Integer);
begin
  FCLT_CODMRC := Value;
end;

procedure TCtrlLote.setFCLT_CODPRO(const Value: Integer);
begin
  FCLT_CODPRO := Value;
end;

procedure TCtrlLote.setFCLT_DT_VENCIMENTO(const Value: TDate);
begin
  FCLT_DT_VENCIMENTO := Value;
end;

procedure TCtrlLote.setFCLT_ESTOQUE(const Value: String);
begin
  FCLT_ESTOQUE := Value;
end;

procedure TCtrlLote.setFCLT_NUMERO(const Value: String);
begin
  FCLT_NUMERO := Value;
end;

procedure TCtrlLote.setFCLT_QT_ENTRADA(const Value: Real);
begin
  FCLT_QT_ENTRADA := Value;
end;

procedure TCtrlLote.setFCLT_QT_SAIDA(const Value: Real);
begin
  FCLT_QT_SAIDA := Value;
end;

procedure TCtrlLote.setFCLT_QT_SALDO(const Value: REal);
begin
  FCLT_QT_SALDO := Value;
end;

end.
