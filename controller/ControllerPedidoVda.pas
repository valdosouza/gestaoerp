unit ControllerPedidoVda;

interface
uses ControllerPedido,ControllerCliente, System.Classes,
    ControllerColaborador, System.SysUtils,ObjOrderSale,tblPEdido, TblOrderItem,
    ObjCustomer, STQuery,ControllerBase;

Type

  TControllerPedidoVda = Class(TControllerPedido)

  private

  public
    Cliente : TControllerCliente;
    Vendedor : TControllerColaborador;
    Obj : TObjOrderSale;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FillDataObjeto(PcRegistro: TPedido);
    function ValidasaveObjWeb(pOrder:TObjOrderSale):Boolean;
    procedure saveObjWeb(pOrder:TObjOrderSale);
    procedure ClearDataObjecto;
    function SaveAddressDelivery:Boolean;
    procedure DeleteAddressDelivery;
    procedure AtualizaVendedor;
  End;
implementation

{ TControllerPedidoVda }

procedure TControllerPedidoVda.AtualizaVendedor;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add(concat(
             ' UPDATE TB_PEDIDO SET ',
             ' PED_CODVDO =:PED_CODVDO ',
             ' WHERE PED_CODIGO =:PED_CODIGO '
      ));
      //Passagem de Parametros
      ParamByName('PED_CODVDO').AsInteger := Registro.Vendedor;
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedidoVda.ClearDataObjecto;
begin
  clearObj(Obj)
end;

constructor TControllerPedidoVda.Create(AOwner: TComponent);
begin
  inherited;
  Cliente := TControllerCliente.create(self);
  Vendedor := TControllerColaborador.create(self);

  Obj := TObjOrderSale.Create;
end;

procedure TControllerPedidoVda.DeleteAddressDelivery;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add(concat(
             ' DELETE FROM TB_PIZ_ENTREGA ',
             ' WHERE PEG_CODPED =:PEG_CODPED '
      ));
      //Passagem de Parametros
      ParamByName('PEG_CODPED').AsInteger       := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

destructor TControllerPedidoVda.Destroy;
begin
  Obj.Destroy;
  FreeAndNil(Vendedor);
  FreeAndNil(Cliente);
  inherited;
end;

procedure TControllerPedidoVda.FillDataObjeto(PcRegistro: TPedido);
Var
  I : Integer;
  lcitems : TOrderItem;
begin
  //Order
  Obj.Order.Codigo          := PcRegistro.Codigo;
  Obj.Order.Estabelecimento := Obj.Estabelecimento;
  Obj.Order.Terminal        := Obj.Terminal;
  Obj.Order.Data            := PcRegistro.Data;
  Obj.Order.Observacao      := PcRegistro.Observacao;
  Obj.Order.Origem          := 'D';
  Obj.Order.Status          := PcRegistro.Faturado;
  Obj.Order.SendoUsado      := '';

  //OrderSale
  Obj.OrderSale.Codigo          := Obj.Order.Codigo;
  Obj.OrderSale.Estabelecimento := Obj.Estabelecimento;
  Obj.OrderSale.Terminal        := Obj.Terminal;
  Obj.OrderSale.Vendedor        := 0;
  Obj.OrderSale.Numero          := PcRegistro.Numero;
  Obj.OrderSale.Cliente         := 0;

  //Referencia Doc Fiscal CPF/CNPJ
  Cliente.Registro.Codigo := PcRegistro.Empresa;
  Cliente.getById;

  Cliente.Obj.Estabelecimento := Obj.Estabelecimento;
  Cliente.fillDataObjeto(Cliente.Registro,Cliente.Obj);


   //Vendedor
  Self.Vendedor.Registro.Codigo := PcRegistro.Vendedor;
  Self.Vendedor.getbyId;
  obj.DocFiscalVendedor := Self.Vendedor.Registro.CPFCNPJ;

  //Items Lembrando que o NFL_Codigo será o tb_order_id
  Itens.Registro.CodigoNota := PcRegistro.Codigo;
  Itens.getListByNF;
  for I := 0 to Itens.Lista.Count -1 do
  Begin
    lcitems     := TOrderItem.Create;
    lcitems.Codigo            := Itens.Lista[I].Codigo;
    lcitems.Estabelecimento   := Obj.Estabelecimento;
    lcitems.Ordem             := Itens.Lista[I].CodigoPedido;
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
  Obj.Totalizer.Codigo            := PcRegistro.Codigo;
  Obj.Totalizer.Estabelecimento   := Obj.Estabelecimento;
  Obj.Totalizer.Terminal          := Obj.Terminal;
  Obj.Totalizer.ItemsQuantidade   := Obj.Items.Count;
  Obj.Totalizer.ProdutoQuantidade := PcRegistro.QtdeProdutos;
  Obj.Totalizer.ValorProduto      := PcRegistro.ValorProdutos;
  Obj.Totalizer.IPIValor          := PcRegistro.ValorIPI;
  Obj.Totalizer.AlíquotaDesconto  := PcRegistro.AliqDesconto;
  Obj.Totalizer.ValorDesconto     := PcRegistro.ValorDesconto;
  Obj.Totalizer.ValorDespesas     := PcRegistro.ValorOutrasDEspesas;
  Obj.Totalizer.ValorTotal        := PcRegistro.ValorPedido;

  //Billing
  FormaPagto.Registro.Codigo :=  PcRegistro.FormaPagto;
  FormaPagto.getById;
  Obj.FormaPagamento          := FormaPagto.Registro.Descricao;
  Obj.Billing.Codigo          := PcRegistro.Codigo;
  Obj.Billing.Estabelecimento := Obj.Estabelecimento;
  Obj.Billing.Terminal        := Obj.Terminal;
  Obj.Billing.FormaPagamento  := PcRegistro.FormaPagto;
  Obj.Billing.Parcelas        := Copy(PcRegistro.Prazo,1,3);
  Obj.Billing.Prazo           := Copy(PcRegistro.Prazo,7,Length(PcRegistro.Prazo )- 6);
  Obj.Billing.Responsavel     := 0;
