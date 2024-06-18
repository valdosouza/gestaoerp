unit tblIfoodCustomer;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_CUSTOMER')]
  TIfoodCustomer = Class(TGenericEntity)
  private
    FNAME: String;
    FPHONENUMBER: String;
    FLOCALIZER: String;
    FLOCALIZEREXPIRATION: TDateTime;

    FTB_IFOOD_ORDER_ID: String;
    FDOCUMENTNUMBER: String;
    FID: String;
    FORDERCOUNTONMERCHANT: Integer;
    procedure setFLOCALIZER(const Value: String);
    procedure setFLOCALIZEREXPIRATION(const Value: TDateTime);
    procedure setFNAME(const Value: String);

    procedure setFPHONENUMBER(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFDOCUMENTNUMBER(const Value: String);
    procedure setFID(const Value: String);
    procedure setFORDERCOUNTONMERCHANT(const Value: Integer);

  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [FieldName('ID')]
    property ID: String read FID write setFID;

    [FieldName('NAME')]
    property NAME: String read FNAME write setFNAME;

    [FieldName('PHONENUMBER')]
    property PHONENUMBER: String read FPHONENUMBER write setFPHONENUMBER;

    [FieldName('DOCUMENTNUMBER')]
    property DOCUMENTNUMBER: String read FDOCUMENTNUMBER write setFDOCUMENTNUMBER;

    [FieldName('LOCALIZER')]
    property LOCALIZER: String read FLOCALIZER write setFLOCALIZER;

    [FieldName('LOCALIZEREXPIRATION')]
    property LOCALIZEREXPIRATION: TDateTime read FLOCALIZEREXPIRATION write setFLOCALIZEREXPIRATION;

    [FieldName('ORDERCOUNTONMERCHANT')]
    property ORDERCOUNTONMERCHANT: Integer read FORDERCOUNTONMERCHANT write setFORDERCOUNTONMERCHANT;

  End;
implementation

{ TIfoodCustomer }

procedure TIfoodCustomer.setFDOCUMENTNUMBER(const Value: String);
begin
  FDOCUMENTNUMBER := Value;
end;

procedure TIfoodCustomer.setFID(const Value: String);
begin
  FID := Value;
end;

procedure TIfoodCustomer.setFLOCALIZER(const Value: String);
begin
  FLOCALIZER := Value;
end;

procedure TIfoodCustomer.setFLOCALIZEREXPIRATION(const Value: TDateTime);
begin
  FLOCALIZEREXPIRATION := Value;
end;

procedure TIfoodCustomer.setFNAME(const Value: String);
begin
  FNAME := Value;
end;


procedure TIfoodCustomer.setFORDERCOUNTONMERCHANT(const Value: Integer);
begin
  FORDERCOUNTONMERCHANT := Value;
end;

procedure TIfoodCustomer.setFPHONENUMBER(const Value: String);
begin
  FPHONENUMBER := Value;
end;

procedure TIfoodCustomer.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

end.
