unit tblProductVAriantSKU;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_PRODUCT_VARIANT_SKU')]
  TProductVAriantSKU = Class(TGenericEntity)
  private
    FCOR: String;
    FPRICE_TAG: Real;
    FID: Integer;
    FQUANTITY: Real;
    FTB_PRODUCT_VARIANT_ID: Integer;
    FTAMANHO: String;
    procedure setFCOR(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFPRICE_TAG(const Value: Real);
    procedure setFQUANTITY(const Value: Real);
    procedure setFTAMANHO(const Value: String);
    procedure setFTB_PRODUCT_VARIANT_ID(const Value: Integer);


  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_PRODUCT_VARIANT_ID')]
    [FieldName('TB_PRODUCT_VARIANT_ID')]
    property VarianteID: Integer read FTB_PRODUCT_VARIANT_ID write setFTB_PRODUCT_VARIANT_ID;

    [FieldName('TAMANHO')]
    property Tamanho: String read FTAMANHO write setFTAMANHO;

    [FieldName('COR')]
    property Cor: String read FCOR write setFCOR;

    [FieldName('PRICE_TAG')]
    property Valor: Real read FPRICE_TAG write setFPRICE_TAG;

    [FieldName('QUANTITY')]
    property Quantidade: Real read FQUANTITY write setFQUANTITY;

  End;

implementation


{ TProductVAriantSKU }

procedure TProductVAriantSKU.setFCOR(const Value: String);
begin
  FCOR := Value;
end;

procedure TProductVAriantSKU.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TProductVAriantSKU.setFPRICE_TAG(const Value: Real);
begin
  FPRICE_TAG := Value;
end;

procedure TProductVAriantSKU.setFQUANTITY(const Value: Real);
begin
  FQUANTITY := Value;
end;

procedure TProductVAriantSKU.setFTAMANHO(const Value: String);
begin
  FTAMANHO := Value;
end;

procedure TProductVAriantSKU.setFTB_PRODUCT_VARIANT_ID(const Value: Integer);
begin
  FTB_PRODUCT_VARIANT_ID := Value;
end;

end.