end;

function TControllerPedidoVda.SaveAddressDelivery: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.add(concat(
             ' UPDATE OR INSERT INTO TB_PIZ_ENTREGA (PEG_CODPED, PEG_TM_PEDIDO)   ',
             '                               VALUES (:PEG_CODPED, :PEG_TM_PEDIDO) ',
             '                             MATCHING (PEG_CODPED);                 '
      ));
      //Passagem de Parametros
      ParamByName('PEG_CODPED').AsInteger       := Registro.Codigo;
      ParamByName('PEG_TM_PEDIDO').AsAnsiString := Copy(TimeToStr(now),1,5);
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedidoVda.saveObjWeb(pOrder: TObjOrderSale);
Var
  I : Integer;
  LcItem : TOrderItem;
begin
  //Informar Codigo WEb e Vendedor
  Registro.CodigoWeb             := pOrder.Order.Codigo;
  Self.Vendedor.Registro.CPFCNPJ := pOrder.DocFiscalVendedor;
  Registro.Vendedor := Self.Vendedor.getIDByDoc;
  pOrder.Cliente.Vendedor := Registro.Vendedor;

  if not WebFaturado then
  Begin
    //Verifica se esta faturado e não atualiza
    Registro.Codigo                := 0;
    Registro.Numero                := 0;
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
        pOrder.Cliente.Codigo := pOrder.Fiscal.Entidade.Entidade.Codigo;
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
    Registro.FormaPagto            := FormaPagto.Registro.Codigo;

    if trim(pOrder.Billing.Prazo) <> '' then
      Registro.Prazo                 := pOrder.Billing.Prazo
    else
      Registro.Prazo                 := '000 - À VISTA';


    Registro.QtdeProdutos          := porder.Totalizer.ItemsQuantidade;
    Registro.ValorProdutos         := porder.Totalizer.ValorProduto;
    Registro.ValorIPI              := porder.Totalizer.IPIValor;
    Registro.ValorFrete            := 0;
    Registro.AliqDesconto          := porder.Totalizer.AlíquotaDesconto;
    Registro.ValorDesconto         := porder.Totalizer.ValorDesconto;
    Registro.ValorPedido           := porder.Totalizer.ValorTotal;
    Registro.Faturado              := porder.Order.Status;
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
    Registro.Observacao            := porder.Order.Observacao;
    Registro.NumeroOrcamento       := 0;
    Registro.Validade              := Date;
    Registro.ValorCredito          := 0;
    Registro.CodigoNegocio         := 0;
    Registro.Entrega               := '';
    Registro.Garantia              := '';
    Registro.OrigemCliente         := '';
    Registro.IndicaPresenca        := 1;
    salvaPedidoInternet;
    //Salvar os itens
    Self.Itens.Registro.CodigoPedido := Self.Registro.Codigo;
    Self.Itens.deleteByPedido;
    for I := 0 to pOrder.Items.Count -1 do
    Begin
      LcItem := pOrder.Items[I];
      with Self.Itens.Registro do
      BEgin
        Codigo            := 0;
        Sequencia         := I+1;
        CodigoPedido      := Self.Registro.Codigo;
        CodigoNota        := 0;
        CodigoProduto     := LcItem.Produto;
        Quantidade        := LcItem.Quantidade;
        ValorCusto        := 0;
        ValorUnitario     := LcItem.ValorUnitario;
        Despachar         := 'S';
        Estoque           := 'S';
        AliqComissao      := 0;
        ValorDesconto     := LcItem.ValorDesconto;
        AliqDesconto      := LcItem.AliquotaDesconto;
        AliqIPI           := 0;
        Operacao          := 'V';
        AliqICMS          := 0;
        if LcItem.Estoque > 0 then
          CodigoEstoque     := LcItem.Estoque
        else
          CodigoEstoque     := 1;
        if LcItem.TabelaPreco > 0 then
          CodigoTabela      := LcItem.TabelaPreco
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
      //Controle de Estoque - Deleta por item
      with CtrlEstoque.Registro do
      Begin
        Vinculo     := 'P';
        Item        := Self.Itens.Registro.Codigo;
      End;
      CtrlEstoque.delete;
      //Controle de Estoque - Insere
      with CtrlEstoque.Registro do
      Begin
        Codigo      := 0;
        Terminal    := Self.Registro.Terminal;
        Vinculo     := 'P';
        Ordem       := Self.Itens.Registro.CodigoPedido;
        Item        := Self.Itens.Registro.Codigo;
        Estoque     := Self.Itens.Registro.CodigoEstoque;
        Operacao    := 'S';
        Produto     := Self.Itens.Registro.CodigoProduto;
        Quantidade  := Self.Itens.Registro.Quantidade;
        Tipo        := 'Venda';
        Data        := Date;
      End;
      CtrlEstoque.Registra;
    End;
  End;

end;

function TControllerPedidoVda.ValidasaveObjWeb(pOrder: TObjOrderSale): Boolean;
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
