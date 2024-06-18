unit tblPais;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_PAIS')]
  TPais = Class(TGenericEntity)
  private
    FPAI_DESCRICAO: String;
    FPAI_CODBACEN: Integer;
    FPAI_CODIGO: integer;
    procedure setFPAI_CODBACEN(const Value: Integer);
    procedure setFPAI_CODIGO(const Value: integer);
    procedure setFPAI_DESCRICAO(const Value: String);


  public


    [FieldName('PAI_CODIGO')]
    property Codigo: integer read FPAI_CODIGO write setFPAI_CODIGO;

    [KeyField('PAI_CODBACEN')]
    [FieldName('PAI_CODBACEN')]
    property Bacen: Integer read FPAI_CODBACEN write setFPAI_CODBACEN;

    [FieldName('PAI_DESCRICAO')]
    property Descricao: String read FPAI_DESCRICAO write setFPAI_DESCRICAO;

  End;


implementation

{ TPais }

procedure TPais.setFPAI_CODBACEN(const Value: Integer);
begin
  FPAI_CODBACEN := Value;
end;

procedure TPais.setFPAI_CODIGO(const Value: integer);
begin
  FPAI_CODIGO := Value;
end;

procedure TPais.setFPAI_DESCRICAO(const Value: String);
begin
  FPAI_DESCRICAO := Value;
end;

end.
