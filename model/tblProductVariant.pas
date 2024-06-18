unit tblProductVariant;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_PRODUCT_VARIANT')]
  TProductVAriant = Class(TGenericEntity)
  private
    FAVAILABLE: String;
    FID: Integer;
    FQUANTITY: Real;
    FTB_PRODUCT_ID: Integer;
    procedure setFAVAILABLE(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFQUANTITY(const Value: Real);
    procedure setFTB_PRODUCT_ID(const Value: Integer);



  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_PRODUCT_ID')]
    [FieldName('TB_PRODUCT_ID')]
    property ProdutoVariante: Integer read FTB_PRODUCT_ID write setFTB_PRODUCT_ID;

    [FieldName('AVAILABLE')]
    property Disponibilidade: String read FAVAILABLE write setFAVAILABLE;

    [FieldName('QUANTITY')]
    property Quantidade: Real read FQUANTITY write setFQUANTITY;
  End;

implementation


{ TProductVAriant }

procedure TProductVAriant.setFAVAILABLE(const Value: String);
begin
  FAVAILABLE := Value;
end;

procedure TProductVAriant.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TProductVAriant.setFQUANTITY(const Value: Real);
begin
  FQUANTITY := Value;
end;

procedure TProductVAriant.setFTB_PRODUCT_ID(const Value: Integer);
begin
  FTB_PRODUCT_ID := Value;
end;

end.
