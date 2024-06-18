unit tblItensObs;


interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_OBS')]
  TItensObs = Class(TGenericEntity)
  private
    FDETAIL: String;
    FTB_ITENS_CTC_ID: Integer;
    FTB_ITENS_NFL_ID: Integer;
    procedure setFDETAIL(const Value: String);
    procedure setFTB_ITENS_CTC_ID(const Value: Integer);
    procedure setFTB_ITENS_NFL_ID(const Value: Integer);

  public
    [KeyField('TB_ITENS_CTC_ID')]
    [FieldName('TB_ITENS_CTC_ID')]
    property ItemOrcamento: Integer read FTB_ITENS_CTC_ID write setFTB_ITENS_CTC_ID;

    [FieldName('TB_ITENS_NFL_ID')]
    property ItemPedido: Integer read FTB_ITENS_NFL_ID write setFTB_ITENS_NFL_ID;

    [FieldName('DETAIL')]
    property Detalhe: String read FDETAIL write setFDETAIL;

  End;
implementation

{ TItensObs }

procedure TItensObs.setFDETAIL(const Value: String);
begin
  FDETAIL := Value;
end;

procedure TItensObs.setFTB_ITENS_CTC_ID(const Value: Integer);
begin
  FTB_ITENS_CTC_ID := Value;
end;

procedure TItensObs.setFTB_ITENS_NFL_ID(const Value: Integer);
begin
  FTB_ITENS_NFL_ID := Value;
end;

end.
