unit tblOperInterface;

interface

Uses TEntity, CAtribEntity, System.Classes;

Type
  [TableName('TB_OPER_INTERFACE')]
  TOperInterface = Class(TGenericEntity)
  private
    FOPF_DESCRICAO: String;
    FOPF_CODIGO: Integer;
    FOPF_IMAGEM: TStream;
    procedure setFOPF_CODIGO(const Value: Integer);
    procedure setFOPF_DESCRICAO(const Value: String);
    procedure setFOPF_IMAGEM(const Value: TStream);

  public
    [KeyField('OPF_CODIGO')]
    [FieldName('OPF_CODIGO')]
    property Codigo: Integer read FOPF_CODIGO write setFOPF_CODIGO;

    [FieldName('OPF_DESCRICAO')]
    property Descricao: String read FOPF_DESCRICAO write setFOPF_DESCRICAO;

    //[FieldName('OPF_IMAGEM')]
    //property Imagem: TStream read FOPF_IMAGEM write setFOPF_IMAGEM;
  End;
{CREATE TABLE TB_OPER_INTERFACE (
    OPF_CODIGO     "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    OPF_DESCRICAO  "Descricao_30" /* "Descricao_30" = VARCHAR(30) */,
    OPF_IMAGEM     "Observacao" /* "Observacao" = BLOB SUB_TYPE 0 SEGMENT SIZE 80 */
);
ALTER TABLE TB_OPER_INTERFACE ADD PRIMARY KEY (OPF_CODIGO);

    object FDTable1OPF_IMAGEM: TBlobField
      FieldName = 'OPF_IMAGEM'
      Origin = 'OPF_IMAGEM'
    end

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

procedure TOperInterface.setFOPF_IMAGEM(const Value: TStream);
begin
  FOPF_IMAGEM := Value;
end;

end.
