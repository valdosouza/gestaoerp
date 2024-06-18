unit tblVehicleOs;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_VEHICLE_SO')]
  TVehicleOs = Class(TGenericEntity)
  private
    FEXIT_HOUR: String;
    FTB_INSTITUTION_ID: Integer;
    FOBS: String;
    FMOBILE: Integer;
    FTB_ORDER_ID: Integer;
    FTB_BUDGET_ID: Integer;
    FEXIT_DATE: String;
    FTB_VEHICLE_ID: String;


    procedure setFTB_INSTITUTION_ID( Value : INTEGER);
    procedure setFTB_BUDGET_ID( Value : INTEGER);
    procedure setFTB_ORDER_ID( Value : INTEGER);
    procedure setFMOBILE( Value : INTEGER);
    procedure setFTB_VEHICLE_ID( Value : String);
    procedure setFOBS( Value : String);
    procedure setFEXIT_DATE( Value : String);
    procedure setFEXIT_HOUR( Value : String);


  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property CodigoEstabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_BUDGET_ID')]
    [FieldName('TB_BUDGET_ID')]
    property CodigoCotacao: Integer read FTB_BUDGET_ID write setFTB_BUDGET_ID;

    [KeyField('TB_ORDER_ID')]
    [FieldName('TB_ORDER_ID')]
    property CodigoPedido: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('MOBILE')]
    property CodigoMobile: Integer read FMOBILE write setFMOBILE;

    [FieldName('TB_VEHICLE_ID')]
    property Placa: String read FTB_VEHICLE_ID write setFTB_VEHICLE_ID;

    [FieldName('OBS')]
    property Observacao: String read FOBS write setFOBS;

    [FieldName('EXIT_DATE')]
    property DataSaida: String read FEXIT_DATE write setFEXIT_DATE;

    [FieldName('EXIT_HOUR')]
    property HoraSaida: String read FEXIT_HOUR write setFEXIT_HOUR;


  End;

implementation


{ TVehicleOs }

procedure TVehicleOs.setFEXIT_DATE(Value: String);
begin
  FEXIT_DATE := Value;
end;

procedure TVehicleOs.setFEXIT_HOUR(Value: String);
begin
  FEXIT_HOUR := Value;
end;

procedure TVehicleOs.setFMOBILE(Value: INTEGER);
begin
  FMOBILE := Value;
end;

procedure TVehicleOs.setFOBS(Value: String);
begin
  FOBS := Value;
end;

procedure TVehicleOs.setFTB_BUDGET_ID(Value: INTEGER);
begin
  FTB_BUDGET_ID := Value;
end;

procedure TVehicleOs.setFTB_INSTITUTION_ID(Value: INTEGER);
begin
 FTB_INSTITUTION_ID := Value;
end;

procedure TVehicleOs.setFTB_ORDER_ID(Value: INTEGER);
begin
  FTB_ORDER_ID := Value;
end;

procedure TVehicleOs.setFTB_VEHICLE_ID(Value: String);
begin
  FTB_VEHICLE_ID := Value;
end;

end.
