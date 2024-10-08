unit ControllerItensNFL;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
       tblItensNFL ,ControllerItensICMS, ControllerItensIPI,ControllerItensPis,
       ControllerItensCofins,ControllerItensII,FireDAC.Stan.Param,
      Generics.Collections,controllerProduto,ControllerItensISSQN,
    ControllerItensNFLTributacao,ControllerExchangeBasis,
    ControllerItensRTR,ControllerItensAvulso, prm_ItensNFL;


Type
  TListaOrdemItem = TObjectList<TItensNFL>;

  TControllerItensNFL = Class(TControllerBase)

  private
    FParametros: TPrmItensNFL;
    function nextCodigo:Integer;
    function getSequencia:Integer;
    procedure setFParametros(const Value: TPrmItensNFL);
  public
    Registro : TItensNFL;
    Lista: TListaOrdemItem;
    Produto : TControllerProduto;
    ItensIcms : TControllerItensICMS;
    ItensIpi : TControllerItensIpi;
    ItensPis : TControllerItensPis;
    ItensCofins : TControllerItensCofins;
    ItensII : TControllerItensII;
    ItensISSQN : TControllerItensISSQN;
    Tributacao : TControllerItensNFLTributacao;
    BaseTroca : TControllerExchangeBasis;
    ItensRTR : TControllerItensRTR;
    ItensAvulso : TControllerItensAvulso;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function salvaByIdInternet:boolean;
    function migra:Boolean;
    function insere:boolean;
    function atualizaParcial:boolean;
    function atualiza:boolean;
    function atualizaFaturamento:boolean;
    procedure getByProduct;
    procedure getByFactoryProduct(ProdutoFab:String);
    procedure getList;
    function delete:Boolean;
    procedure getListByNF;
    procedure deleteByPedido;
    procedure getById;
    procedure clear;
    procedure setITF_Estoque;
    function ExisteItemNoPedido(Pc_Tp_Operacao:String): Boolean;
    function Fc_ValidaExclusao(iCodigoProduto: Integer): boolean;

    procedure Search;
    property Parametros : TPrmItensNFL read FParametros write setFParametros;
  End;

implementation


uses Un_Regra_Negocio, UN_Sistema;

constructor TControllerItensNFL.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensNFL.Create;
  Lista := TListaOrdemItem.Create;
  Produto := TControllerProduto.create(Self);
  ItensIcms := TControllerItensICMS.Create(Self);
  ItensIpi  := TControllerItensIpi.Create(Self);
  ItensPis := TControllerItensPis.Create(Self);
  ItensCofins := TControllerItensCofins.Create(Self);
  ItensII := TControllerItensII.Create(Self);
  ItensISSQN := TControllerItensISSQN.Create(Self);
  Tributacao := TControllerItensNFLTributacao.Create(Self);
  BaseTroca := TControllerExchangeBasis.Create(Self);
  ItensRTR := TControllerItensRTR.Create(Self);
  ItensAvulso := TControllerItensAvulso.Create(Self);
  FParametros := TPrmItensNFL.Create;
end;

destructor TControllerItensNFL.Destroy;
begin
  ItensAvulso.DisposeOf;
  ItensRTR.DisposeOf;
  BaseTroca.DisposeOf;
  Tributacao.DisposeOf;
  ItensISSQN.DisposeOf;
  Lista.DisposeOf;
  ItensII.DisposeOf;
  ItensCofins.DisposeOf;
  ItensIcms.DisposeOf;
  ItensIpi.DisposeOf;
  ItensPis.DisposeOf;
  Produto.DisposeOf;
  Registro.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerItensNFL.atualiza: boolean;
begin
  Result := true;
  UpdateObj(Registro);
end;

