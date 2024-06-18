unit tblIfoodOrderItemsOptions;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_ITEMS_OPTIONS')]
  TIfoodOrderItemsOptions = Class(TGenericEntity)
  private
    FNAME: String;
    FINDEX_: Integer;
    FPRICE: Real;
    FUNITPRICE: Real;
    FADDITION: Real;
    FID: Integer;
    FQUANTITY: Real;
    FUNIT: String;
    FEXTERNALCODE: Integer;
    FTB_IFOOD_ORDER_ID: String;
    FTB_IFOOD_ORDER_ITEMS_ID: Integer;
    procedure setFADDITION(const Value: Real);
    procedure setFEXTERNALCODE(const Value: Integer);
    procedure setFID(const Value: Integer);
    procedure setFINDEX_(const Value: Integer);
    procedure setFNAME(const Value: String);
    procedure setFPRICE(const Value: Real);
    procedure setFQUANTITY(const Value: Real);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTB_IFOOD_ORDER_ITEMS_ID(const Value: Integer);
    procedure setFUNIT(const Value: String);
    procedure setFUNITPRICE(const Value: Real);

  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [KeyField('TB_IFOOD_ORDER_ITEMS_ID')]
    [FieldName('TB_IFOOD_ORDER_ITEMS_ID')]
    property OrderItemsId: Integer read FTB_IFOOD_ORDER_ITEMS_ID write setFTB_IFOOD_ORDER_ITEMS_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property ID: Integer read FID write setFID;

    [FieldName('INDEX_')]
    property INDEX_: Integer read FINDEX_ write setFINDEX_;

    [FieldName('NAME')]
    property NAME: String read FNAME write setFNAME;

    [FieldName('EXTERNALCODE')]
    property EXTERNALCODE: Integer read FEXTERNALCODE write setFEXTERNALCODE;

    [FieldName('UNIT')]
    property UNITDes: String read FUNIT write setFUNIT;

    [FieldName('QUANTITY')]
    property QUANTITY: Real read FQUANTITY write setFQUANTITY;

    [FieldName('UNITPRICE')]
    property UNITPRICE: Real read FUNITPRICE write setFUNITPRICE;

    [FieldName('ADDITION')]
    property ADDITION: Real read FADDITION write setFADDITION;

    [FieldName('PRICE')]
    property PRICE: Real read FPRICE write setFPRICE;

  End;

implementation

{ TIfoodOrderItemsOptions }

procedure TIfoodOrderItemsOptions.setFADDITION(const Value: Real);
begin
  FADDITION := Value;
end;

procedure TIfoodOrderItemsOptions.setFEXTERNALCODE(const Value: Integer);
begin
  FEXTERNALCODE := Value;
end;

procedure TIfoodOrderItemsOptions.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TIfoodOrderItemsOptions.setFINDEX_(const Value: Integer);
begin
  FINDEX_ := Value;
end;

procedure TIfoodOrderItemsOptions.setFNAME(const Value: String);
begin
  FNAME := Copy(Value,1,100);
end;

procedure TIfoodOrderItemsOptions.setFPRICE(const Value: Real);
begin
  FPRICE := Value;
end;

procedure TIfoodOrderItemsOptions.setFQUANTITY(const Value: Real);
begin
  FQUANTITY := Value;
end;

procedure TIfoodOrderItemsOptions.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderItemsOptions.setFTB_IFOOD_ORDER_ITEMS_ID(
  const Value: Integer);
begin
  FTB_IFOOD_ORDER_ITEMS_ID := Value;
end;

procedure TIfoodOrderItemsOptions.setFUNIT(const Value: String);
begin
  FUNIT := Value;
end;

procedure TIfoodOrderItemsOptions.setFUNITPRICE(const Value: Real);
begin
  FUNITPRICE := Value;
end;

end.
