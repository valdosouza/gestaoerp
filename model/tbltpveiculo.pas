unit tbltpveiculo;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_TP_VEICULO')]
  TTpVeiculo = Class(TGenericEntity)
  private
    FTPV_DESCRICAO: String;
    FTPV_CODIGO: Integer;
    FTPV_RENAVAM: String;
    procedure setFTPV_CODIGO(const Value: Integer);
    procedure setFTPV_DESCRICAO(const Value: String);
    procedure setFTPV_RENAVAM(const Value: String);

  public
    [KeyField('TPV_CODIGO')]
    [FieldName('TPV_CODIGO')]
    property Codigo: Integer read FTPV_CODIGO write setFTPV_CODIGO;

    [FieldName('TPV_RENAVAM')]
    property Renavam: String read FTPV_RENAVAM write setFTPV_RENAVAM;

    [FieldName('TPV_DESCRICAO')]
    property Descricao: String read FTPV_DESCRICAO write setFTPV_DESCRICAO;
  End;

implementation


procedure TTpVeiculo.setFTPV_CODIGO(const Value: Integer);
begin
  FTPV_CODIGO := Value;
end;

procedure TTpVeiculo.setFTPV_DESCRICAO(const Value: String);
begin
  FTPV_DESCRICAO := Value;
end;

procedure TTpVeiculo.setFTPV_RENAVAM(const Value: String);
begin
  FTPV_RENAVAM := Value;
end;

end.
