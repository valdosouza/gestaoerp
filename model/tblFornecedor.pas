unit tblFornecedor;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_fornecedor')]
  TFornecedor = Class(TGenericEntity)
  private
    FFOR_ATIVO: String;
    FFOR_CODEMP: Integer;
    FDescricao: String;

    procedure setFFOR_CODEMP( Value : INTEGER);
    procedure setFFOR_ATIVO( Value : String);
    procedure setFDescricao(const Value: String);
  public

    [KeyField('FOR_CODEMP')]
    [FieldName('FOR_CODEMP')]
    property Codigo: Integer read FFOR_CODEMP write setFFOR_CODEMP;

    [FieldName('FOR_ATIVO')]
    property Ativo: String read FFOR_ATIVO write setFFOR_ATIVO;

    property Descricao: String read FDescricao write setFDescricao;

  End;

implementation


{ TFornecedor }

procedure TFornecedor.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TFornecedor.setFFOR_ATIVO(Value: String);
begin
  FFOR_ATIVO := Value;
end;

procedure TFornecedor.setFFOR_CODEMP(Value: INTEGER);
begin
  FFOR_CODEMP := Value;
end;

end.
