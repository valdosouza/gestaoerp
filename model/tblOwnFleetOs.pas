unit tblOwnFleetOs;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils,System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_OWN_FLEET_OS')]
  TOwnFleetOs = Class(TGenericEntity)
  private
    FOBS: String;
    FKM: String;
    FID: Integer;

    FTB_VEHICLE_ID: String;
    FDT_RECORD: TDate;
    FTB_INSTITUTION_ID: Integer;
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFID(const Value: Integer);
    procedure setFKM(const Value: String);
    procedure setFOBS(const Value: String);

    procedure setFTB_VEHICLE_ID(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('id')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_VEHICLE_ID')]
    property Placa: String read FTB_VEHICLE_ID write setFTB_VEHICLE_ID;

    [FieldName('DT_RECORD')]
    property Data: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('KM')]
    property KM: String read FKM write setFKM;

    [FieldName('OBS')]
    property Observacao: String read FOBS write setFOBS;

  End;
implementation

{ TOwnFleetOs }

procedure TOwnFleetOs.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TOwnFleetOs.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TOwnFleetOs.setFKM(const Value: String);
begin
  FKM := Value;
end;

procedure TOwnFleetOs.setFOBS(const Value: String);
begin
  FOBS := Value;
end;


procedure TOwnFleetOs.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TOwnFleetOs.setFTB_VEHICLE_ID(const Value: String);
begin
  FTB_VEHICLE_ID := Value;
end;

end.
