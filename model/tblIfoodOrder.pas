unit tblIfoodOrder;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER')]
  TIfoodOrder = Class(TGenericEntity)
  private
    FSTATUS_TM: TDateTime;
    FORDERTIMING: String;
    FORDERTYPE: String;
    FId: String;
    FDISPLAYID: String;
    FEXTRA_INFO: String;
    FSTATUS: String;
    FCREATEDATLOCAL: TDateTime;
    FCREATEDAT: TDateTime;
    FSALESCHANNEL: String;
    FPREPARATIONSTART: TDateTime;
    FDELIVERYDATETIME: TDateTime;
    FDELIVERYDATETIMEEND: TDateTime;
    FDELIVERYDATETIMESTART: TDateTime;
    FID_SETES: Integer;

    procedure setFCREATEDAT(const Value: TDateTime);
    procedure setFCREATEDATLOCAL(const Value: TDateTime);
    procedure setFDISPLAYID(const Value: String);
    procedure setFEXTRA_INFO(const Value: String);
    procedure setFId(const Value: String);
    procedure setFORDERTIMING(const Value: String);
    procedure setFORDERTYPE(const Value: String);
    procedure setFPREPARATIONSTART(const Value: TDateTime);
    procedure setFSALESCHANNEL(const Value: String);
    procedure setFSTATUS(const Value: String);
    procedure setFSTATUS_TM(const Value: TDateTime);
    procedure setFDELIVERYDATETIME(const Value: TDateTime);
    procedure setFDELIVERYDATETIMEEND(const Value: TDateTime);
    procedure setFDELIVERYDATETIMESTART(const Value: TDateTime);
    procedure setFID_SETES(const Value: Integer);

  public

    [FieldName('id')]
    [KeyField('id')]
    property Codigo: String read FId write setFId;


    [FieldName('ID_SETES')]
    property IdSetes: Integer read FID_SETES write setFID_SETES;


    [FieldName('ORDERTYPE')]
    property OrderType: String read FORDERTYPE write setFORDERTYPE;

    [FieldName('ORDERTIMING')]
    property OrderTiming: String read FORDERTIMING write setFORDERTIMING;

    [FieldName('DISPLAYID')]
    property DisplayId: String read FDISPLAYID write setFDISPLAYID;

    [FieldName('CREATEDAT')]
    property CreatedAt: TDateTime read FCREATEDAT write setFCREATEDAT;

    [FieldName('CREATEDATLOCAL')]
    property CreatedAtLocal: TDateTime read FCREATEDATLOCAL write setFCREATEDATLOCAL;

    [FieldName('PREPARATIONSTART')]
    property PreparationStart: TDateTime read FPREPARATIONSTART write setFPREPARATIONSTART;

    [FieldName('SALESCHANNEL')]
    property SalesChannel: String read FSALESCHANNEL write setFSALESCHANNEL;

    [FieldName('STATUS')]
    property Status: String read FSTATUS write setFSTATUS;

    [FieldName('STATUS_TM')]
    property StatusTempo: TDateTime  read FSTATUS_TM write setFSTATUS_TM;

    [FieldName('EXTRA_INFO')]
    property ExtraInfo: String  read FEXTRA_INFO write setFEXTRA_INFO;

    [FieldName('DELIVERYDATETIME')]
    property DeliveryDateTime: TDateTime  read FDELIVERYDATETIME write setFDELIVERYDATETIME;

    [FieldName('DELIVERYDATETIMESTART')]
    property DeliveryDateTimeStar: TDateTime  read FDELIVERYDATETIMESTART write setFDELIVERYDATETIMESTART;

    [FieldName('DELIVERYDATETIMEEND')]
    property DeliveryDateTimeEnd: TDateTime  read FDELIVERYDATETIMEEND write setFDELIVERYDATETIMEEND;

  End;

implementation

{ TIfoodOrder }

procedure TIfoodOrder.setFCREATEDAT(const Value: TDateTime);
begin
  FCREATEDAT := Value;
end;

procedure TIfoodOrder.setFCREATEDATLOCAL(const Value: TDateTime);
begin
  FCREATEDATLOCAL := Value;
end;

procedure TIfoodOrder.setFDELIVERYDATETIME(const Value: TDateTime);
begin
  FDELIVERYDATETIME := Value;
end;

procedure TIfoodOrder.setFDELIVERYDATETIMEEND(const Value: TDateTime);
begin
  FDELIVERYDATETIMEEND := Value;
end;

procedure TIfoodOrder.setFDELIVERYDATETIMESTART(const Value: TDateTime);
begin
  FDELIVERYDATETIMESTART := Value;
end;

procedure TIfoodOrder.setFDISPLAYID(const Value: String);
begin
  FDISPLAYID := Value;
end;

procedure TIfoodOrder.setFEXTRA_INFO(const Value: String);
begin
  FEXTRA_INFO := Value;
end;

procedure TIfoodOrder.setFId(const Value: String);
begin
  FId := Value;
end;


procedure TIfoodOrder.setFID_SETES(const Value: Integer);
begin
  FID_SETES := Value;
end;

procedure TIfoodOrder.setFORDERTIMING(const Value: String);
begin
  FORDERTIMING := Value;
end;

procedure TIfoodOrder.setFORDERTYPE(const Value: String);
begin
  FORDERTYPE := Value;
end;

procedure TIfoodOrder.setFPREPARATIONSTART(const Value: TDateTime);
begin
  FPREPARATIONSTART := Value;
end;

procedure TIfoodOrder.setFSALESCHANNEL(const Value: String);
begin
  FSALESCHANNEL := Value;
end;

procedure TIfoodOrder.setFSTATUS(const Value: String);
begin
  FSTATUS := Value;
end;

procedure TIfoodOrder.setFSTATUS_TM(const Value: TDateTime);
begin
  FSTATUS_TM := Value;
end;

end.
