unit ControllerDskConsignment;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDskConsignment ,Un_MSg,
      System.Generics.Collections,ControllerDskConsignmentOperation,objOrderConsignment,
      tblOrderItem,ControllerPedidoVenda;

Type
  TListConsignment  =  TObjectList<TDskConsignment>;
  TControllerDskConsignment = Class(TControllerBase)

  private
  protected

  public
    Registro : TDskConsignment;
    Operacoes : TControllerDskConsignmentOperation;
    Lista : TListConsignment;
    UsuarioIntegracao : Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure clear;
    function salva:boolean;
    function Insert:boolean;
    function replace:boolean;
    procedure getList;
    function update:boolean;
    Function delete:boolean;
    procedure getbyId;
    procedure getByCustomer;
    procedure saveObjWeb(pOrder:TObjOrderConsignment);
  End;

implementation

{ TControllerDskConsignment }

procedure TControllerDskConsignment.clear;
begin
  clearObj(Registro);
  Lista.Clear;
  Operacoes.clear;
end;

constructor TControllerDskConsignment.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskConsignment.Create;
  Operacoes := TControllerDskConsignmentOperation.create(self);
  Lista := TListConsignment.Create;
end;

function TControllerDskConsignment.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDskConsignment.Destroy;
begin
  Operacoes.DisposeOf;
  lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerDskConsignment.getbyId;
begin

end;

procedure TControllerDskConsignment.getByCustomer;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat('select * ',
                     'from tb_order_consignment ',
                     'where ( tb_customer_id =:tb_customer_id ) '
                     ));
      ParamByName('tb_customer_id').AsInteger := Registro.Cliente;
      Active := True;
      FetchAll;
      exist := ( recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskConsignment.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TDskConsignment;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CONSIGNMENT ',
                      ' where ( TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) '
      ));
      if Registro.Cliente > 0 then
        sql.add(' AND (TB_CUSTOMER_ID=:TB_CUSTOMER_ID ) ');

      if Registro.Estabelecimento > 0 then
        ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;

      if Registro.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Registro.Cliente;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TDskConsignment.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerDskConsignment.Insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PROMOTION');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerDskConsignment.replace: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PROMOTION');
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskConsignment.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PROMOTION');
  SaveObj(Registro);
end;

procedure TControllerDskConsignment.saveObjWeb(pOrder: TObjOrderConsignment);
Var
  I : Integer;
  LcPedido : TControllerPedidoVenda;
