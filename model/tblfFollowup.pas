unit tblFollowup;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_FOLLOWUP')]
  TFollowup = Class(TGenericEntity)
  private
    FDT_DONE: TDate;
    FID: Integer;
    FDETAIL: String;
    FTB_INSTITUTION_ID: Integer;
    FDT_FORECAST: TDate;
    FTB_ORDER_ID: Integer;
    FTERMINAL: Integer;
    FDT_RECORD: TDateTime;
    FPROCESS: String;
    procedure setFDETAIL(const Value: String);
    procedure setFDT_DONE(const Value: TDate);
    procedure setFDT_FORECAST(const Value: TDate);
    procedure setFDT_RECORD(const Value: TDateTime);
    procedure setFID(const Value: Integer);
    procedure setFPROCESS(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTERMINAL(const Value: Integer);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TERMINAL')]
    [FieldName('TERMINAL')]
    property Terminal: Integer read FTERMINAL write setFTERMINAL;

    [KeyField('TB_ORDER_ID')]
    [FieldName('TB_ORDER_ID')]
    property Ordem: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('PROCESS')]
    [FieldName('PROCESS')]
    property Processo: String read FPROCESS write setFPROCESS;

    [FieldName('DT_RECORD')]
    property Data: TDateTime  read FDT_RECORD write setFDT_RECORD;

    [FieldName('DT_FORECAST')]
    property DataPrevista: TDate  read FDT_FORECAST write setFDT_FORECAST;

    [FieldName('DT_DONE')]
    property DataRealizada: TDate  read FDT_DONE write setFDT_DONE;

    [FieldName('DETAIL')]
    property Detalhes:String read FDETAIL write setFDETAIL;

  End;
implementation

{ TFollowup }

procedure TFollowup.setFDETAIL(const Value: String);
begin
  FDETAIL := Value;
end;

procedure TFollowup.setFDT_DONE(const Value: TDate);
begin
  FDT_DONE := Value;
end;

procedure TFollowup.setFDT_FORECAST(const Value: TDate);
begin
  FDT_FORECAST := Value;
end;

procedure TFollowup.setFDT_RECORD(const Value: TDateTime);
begin
  FDT_RECORD := Value;
end;

procedure TFollowup.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TFollowup.setFPROCESS(const Value: String);
begin
  FPROCESS := Value;
end;

procedure TFollowup.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TFollowup.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TFollowup.setFTERMINAL(const Value: Integer);
begin
  FTERMINAL := Value;
end;

end.
