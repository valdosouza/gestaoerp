unit ControllerPedidoVenda;

interface

uses ControllerPedido,tblOrder,tblOrderSale,tblOrderItem,objORderSale,
  System.SysUtils,ObjCustomer,tblPedido, System.Classes,ControllerCliente;

type
  TControllerPedidoVenda = class(TControllerPedido)

  private

  protected

  public
    Obj:TObjOrderSale;
    Cliente : TControllerCliente;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearDataObjecto;
    procedure saveObjWeb(pOrder:TObjOrderSale);
    procedure FillDataObjeto(PcReg: TPedido);
    function ValidasaveObjWeb(pOrder: TObjOrderSale): Boolean;
  end;
implementation

{ TControllerPedidoVenda }

uses UnFunctions, Un_funcao;

procedure TControllerPedidoVenda.ClearDataObjecto;
begin
  Obj.clear;
end;

constructor TControllerPedidoVenda.Create(AOwner: TComponent);
begin
  inherited;
  Cliente   := TControllerCliente.create(Self);
  Obj := TObjOrderSale.Create;
end;

destructor TControllerPedidoVenda.Destroy;
begin
  Cliente.DisposeOf;
  Obj.Destroy;
  inherited;
end;

procedure TControllerPedidoVenda.FillDataObjeto(PcReg: TPedido);
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

  //OrderSale
  Obj.OrderSale.Codigo          := Obj.Order.Codigo;
  Obj.OrderSale.Estabelecimento := Obj.Estabelecimento;
  Obj.OrderSale.Terminal        := Obj.Terminal;
  Obj.OrderSale.Vendedor        := 0;
  Obj.OrderSale.Numero          := PcReg.Numero;
  Obj.OrderSale.Cliente         := 0;

  //Referencia Doc Fiscal CPF/CNPJ
  Cliente.Registro.Codigo := PcReg.Empresa;
  Cliente.getallByKey;
  Cliente.Obj.Estabelecimento := Obj.Estabelecimento;
  Cliente.Empresa.fillDataObjeto(Cliente.Empresa.Registro,Obj.Fiscal );

  Cliente.fillCustomer(Obj.Cliente);


   //Vendedor
  obj.DocFiscalVendedor := '';
  Self.Vendedor.Registro.Codigo := PcReg.Vendedor;
  Self.Vendedor.getbyId;
  if Self.Vendedor.exist then
    obj.DocFiscalVendedor := Self.Vendedor.Registro.CPFCNPJ;

  //Items Lembrando que o NFL_Codigo será o tb_order_id
  Itens.Registro.CodigoNota := PcReg.Codigo;
  Itens.getListByNF;
  Obj.Items.Clear;
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

