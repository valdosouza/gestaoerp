unit tblTabelaPreco;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_tabela_preco')]
  TTabelaPreco = Class(TGenericEntity)
  private
    FTPR_MOBILE: String;
    FTPR_PRINCIPAL: String;
    FTPR_NOME: String;
    FTPR_CODIGO: Integer;
    FTPR_MAR_LRC: Real;
    FTPR_CODEMP: Integer;
    FTPR_MODALIDADE: String;
    FTPR_VALIDADE: TDate;
    FTPR_TIPO_CLIENTE: String;
    FTPR_CASA_DECIMAL: Integer;
    FTPR_LOJISTA: String;
    FTPR_ATIVA: String;
    FTPR_MAR_PRIORITARIA: String;
    FTPR_MAR_VIA_ESCALA: Real;
    procedure setFTPR_CODEMP(const Value: Integer);
    procedure setFTPR_CODIGO(const Value: Integer);
    procedure setFTPR_MAR_LRC(const Value: Real);
    procedure setFTPR_MOBILE(const Value: String);
    procedure setFTPR_MODALIDADE(const Value: String);
    procedure setFTPR_NOME(const Value: String);
    procedure setFTPR_PRINCIPAL(const Value: String);
    procedure setFTPR_VALIDADE(const Value: TDate);
    procedure setFTPR_TIPO_CLIENTE(const Value: String);
    procedure setFTPR_CASA_DECIMAL(const Value: Integer);
    procedure setFTPR_LOJISTA(const Value: String);
    procedure setFTPR_ATIVA(const Value: String);
    procedure setFTPR_MAR_PRIORITARIA(const Value: String);
    procedure setFTPR_MAR_VIA_ESCALA(const Value: Real);



  public

    [KeyField('TPR_CODIGO')]
    [FieldName('TPR_CODIGO')]
    property Codigo: Integer read FTPR_CODIGO write setFTPR_CODIGO;

    [FieldName('TPR_CODEMP')]
    property Estabelecimento: Integer read FTPR_CODEMP write setFTPR_CODEMP;

    [FieldName('TPR_NOME')]
    property Descricao: String read FTPR_NOME write setFTPR_NOME;

    [FieldName('TPR_VALIDADE')]
    property Validade: TDate read FTPR_VALIDADE write setFTPR_VALIDADE;

    [FieldName('TPR_MODALIDADE')]
    property Modalidade: String read FTPR_MODALIDADE write setFTPR_MODALIDADE;

    [FieldName('TPR_MAR_LRC')]
    property MargemLucro: Real read FTPR_MAR_LRC write setFTPR_MAR_LRC;

    [FieldName('TPR_PRINCIPAL')]
    property Principal: String read FTPR_PRINCIPAL write setFTPR_PRINCIPAL;

    [FieldName('TPR_MOBILE')]
    property Mobile: String read FTPR_MOBILE write setFTPR_MOBILE;

    [FieldName('TPR_TIPO_CLIENTE')]
    property TipoCliente: String read FTPR_TIPO_CLIENTE write setFTPR_TIPO_CLIENTE;

    [FieldName('TPR_CASA_DECIMAL')]
    property CasaDecimal: Integer read FTPR_CASA_DECIMAL write setFTPR_CASA_DECIMAL;

    [FieldName('TPR_LOJISTA')]
    property Lojista: String read FTPR_LOJISTA write setFTPR_LOJISTA;

    [FieldName('TPR_ATIVA')]
    property Ativa: String read FTPR_ATIVA write setFTPR_ATIVA;

    [FieldName('TPR_MAR_PRIORITARIA')]
    property MargemPrioritaria: String read FTPR_MAR_PRIORITARIA write setFTPR_MAR_PRIORITARIA;

    [FieldName('TPR_MAR_VIA_ESCALA')]
    property MargemViaEscala: Real read FTPR_MAR_VIA_ESCALA write setFTPR_MAR_VIA_ESCALA;

  End;

implementation



{ TTabelaPreco }

procedure TTabelaPreco.setFTPR_ATIVA(const Value: String);
begin
  FTPR_ATIVA := Value;
end;

procedure TTabelaPreco.setFTPR_CASA_DECIMAL(const Value: Integer);
begin
  FTPR_CASA_DECIMAL := Value;
end;

procedure TTabelaPreco.setFTPR_CODEMP(const Value: Integer);
begin
  FTPR_CODEMP := Value;
end;

procedure TTabelaPreco.setFTPR_CODIGO(const Value: Integer);
begin
  FTPR_CODIGO := Value;
end;

procedure TTabelaPreco.setFTPR_LOJISTA(const Value: String);
begin
  FTPR_LOJISTA := Value;
end;

procedure TTabelaPreco.setFTPR_MAR_LRC(const Value: Real);
begin
  FTPR_MAR_LRC := Value;
end;

procedure TTabelaPreco.setFTPR_MAR_PRIORITARIA(const Value: String);
begin
  FTPR_MAR_PRIORITARIA := Value;
end;

procedure TTabelaPreco.setFTPR_MAR_VIA_ESCALA(const Value: Real);
begin
  FTPR_MAR_VIA_ESCALA := Value;
end;

procedure TTabelaPreco.setFTPR_MOBILE(const Value: String);
begin
  FTPR_MOBILE := Value;
end;

procedure TTabelaPreco.setFTPR_MODALIDADE(const Value: String);
begin
  FTPR_MODALIDADE := Value;
end;

procedure TTabelaPreco.setFTPR_NOME(const Value: String);
begin
  FTPR_NOME := Value;
end;

procedure TTabelaPreco.setFTPR_PRINCIPAL(const Value: String);
begin
  FTPR_PRINCIPAL := Value;
end;

procedure TTabelaPreco.setFTPR_TIPO_CLIENTE(const Value: String);
begin
  FTPR_TIPO_CLIENTE := Value;
end;

procedure TTabelaPreco.setFTPR_VALIDADE(const Value: TDate);
begin
  FTPR_VALIDADE := Value;
end;

end.