function TControllerItensNFL.atualizaFaturamento: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'update "TB_ITENS_NFL" set ',
                '  "ITF_CODNFL" = :"ITF_CODNFL" ',
                ', "ITF_VL_CUSTO" = :"ITF_VL_CUSTO" ',
                ', "ITF_SENTIDO" = :"ITF_SENTIDO" ',
                ', "ITF_IMP_APROX" = :"ITF_IMP_APROX" ',
                'where "ITF_CODIGO" = :"ITF_CODIGO"'
      ));
      ParamByName('ITF_CODIGO').AsInteger     := Registro.Codigo;
      ParamByName('ITF_CODNFL').AsInteger     := Registro.CodigoNota;
      ParamByName('ITF_VL_CUSTO').AsFloat     := Registro.ValorCusto;
      ParamByName('ITF_SENTIDO').AsString := Registro.Sentido;
      ParamByName('ITF_IMP_APROX').asFloat    := Registro.ImpostoAproximado;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerItensNFL.atualizaParcial: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE tb_itens_nfl SET ',
                     'ITF_QTDE = :ITF_QTDE,' ,
                     'ITF_VL_UNIT=:ITF_VL_UNIT ',
                     'WHERE ITF_CODIGO=:ITF_CODIGO '
                  ));
      ParamByName('ITF_QTDE').AsFloat     := Registro.Quantidade;
      ParamByName('ITF_VL_UNIT').AsFloat  := Registro.ValorUnitario;
      ParamByName('ITF_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerItensNFL.clear;
begin
  ClearObj(Registro);
  Lista.Clear;
end;

function TControllerItensNFL.delete: Boolean;
begin
  Result := true;
  try
    deleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerItensNFL.deleteByPedido;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE FROM tb_itens_nfl ',
                      'WHERE ITF_CODPED=:PED_CODIGO '
                  ));

      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerItensNFL.ExisteItemNoPedido(
  Pc_Tp_Operacao: String): Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat('SELECT it.* ' ,
                     ' FROM TB_ITENS_NFL it ' ,
                     ' WHERE ITF_CODPRO =:PRO_CODIGO AND (ITF_CODPED=:ITF_CODPED) and (ITF_OPER=:ITF_OPER) '
      ));
      ParamByName('ITF_OPER').AsString := Pc_Tp_Operacao;
      ParamByName('ITF_CODPED').AsInteger := registro.CodigoPedido;
      ParamByName('PRO_CODIGO').AsInteger := registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      exist := (recordCount > 0);
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(LC_Qry)
  End;
end;

procedure TControllerItensNFL.getByProduct;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_nfl ',
                      'WHERE ITF_CODPED=:PED_CODIGO ',
                      ' AND (ITF_CODPRO =:PRO_CODIGO) '
        ));
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      exist := (recordCount > 0);
      if exist then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(LC_Qry)
  End;
end;


procedure TControllerItensNFL.getByFactoryProduct(ProdutoFab:String);
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT i.* ',
                      'FROM tb_itens_nfl i ',
                      '  inner join tb_produto p ',
                      '  on (p.pro_codigo  = i.ITF_CODPRO) ',
                      'WHERE ITF_CODPED=:PED_CODIGO ',
                      ' AND (PRO_CODIGOFAB =:PRO_CODIGOFAB) '
        ));
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ParamByName('PRO_CODIGOFAB').AsString := ProdutoFab;
      Active := True;
      FetchAll;
      First;
      exist := (recordCount > 0);
      if exist then get(Lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerItensNFL.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerItensNFL.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensNFL;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_nfl ',
                      'WHERE ITF_CODIGO IS NOT NULL '
                      ));
      if Registro.CodigoPedido > 0 then
        sql.add(' and ITF_CODPED=:PED_CODIGO ');
      sql.add(' ORDER BY ITF_CODIGO ');
      if Registro.CodigoPedido > 0 then
        ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensNFL.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerItensNFL.getListByNF;
var
  Lc_Qry : TSTQuery;
  LITem : TItensNFL;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_nfl ',
                      'WHERE ITF_CODNFL=:NFL_CODIGO ',
                      ' ORDER BY ITF_CODIGO '));

      ParamByName('NFL_CODIGO').AsInteger := Registro.CodigoNota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensNFL.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerItensNFL.getSequencia: Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat('SELECT MAX(ITF_SEQUENCIA) ',
                     'FROM TB_ITENS_NFL ',
                     'WHERE ITF_CODPED=:PED_CODIGO '
                     ));
      Parambyname('PED_CODIGO').asInteger := Registro.CodigoPedido;
      Active := True;
      fetchall;
      if recordcount > 0 then
        Result := FieldByName('MAX').AsInteger + 1
      else
        Result := 1;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerItensNFL.nextCodigo:Integer;
begin
  Result :=  Generator('GN_ITENS_NFL');
end;

function TControllerItensNFL.insere: boolean;
begin
  Result := true;
  Registro.Codigo := nextCodigo;
  if registro.Sequencia = 0 then
    registro.Sequencia := getSequencia;
  InsertObj(Registro);
