unit tblExchangeBasis;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  [TableName('TB_EXCHANGE_BASIS')]
  TExchangeBasis = Class(TGenericEntity)
  private
    FTB_PRODUCT_ID: Integer;
    FNOTE: String;
    FWEIGHT_IN: Real;
    FPRICE_TAG: Real;
    FTB_CUSTOMER_ID: Integer;
    FTB_SALESMAN_ID: Integer;
    FTB_ORDER_ITEM_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FTB_USER_ID: Integer;
    FTB_ORDER_ID: Integer;
    FWEIGHT_OUT: Real;
    FDT_IN: TDate;
    FDT_OUT: TDate;

    procedure setFNOTE(const Value: String);
    procedure setFPRICE_TAG(const Value: Real);
    procedure setFTB_CUSTOMER_ID(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTB_ORDER_ITEM_ID(const Value: Integer);
    procedure setFTB_PRODUCT_ID(const Value: Integer);
    procedure setFTB_SALESMAN_ID(const Value: Integer);
    procedure setFTB_USER_ID(const Value: Integer);
    procedure setFWEIGHT_IN(const Value: Real);
    procedure setFWEIGHT_OUT(const Value: Real);
    procedure setFDT_IN(const Value: TDate);
    procedure setFDT_OUT(const Value: TDate);

  public
    //[KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer Read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_ORDER_ITEM_ID')]
    [FieldName('TB_ORDER_ITEM_ID')]
    property Item : Integer read FTB_ORDER_ITEM_ID write setFTB_ORDER_ITEM_ID;

    [FieldName('TB_ORDER_ID')]
    property Ordem: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('TB_USER_ID')]
    property Usuario:Integer read FTB_USER_ID write setFTB_USER_ID;

    [FieldName('TB_CUSTOMER_ID')]
    property Cliente:Integer read FTB_CUSTOMER_ID write setFTB_CUSTOMER_ID;

    [FieldName('TB_SALESMAN_ID')]
    property Vendedor :Integer read FTB_SALESMAN_ID write setFTB_SALESMAN_ID;

    [FieldName('TB_PRODUCT_ID')]
    property Produto:Integer read FTB_PRODUCT_ID write setFTB_PRODUCT_ID;

    [FieldName('DT_IN')]
    property DataEntrada:TDate read FDT_IN write setFDT_IN;

    [FieldName('DT_OUT')]
    property DataSaida:TDate read FDT_OUT write setFDT_OUT;

    [FieldName('PRICE_TAG')]
    property Preco : Real read FPRICE_TAG write setFPRICE_TAG;

    [FieldName('WEIGHT_IN')]
    property PesoEntrada : Real read FWEIGHT_IN write setFWEIGHT_IN;

    [FieldName('WEIGHT_OUT')]
    property PesoSaida:Real read FWEIGHT_OUT write setFWEIGHT_OUT;

    [FieldName('NOTE')]
    property Observacao : String read FNOTE write setFNOTE;
  End;

implementation

{ TExchangeBasis }


procedure TExchangeBasis.setFDT_IN(const Value: TDate);
begin
  FDT_IN := Value;
end;

procedure TExchangeBasis.setFDT_OUT(const Value: TDate);
begin
  FDT_OUT := Value;
end;

procedure TExchangeBasis.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TExchangeBasis.setFPRICE_TAG(const Value: Real);
begin
  FPRICE_TAG := Value;
end;

procedure TExchangeBasis.setFTB_CUSTOMER_ID(const Value: Integer);
begin
  FTB_CUSTOMER_ID := Value;
end;

procedure TExchangeBasis.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TExchangeBasis.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TExchangeBasis.setFTB_ORDER_ITEM_ID(const Value: Integer);
begin
  FTB_ORDER_ITEM_ID := Value;
end;

procedure TExchangeBasis.setFTB_PRODUCT_ID(const Value: Integer);
begin
  FTB_PRODUCT_ID := Value;
end;

procedure TExchangeBasis.setFTB_SALESMAN_ID(const Value: Integer);
begin
  FTB_SALESMAN_ID := Value;
end;

procedure TExchangeBasis.setFTB_USER_ID(const Value: Integer);
begin
  FTB_USER_ID := Value;
end;

procedure TExchangeBasis.setFWEIGHT_IN(const Value: Real);
begin
  FWEIGHT_IN := Value;
end;

procedure TExchangeBasis.setFWEIGHT_OUT(const Value: Real);
begin
  FWEIGHT_OUT := Value;
end;

end.
