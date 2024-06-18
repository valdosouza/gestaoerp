unit tblItensImport;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_itens_import')]
  TItensImport = Class(TGenericEntity)
  private
    Ftb_product_id: Integer;
    Fquotation: Real;
    FID: Integer;
    Funit_value: Real;
    Fqtde: Real;
    Ftb_order_id: Integer;
    procedure setFID(const Value: Integer);
    procedure setFqtde(const Value: Real);
    procedure setFquotation(const Value: Real);
    procedure setFtb_order_id(const Value: Integer);
    procedure setFtb_product_id(const Value: Integer);
    procedure setFunit_value(const Value: Real);

  public

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FID write setFID;

    [KeyField('tb_order_id')]
    [FieldName('tb_order_id')]
    property Ordem: Integer read Ftb_order_id write setFtb_order_id;

    [FieldName('tb_product_id')]
    property Produto: Integer read Ftb_product_id write setFtb_product_id;

    [FieldName('qtde')]
    property Quantidade: Real read Fqtde write setFqtde;

    [FieldName('unit_value')]
    property ValorUnitario: Real read Funit_value write setFunit_value;

    [FieldName('quotation')]
    property Cotacao: Real read Fquotation write setFquotation;

  End;

implementation


{ TItensImport }

procedure TItensImport.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TItensImport.setFqtde(const Value: Real);
begin
  Fqtde := Value;
end;

procedure TItensImport.setFquotation(const Value: Real);
begin
  Fquotation := Value;
end;

procedure TItensImport.setFtb_order_id(const Value: Integer);
begin
  Ftb_order_id := Value;
end;

procedure TItensImport.setFtb_product_id(const Value: Integer);
begin
  Ftb_product_id := Value;
end;

procedure TItensImport.setFunit_value(const Value: Real);
begin
  Funit_value := Value;
end;

end.
