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
    FDescricaoOperacao: String;
    procedure setFIIF_CODIFC(const Value: Integer);
    procedure setFIIF_CODIGO(const Value: Integer);
    procedure setFIIF_CODOPF(const Value: Integer);
    procedure setFDescricaoOperacao(const Value: String);
  public
    //No banco está como primary Key, mas nesta camada trataremos este campo apenas o sequenciamento
    [FieldName('IIF_CODIGO')]
    property Codigo: Integer read FIIF_CODIGO write setFIIF_CODIGO;

    [KeyField('IIF_CODIFC')]
    [FieldName('IIF_CODIFC')]
    property CodigoInterface: Integer read FIIF_CODIFC write setFIIF_CODIFC;

    [KeyField('IIF_CODOPF')]
    [FieldName('IIF_CODOPF')]
    property CodigoOperacao: Integer read FIIF_CODOPF write setFIIF_CODOPF;

    property DescricaoOperacao: String Read FDescricaoOperacao write setFDescricaoOperacao;
  End;

implementation

{ TCargo }

procedure TItensIFC.setFDescricaoOperacao(const Value: String);
begin
  FDescricaoOperacao := Value;
end;

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
