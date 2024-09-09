unit tblmarcaproduto;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MARCA_PRODUTO')]
  TMarcaProduto = Class(TGenericEntity)
  private
    FMRC_CODFAB: Integer;
    FMRC_DESCRICAO: String;
    FMRC_CODIGO: Integer;
    procedure setFMRC_CODFAB(const Value: Integer);
    procedure setFMRC_CODIGO(const Value: Integer);
    procedure setFMRC_DESCRICAO(const Value: String);


  public

    [KeyField('MRC_CODIGO')]
    [FieldName('MRC_CODIGO')]
    property Codigo: Integer read FMRC_CODIGO write setFMRC_CODIGO;

    [FieldName('MRC_DESCRICAO')]
    property Descricao: String read FMRC_DESCRICAO write setFMRC_DESCRICAO;

    [FieldName('MRC_CODFAB')]
    property Fabrica: Integer read FMRC_CODFAB write setFMRC_CODFAB;

  End;

implementation

{ TMarcaProduto }

procedure TMarcaProduto.setFMRC_CODFAB(const Value: Integer);
begin
  FMRC_CODFAB := Value;
end;

procedure TMarcaProduto.setFMRC_CODIGO(const Value: Integer);
begin
  FMRC_CODIGO := Value;
end;

procedure TMarcaProduto.setFMRC_DESCRICAO(const Value: String);
begin
  FMRC_DESCRICAO := Value;
end;

end.
