unit tblOperInterface;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_OPER_INTERFACE')]
  TOperInterface = Class(TGenericEntity)
  private
    FOPF_DESCRICAO: String;
    FOPF_CODIGO: Integer;
    procedure setFOPF_CODIGO(const Value: Integer);
    procedure setFOPF_DESCRICAO(const Value: String);

  public
    [KeyField('OPF_CODIGO')]
    [FieldName('OPF_CODIGO')]
    property Codigo: Integer read FOPF_CODIGO write setFOPF_CODIGO;

    [FieldName('OPF_DESCRICAO')]
    property Descricao: String read FOPF_DESCRICAO write setFOPF_DESCRICAO;
  End;
{CREATE TABLE TB_OPER_INTERFACE (
    OPF_CODIGO     "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    OPF_DESCRICAO  "Descricao_30" /* "Descricao_30" = VARCHAR(30) */,
    OPF_IMAGEM     "Observacao" /* "Observacao" = BLOB SUB_TYPE 0 SEGMENT SIZE 80 */
);
ALTER TABLE TB_OPER_INTERFACE ADD PRIMARY KEY (OPF_CODIGO);
}

implementation

{ TOperInterface }

procedure TOperInterface.setFOPF_CODIGO(const Value: Integer);
begin
  FOPF_CODIGO := Value;
end;

procedure TOperInterface.setFOPF_DESCRICAO(const Value: String);
begin
  FOPF_DESCRICAO := Value;
end;

end.
