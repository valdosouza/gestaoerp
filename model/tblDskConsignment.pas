unit tblDskConsignment;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ORDER_CONSIGNMENT')]
  TDskConsignment = Class(TGenericEntity)
  private
    Ftb_customer_id: Integer;
    FId: Integer;
    Fupdated_at: TDAteTime;
    Ftb_salesman_id: Integer;
    Ftb_institution_id: Integer;
    Fterminal: Integer;
    Fcreated_at: TDAteTime;
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFId(const Value: Integer);
    procedure setFtb_customer_id(const Value: Integer);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_salesman_id(const Value: Integer);
    procedure setFterminal(const Value: Integer);
    procedure setFupdated_at(const Value: TDAteTime);


  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: Integer read FId write setFId;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [KeyField('terminal')]
    [FieldName('terminal')]
    property Terminal: Integer read Fterminal write setFterminal;

    [KeyField('tb_customer_id')]
    [FieldName('tb_customer_id')]
    property Cliente: Integer read Ftb_customer_id write setFtb_customer_id;

    [FieldName('tb_salesman_id')]
    property Vendedor: Integer read Ftb_salesman_id write setFtb_salesman_id;

    [FieldName('created_at')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;

  End;

implementation

{ TDskConsignment }

procedure TDskConsignment.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TDskConsignment.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TDskConsignment.setFtb_customer_id(const Value: Integer);
begin
  Ftb_customer_id := Value;
end;

procedure TDskConsignment.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TDskConsignment.setFtb_salesman_id(const Value: Integer);
begin
  Ftb_salesman_id := Value;
end;

procedure TDskConsignment.setFterminal(const Value: Integer);
begin
  Fterminal := Value;
end;

procedure TDskConsignment.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

end.
