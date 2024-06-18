unit tblElectEquip;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ELECT_EQUIP')]
  TElectEquip = Class(TGenericEntity)

  private
    FACCESSORIES: String;
    FDEVICE: String;
    FTB_CUSTOMER_ID: Integer;
    FID: Integer;
    FSERIE: String;
    FMODEL: String;
    FIMEI: String;
    FBRAND: String;
    procedure setFACCESSORIES(const Value: String);
    procedure setFBRAND(const Value: String);
    procedure setFDEVICE(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFIMEI(const Value: String);
    procedure setFMODEL(const Value: String);
    procedure setFSERIE(const Value: String);
    procedure setFTB_CUSTOMER_ID(const Value: Integer);


  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_CUSTOMER_ID')]
    property Customer: Integer read FTB_CUSTOMER_ID write setFTB_CUSTOMER_ID;

    [FieldName('DEVICE')]
    property Dispositivo: String read FDEVICE write setFDEVICE;

    [FieldName('BRAND')]
    property Marca: String read FBRAND write setFBRAND;

    [FieldName('MODEL')]
    property Modelo: String read FMODEL write setFMODEL;

    [FieldName('SERIE')]
    property Serie: String read FSERIE write setFSERIE;

    [FieldName('IMEI')]
    property Imei: String read FIMEI write setFIMEI;

    [FieldName('ACCESSORIES')]
    property Acessorios: String read FACCESSORIES write setFACCESSORIES;

  End;

implementation

{ TElectEquip }

procedure TElectEquip.setFACCESSORIES(const Value: String);
begin
  FACCESSORIES := Value;
end;

procedure TElectEquip.setFBRAND(const Value: String);
begin
  FBRAND := Value;
end;

procedure TElectEquip.setFDEVICE(const Value: String);
begin
  FDEVICE := Value;
end;

procedure TElectEquip.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TElectEquip.setFIMEI(const Value: String);
begin
  FIMEI := Value;
end;

procedure TElectEquip.setFMODEL(const Value: String);
begin
  FMODEL := Value;
end;

procedure TElectEquip.setFSERIE(const Value: String);
begin
  FSERIE := Value;
end;

procedure TElectEquip.setFTB_CUSTOMER_ID(const Value: Integer);
begin
  FTB_CUSTOMER_ID := Value;
end;

end.
