unit tblMdfeRoad;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_ROAD')]
  TMdfeRoad = Class(TGenericEntity)

    private
    FSCHEDULE_PORT: String;
    FTB_MDFE_ID: Integer;
    FRNTRC: String;
    FTB_INSTITUTION_ID: Integer;
    FTB_VEHICLE_ID: String;
    procedure setFRNTRC(const Value: String);
    procedure setFSCHEDULE_PORT(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_VEHICLE_ID(const Value: String);

    public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [FieldName('TB_VEHICLE_ID')]
    property Veiculo: String read FTB_VEHICLE_ID write setFTB_VEHICLE_ID;

    [FieldName('RNTRC')]
    property RNTRC: String read FRNTRC write setFRNTRC;

    [FieldName('SCHEDULE_PORT')]
    property AgendamentoPorto: String read FSCHEDULE_PORT write setFSCHEDULE_PORT;

  End;

implementation

{ TMdfeRoad }

procedure TMdfeRoad.setFRNTRC(const Value: String);
begin
  FRNTRC := Value;
end;

procedure TMdfeRoad.setFSCHEDULE_PORT(const Value: String);
begin
  FSCHEDULE_PORT := Value;
end;

procedure TMdfeRoad.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeRoad.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeRoad.setFTB_VEHICLE_ID(const Value: String);
begin
  FTB_VEHICLE_ID := Value;
end;

end.
