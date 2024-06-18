unit tblTabelaPrecoHasFormaPagto;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_TABELA_PRECO_HAS_FORMA_PAGTO')]
  TTabelaPrecoHasFormaPagto = Class(TGenericEntity)
  private
    FTB_FORMA_PAGTO_ID: Integer;
    FTB_TABELA_PRECO_ID: Integer;
    FATIVO: String;
    procedure setFTB_FORMA_PAGTO_ID(const Value: Integer);
    procedure setFTB_TABELA_PRECO_ID(const Value: Integer);
    procedure setFTATIVO(const Value: String);

  public
    [KeyField('TB_TABELA_PRECO_ID')]
    [FieldName('TB_TABELA_PRECO_ID')]
    property Tabela: Integer read FTB_TABELA_PRECO_ID write setFTB_TABELA_PRECO_ID;

    [KeyField('TB_FORMA_PAGTO_ID')]
    [FieldName('TB_FORMA_PAGTO_ID')]
    property FormaPagto: Integer read FTB_FORMA_PAGTO_ID write setFTB_FORMA_PAGTO_ID;

    [FieldName('ATIVO')]
    property Ativo: String read FATIVO write setFTATIVO;

  End;

implementation

{ TTabelaPrecoHasFormaPagto }

procedure TTabelaPrecoHasFormaPagto.setFTATIVO(const Value: String);
begin
  FATIVO := Value;
end;

procedure TTabelaPrecoHasFormaPagto.setFTB_FORMA_PAGTO_ID(const Value: Integer);
begin
  FTB_FORMA_PAGTO_ID := Value;
end;

procedure TTabelaPrecoHasFormaPagto.setFTB_TABELA_PRECO_ID(
  const Value: Integer);
begin
  FTB_TABELA_PRECO_ID := Value;
end;

end.
