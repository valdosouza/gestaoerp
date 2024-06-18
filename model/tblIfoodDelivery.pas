unit tblIfoodDelivery;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_DELIVERY')]
  TIfoodDelivery = Class(TGenericEntity)
  private
    FFORMATTEDADDRESS: String;
    FMODE: String;
    FSTREETNAME: String;
    FPOSTALCODE: String;
    FDELIVERYDATETIME: TDateTime;
    FSTATE: String;
    FCOUNTRY: String;
    FDELIVEREDBY: String;
    FNEIGHBORHOOD: String;
    FSTREETNUMBER: String;
    FCITY: String;
    FTB_IFOOD_ORDER_ID: String;
    FOBSERVATIONS: String;
    FCOMPLEMENT: String;
    FREFERENCE: String;
    procedure setFCITY(const Value: String);
    procedure setFCOUNTRY(const Value: String);
    procedure setFDELIVEREDBY(const Value: String);
    procedure setFDELIVERYDATETIME(const Value: TDateTime);
    procedure setFFORMATTEDADDRESS(const Value: String);
    procedure setFMODE(const Value: String);
    procedure setFNEIGHBORHOOD(const Value: String);
    procedure setFPOSTALCODE(const Value: String);
    procedure setFSTATE(const Value: String);
    procedure setFSTREETNAME(const Value: String);
    procedure setFSTREETNUMBER(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFOBSERVATIONS(const Value: String);
    procedure setFCOMPLEMENT(const Value: String);
    procedure setFREFERENCE(const Value: String);


  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [FieldName('MODE')]
    property Mode: String read FMODE write setFMODE;

    [FieldName('DELIVEREDBY')]
    property DeliveredBy: String read FDELIVEREDBY write setFDELIVEREDBY;

    [FieldName('DELIVERYDATETIME')]
    property DEliveryDateTime: TDateTime read FDELIVERYDATETIME write setFDELIVERYDATETIME;

    [FieldName('STREETNAME')]
    property StreetName: String read FSTREETNAME write setFSTREETNAME;

    [FieldName('STREETNUMBER')]
    property StreetNumber: String read FSTREETNUMBER write setFSTREETNUMBER;

    [FieldName('FORMATTEDADDRESS')]
    property FormattedAddress: String read FFORMATTEDADDRESS write setFFORMATTEDADDRESS;

    [FieldName('NEIGHBORHOOD')]
    property NeighBorHood: String read FNEIGHBORHOOD write setFNEIGHBORHOOD;

    [FieldName('COMPLEMENT')]
    property Complement: String read FCOMPLEMENT write setFCOMPLEMENT;

    [FieldName('REFERENCE')]
    property Reference: String read FREFERENCE write setFREFERENCE;

    [FieldName('POSTALCODE')]
    property PostalCode: String read FPOSTALCODE write setFPOSTALCODE;

    [FieldName('CITY')]
    property City: String read FCITY write setFCITY;

    [FieldName('STATE')]
    property State: String read FSTATE write setFSTATE;

    [FieldName('COUNTRY')]
    property Country: String read FCOUNTRY write setFCOUNTRY;

    [FieldName('OBSERVATIONS')]
    property OBSERVACAO: String read FOBSERVATIONS write setFOBSERVATIONS;

  End;

implementation

{ TIfoodDelivery }

procedure TIfoodDelivery.setFCITY(const Value: String);
begin
  FCITY := Copy(Value,1,100);
end;

procedure TIfoodDelivery.setFCOMPLEMENT(const Value: String);
begin
  FCOMPLEMENT := Copy(Value,1,50);
end;

procedure TIfoodDelivery.setFCOUNTRY(const Value: String);
begin
  FCOUNTRY := Copy(Value,1,50);
end;

procedure TIfoodDelivery.setFDELIVEREDBY(const Value: String);
begin
  FDELIVEREDBY := Copy(Value,1,20);
end;

procedure TIfoodDelivery.setFDELIVERYDATETIME(const Value: TDateTime);
begin
  FDELIVERYDATETIME := Value;
end;

procedure TIfoodDelivery.setFFORMATTEDADDRESS(const Value: String);
begin
  FFORMATTEDADDRESS := Copy(Value,1,150);
end;

procedure TIfoodDelivery.setFMODE(const Value: String);
begin
  FMODE := Copy(Value,1,20);
end;

procedure TIfoodDelivery.setFNEIGHBORHOOD(const Value: String);
begin
  FNEIGHBORHOOD := Copy(Value,1,50);
end;

procedure TIfoodDelivery.setFOBSERVATIONS(const Value: String);
begin
  FOBSERVATIONS := Value;
end;

procedure TIfoodDelivery.setFPOSTALCODE(const Value: String);
begin
  FPOSTALCODE := Value;
end;

procedure TIfoodDelivery.setFREFERENCE(const Value: String);
begin
  FREFERENCE := Copy(Value,1,100);
end;

procedure TIfoodDelivery.setFSTATE(const Value: String);
begin
  FSTATE := Copy(Value,1,2);
end;

procedure TIfoodDelivery.setFSTREETNAME(const Value: String);
begin
  FSTREETNAME := Copy(Value,1,100);
end;

procedure TIfoodDelivery.setFSTREETNUMBER(const Value: String);
begin
  FSTREETNUMBER := Copy(Value,1,10);
end;

procedure TIfoodDelivery.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

end.
