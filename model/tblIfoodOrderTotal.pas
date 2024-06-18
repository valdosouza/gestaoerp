unit tblIfoodOrderTotal;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_TOTAL')]
  TIfoodOrderTotal = Class(TGenericEntity)
  private
    FPREPAIDVALUE: Real;
    FSUBTOTAL: Real;
    FTOTALPRICE: Real;
    FTOTALBENEFITS: Real;
    FADDITIONALFEES: Real;
    FDELIVERYFEE: Real;
    FTB_IFOOD_ORDER_ID: String;
    FPENDINGVALUE: Real;
    FORDERAMOUNT: Real;
    procedure setFADDITIONALFEES(const Value: Real);
    procedure setFDELIVERYFEE(const Value: Real);
    procedure setFORDERAMOUNT(const Value: Real);
    procedure setFPENDINGVALUE(const Value: Real);
    procedure setFPREPAIDVALUE(const Value: Real);
    procedure setFSUBTOTAL(const Value: Real);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTOTALBENEFITS(const Value: Real);
    procedure setFTOTALPRICE(const Value: Real);

  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [FieldName('SUBTOTAL')]
    property SUBTOTAL: Real read FSUBTOTAL write setFSUBTOTAL;

    [FieldName('DELIVERYFEE')]
    property DELIVERYFEE: Real read FDELIVERYFEE write setFDELIVERYFEE;

    [FieldName('TOTALBENEFITS')]
    property TOTALBENEFITS: Real read FTOTALBENEFITS write setFTOTALBENEFITS;

    [FieldName('TOTALPRICE')]
    property TOTALPRICE: Real read FTOTALPRICE write setFTOTALPRICE;

    [FieldName('ADDITIONALFEES')]
    property ADDITIONALFEES: Real read FADDITIONALFEES write setFADDITIONALFEES;

    [FieldName('PENDINGVALUE')]
    property PENDINGVALUE: Real read FPENDINGVALUE write setFPENDINGVALUE;

    [FieldName('PREPAIDVALUE')]
    property PREPAIDVALUE: Real read FPREPAIDVALUE write setFPREPAIDVALUE;

  End;

implementation

{ TIfoodOrderTotal }

procedure TIfoodOrderTotal.setFADDITIONALFEES(const Value: Real);
begin
  FADDITIONALFEES := Value;
end;

procedure TIfoodOrderTotal.setFDELIVERYFEE(const Value: Real);
begin
  FDELIVERYFEE := Value;
end;

procedure TIfoodOrderTotal.setFORDERAMOUNT(const Value: Real);
begin
  FORDERAMOUNT := Value;
end;

procedure TIfoodOrderTotal.setFPENDINGVALUE(const Value: Real);
begin
  FPENDINGVALUE := Value;
end;

procedure TIfoodOrderTotal.setFPREPAIDVALUE(const Value: Real);
begin
  FPREPAIDVALUE := Value;
end;

procedure TIfoodOrderTotal.setFSUBTOTAL(const Value: Real);
begin
  FSUBTOTAL := Value;
end;

procedure TIfoodOrderTotal.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderTotal.setFTOTALBENEFITS(const Value: Real);
begin
  FTOTALBENEFITS := Value;
end;

procedure TIfoodOrderTotal.setFTOTALPRICE(const Value: Real);
begin
  FTOTALPRICE := Value;
end;

end.