end;

function TControllerItensNFL.migra: Boolean;
begin
  Result := true;
  InsertObj(Registro);
end;

function TControllerItensNFL.salva: boolean;
begin
  Result := true;
  if registro.Codigo = 0 then
    Registro.Codigo := nextCodigo;
  if registro.Sequencia = 0 then
    registro.Sequencia := getSequencia;
  SaveObj(Registro);
end;


function TControllerItensNFL.salvaByIdInternet: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    //Fiz errado no controle errado tendo uma função para isso no controller pedido  - analiando se vale a pena manter
    with Lc_Qry,Registro do
    Begin
      sql.add(concat(
              'UPDATE OR INSERT INTO TB_PEDIDO (PED_CODIGO, PED_NUMERO, PED_TIPO, ',
              '                                 PED_CODUSU, PED_DATA, PED_CODEMP, ',
              '                                 PED_CODVDO, PED_CODFPG, PED_PRAZO, ',
              '                                 PED_CODEND, PED_QT_PRODUTO, PED_VL_PRODUTO, ',
              '                                 PED_VL_IPI, PED_VL_FRETE, PED_ALIQ_DESCONTO, ',
              '                                 PED_VL_DESCONTO, PED_VL_PEDIDO, PED_FATURADO, ',
              '                                 PED_TP_CONTATO, PED_DT_ENTREGA, PED_NUM_ANT, ',
              '                                 PED_DT_ALTERA, PED_VL_SERVICO, PED_CODTRP, PED_CTA_FRETE, ',
              '                                 PED_EMUSO, PED_CODNAT, PED_CODENT, PED_CODFAT, PED_CODCOB, ',
              '                                 PED_CODMHA, PED_APROVADO, PED_VL_ODESPESA, PED_CODCEF, ',
              '                                 PED_ID_ECF, PED_NUM_ORCA, PED_VALIDADE, PED_CODWEB, ',
              '                                 PED_VL_CREDITO, PED_CODNEG, PED_ENTREGA, PED_GARANTIA, ',
              '                                 PED_TP_CUSTOMER, PED_INDPRES, PED_VL_ST, PED_TERMINAL) ',
              '                         VALUES (:PED_CODIGO, :PED_NUMERO, :PED_TIPO, :PED_CODUSU, :PED_DATA, ',
              '                                 :PED_CODEMP, :PED_CODVDO, :PED_CODFPG, :PED_PRAZO, :PED_CODEND, ',
              '                                 :PED_QT_PRODUTO, :PED_VL_PRODUTO, :PED_VL_IPI, :PED_VL_FRETE, ',
              '                                 :PED_ALIQ_DESCONTO, :PED_VL_DESCONTO, :PED_VL_PEDIDO, :PED_FATURADO, ',
              '                                 :PED_TP_CONTATO, :PED_DT_ENTREGA, :PED_NUM_ANT, :PED_DT_ALTERA, ',
              '                                 :PED_VL_SERVICO, :PED_CODTRP, :PED_CTA_FRETE, :PED_EMUSO,  ',
              '                                 :PED_CODNAT, :PED_CODENT, :PED_CODFAT, :PED_CODCOB, :PED_CODMHA, ',
              '                                 :PED_APROVADO, :PED_VL_ODESPESA, :PED_CODCEF, :PED_ID_ECF, ',
              '                                 :PED_NUM_ORCA, :PED_VALIDADE, :PED_CODWEB, :PED_VL_CREDITO, ',
              '                                 :PED_CODNEG, :PED_ENTREGA, :PED_GARANTIA, :PED_TP_CUSTOMER, ',
              '                                 :PED_INDPRES, :PED_VL_ST, :PED_TERMINAL) ',
              '                       MATCHING (PED_CODMHA, PED_CODWEB, PED_TERMINAL); '
        ));
      if Codigo = 0 then
        Codigo := nextCodigo;
      ParamByName('ITF_CODIGO').AsInteger     :=  Codigo;
      ParamByName('ITF_SEQUENCIA').AsInteger  :=  Sequencia;
      ParamByName('ITF_CODPED').AsInteger     :=  CodigoPedido;
      ParamByName('ITF_CODNFL').AsInteger     :=  CodigoNota;
      ParamByName('ITF_CODPRO').AsInteger     :=  CodigoProduto;
      ParamByName('ITF_QTDE').AsFloat         :=  Quantidade;
      ParamByName('ITF_VL_CUSTO').AsFloat     :=  ValorCusto;
      ParamByName('ITF_VL_UNIT').AsFloat      :=  ValorUnitario;
      ParamByName('ITF_DESPACHO').AsString    :=  Despachar;
      ParamByName('ITF_ESTOQUE').AsString     :=  Estoque;
      ParamByName('ITF_AQ_COM').AsFloat       :=  AliqComissao;
      ParamByName('ITF_VL_DESC').AsFloat      :=  ValorDesconto;
      ParamByName('ITF_AQ_DESC').AsFloat      :=  AliqDesconto;
      ParamByName('ITF_AQ_IPI').AsFloat       :=  AliqIPI;
      ParamByName('ITF_OPER').AsString        :=  Operacao;
      ParamByName('ITF_AQ_ICMS').AsFloat      :=  AliqICMS;
      ParamByName('ITF_CODEST').AsInteger     :=  CodigoEstoque;
      ParamByName('ITF_CODTPR').AsInteger     :=  CodigoTabela;
      ParamByName('ITF_ALTURA').AsFloat       :=  Altura;
      ParamByName('ITF_LARGURA').AsFloat      :=  Largura;
      ParamByName('ITF_SENTIDO').AsString     :=  Sentido;
      ParamByName('ITF_COMPRA').AsString      :=  PedidoCompra;
      ParamByName('ITF_ITEM_COMPRA').AsString :=  ItemCompra;
      ParamByName('ITF_IMP_APROX').AsFloat    :=  ImpostoAproximado;
      ParamByName('ITF_NR_PECAS').AsFloat     :=  NumeroPecas;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


