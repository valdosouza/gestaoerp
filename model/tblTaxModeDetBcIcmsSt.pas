unit tblTaxModeDetBcIcmsSt;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_MOD_DET_BC_ICMS_ST')]
  TTaxModeDetBcIcmsSt = Class(TGenericEntity)
  private
    FMDB_DESCRICAO: String;
    FMDB_CODIGO: Integer;
    FMDB_GRUPO: String;
    procedure setFMDB_CODIGO(const Value: Integer);
    procedure setFMDB_DESCRICAO(const Value: String);
    procedure setFMDB_GRUPO(const Value: String);
  public
    [KeyField('MDB_CODIGO')]
    [FieldName('MDB_CODIGO')]
    property Codigo: Integer read FMDB_CODIGO write setFMDB_CODIGO;

    [FieldName('MDB_GRUPO')]
    property Grupo: String read FMDB_GRUPO write setFMDB_GRUPO;

    [FieldName('MDB_DESCRICAO')]
    property Descricao: String read FMDB_DESCRICAO write setFMDB_DESCRICAO;
  End;
implementation


procedure TTaxModeDetBcIcmsSt.setFMDB_CODIGO(const Value: Integer);
begin
  FMDB_CODIGO := Value;
end;

procedure TTaxModeDetBcIcmsSt.setFMDB_DESCRICAO(const Value: String);
begin
  FMDB_DESCRICAO := Value;
end;

procedure TTaxModeDetBcIcmsSt.setFMDB_GRUPO(const Value: String);
begin
  FMDB_GRUPO := Value;
end;

end.
