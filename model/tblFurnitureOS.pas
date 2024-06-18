unit tblFurnitureOS;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_FURNITURE_OS')]
  TFurnitureOS = Class(TGenericEntity)
  private
    FNOTE: String;
    FEQUIPMENT: String;
    FTB_COLABORADOR_ID: Integer;
    FHR_ATTENDANCE: TTime;
    FFOUND: String;
    FTB_ORDER_ID: Integer;
    FEXECUTADO: String;
    FREPORTED: String;
    FMODEL: String;
    FTB_SITUACAO_ID: Integer;
    FENVIRONMENT: String;
    FBRAND: String;
    FDT_ATTENDANCE: TDate;
    procedure setFBRAND(const Value: String);
    procedure setFDT_ATTENDANCE(const Value: TDate);
    procedure setFENVIRONMENT(const Value: String);
    procedure setFEQUIPMENT(const Value: String);
    procedure setFEXECUTADO(const Value: String);
    procedure setFFOUND(const Value: String);
    procedure setFHR_ATTENDANCE(const Value: TTime);
    procedure setFMODEL(const Value: String);
    procedure setFNOTE(const Value: String);
    procedure setFREPORTED(const Value: String);
    procedure setFTB_COLABORADOR_ID(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTB_SITUACAO_ID(const Value: Integer);


  public


    [KeyField('TB_ORDER_ID')]
    [FieldName('TB_ORDER_ID')]
    property Pedido: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('EQUIPMENT')]
    property Equipamento: String read FEQUIPMENT write setFEQUIPMENT;

    [FieldName('ENVIRONMENT')]
    property Ambiente: String read FENVIRONMENT write setFENVIRONMENT;

    [FieldName('BRAND')]
    property Marca: String read FBRAND write setFBRAND;

    [FieldName('MODEL')]
    property modelo: String read FMODEL write setFMODEL;


    [FieldName('REPORTED')]
    property Relatado: String read FREPORTED write setFREPORTED;

    [FieldName('FOUND')]
    property Constatado: String read FFOUND write setFFOUND;

    [FieldName('EXECUTED')]
    property Executado: String read FEXECUTADO write setFEXECUTADO;

    [FieldName('NOTE')]
    property Observacao: String read FNOTE write setFNOTE;

    [FieldName('DT_ATTENDANCE')]
    property DataAtendimento: TDate read FDT_ATTENDANCE write setFDT_ATTENDANCE;

    [FieldName('HR_ATTENDANCE')]
    property HoraAtendimento: TTime read FHR_ATTENDANCE write setFHR_ATTENDANCE;

    [FieldName('TB_COLABORADOR_ID')]
    property Tecnico: Integer read FTB_COLABORADOR_ID write setFTB_COLABORADOR_ID;

    [FieldName('TB_SITUACAO_ID')]
    property Situacao: Integer read FTB_SITUACAO_ID write setFTB_SITUACAO_ID;

  End;


implementation


{ TFurnitureOS }

procedure TFurnitureOS.setFBRAND(const Value: String);
begin
  FBRAND := Value;
end;

procedure TFurnitureOS.setFDT_ATTENDANCE(const Value: TDate);
begin
  FDT_ATTENDANCE := Value;
end;

procedure TFurnitureOS.setFENVIRONMENT(const Value: String);
begin
  FENVIRONMENT := Value;
end;

procedure TFurnitureOS.setFEQUIPMENT(const Value: String);
begin
  FEQUIPMENT := Value;
end;

procedure TFurnitureOS.setFEXECUTADO(const Value: String);
begin
  FEXECUTADO := Value;
end;

procedure TFurnitureOS.setFFOUND(const Value: String);
begin
  FFOUND := Value;
end;

procedure TFurnitureOS.setFHR_ATTENDANCE(const Value: TTime);
begin
  FHR_ATTENDANCE := Value;
end;

procedure TFurnitureOS.setFMODEL(const Value: String);
begin
  FMODEL := Value;
end;

procedure TFurnitureOS.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TFurnitureOS.setFREPORTED(const Value: String);
begin
  FREPORTED := Value;
end;

procedure TFurnitureOS.setFTB_COLABORADOR_ID(const Value: Integer);
begin
  FTB_COLABORADOR_ID := Value;
end;

procedure TFurnitureOS.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TFurnitureOS.setFTB_SITUACAO_ID(const Value: Integer);
begin
  FTB_SITUACAO_ID := Value;
end;

end.
