unit tblIfoodOrderPaymentMethods;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_PAYMENT_METHODS')]
  TIfoodOrderPaymentMethods = Class(TGenericEntity)
  private
    FMETHOD: String;
    FTYPE_: String;
    FVALUE_: Real;
    FID: String;
    FPREPAID: String;
    FCHANGEFOR: Real;
    FTB_IFOOD_ORDER_PAYMENT_ID: String;
    FTB_IFOOD_ORDER_ID: String;
    FCURRENCY: String;
    procedure setFCHANGEFOR(const Value: Real);
    procedure setFCURRENCY(const Value: String);
    procedure setFID(const Value: String);
    procedure setFMETHOD(const Value: String);
    procedure setFPREPAID(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTB_IFOOD_ORDER_PAYMENT_ID(const Value: String);
    procedure setFTYPE_(const Value: String);
    procedure setFVALUE_(const Value: Real);

  public
    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [KeyField('TB_IFOOD_ORDER_PAYMENT_ID')]
    [FieldName('TB_IFOOD_ORDER_PAYMENT_ID')]
    property TB_IFOOD_ORDER_PAYMENT_ID: String read FTB_IFOOD_ORDER_PAYMENT_ID write setFTB_IFOOD_ORDER_PAYMENT_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property ID: String read FID write setFID;

    [FieldName('VALUE_')]
    property VALUE_: Real read FVALUE_ write setFVALUE_;

    [FieldName('CURRENCY')]
    property CURRENCY: String read FCURRENCY write setFCURRENCY;

    [FieldName('METHOD')]
    property METHOD: String read FMETHOD write setFMETHOD;

    [FieldName('TYPE_')]
    property TYPE_: String read FTYPE_ write setFTYPE_;

    [FieldName('CHANGEFOR')]
    property CHANGEFOR: Real read FCHANGEFOR write setFCHANGEFOR;

    [FieldName('PREPAID')]
    property PREPAID: String read FPREPAID write setFPREPAID;


  End;


implementation

{ TIfoodOrderPaymentMethods }

procedure TIfoodOrderPaymentMethods.setFCHANGEFOR(const Value: Real);
begin
  FCHANGEFOR := Value;
end;

procedure TIfoodOrderPaymentMethods.setFCURRENCY(const Value: String);
begin
  FCURRENCY := Value;
end;

procedure TIfoodOrderPaymentMethods.setFID(const Value: String);
begin
  FID := Value;
end;

procedure TIfoodOrderPaymentMethods.setFMETHOD(const Value: String);
begin
  FMETHOD := Value;
end;

procedure TIfoodOrderPaymentMethods.setFPREPAID(const Value: String);
begin
  FPREPAID := Value;
end;

procedure TIfoodOrderPaymentMethods.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderPaymentMethods.setFTB_IFOOD_ORDER_PAYMENT_ID(
  const Value: String);
begin
  FTB_IFOOD_ORDER_PAYMENT_ID := Value;
end;

procedure TIfoodOrderPaymentMethods.setFTYPE_(const Value: String);
begin
  FTYPE_ := Value;
end;

procedure TIfoodOrderPaymentMethods.setFVALUE_(const Value: Real);
begin
  FVALUE_ := Value;
end;

end.
