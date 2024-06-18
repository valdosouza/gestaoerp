unit tblDevolIPI;

interface

Uses TEntity,CAtribEntity, Data.DB;

Type
  //nome da classe de entidade
  [TableName('TB_DEVOL_IPI')]
  TDevolIPI = Class(TGenericEntity)
  private
    FP_IPI: Real;
    FV_IPI: Real;
    FTB_ORDER_ITEM_ID: Integer;
    FTB_ORDER_ID: Integer;
    procedure setFP_IPI(const Value: Real);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTB_ORDER_ITEM_ID(const Value: Integer);
    procedure setFV_IPI(const Value: Real);

  public
    [KeyField('TB_ORDER_ID')]
    [FieldName('TB_ORDER_ID')]
    property Ordem: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [KeyField('TB_ORDER_ITEM_ID')]
    [FieldName('TB_ORDER_ITEM_ID')]
    property Item: Integer read FTB_ORDER_ITEM_ID write setFTB_ORDER_ITEM_ID;

    [FieldName('P_IPI')]
    property Percentual: Real read FP_IPI write setFP_IPI;

    [FieldName('V_IPI')]
    property Valor: Real read FV_IPI write setFV_IPI;

  End;
implementation

{ TDevolIPI }

procedure TDevolIPI.setFP_IPI(const Value: Real);
begin
  FP_IPI := Value;
end;

procedure TDevolIPI.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TDevolIPI.setFTB_ORDER_ITEM_ID(const Value: Integer);
begin
  FTB_ORDER_ITEM_ID := Value;
end;

procedure TDevolIPI.setFV_IPI(const Value: Real);
begin
  FV_IPI := Value;
end;

end.