procedure TControllerItensNFL.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TItensNFL;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        'SELECT TB_ITENS_NFL.*, ' +//(ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL, ' +
        '       Tb_produto.PRO_CODIGOFAB, Tb_produto.PRO_DESCRICAO, Tb_pedido.PED_CODMHA ' +
        'FROM TB_ITENS_NFL ' +
        'JOIN TB_PEDIDO Tb_pedido ON Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO ' +
        'JOIN TB_PRODUTO Tb_produto ON Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO ' +
        'WHERE 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND Tb_itens_nfl.ITF_CODIGO = :ITF_CODIGO';
        ParamByName('ITF_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.CodigoPedido > 0 then
      begin
        SQL.Text := SQL.Text + ' AND Tb_itens_nfl.ITF_CODPED = :ITF_CODPED';
        ParamByName('ITF_CODPED').AsInteger := FParametros.FieldName.CodigoPedido;
      end;

      if FParametros.FieldName.CodigoEstabelecimento > 0 then
      begin
        SQL.Text := SQL.Text + ' AND Tb_pedido.PED_CODMHA = :PED_CODMHA';
        ParamByName('PED_CODMHA').AsInteger := FParametros.FieldName.CodigoEstabelecimento;
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TItensNFL.Create;
        get(Lc_Qry, LITem);

        LITem.SubTotal := Lc_Qry.FieldByName('ITF_QTDE').AsFloat * Lc_Qry.FieldByName('ITF_VL_UNIT').AsFloat;//Lc_Qry.FieldByName('ITF_VL_SUBTOTAL').AsFloat;
        LITem.CodigoFabrica := Lc_Qry.FieldByName('PRO_CODIGOFAB').AsString;
        LITem.DescricaoProduto := Lc_Qry.FieldByName('PRO_DESCRICAO').AsString;
        LITem.CodigoEstabelecimento := Lc_Qry.FieldByName('PED_CODMHA').AsInteger;

        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerItensNFL.setFParametros(const Value: TPrmItensNFL);
begin
  FParametros := Value;
end;

procedure TControllerItensNFL.setITF_Estoque;
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              'UPDATE tb_ITENS_NFL SET '+
              'ITF_ESTOQUE =:ITF_ESTOQUE '+
              'WHERE ITF_CODPED=:PED_CODIGO'
                     ));
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ParamByName('ITF_ESTOQUE').AsString := Registro.Estoque;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerItensNFL.Fc_ValidaExclusao(iCodigoProduto: Integer): boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := true;

  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Text := 'SELECT DISTINCT ITF_CODPRO FROM TB_ITENS_NFL WHERE ITF_CODPRO=:PRO_CODIGO';
      ParamByName('PRO_CODIGO').AsInteger := iCodigoProduto;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        Result := False
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
