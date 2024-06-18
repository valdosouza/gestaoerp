unit tblCustoPedido;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CUSTO_PEDIDO')]
  TCustoPedido = Class(TGenericEntity)
  private
    FCTP_CODIGO : Integer;
    FCTP_CODPED : Integer;
    FCTP_CODITF : Integer;
    FCTP_CODPRO : Integer;
    FCTP_DESCRICAO : String;
    FCTP_BS_CALCULO : Real;
    FCTP_VL_ORIG : Real;
    FCTP_COTACAO : Real;
    FCTP_VL_REAL : Real;
    FCTP_ORIGEM : String;

    procedure setFCTP_BS_CALCULO(const Value: Real);
    procedure setFCTP_CODIGO(const Value: Integer);
    procedure setFCTP_CODPED(const Value: Integer);
    procedure setFCTP_COTACAO(const Value: Real);
    procedure setFCTP_DESCRICAO(const Value: String);
    procedure setFCTP_VL_ORIG(const Value: Real);
    procedure setFCTP_VL_REAL(const Value: Real);
    procedure setFCTP_CODPRO(const Value: Integer);
    procedure setFCTP_ORIGEM(const Value: String);
    procedure setFCTP_CODITF(const Value: Integer);

  public

    [KeyField('CTP_CODIGO')]
    [FieldName('CTP_CODIGO')]
    property Codigo: Integer read FCTP_CODIGO write setFCTP_CODIGO;

    [KeyField('CTP_CODPED')]
    [FieldName('CTP_CODPED')]
    property CodigoPedido: Integer read FCTP_CODPED write setFCTP_CODPED;

    [FieldName('CTP_CODITF')]
    property ItemPedido: Integer read FCTP_CODITF write setFCTP_CODITF;

    [FieldName('CTP_CODPRO')]
    property CodigoProduto: Integer read FCTP_CODPRO write setFCTP_CODPRO;

    [FieldName('CTP_DESCRICAO')]
    property Descricao: String read FCTP_DESCRICAO write setFCTP_DESCRICAO;

    [FieldName('CTP_BS_CALCULO')]
    property BaseCalculo: Real read FCTP_BS_CALCULO write setFCTP_BS_CALCULO;

    [FieldName('CTP_VL_ORIG')]
    property ValorOriginal: Real read FCTP_VL_ORIG write setFCTP_VL_ORIG;

    [FieldName('CTP_COTACAO')]
    property Cotacao: Real read FCTP_COTACAO write setFCTP_COTACAO;

    [FieldName('CTP_VL_REAL')]
    property ValorReal: Real read FCTP_VL_REAL write setFCTP_VL_REAL;

    [FieldName('CTP_ORIGEM')]
    property OrigemLancamento: String read FCTP_ORIGEM write setFCTP_ORIGEM;

  End;

implementation

{ TCustoPedido }

procedure TCustoPedido.setFCTP_BS_CALCULO(const Value: Real);
begin
  FCTP_BS_CALCULO := Value;
end;

procedure TCustoPedido.setFCTP_CODIGO(const Value: Integer);
begin
  FCTP_CODIGO := Value;
end;

procedure TCustoPedido.setFCTP_CODITF(const Value: Integer);
begin
  FCTP_CODITF := Value;
end;

procedure TCustoPedido.setFCTP_CODPED(const Value: Integer);
begin
  FCTP_CODPED := Value;
end;

procedure TCustoPedido.setFCTP_CODPRO(const Value: Integer);
begin
  FCTP_CODPRO := Value;
end;

procedure TCustoPedido.setFCTP_COTACAO(const Value: Real);
begin
  FCTP_COTACAO := Value;
end;

procedure TCustoPedido.setFCTP_DESCRICAO(const Value: String);
begin
  FCTP_DESCRICAO := Value;
end;

procedure TCustoPedido.setFCTP_ORIGEM(const Value: String);
begin
  FCTP_ORIGEM := Value;
end;

procedure TCustoPedido.setFCTP_VL_ORIG(const Value: Real);
begin
  FCTP_VL_ORIG := Value;
end;

procedure TCustoPedido.setFCTP_VL_REAL(const Value: Real);
begin
  FCTP_VL_REAL := Value;
end;

end.
