unit tblKindLucratividade;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_KIND_LUCRATIVIDADE')]
  TKindLucratividade = Class(TGenericEntity)

  private
    Fid: Integer;
    Fdescription: String;

    procedure setdescription(const Value: String);
    procedure setid(const Value: Integer);
  public
    [FieldName('id')]
    [KeyField('id')]
    property codigo: Integer read Fid write setid;

    [KeyField('description')]
    [FieldName('description')]
    property descricao: String read Fdescription write setdescription;
  End;

implementation

procedure TKindLucratividade.setdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TKindLucratividade.setid(const Value: Integer);
begin
  Fid := Value;
end;

end.
