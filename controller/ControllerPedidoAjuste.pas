unit ControllerPedidoAjuste;

interface

uses ControllerPedido,tblOrder,tblOrderStockAdjust,tblOrderItem,objORderStockAdjust,
  System.SysUtils,ObjCustomer,tblPedido, System.Classes, objOrderBonus;

type
  TControllerPedidoAjuste = class(TControllerPedido)

  private

  protected


  public
    Obj : TObjOrderStockAdjust;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearDataObjecto;
    procedure SaveObjOrderBonus(porder:TobjOrderBonus);
    procedure FillDataObjeto(PcReg: TPedido);
    function ValidaSaveObjOrderBonus(pOrder: TObjOrderBonus): Boolean;

  end;
implementation

{ TControllerPedidoAjuste }

procedure TControllerPedidoAjuste.ClearDataObjecto;
begin
  ClearObj(Obj);
end;

constructor TControllerPedidoAjuste.Create(AOwner: TComponent);
begin
  inherited;
  Obj := TObjOrderStockAdjust.Create;
end;

destructor TControllerPedidoAjuste.Destroy;
begin
  Obj.Destroy;
  inherited;
end;

procedure TControllerPedidoAjuste.FillDataObjeto(PcReg: TPedido);
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

  //OrderStockAdjust
  Obj.OrderStockAdjust.Codigo          := Obj.Order.Codigo;
  Obj.OrderStockAdjust.Estabelecimento := Obj.Estabelecimento;
  Obj.OrderStockAdjust.Terminal        := Obj.Terminal;
  Obj.OrderStockAdjust.Numero          := PcReg.Numero;
  Obj.OrderStockAdjust.Destinatario    := 0;

  //Destinatario
  Empresa.Registro.Codigo := PcReg.Empresa;
  Empresa.getById;
  Empresa.fillDataObjeto(Empresa.Registro,Obj.Destinatario);


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


procedure TControllerPedidoAjuste.SaveObjOrderBonus(porder: TobjOrderBonus);
Var
  I : Integer;
