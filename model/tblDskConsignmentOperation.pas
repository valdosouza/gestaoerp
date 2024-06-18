unit tblDskConsignmentOperation;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ORDER_CONSIGNMENT_OPERATION')]
  TDskConsignmentOperation = Class(TGenericEntity)
  private
    Fupdated_at: TDAteTime;
    Ftb_order_item_id: Integer;
    Ftb_institution_id: Integer;
    Fkind: String;
    Ftb_order_id: Integer;
    Fterminal: Integer;
    Fdt_record: TDate;
    Fcreated_at: TDAteTime;
    FTB_ITENS_NFL_ID: Integer;
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFdt_record(const Value: TDate);
    procedure setFkind(const Value: String);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_order_id(const Value: Integer);
    procedure setFtb_order_item_id(const Value: Integer);
    procedure setFterminal(const Value: Integer);
    procedure setFupdated_at(const Value: TDAteTime);
    procedure setFTB_ITENS_NFL_ID(const Value: Integer);

   public
    //Este campo refere-se ao tb_order_id

    [FieldName('tb_order_item_id')]
    [KeyField('tb_order_item_id')]
    property ItemOrdem: Integer read Ftb_order_item_id write setFtb_order_item_id;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [KeyField('terminal')]
    [FieldName('terminal')]
    property Terminal: Integer read Fterminal write setFterminal;

    [KeyField('tb_order_id')]
    [FieldName('tb_order_id')]
    property Ordem: Integer read Ftb_order_id write setFtb_order_id;

    [FieldName('TB_ITENS_NFL_ID')]
    property PedidoItem: Integer read FTB_ITENS_NFL_ID write setFTB_ITENS_NFL_ID;

    [FieldName('dt_record')]
    property Data: TDate read Fdt_record write setFdt_record;

    [FieldName('kind')]
    property Tipo: String read Fkind write setFkind;

    [FieldName('created_at')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;



  End;

implementation


{ TDskConsignmentOperation }

procedure TDskConsignmentOperation.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TDskConsignmentOperation.setFdt_record(const Value: TDate);
begin
  Fdt_record := Value;
end;

procedure TDskConsignmentOperation.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TDskConsignmentOperation.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TDskConsignmentOperation.setFTB_ITENS_NFL_ID(const Value: Integer);
begin
  FTB_ITENS_NFL_ID := Value;
end;

procedure TDskConsignmentOperation.setFtb_order_id(const Value: Integer);
begin
  Ftb_order_id := Value;
end;

procedure TDskConsignmentOperation.setFtb_order_item_id(const Value: Integer);
begin
  Ftb_order_item_id := Value;
end;

procedure TDskConsignmentOperation.setFterminal(const Value: Integer);
begin
  Fterminal := Value;
end;

procedure TDskConsignmentOperation.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

end.
