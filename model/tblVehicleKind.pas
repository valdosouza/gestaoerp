unit tblVehicleKind;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_TP_VEICULO')]
  TVehicleKind = Class(TGenericEntity)

  private
    FTPV_DESCRICAO: String;
    FTPV_CODIGO: Integer;
    FTPV_RENAVAM: String;
    procedure setFPTPV_RENAVAM(const Value: String);
    procedure setFTPV_CODIGO(const Value: Integer);
    procedure setFTPV_DESCRICAO(const Value: String);

  public
    [KeyField('TPV_CODIGO')]
    [FieldName('TPV_CODIGO')]
    property Codigo: Integer read FTPV_CODIGO write setFTPV_CODIGO;

    [FieldName('TPV_RENAVAM')]
    property Renavam: String read FTPV_RENAVAM write setFPTPV_RENAVAM;

    [FieldName('TPV_DESCRICAO')]
    property Descricao: String read FTPV_DESCRICAO write setFTPV_DESCRICAO;

  End;

implementation

{ TVehicleKind }

procedure TVehicleKind.setFPTPV_RENAVAM(const Value: String);
begin
  FTPV_RENAVAM := Value;
end;

procedure TVehicleKind.setFTPV_CODIGO(const Value: Integer);
begin
  FTPV_CODIGO := Value;
end;

procedure TVehicleKind.setFTPV_DESCRICAO(const Value: String);
begin
  FTPV_DESCRICAO := Value;
end;

end.