begin
  Try
    LcPedido := TControllerPedidoVEnda.Create(nil);
    with LcPedido do
    Begin
      //Informar Codigo WEb e Vendedor
      Registro.CodigoWeb         := pOrder.Order.Codigo;
      Vendedor.Registro.CPFCNPJ  := pOrder.DocFiscalVendedor;
      Registro.Vendedor          := LcPedido.Vendedor.getIDByDoc;


      if not WebFaturado then
      Begin
        //Verifica se esta faturado e não atualiza
        Registro.Codigo                := 0;
        Registro.Numero                := 0;
        Registro.Tipo                  := 5;
        if pOrder.Order.Data >0  then
          Registro.Data              := pOrder.Order.Data
        else
          Registro.Data              := Date;

        Cliente.Empresa.Clear;
        Cliente.Empresa.exist := False;
        //caso não venha com CPF nem CNPJ vamos criar uma empresa para poder receber o pedido e o cliente alterar depois
        if (Trim(pOrder.Fiscal.Fisica.CPF) = '') and (Trim(pOrder.Fiscal.Juridica.CNPJ) = '') then
        Begin
          Cliente.criarClienteSemCPFCNPJ;
        End
        else
        Begin
          //Busca Por CPF
          if Trim(pOrder.Fiscal.Fisica.CPF) <> '' then
          Begin
            Cliente.Empresa.Registro.CpfCNPJ := pOrder.Fiscal.Fisica.CPF;
            Cliente.Empresa.getByDocumento;
          End;
          //Se não encontrou buscar por CNPJ
          if not LcPedido.Cliente.Empresa.exist then
          Begin
            Cliente.Empresa.Registro.CpfCNPJ := pOrder.Fiscal.Juridica.CNPJ;
            Cliente.Empresa.getByDocumento;
          End;
          //Caso não encontre precisa salvar o cliente
          if not LcPedido.Cliente.Empresa.exist then
          Begin
            Cliente.Empresa.saveObjWeb(pOrder.Fiscal);
            Cliente.saveCustomer(pOrder.Cliente);
          End;
        End;
        //Registra o codigo da Empresa no pedido
        Registro.Empresa                 := Cliente.Empresa.Registro.Codigo;
        Endereco.Registro.CodigoEmpresa  := Cliente.Empresa.Registro.Codigo;
        Endereco.getByEmpresa;
        if not Endereco.exist then
        BEgin
          Endereco.Registro.CodigoEmpresa := Cliente.Empresa.Registro.Codigo;
          Endereco.AutoEndereco;
        End;
        if Endereco.Registro.Codigo >0 then
          Registro.Endereco              := Endereco.Registro.Codigo
        else
          Registro.Endereco              := 1;
        LcPedido.Registro.Usuario               := self.UsuarioIntegracao;//cuidado com o mesmo campo no contorle pedido

        FormaPagto.Registro.Descricao := 'CARTEIRA';
        FormaPagto.getByPartDescription;
        Registro.FormaPagto            := FormaPagto.Registro.Codigo;

        Registro.Prazo                 := '000 - À VISTA';

        Registro.QtdeProdutos          := 0;
        Registro.ValorProdutos         := 0;
        Registro.ValorIPI              := 0;
        Registro.ValorFrete            := 0;
        Registro.AliqDesconto          := 0;
        Registro.ValorDesconto         := 0;
        Registro.ValorPedido           := 0;
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
        Registro.Aprovado              := 'S';
        Registro.ValorSubstTributaria  := 0;
        Registro.ValorOutrasDEspesas   := 0;
        Registro.Observacao            := pOrder.Order.Observacao;
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
        Itens.Registro.CodigoPedido := Registro.Codigo;
        Itens.deleteByPedido;
        for I := 0 to pOrder.Items.Count -1 do
        Begin
          with Itens.Registro do
          BEgin
            Codigo            := 0;
            Sequencia         := pOrder.Items[I].Codigo;
            CodigoPedido      := Registro.Codigo;
            CodigoNota        := 0;
            CodigoProduto     := pOrder.Items[I].Produto;
            Quantidade        := pOrder.Items[I].Quantidade;
            ValorCusto        := 0;
            ValorUnitario     := pOrder.Items[I].ValorUnitario;
            Despachar         := 'S';
            Estoque           := 'N';
            AliqComissao      := 0;
            ValorDesconto     := pOrder.Items[I].ValorDesconto;
            AliqDesconto      := pOrder.Items[I].AliquotaDesconto;
            AliqIPI           := 0;
            Operacao          := 'S';//CON[S]IGNADO
            AliqICMS          := 0;
            CodigoEstoque     := 0;
            CodigoTabela      := 1;
            Altura            := 0;
            Largura           := 0;
            Sentido           := 'S';
            PedidoCompra      := '0';
            ItemCompra        := '0';
            ImpostoAproximado := 0;
            NumeroPecas       := 0;
          End;
          Itens.insere;

          with Operacoes.Registro do
          Begin
            PedidoItem       := Itens.Registro.Codigo;
            ItemOrdem        := pOrder.Operacoes[I].ItemOrdem;
            Estabelecimento  := pOrder.Estabelecimento;
            Terminal         := pOrder.Operacoes[I].Terminal;
            Ordem            := pOrder.Operacoes[I].Ordem;
            Data             := pOrder.Operacoes[I].Data;
            Tipo             := pOrder.Operacoes[I].Tipo;
          End;
          Operacoes.salva;
        End;
      End;
    End;
    //Salvar o Consignação
    Registro.Codigo           := pOrder.Consignacao.Codigo;
    Registro.Estabelecimento  := pOrder.Estabelecimento;
    Registro.Terminal         := pOrder.Consignacao.Terminal;
    Registro.Cliente          := pOrder.Consignacao.Cliente;
    Registro.Vendedor         := pOrder.Consignacao.Vendedor;
    self.salva;
  Finally
    LcPedido.disposeOf;
  End;

end;

function TControllerDskConsignment.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
