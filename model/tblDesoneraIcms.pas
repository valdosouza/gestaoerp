unit tblDesoneraIcms;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_DESONERA_ICMS')]
  TCargo = Class(TGenericEntity)
  private
    FCRG_DESCRICAO: String;
    FCRG_CODIGO: Integer;

    procedure setFCRG_CODIGO(const Value: Integer);
    procedure setFCRG_DESCRICAO(const Value: String);
  public
    [KeyField('CRG_CODIGO')]
    [FieldName('CRG_CODIGO')]
    property Codigo: Integer read FCRG_CODIGO write setFCRG_CODIGO;

    [FieldName('CRG_DESCRICAO')]
    property Descricao: String read FCRG_DESCRICAO write setFCRG_DESCRICAO;
  End;

implementation

{ TCargo }

procedure TCargo.setFCRG_CODIGO(const Value: Integer);
begin
  FCRG_CODIGO := Value;
end;

procedure TCargo.setFCRG_DESCRICAO(const Value: String);
begin
  FCRG_DESCRICAO := Value;
end;

end.
