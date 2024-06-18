unit tblCtrlEstoqueZerado;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CTRL_ESTOQUE_ZERADO')]
  TCtrlEstoqueZerado = Class(TGenericEntity)
  private
    FTB_PRODUCT_ID: Integer;
    FBALANCE_FOUND: Real;
    FCRG_CODIGO: Integer;
    FTB_ESTOQUE_ID: Integer;
    FDT_RECORD: TDatetime;
    procedure setFBALANCE_FOUND(const Value: Real);
    procedure setFCRG_CODIGO(const Value: Integer);
    procedure setFDT_RECORD(const Value: TDatetime);
    procedure setFTB_ESTOQUE_ID(const Value: Integer);
    procedure setFTB_PRODUCT_ID(const Value: Integer);
  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FCRG_CODIGO write setFCRG_CODIGO;

    [FieldName('DT_RECORD')]
    property Data: TDatetime read FDT_RECORD write setFDT_RECORD;

    [FieldName('TB_ESTOQUE_ID')]
    property Estoque: Integer read FTB_ESTOQUE_ID write setFTB_ESTOQUE_ID;

    [FieldName('TB_PRODUCT_ID')]
    property Produto: Integer read FTB_PRODUCT_ID write setFTB_PRODUCT_ID;

    [FieldName('BALANCE_FOUND')]
    property SaldoEncontrado: Real read FBALANCE_FOUND write setFBALANCE_FOUND;
  End;

implementation


{ TCtrlEstoqueZerado }

procedure TCtrlEstoqueZerado.setFBALANCE_FOUND(const Value: Real);
begin
  FBALANCE_FOUND := Value;
end;

procedure TCtrlEstoqueZerado.setFCRG_CODIGO(const Value: Integer);
begin
  FCRG_CODIGO := Value;
end;

procedure TCtrlEstoqueZerado.setFDT_RECORD(const Value: TDatetime);
begin
  FDT_RECORD := Value;
end;

procedure TCtrlEstoqueZerado.setFTB_ESTOQUE_ID(const Value: Integer);
begin
  FTB_ESTOQUE_ID := Value;
end;

procedure TCtrlEstoqueZerado.setFTB_PRODUCT_ID(const Value: Integer);
begin
  FTB_PRODUCT_ID := Value;
end;

end.
