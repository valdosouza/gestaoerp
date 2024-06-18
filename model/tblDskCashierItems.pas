unit tblDskCashierItems;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_cashier_Items')]
  TDskCashierItems = Class(TGenericEntity)
  private
    FTBCASHIERID: Integer;
    FTBUSERID: Integer;
    FTBPAYMENTTYPESID: Integer;
    FSETVALUE: Real;
    Fkind: String;
    procedure setFSETVALUE(const Value: Real);
    procedure setFTBCASHIERID(const Value: Integer);
    procedure setFTBPAYMENTTYPESID(const Value: Integer);
    procedure setFTBUSERID(const Value: Integer);
    procedure setFkind(const Value: String);


  public
    [KeyField('tb_cashier_id')]
    [FieldName('tb_cashier_id')]
    property CodigoCaixa: Integer read FTBCASHIERID write setFTBCASHIERID;

    [KeyField('tb_user_id')]
    [FieldName('tb_user_id')]
    property CodigoUsuario: Integer read FTBUSERID write setFTBUSERID;

    [KeyField('tb_payment_types_id')]
    [FieldName('tb_payment_types_id')]
    property TipoFormaPagamento: Integer read FTBPAYMENTTYPESID write setFTBPAYMENTTYPESID;

    [FieldName('set_value')]
    property Valor: Real read FSETVALUE write setFSETVALUE;

   [FieldName('kind')]
    property Tipo: String read Fkind write setFkind;

  End;

implementation



{ TDskCashierItems }

procedure TDskCashierItems.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TDskCashierItems.setFSETVALUE(const Value: Real);
begin
  FSETVALUE := Value;
end;

procedure TDskCashierItems.setFTBCASHIERID(const Value: Integer);
begin
  FTBCASHIERID := Value;
end;

procedure TDskCashierItems.setFTBPAYMENTTYPESID(const Value: Integer);
begin
  FTBPAYMENTTYPESID := Value;
end;

procedure TDskCashierItems.setFTBUSERID(const Value: Integer);
begin
  FTBUSERID := Value;
end;

end.
