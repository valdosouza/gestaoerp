unit tblIfoodOrderItems;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_ITEMS')]
  TIfoodOrderItems = Class(TGenericEntity)
  private
    FNAME: String;
    FINDEX_: Integer;
    FUNITPRICE: Real;
    FOPTIONPRICE: Real;
    FID: Integer;
    FQUANTITY: Real;
    FUNIT: String;
    FTOTALPRICE: Real;
    FEXTERNALCODE: Integer;
    FTB_IFOOD_ORDER_ID: String;
    FOBSERVATIONS: String;
    procedure setFEXTERNALCODE(const Value: Integer);
    procedure setFID(const Value: Integer);
    procedure setFINDEX_(const Value: Integer);
    procedure setFNAME(const Value: String);
    procedure setFOPTIONPRICE(const Value: Real);
    procedure setFQUANTITY(const Value: Real);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTOTALPRICE(const Value: Real);
    procedure setFUNIT(const Value: String);
    procedure setFUNITPRICE(const Value: Real);
    procedure setFOBSERVATIONS(const Value: String);

  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

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

    [FieldName('OPTIONPRICE')]
    property OPTIONPRICE: Real read FOPTIONPRICE write setFOPTIONPRICE;

    [FieldName('TOTALPRICE')]
    property TOTALPRICE: Real read FTOTALPRICE write setFTOTALPRICE;

    [FieldName('OBSERVATIONS')]
    property OBSERVATIONS: String read FOBSERVATIONS write setFOBSERVATIONS;

  End;

implementation


{ TIfoodOrderItems }

procedure TIfoodOrderItems.setFEXTERNALCODE(const Value: Integer);
begin
  FEXTERNALCODE := Value;
end;

procedure TIfoodOrderItems.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TIfoodOrderItems.setFINDEX_(const Value: Integer);
begin
  FINDEX_ := Value;
end;

procedure TIfoodOrderItems.setFNAME(const Value: String);
begin
  FNAME := Copy(Value,1,100);
end;

procedure TIfoodOrderItems.setFOBSERVATIONS(const Value: String);
begin
  FOBSERVATIONS := Value;
end;

procedure TIfoodOrderItems.setFOPTIONPRICE(const Value: Real);
begin
  FOPTIONPRICE := Value;
end;

procedure TIfoodOrderItems.setFQUANTITY(const Value: Real);
begin
  FQUANTITY := Value;
end;

procedure TIfoodOrderItems.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderItems.setFTOTALPRICE(const Value: Real);
begin
  FTOTALPRICE := Value;
end;

procedure TIfoodOrderItems.setFUNIT(const Value: String);
begin
  FUNIT := Value;
end;

procedure TIfoodOrderItems.setFUNITPRICE(const Value: Real);
begin
  FUNITPRICE := Value;
end;

end.
