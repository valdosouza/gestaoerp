unit tblContractOrder;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('TB_CONTRACT_ORDER')]
  TContractOrder = Class(TGenericEntity)
  private
    FTITTLE: String;
    FCONTENTS: String;
    FTB_PEDIDO_ID: Integer;
    FLAST_UPDATE: TDateTime;
    FTB_CONTRACT_ID: Integer;
    procedure setFCONTENTS(const Value: String);
    procedure setFTB_PEDIDO_ID(const Value: Integer);
    procedure setFTITTLE(const Value: String);
    procedure setFLAST_UPDATE(const Value: TDateTime);
    procedure setFTB_CONTRACT_ID(const Value: Integer);

  public
    [KeyField('TB_PEDIDO_ID')]
    [FieldName('TB_PEDIDO_ID')]
    property Ordem: Integer read FTB_PEDIDO_ID write setFTB_PEDIDO_ID;

    [FieldName('TITTLE')]
    property Titulo:String  read FTITTLE write setFTITTLE;

    [FieldName('TB_CONTRACT_ID')]
    property Contrato:Integer  read FTB_CONTRACT_ID write setFTB_CONTRACT_ID;

    [FieldName('CONTENTS')]
    property Conteudo: String  read FCONTENTS write setFCONTENTS;

    [FieldName('LAST_UPDATE')]
    property UltimaAlteracao: TDateTime read FLAST_UPDATE write setFLAST_UPDATE;

  End;


implementation

{ TContractOrder }

procedure TContractOrder.setFCONTENTS(const Value: String);
begin
  FCONTENTS := Value;
end;

procedure TContractOrder.setFLAST_UPDATE(const Value: TDateTime);
begin
  FLAST_UPDATE := Value;
end;

procedure TContractOrder.setFTB_CONTRACT_ID(const Value: Integer);
begin
  FTB_CONTRACT_ID := Value;
end;

procedure TContractOrder.setFTB_PEDIDO_ID(const Value: Integer);
begin
  FTB_PEDIDO_ID := Value;
end;

procedure TContractOrder.setFTITTLE(const Value: String);
begin
  FTITTLE := Value;
end;

end.
