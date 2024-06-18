unit tblIfoodEvents;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils,System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_EVENTS')]
  TIfoodEvents = Class(TGenericEntity)
  private
    FEVENT_ID: String;
    FTB_IFOOD_ORDER_ID: String;
    FTYPE_EVENT: String;
    FTB_INSTITUTION_ID: Integer;
    procedure setFEVENT_ID(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTYPE_EVENT(const Value: String);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrdemID: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [KeyField('TYPE_EVENT')]
    [FieldName('TYPE_EVENT')]
    property TipoEvento: String read FTYPE_EVENT write setFTYPE_EVENT;

    [FieldName('EVENT_ID')]
    property EventoID: String read FEVENT_ID write setFEVENT_ID;


  End;

implementation

{ TIfoodEvents }

procedure TIfoodEvents.setFEVENT_ID(const Value: String);
begin
  FEVENT_ID := Value;
end;

procedure TIfoodEvents.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodEvents.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TIfoodEvents.setFTYPE_EVENT(const Value: String);
begin
  FTYPE_EVENT := Value;
end;

end.
