unit ControllerPedidoCompra;

interface

uses ControllerPedido,tblOrder,tblOrderItem,objORderPurchase,//tblOrderPurchase
  System.SysUtils,ObjCustomer,tblPedido, System.Classes,ControllerFornecedor;

type
  TControllerPedidoCompra = class(TControllerPedido)

  private

  protected


  public
    Obj : TObjOrderPurchase;
    Fornecedor : TControllerFornecedor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearDataObjecto;
    procedure FillDataObjeto(PcReg: TPedido);
    function ValidasaveObjWeb(pOrder: TObjOrderPurchase): Boolean;
  end;
implementation

{ TControllerPedidoCompra }

procedure TControllerPedidoCompra.ClearDataObjecto;
begin
  clearObj(Obj);
end;

constructor TControllerPedidoCompra.Create(AOwner: TComponent);
begin
  inherited;
  Fornecedor := TControllerFornecedor.Create(Self);
  Obj := TObjOrderPurchase.Create;
end;

destructor TControllerPedidoCompra.Destroy;
begin
  Fornecedor.DisposeOf;
  Obj.Destroy;
  inherited;
end;

procedure TControllerPedidoCompra.FillDataObjeto(PcReg: TPedido);
Var
  I : Integer;
  lcitems : TOrderItem;
begin
  //Order
  Obj.Order.Codigo          := PcReg.Codigo;
  Obj.Order.Estabelecimento := Obj.Estabelecimento;
  Obj.Order.Terminal        := Obj.Terminal;
  Obj.Order.Data            := PcReg.Data;
  Obj.Order.Observacao      := PcReg.Observacao;
  Obj.Order.Origem          := 'D';
  Obj.Order.Status          := PcReg.Faturado;
  Obj.Order.SendoUsado      := '';
  Obj.Order.RegistroCriado  := PcReg.DataAlteracao;
  //OrderPurchase
  Obj.OrderPurchase.Codigo          := Obj.Order.Codigo;
  Obj.OrderPurchase.Estabelecimento := Obj.Estabelecimento;
  Obj.OrderPurchase.Terminal        := Obj.Terminal;
  Obj.OrderPurchase.Aprovado        := PcReg.Aprovado;
  Obj.OrderPurchase.Numero          := PcReg.Numero;
  Obj.OrderPurchase.Fornecedor      := 0;

  //Referencia Doc Fiscal CPF/CNPJ
  Fornecedor.Registro.Codigo := PcReg.Empresa;
  Fornecedor.getById;
  Fornecedor.Obj.Estabelecimento := Obj.Estabelecimento;
  Fornecedor.fillDataObjeto(Fornecedor.Registro,Fornecedor.Obj);

  //Items Lembrando que o NFL_Codigo será o tb_order_id
  Itens.Registro.CodigoNota := PcReg.Codigo;
  Itens.getListByNF;
  for I := 0 to Itens.Lista.Count -1 do
  Begin
    lcitems     := TOrderItem.Create;
    lcitems.Codigo            := Itens.Lista[I].Codigo;
    lcitems.Estabelecimento   := Obj.Estabelecimento;
    lcitems.Ordem             := Obj.Order.Codigo;
    lcitems.Terminal          := Obj.Terminal;
    lcitems.Produto           := Itens.Lista[I].CodigoProduto;
    lcitems.Estoque           := Itens.Lista[I].CodigoEstoque;
    lcitems.TabelaPreco       := Itens.Lista[I].CodigoTabela;
    lcitems.Quantidade        := Itens.Lista[I].Quantidade;
    lcitems.ValorUnitario     := Itens.Lista[I].ValorUnitario;
    lcitems.AliquotaDesconto  := Itens.Lista[I].AliqDesconto;
    lcitems.ValorDesconto     := Itens.Lista[I].ValorDesconto;
    Obj.Items.Add(lcitems);
  end;

  //Totlalizer
  Obj.Totalizer.Codigo            := Obj.Order.Codigo;
  Obj.Totalizer.Estabelecimento   := Obj.Estabelecimento;
  Obj.Totalizer.Terminal          := Obj.Terminal;
  Obj.Totalizer.ItemsQuantidade   := Obj.Items.Count;
  Obj.Totalizer.ProdutoQuantidade := PcReg.QtdeProdutos;
  Obj.Totalizer.ValorProduto      := PcReg.ValorProdutos;
  Obj.Totalizer.IPIValor          := PcReg.ValorIPI;
  Obj.Totalizer.AlíquotaDesconto  := PcReg.AliqDesconto;
  Obj.Totalizer.ValorDesconto     := PcReg.ValorDesconto;
  Obj.Totalizer.ValorDespesas     := PcReg.ValorOutrasDEspesas;
  Obj.Totalizer.ValorTotal        := PcReg.ValorPedido;

  //Billing
  FormaPagto.Registro.Codigo :=  PcReg.FormaPagto;
  FormaPagto.getById;
  Obj.FormaPagamento          := FormaPagto.Registro.Descricao;
  Obj.Billing.Codigo          := Obj.Order.Codigo;
  Obj.Billing.Estabelecimento := Obj.Estabelecimento;
  Obj.Billing.Terminal        := Obj.Terminal;
  Obj.Billing.FormaPagamento  := PcReg.FormaPagto;
  Obj.Billing.Parcelas        := Copy(PcReg.Prazo,1,3);
  Obj.Billing.Prazo           := Copy(PcReg.Prazo,7,Length(PcReg.Prazo )- 6);
  Obj.Billing.Responsavel     := 0;
end;



function TControllerPedidoCompra.ValidasaveObjWeb( pOrder: TObjOrderPurchase): Boolean;
begin
  Result := True;
  {
  if (pOrder.Cliente.Fiscal.Fisica.CPF = '') and (pOrder.Cliente.Fiscal.Juridica.CNPJ = '') then
  Begin
    geralog('TControllerPedido.ValidasaveObjWeb',
            concat(
              'Mensagem: Sem CPF/CNJ :   ',
              ' | Terminal: ', IntToStr(pOrder.OrderPurchase.Terminal),
              ' | Numero: ', IntToStr(pOrder.OrderPurchase.Numero),
              ' | Estabelecimento: ', IntToStr(pOrder.Estabelecimento)
            ));
  End;
  }

end;

end.

