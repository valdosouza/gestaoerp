unit tblPedidoCtrlMmb;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_pedido_ctrl_mb')]
  TPedidoCtrlMmb = Class(TGenericEntity)
  private
    Fsyncronismo: String;
    Ftb_pedido_id: Integer;
    Finvoice: String;
    Ftb_salesman_id: Integer;
    Ftb_pedido_id_ext: Integer;
    Ftb_institution_id: Integer;
    Fintegrado: String;
    procedure setFintegrado(const Value: String);
    procedure setFinvoice(const Value: String);
    procedure setFsyncronismo(const Value: String);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_pedido_id(const Value: Integer);
    procedure setFtb_pedido_id_ext(const Value: Integer);
    procedure setFtb_salesman_id(const Value: Integer);

  public

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('tb_pedido_id')]
    property CodigoPedido: Integer read Ftb_pedido_id write setFtb_pedido_id;

    [KeyField('tb_pedido_id_ext')]
    [FieldName('tb_pedido_id_ext')]
    property PedidoExterno: Integer read Ftb_pedido_id_ext write setFtb_pedido_id_ext;

    [KeyField('tb_salesman_id')]
    [FieldName('tb_salesman_id')]
    property Vendedor: Integer read Ftb_salesman_id write setFtb_salesman_id;

    [FieldName('syncronismo')]
    property Sincronismo: String read Fsyncronismo write setFsyncronismo;

    [FieldName('integrado')]
    property Integerado: String read Fintegrado write setFintegrado;

    [FieldName('invoice')]
    property NotaFiscal: String read Finvoice write setFinvoice;

  End;

implementation

{ TPedidoCtrlMmb }

procedure TPedidoCtrlMmb.setFintegrado(const Value: String);
begin
  Fintegrado := Value;
end;

procedure TPedidoCtrlMmb.setFinvoice(const Value: String);
begin
  Finvoice := Value;
end;

procedure TPedidoCtrlMmb.setFsyncronismo(const Value: String);
begin
  Fsyncronismo := Value;
end;

procedure TPedidoCtrlMmb.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TPedidoCtrlMmb.setFtb_pedido_id(const Value: Integer);
begin
  Ftb_pedido_id := Value;
end;

procedure TPedidoCtrlMmb.setFtb_pedido_id_ext(const Value: Integer);
begin
  Ftb_pedido_id_ext := Value;
end;

procedure TPedidoCtrlMmb.setFtb_salesman_id(const Value: Integer);
begin
  Ftb_salesman_id := Value;
end;

end.