begin
  //Informar Codigo WEb e Vendedor
  Registro.CodigoWeb              := pOrder.Order.Codigo;
  Self.Vendedor.Registro.CPFCNPJ  := pOrder.DocFiscalVendedor;
  Registro.Vendedor               := Self.Vendedor.getIDByDoc;
  pOrder.Cliente.Vendedor         := Registro.Vendedor;

  if not WebFaturado then
  Begin
    //Verifica se esta faturado e não atualiza
    Registro.Codigo                := 0;
    Registro.Numero                := 0;
    Registro.Terminal              := pOrder.Order.Terminal;
    Registro.NumeroWeb             := pOrder.OrderBonus.Numero;
    Registro.Tipo                  := 3;
    if pOrder.Order.Data >0  then
      Registro.Data              := pOrder.Order.Data
    else
      Registro.Data              := Date;

    Self.Cliente.Empresa.Clear;
    Self.Cliente.Empresa.exist := False;
    //caso não venha com CPF nem CNPJ vamos criar uma empresa para poder receber o pedido e o cliente alterar depois
    if (Trim(pOrder.Fiscal.Fisica.CPF) = '') and (Trim(pOrder.Fiscal.Juridica.CNPJ) = '') then
    Begin
      Self.Cliente.criarClienteSemCPFCNPJ;
    End
    else
    Begin
      //Busca Por CPF
      if Trim(pOrder.Fiscal.Fisica.CPF) <> '' then
      Begin
        Self.Cliente.Empresa.Registro.CpfCNPJ := pOrder.Fiscal.Fisica.CPF;
        Self.Cliente.Empresa.getByDocumento;
      End;
      //Se não encontrou buscar por CNPJ
      if not Self.Cliente.Empresa.exist then
      Begin
        Self.Cliente.Empresa.Registro.CpfCNPJ := pOrder.Fiscal.Juridica.CNPJ;
        Self.Cliente.Empresa.getByDocumento;
      End;
      //Caso não encontre precisa salvar o cliente
      if not Self.Cliente.Empresa.exist then
      Begin
        Self.Cliente.Empresa.saveObjWeb(pOrder.Fiscal);
        pOrder.Cliente.Codigo := Self.Cliente.Empresa.Registro.Codigo;
        Self.Cliente.saveCustomer(pOrder.Cliente);
      End;
    End;
    //Registra o codigo da Empresa no pedido
    Registro.Empresa                      := Self.Cliente.Empresa.Registro.Codigo;
    Self.Endereco.Registro.CodigoEmpresa  := Self.Cliente.Empresa.Registro.Codigo;
    Self.Endereco.getByEmpresa;
    if not Self.Endereco.exist then
    BEgin
      Self.Endereco.Registro.CodigoEmpresa := Self.Cliente.Empresa.Registro.Codigo;
      Self.Endereco.AutoEndereco;
    End;
    if Self.Endereco.Registro.Codigo >0 then
      Registro.Endereco              := Self.Endereco.Registro.Codigo
    else
      Registro.Endereco              := 1;
    Registro.Usuario               := UsuarioIntegracao;

    Registro.FormaPagto := 0;
    Registro.Prazo := '000 - À Vista';

    Registro.QtdeProdutos := 0;
    for I := 0 to pOrder.Items.Count -1 do
    Begin
      Registro.QtdeProdutos := Registro.QtdeProdutos + pOrder.Items[I].Quantidade;
    End;


    Registro.ValorProdutos         := 0;
    Registro.ValorIPI              := 0;
    Registro.ValorFrete            := 0;
    Registro.AliqDesconto          := 0;
    Registro.ValorDesconto         := 0;
    Registro.ValorPedido           := 0;
    //Aplicativo no Delphi
    if (porder.Order.Status = 'N') then
    Begin
      Registro.Faturado := 'N';
    End
    else
    Begin
      //Aplicativo no Flutter
      if (porder.Order.Status = 'F') then
      Begin
        Registro.Faturado := 'N';
      End;
    End;
    Registro.TipoContato           := '1';
    //DataEntrega           :=
    Registro.ValorServico          := 0;
    Registro.Transportadora        := 0;
    Registro.FretePorConta         := 0;
    Registro.EmUso                 := '';
    Registro.DataAlteracao         := Now;
    Registro.CodigoNatureza        := 0;
    Registro.EnderecoEntrega       := 0;
    Registro.EnderecoFaturamento   := 0;
    Registro.EnderecoCobranca      := 0;
    Registro.CodigoEstabelecimento := porder.Estabelecimento;
    Registro.Aprovado              := 'N';
    Registro.ValorSubstTributaria  := 0;
    Registro.ValorOutrasDEspesas   := 0;
    Registro.NumeroOrcamento       := 0;
    Registro.Validade              := Date;
    Registro.ValorCredito          := 0;
    Registro.CodigoNegocio         := 0;
    Registro.Entrega               := '';
    Registro.Garantia              := '';
    Registro.OrigemCliente         := '';
    Registro.IndicaPresenca        := 1;
    if (not Self.Cliente.Empresa.exist ) then
    Begin
      Self.Cliente.Empresa.Registro.Codigo := Registro.Empresa;
      Self.Cliente.Empresa.getById;
    End;
    //Quando tiver observação no cliente junta os dois
    if Length(Trim(Self.Cliente.Empresa.Registro.Observacao)) > 0 then
    Begin
      Registro.Observacao := concat(Self.Cliente.Empresa.Registro.Observacao,' ',
                                    porder.Order.Observacao);
    End
    else
    Begin
      //Aqui coloca somente a observação do pedido
      Registro.Observacao := porder.Order.Observacao;
    End;

    salvaPedidoInternet;
    //Salvar os itens
    Self.Itens.Registro.CodigoPedido := Self.Registro.Codigo;
    Self.Itens.deleteByPedido;
    for I := 0 to pOrder.Items.Count -1 do
    Begin
      //Pega o valor da tabela principal
      Itens.Produto.Preco.Registro.CodigoTabela := 1;
      Itens.Produto.Preco.Registro.CodigoProduto := pOrder.Items[I].Produto;
      Itens.Produto.Preco.getByTabelaProduto;

      with Self.Itens.Registro do
      BEgin
        Codigo            := 0;
        Sequencia         := I+1;
        CodigoPedido      := Self.Registro.Codigo;
        CodigoNota        := 0;
        CodigoProduto     := pOrder.Items[I].Produto;
        Quantidade        := pOrder.Items[I].Quantidade;
        ValorCusto        := 0;
        ValorUnitario     := Itens.Produto.Preco.Registro.Valor;
        Despachar         := 'S';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := 0;
        AliqDesconto      := 0;
        AliqIPI           := 0;
        Operacao          := 'A';
        AliqICMS          := 0;
        if pOrder.Items[I].Estoque > 0 then
          CodigoEstoque     := pOrder.Items[I].Estoque
        else
          CodigoEstoque     := 1;
        CodigoTabela      := 1;
        Altura            := 0;
        Largura           := 0;
        Sentido           := 'S';
        PedidoCompra      := '0';
        ItemCompra        := '0';
        ImpostoAproximado := 0;
        NumeroPecas       := 0;
      End;
      Self.Itens.insere;
    End;
  End;

end;

function TControllerPedidoAjuste.ValidaSaveObjOrderBonus( pOrder: TObjOrderbonus): Boolean;
begin
  Result := True;
  {
  if (pOrder.Cliente.Fiscal.Fisica.CPF = '') and (pOrder.Cliente.Fiscal.Juridica.CNPJ = '') then
  Begin
    geralog('TControllerPedido.ValidasaveObjWeb',
            concat(
              'Mensagem: Sem CPF/CNJ :   ',
              ' | Terminal: ', IntToStr(pOrder.OrderStockAdjust.Terminal),
              ' | Numero: ', IntToStr(pOrder.OrderStockAdjust.Numero),
              ' | Estabelecimento: ', IntToStr(pOrder.Estabelecimento)
            ));
  End;
  }

end;

end.

