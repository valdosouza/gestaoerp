unit tblIfoodOrderBenefits;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_BENEFITS')]
  TIfoodOrderBenefits = Class(TGenericEntity)
  private
    FTOTAL_VALUE: Real;
    FMERCHANT_VALUE: Real;
    FTARGET: String;
    FIFOOD_VALUE: Real;
    FTB_IFOOD_ORDER_ID: String;
    FSPONSORSHIP: String;
    procedure setFIFOOD_VALUE(const Value: Real);
    procedure setFMERCHANT_VALUE(const Value: Real);
    procedure setFSPONSORSHIP(const Value: String);
    procedure setFTARGET(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTOTAL_VALUE(const Value: Real);


  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property Ordem: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [KeyField('SPONSORSHIP')]
    [FieldName('SPONSORSHIP')]
    property SponsorShip: String read FSPONSORSHIP write setFSPONSORSHIP;

    [FieldName('TARGET')]
    property Target: String read FTARGET write setFTARGET;

    [FieldName('TOTAL_VALUE')]
    property TotalValue: Real read FTOTAL_VALUE write setFTOTAL_VALUE;

    [FieldName('IFOOD_VALUE')]
    property IfoodValue: Real read FIFOOD_VALUE write setFIFOOD_VALUE;

    [FieldName('MERCHANT_VALUE')]
    property MerchantValue: Real read FMERCHANT_VALUE write setFMERCHANT_VALUE;

  End;

implementation


{ TIfoodOrderBenefits }

procedure TIfoodOrderBenefits.setFIFOOD_VALUE(const Value: Real);
begin
  FIFOOD_VALUE := Value;
end;

procedure TIfoodOrderBenefits.setFMERCHANT_VALUE(const Value: Real);
begin
  FMERCHANT_VALUE := Value;
end;

procedure TIfoodOrderBenefits.setFSPONSORSHIP(const Value: String);
begin
  FSPONSORSHIP := Value;
end;

procedure TIfoodOrderBenefits.setFTARGET(const Value: String);
begin
  FTARGET := Value;
end;

procedure TIfoodOrderBenefits.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderBenefits.setFTOTAL_VALUE(const Value: Real);
begin
  FTOTAL_VALUE := Value;
end;

end.
