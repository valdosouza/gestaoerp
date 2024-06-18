unit tblPetOrder;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PET_ORDER')]
  TPetOrder = Class(TGenericEntity)

  private
    FFORECAST_TIME: String;
    FEXIT_TIME: String;
    FNOTE: String;
    FENTRANCE_DATE: TDate;
    FTB_PET_ID: Integer;
    FTB_PEDIDO_ID: Integer;
    FENTRANCE_TIME: String;
    FFORECAST_DATE: TDate;
    FEXIT_DATE: TDate;
    procedure setFENTRANCE_DATE(const Value: TDate);
    procedure setFENTRANCE_TIME(const Value: String);
    procedure setFEXIT_DATE(const Value: TDate);
    procedure setFEXIT_TIME(const Value: String);
    procedure setFFORECAST_DATE(const Value: TDate);
    procedure setFFORECAST_TIME(const Value: String);
    procedure setFNOTE(const Value: String);
    procedure setFTB_PEDIDO_ID(const Value: Integer);
    procedure setFTB_PET_ID(const Value: Integer);

  public
    [KeyField('TB_PEDIDO_ID')]
    [FieldName('TB_PEDIDO_ID')]
    property Pedido: Integer read FTB_PEDIDO_ID write setFTB_PEDIDO_ID;

    [FieldName('TB_PET_ID')]
    property Pet: Integer read FTB_PET_ID write setFTB_PET_ID;

    [FieldName('ENTRANCE_DATE')]
    property DataEntrada: TDate read FENTRANCE_DATE write setFENTRANCE_DATE;

    [FieldName('ENTRANCE_TIME')]
    property HoraEntrada: String read FENTRANCE_TIME write setFENTRANCE_TIME;

    [FieldName('FORECAST_DATE')]
    property DataPrevista: TDate read FFORECAST_DATE write setFFORECAST_DATE;

    [FieldName('FORECAST_TIME')]
    property HoraPrevista: String read FFORECAST_TIME write setFFORECAST_TIME;

    [FieldName('EXIT_DATE')]
    property DataSaida: TDate read FEXIT_DATE write setFEXIT_DATE;

    [FieldName('EXIT_TIME')]
    property HoraSaida: String read FEXIT_TIME write setFEXIT_TIME;

    [FieldName('NOTE')]
    property Observacao: String read FNOTE write setFNOTE;

  End;
implementation


{ TPetOrder }

procedure TPetOrder.setFENTRANCE_DATE(const Value: TDate);
begin
  FENTRANCE_DATE := Value;
end;

procedure TPetOrder.setFENTRANCE_TIME(const Value: String);
begin
  FENTRANCE_TIME := Value;
end;

procedure TPetOrder.setFEXIT_DATE(const Value: TDate);
begin
  FEXIT_DATE := Value;
end;

procedure TPetOrder.setFEXIT_TIME(const Value: String);
begin
  FEXIT_TIME := Value;
end;

procedure TPetOrder.setFFORECAST_DATE(const Value: TDate);
begin
  FFORECAST_DATE := Value;
end;

procedure TPetOrder.setFFORECAST_TIME(const Value: String);
begin
  FFORECAST_TIME := Value;
end;

procedure TPetOrder.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TPetOrder.setFTB_PEDIDO_ID(const Value: Integer);
begin
  FTB_PEDIDO_ID := Value;
end;

procedure TPetOrder.setFTB_PET_ID(const Value: Integer);
begin
  FTB_PET_ID := Value;
end;

end.