procedure TControllerPedidoVenda.saveObjWeb(pOrder: TObjOrderSale);
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
    Registro.NumeroWeb             := pOrder.OrderSale.Numero;
    Registro.Tipo                  := 1;
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

    FormaPagto.Registro.Descricao := pOrder.FormaPagamento;
    FormaPagto.getByDescricao;
    if FormaPagto.exist then
      Registro.FormaPagto            := FormaPagto.Registro.Codigo
    else
    Begin
      FormaPagto.autocreate('CARTEIRA');
      Registro.FormaPagto            := FormaPagto.Registro.Codigo
    End;

    if (Pos('-',pOrder.Billing.Prazo)>0 ) then
    Begin
        Registro.Prazo := pOrder.Billing.Prazo;
    End
    else
    Begin
      if StrToIntDef(pOrder.Billing.Prazo,0) > 0 then
      Begin
        Registro.Prazo := concat(
                            StrZero(StrToInt(pOrder.Billing.Parcelas),3,0),
                            ' - ',
                            pOrder.Billing.Prazo);
      End
      else
      Begin
        Registro.Prazo                 := '000 - À VISTA';
      End;
    End;

    Registro.QtdeProdutos := 0;
    for I := 0 to pOrder.Items.Count -1 do
    Begin
      Registro.QtdeProdutos := Registro.QtdeProdutos + pOrder.Items[I].Quantidade;
    End;


    Registro.ValorProdutos         := porder.Totalizer.ValorProduto;
    Registro.ValorIPI              := porder.Totalizer.IPIValor;
    Registro.ValorFrete            := 0;
    Registro.AliqDesconto          := porder.Totalizer.AlíquotaDesconto;
    Registro.ValorDesconto         := porder.Totalizer.ValorDesconto;
    Registro.ValorPedido           := porder.Totalizer.ValorTotal;
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
    Registro.ValorOutrasDEspesas   := porder.Totalizer.ValorDespesas;
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
    //Desregitrar o Estoque
    CtrlEstoque.Desregistra('P',
                            Registro.Codigo,
                            0);

    //Salvar os itens
    Self.Itens.Registro.CodigoPedido := Self.Registro.Codigo;
    Self.Itens.getList;
    for I := 0 to Self.Itens.Lista.Count -1 do
    Begin
      Self.Itens.ItensIcms.Registro.ItemNota := Self.Itens.Lista[I].Codigo;
      Self.Itens.ItensIcms.delete;
      Self.Itens.ItensIpi.Registro.ItemNota := Self.Itens.Lista[I].Codigo;
      Self.Itens.ItensIpi.delete;
      Self.Itens.ItensPis.Registro.ItemNota := Self.Itens.Lista[I].Codigo;
      Self.Itens.ItensPis.delete;
      Self.Itens.ItensCofins.Registro.ItemNota := Self.Itens.Lista[I].Codigo;
      Self.Itens.ItensCofins.delete;
      Self.Itens.Registro.Codigo := Self.Itens.Lista[I].Codigo;
      Self.Itens.delete;
    End;
    for I := 0 to pOrder.Items.Count -1 do
    Begin
      with Self.Itens.Registro do
      BEgin
        Codigo            := 0;
        Sequencia         := I+1;
        CodigoPedido      := Self.Registro.Codigo;
        CodigoNota        := 0;
        CodigoProduto     := pOrder.Items[I].Produto;
        Quantidade        := pOrder.Items[I].Quantidade;
        ValorCusto        := 0;
        ValorUnitario     := pOrder.Items[I].ValorUnitario;
        Despachar         := 'S';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := pOrder.Items[I].ValorDesconto;
        AliqDesconto      := pOrder.Items[I].AliquotaDesconto;
        AliqIPI           := 0;
        Operacao          := 'V';
        AliqICMS          := 0;
        if pOrder.Items[I].Estoque > 0 then
          CodigoEstoque     := pOrder.Items[I].Estoque
        else
          CodigoEstoque     := 1;
        if pOrder.Items[I].TabelaPreco > 0 then
          CodigoTabela      := pOrder.Items[I].TabelaPreco
        else
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
      //Controle de Estoque - Insere
      with CtrlEstoque.Registro do
      Begin
        Codigo      := 0;
        Vinculo     := 'P';
        Terminal    := pOrder.Order.Terminal;
        Ordem       := Self.Itens.Registro.CodigoPedido;
        Item        := Self.Itens.Registro.Codigo;
        Estoque     := Self.Itens.Registro.CodigoEstoque;
        Operacao    := 'S';
        Produto     := Self.Itens.Registro.CodigoProduto;
        Quantidade  := Self.Itens.Registro.Quantidade;
        case Self.Registro.Tipo of
          1:Tipo := 'Venda';
          2:Tipo := 'Compra';
          3:Tipo := 'Ajuste';
          4:Tipo := 'Venda';
          5:Tipo := 'Consignação';
        end;
        Data        := Date;
      End;
      CtrlEstoque.Registra;
    End;
  End;
end;


function TControllerPedidoVenda.ValidasaveObjWeb( pOrder: TObjOrderSale): Boolean;
begin
  Result := True;
  {
  if (pOrder.Cliente.Fiscal.Fisica.CPF = '') and (pOrder.Cliente.Fiscal.Juridica.CNPJ = '') then
  Begin
    geralog('TControllerPedido.ValidasaveObjWeb',
            concat(
              'Mensagem: Sem CPF/CNJ :   ',
              ' | Terminal: ', IntToStr(pOrder.OrderSale.Terminal),
              ' | Numero: ', IntToStr(pOrder.OrderSale.Numero),
              ' | Estabelecimento: ', IntToStr(pOrder.Estabelecimento)
            ));
  End;
  }

end;

end.
