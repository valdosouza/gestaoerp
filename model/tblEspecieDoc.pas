unit tblEspecieDoc;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_especie_doc')]
  TEspecieDoc = Class(TGenericEntity)
  private
    FEPD_CODIGO : Integer;
    FEPD_SIGLA : String;
    FEPD_NUMERO : String;
    FEPD_DESCRICAO : String;

    procedure setFEPD_CODIGO( Value : Integer);
    procedure setFEPD_SIGLA( Value : String);
    procedure setFEPD_NUMERO( Value : String);
    procedure setFEPD_DESCRICAO( Value : String);

  public
    [KeyField('EPD_CODIGO')]
    [FieldName('EPD_CODIGO')]
    property Codigo: Integer read FEPD_CODIGO write setFEPD_CODIGO;
    [FieldName('EPD_SIGLA')]
    property Sigla: String read FEPD_SIGLA write setFEPD_SIGLA;
    [FieldName('EPD_NUMERO')]
    property Numero: String read FEPD_NUMERO write setFEPD_NUMERO;
    [FieldName('EPD_DESCRICAO')]
    property Descricao: String read FEPD_DESCRICAO write setFEPD_DESCRICAO;

  End;
implementation

{ TEspecieDoc }

procedure TEspecieDoc.setFEPD_CODIGO(Value: Integer);
begin
  FEPD_CODIGO := Value;
end;

procedure TEspecieDoc.setFEPD_DESCRICAO(Value: String);
begin
  FEPD_DESCRICAO := Value;
end;

procedure TEspecieDoc.setFEPD_NUMERO(Value: String);
begin
  FEPD_NUMERO := Value;
end;

procedure TEspecieDoc.setFEPD_SIGLA(Value: String);
begin
  FEPD_SIGLA := Value;
end;

end.
