unit tblItensIFC;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_ITENS_IFC')]
  TItensIFC = Class(TGenericEntity)
  private
    FIIF_CODIFC: Integer;
    FIIF_CODIGO: Integer;
    FIIF_CODOPF: Integer;
    procedure setFIIF_CODIFC(const Value: Integer);
    procedure setFIIF_CODIGO(const Value: Integer);
    procedure setFIIF_CODOPF(const Value: Integer);
  public
    //No banco está como primary Key, mas nesta camada trataremos este campo apenas o sequenciamento
    [FieldName('IIF_CODIGO')]
    property Codigo: Integer read FIIF_CODIGO write setFIIF_CODIGO;

    [KeyField('IIF_CODIFC')]
    [FieldName('IIF_CODIFC')]
    property CodigoIfc: Integer read FIIF_CODIFC write setFIIF_CODIFC;

    [KeyField('IIF_CODOPF')]
    [FieldName('IIF_CODOPF')]
    property CodigoOpf: Integer read FIIF_CODOPF write setFIIF_CODOPF;
  End;
{CREATE TABLE TB_ITENS_IFC (
    IIF_CODIGO  "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    IIF_CODIFC  "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    IIF_CODOPF  "Codigo" /* "Codigo" = INTEGER NOT NULL */
);
/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/
ALTER TABLE TB_ITENS_IFC ADD PRIMARY KEY (IIF_CODIGO);
/******************************************************************************/
/****                             Foreign keys                             ****/
/******************************************************************************/
ALTER TABLE TB_ITENS_IFC ADD CONSTRAINT FK_TB_ITENS_IFC_1 FOREIGN KEY (IIF_CODOPF) REFERENCES TB_OPER_INTERFACE (OPF_CODIGO);
}

implementation

{ TCargo }

procedure TItensIFC.setFIIF_CODIFC(const Value: Integer);
begin
  FIIF_CODIFC := Value;
end;

procedure TItensIFC.setFIIF_CODIGO(const Value: Integer);
begin
  FIIF_CODIGO := Value;
end;

procedure TItensIFC.setFIIF_CODOPF(const Value: Integer);
begin
  FIIF_CODOPF := Value;
end;

end.
