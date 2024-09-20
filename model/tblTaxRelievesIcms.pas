unit tblTaxRelievesIcms;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_DESONERA_ICMS')]
  TTaxRelievesIcms = Class(TGenericEntity)

  private
    FDSI_CODIGO: Integer;
    FDSI_DESCRICAO: String;
    procedure setFDSI_CODIGO(const Value: Integer);
    procedure setFDSI_DESCRICAO(const Value: String);
  public
    [KeyField('DSI_CODIGO')]
    [FieldName('DSI_CODIGO')]
    property Codigo: Integer read FDSI_CODIGO write setFDSI_CODIGO;

    [FieldName('DSI_DESCRICAO')]
    property Descricao: String read FDSI_DESCRICAO write setFDSI_DESCRICAO;
  End;

implementation

{ TTaxRelievesIcms }

procedure TTaxRelievesIcms.setFDSI_CODIGO(const Value: Integer);
begin
  FDSI_CODIGO := Value;
end;

procedure TTaxRelievesIcms.setFDSI_DESCRICAO(const Value: String);
begin
  FDSI_DESCRICAO := Value;
end;

end.
