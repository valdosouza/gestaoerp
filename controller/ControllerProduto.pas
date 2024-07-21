unit ControllerProduto;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,Vcl.Forms,
      tblProduto ,Un_MSg,ControllerMedida,FireDAC.Stan.Param,
      Generics.Collections,controllerPreco,ObjMerchandise,ControllerEmbalagem,
      controllerEstoques,ControllerMarcaProduto,ControllerGRupos,ControllerCtrlEstoque,
      ControllerTabelaPreco,
      tblStockBalance, tblPrice,ObjStockList,ObjPriceList, System.StrUtils;




Type
  TListaProdutos = TObjectList<TProduto>;

  TProdutoPizza = class
  private
    FDescricao: String;
    FCodigo: Integer;
    FMedida: String;
    procedure setFCodigo(const Value: Integer);
    procedure setFDescricao(const Value: String);
    procedure setFMedida(const Value: String);
  public
    property Codigo : Integer read FCodigo write setFCodigo;
    property Descricao : String read FDescricao write setFDescricao;
    property Medida: String read FMedida write setFMedida;

  end;

  TControllerProduto = Class(TControllerBase)
  private

  protected

  public
    Registro : TProduto;
    Lista : TListaProdutos;
    Marca : TControllerMarcaProduto;
    Medida : TControllerMedida;
    Embalagem : TControllerEmbalagem;
    Preco : TcontrollerPreco;
    TabelaPreco :  TControllerTabelaPreco;
    Estoque : TcontrollerEstoques;
    Grupo : TControllerGRupos;
    MovimentoEStoque :TControllerCtrlEstoque;
    Obj  : TObjMerchandise;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    Function migra:Boolean;
    procedure getbyId;
    procedure getProdutoToSincronia;
    function getbyFactoryProduct:Boolean;
    function getbyBarCode:Boolean;
    function getCusto:Real;
    function getValorBaseTroca:Real;
    function getFromXML(Fc_Cd_Fornecedor,Fc_cd_Produto,Fc_Cd_Barras:String) : Boolean;
    function getPeso:Real;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteaLL:boolean;
    function getProdutoAvulso:Boolean;
    procedure ReOrdenaSequenciaCodigo;
    procedure getList(limite:String);
    procedure getListSimples(limite:String);
    function getDescricao:String;
    function getField(codigo:Integer;Field:String):String;
    Function getByDescricao(descricao:String):Integer;
    procedure MarcaPromocao(Codigo:Integer;Ativa:Boolean);
    procedure clear;
    function saveDatawebObjeto(DObj : TObjMerchandise):Boolean;
    function temmovimento:Boolean;
    procedure FillDataObjects(prod: TProduto;ObjMer:TObjMerchandise; institutioWebId:Integer);
    procedure MigraSelf(Lc_Qry: TSTQuery);
    PROCEDURE AtualizaSeries(Operacao,Disponivel:String;ItemID:Integer);
    procedure Ativa;
    procedure DesativarTodos(pCodMha: Integer);
    procedure AtualizaCusto;
    procedure AtualizaUltimoCusto;
    procedure AtualizaCategoria;
    function getByExternalCodeIfood(CodigoMedida, Codigoitem:Integer):TProdutoPizza;
  End;

implementation

uses Un_Regra_Negocio;


procedure TControllerProduto.Ativa;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                'PRO_ATIVO = :PRO_ATIVO ',
                'WHERE ( PRO_CODIGO=:PRO_CODIGO) '
      ));
      ParamByName('PRO_ATIVO').AsString := Registro.Ativo;
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.AtualizaCategoria;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    //Tanto faz o objeto e somente para usar a funçao do Generator
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE TB_PRODUTO SET ',
                     'PRO_CODCAT=:PRO_CODCAT ',
                     'WHERE PRO_CODIGO=:PRO_CODIGO'
      ));
      Active := False;
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('PRO_CODCAT').AsInteger := Registro.Categoria;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.AtualizaCusto;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.add( concat(
               'UPDATE TB_PRODUTO SET ',
               'PRO_VL_CUSTOANT     = PRO_VL_CUSTO, ',
               'PRO_VL_CUSTO        =:PRO_VL_CUSTO, ',
               'PRO_VL_CUSTOMEDANT  = PRO_VL_CUSTOMED, ',
               'PRO_VL_CUSTOMED     =:PRO_VL_CUSTOMED,  ',
               'PRO_ATIVO           = ''S'' ',
               'WHERE (PRO_CODIGO   =:PRO_CODIGO) '
      ));
      ParamByName('PRO_VL_CUSTO').asfloat     := REgistro.VAlorCusto;
      ParamByName('PRO_VL_CUSTOMED').asfloat  := REgistro.ValorCustoMedio;
      ParamByName('PRO_CODIGO').asfloat       := REgistro.Codigo;
      execSql;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerProduto.AtualizaSeries(Operacao,Disponivel: String;ItemID:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      if Operacao = 'S' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        SQL.Clear;
        sql.Add(concat('UPDATE TB_SERIE_PRODUTO SET SRP_DISPON =:SRP_DISPON WHERE SRP_CODSAI=:SRP_CODSAI '));
        Active := False;
        ParamByName('SRP_DISPON').AsString := Disponivel;
        ParamByName('SRP_CODSAI').AsInteger := ItemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      end
      else
      if Operacao = 'E' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        Active := False;
        SQL.Clear;
        sql.Add(concat('UPDATE TB_SERIE_PRODUTO SET SRP_DISPON =:SRP_DISPON WHERE SRP_CODENT =:SRP_CODENT '));
        ParamByName('SRP_DISPON').AsString := Disponivel;
        ParamByName('SRP_CODENT').AsInteger := ItemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      end
      else
      if Operacao = 'A' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        //exclui as series de entrada
        Active := False;
        SQL.Clear;
        sql.Add(concat('DELETE FROM TB_SERIE_PRODUTO SET WHERE SRP_CODENT:SRP_CODENT '));
        ParamByName('SRP_CODENT').AsInteger := ItemId;
        ExecSQL;
        //exclui as series de Saida
        Active := False;
        SQL.Clear;
        sql.Add(concat('DELETE FROM TB_SERIE_PRODUTO SET WHERE SRP_CODSAI:SRP_CODSAI '));
        ParamByName('SRP_CODSAI').AsInteger := itemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
  //Executa a Ação

end;

procedure TControllerProduto.AtualizaUltimoCusto;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.add( concat(
               'UPDATE TB_PRODUTO SET ',
               'PRO_VL_CUSTO_LAST =:PRO_VL_CUSTO_LAST ',
               'WHERE (PRO_CODIGO   =:PRO_CODIGO) '
      ));
      ParamByName('PRO_VL_CUSTO_LAST').asfloat  := REgistro.UltimoCusto;
      ParamByName('PRO_CODIGO').asfloat         := REgistro.Codigo;
      execSql;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.clear;
begin
  clearObj(registro);
end;

constructor TControllerProduto.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TProduto.Create;
  Marca     := TControllerMarcaProduto.Create(Self);
  Medida    := TControllerMedida.Create(Self);
  Embalagem := TControllerEmbalagem.Create(Self);
  Lista     := TListaProdutos.Create;
  Preco     := TcontrollerPreco.Create(Self);
  Estoque   := TcontrollerEstoques.Create(Self);
  Grupo     := TControllerGRupos.Create(Self);
  MovimentoEStoque := TControllerCtrlEstoque.Create(Self);
  Obj     := TObjMerchandise.create;
  TabelaPreco :=  TControllerTabelaPreco.Create(Self);
end;

function TControllerProduto.delete: boolean;
begin
  Result := True;
  Try
    MovimentoEStoque.Registro.Produto := Registro.Codigo;
    MovimentoEStoque.deleteByProduto;
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerProduto.deleteaLL: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add('DELETE FROM TB_PRODUTO ');
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.DesativarTodos(pCodMha: Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                'PRO_ATIVO = ''N'' ',
                'WHERE (PRO_TIPO <> ''S'') ',
                ' AND (PRO_CODMHA =:PRO_CODMHA) '
              ));
      ParamByName('PRO_CODMHA').AsInteger := pCodMha;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

destructor TControllerProduto.Destroy;
begin
  TabelaPreco.DisposeOf;
  Obj.Destroy;
  MovimentoEstoque.DisposeOf;
  Estoque.DisposeOf;
  Marca.DisposeOf;
  Preco.DisposeOf;
  Embalagem.DisposeOf;
  Registro.DisposeOf;
  Medida.DisposeOf;
  Lista.DisposeOf;
  Grupo.DisposeOf;
  inherited;

end;


procedure TControllerProduto.FillDataObjects(prod: TProduto;
  ObjMer: TObjMerchandise; institutioWebId: Integer);
var
  LcOriMarca : TControllerMarcaProduto;
  LcOriMedida : TControllerMedida;
  LcOriEmbalagem : TControllerEmbalagem;
begin
  LcOriMarca := TControllerMarcaProduto.Create(Self);
  LcOriMedida := TControllerMedida.Create(Self);
  LcOriEmbalagem := TControllerEmbalagem.Create(Self);
  clearObj(ObjMer);
  Try
    with ObjMer do
    BEgin
      Estabelecimento := institutioWebId;
      //Objeto produto
      with Produto do
      BEgin
        Codigo            := Prod.Codigo;
        Identificador     := Prod.CodigoFabrica;
        Estabelecimento   := institutioWebId;
        Descricao         := Prod.Descricao;
        if Prod.Categoria > 0 then
          Categoria         := Prod.Categoria
        else
          Categoria         := 2;
        Promocao          := Prod.Campanha;
        Destaque          := Prod.Destaque;
        Ativo             := Prod.Ativo;
        Publicado         := Prod.Internet;
        Observaocao       := Prod.Detalhes;
      End;

      //Verifica se a Marca foi enviada para o sistema Web
      LcOriMarca.Registro.Codigo := prod.CodigoMarca;
      LcOriMarca.getbyId;
      if LcOriMarca.exist then
        ObjMer.Marca := LcOriMarca.Registro.Descricao
      else
        ObjMer.Marca := 'NÃO INFORMADA';

      //Objeto Mercadoria
      with Mercadoria do
      BEgin
        Codigo            := Prod.Codigo;
        Estabelecimento   := institutioWebId;
        CodigoInterno     := Prod.CodigoFabrica;
        Fornecedor        := StrToIntDEf(Prod.CodigoFornecedor,0);
        NCM               := Prod.CodigoNCM;
        CEST              := Prod.CEST;
        TipoTributacao    := Prod.FinalidadeTributacao;
        Origem            := Prod.Origem;
        Tipo              := Prod.Tipo;
        Marca             := 0;
        Imprime           := Prod.Imprime;
        ControlarSerie    := Prod.UtilizaSerie;
        ExclusivoRevenda  := Prod.Exclusivo;
        Aplicacao         := Prod.Aplicacao;
        TipoComposicao    := Prod.Composicao;
      End;

      //Verifica se a Medida foi enviada para o sistema Web
      LcOriMedida.Registro.Codigo := prod.MedidaComercial;
      LcOriMedida.getbyId;
      if LcOriMedida.exist then
        ObjMer.Medida := LcOriMedida.Registro.Descricao
      else
        ObjMer.Medida := 'UND';

      //Verifica se a Embalagem foi enviada para o sistema Web
      LcOriEmbalagem.Registro.Codigo := prod.CodigoEmbalagem;
      LcOriEmbalagem.getbyId;
      if LcOriEmbalagem.exist then
        ObjMer.Embalagem := LcOriEmbalagem.Registro.Descricao
      else
        ObjMer.Embalagem := 'UND';

      with Estoque do
      BEgin
        Mercadoria        := prod.Codigo;
        Estabelecimento   := institutioWebId;
        Embalagem         := 0;
        Medida            := 0;
        Cor               := 0;
        CodigoBarra       := prod.CodigoBarras;
        TemST             := prod.SubsTrib;
        Qtde              := 0;
        QtdeMinima        := prod.QtdeMinima;
        Divisor           := prod.Divisor;
        Localizacao       := prod.Localizacao;
        Peso              := prod.Peso;
        Largura           := prod.Largura;
        Comprimento       := prod.Comprimento;
        Altura            := prod.Altura;
        CustoFabrica      := prod.ValorFabrica;
        CustoReal         := prod.ValorCustoMedio;
        PrecoCusto        := prod.ValorCusto;
        EstoqueNegativa   := prod.EstoqueNegativo;
        ForaDeLinha       := prod.ForaLinha;
      End;
    End;
  Finally
    LcOriMarca.DisposeOf;
    LcOriMedida.DisposeOf;
    LcOriEmbalagem.DisposeOf;
  End;
end;

function TControllerProduto.insert: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRODUTO');

    if Length(Registro.CodigoFabrica) = 0 then
      Registro.CodigoFabrica := IntToStr(Registro.Codigo);

    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerProduto.MarcaPromocao(Codigo: Integer;Ativa:Boolean);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add('UPDATE TB_PRODUTO SET '+
              'PRO_CAMPANHA=:PRO_CAMPANHA '+
              'WHERE ( PRO_CODIGO=:PRO_CODIGO )');
      if Ativa then
        ParamByName('PRO_CAMPANHA').AsString := 'S'
      else
        ParamByName('PRO_CAMPANHA').AsString := 'N';
      ParamByName('PRO_CODIGO').AsInteger := Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.migraSelf(Lc_Qry: TSTQuery);
begin
  get(Lc_qry,Registro);
end;

function TControllerProduto.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

procedure TControllerProduto.ReOrdenaSequenciaCodigo;
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                ' PRO_CODIGO=:PRO_CODIGO ',
                ' PRO_CODIGOFAB=:PRO_CODIGO ',
                'WHERE PRO_CODIGO=:OLD_CODIGO '
      ));
      //rEGISTRA O NUMERO ALTO PARA INICIAR DO ZERO DEPOIS
      getList('');
      FProgresso.Progress := 0;
      FProgresso.MinValue := 0;
      FProgresso.MaxValue := Lista.Count;
      Application.ProcessMessages;
      Lc_Contatdor := 900000;
      for I := 0 to Lista.Count - 1 do
      Begin
        Active := False;
        ParamByName('PRO_CODIGO').AsInteger := Lc_Contatdor;
        ParamByName('OLD_CODIGO').AsInteger := Lista[I].Codigo;
        ExecSQL;
        Lc_Contatdor := Lc_Contatdor + 1;
      End;
      //Agora inicia do 1 para ajustar a ordeñação
      getList('');
      FProgresso.Progress := 0;
      FProgresso.MinValue := 0;
      FProgresso.MaxValue := Lista.Count;
      Lc_Contatdor := 1;
      for I := 0 to Lista.Count - 1 do
      Begin
        Active := False;
        ParamByName('PRO_CODIGO').AsInteger := Lc_Contatdor;
        ParamByName('OLD_CODIGO').AsInteger := Lista[I].Codigo;
        ExecSQL;
        Lc_Contatdor := Lc_Contatdor + 1;
      End;

    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerProduto.save: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUTO');

  if Length(Trim(Registro.CodigoFabrica)) = 0 then
    Registro.CodigoFabrica := IntToStr(Registro.Codigo);

  SaveObj(Registro);
end;

function TControllerProduto.saveDatawebObjeto(DObj: TObjMerchandise): Boolean;
begin
  Result := True;
  with registro do
  Begin
    Codigo                := DObj.Produto.Codigo;
    CodigoEstabelecimento := DObj.Produto.Estabelecimento;
    CodigoFabrica         := DObj.Produto.Identificador;
    CodigoBarras          := DObj.Estoque.CodigoBarra;
    CodigoFornecedor      := InttoStr(DObj.Mercadoria.Fornecedor);
    CodigoNCM             := DObj.Mercadoria.NCM;
    Descricao             := DObj.Produto.Descricao;

    Marca.Registro.Descricao := DObj.Marca;
    Marca.getIdAutoByDesc;
    CodigoMarca          := Marca.Registro.Codigo;

    Medida.Registro.Descricao := DObj.Medida;
    Medida.getIdAutoByDesc;
    MedidaComercial          := Medida.Registro.Codigo;

    Embalagem.Registro.Descricao := DObj.Embalagem;
    Embalagem.getIdAutoByDesc;
    CodigoEmbalagem       :=  Embalagem.Registro.Codigo;

    CodigoGrupo           :=  Grupo.autocreate(DObj.Grupo);
    CodigoSubgrupo        :=  Grupo.SubGRupo.autocreate(CodigoGrupo,DObj.SubGrupo);
    Divisor               :=  DObj.Estoque.Divisor;
    Origem                :=  DObj.Mercadoria.Origem;
    Tipo                  :=  DObj.Mercadoria.Tipo;
    Localizacao           :=  DObj.Estoque.Localizacao;
    Peso                  :=  DObj.Estoque.Peso;
    Largura               :=  DObj.Estoque.Largura;
    Comprimento           :=  DObj.Estoque.Comprimento;
    Altura                :=  DObj.Estoque.Altura;
    ValorFabrica          :=  DObj.Estoque.CustoFabrica;
    ValorCustoMedio       :=  DObj.Estoque.CustoReal;
    ValorCustoMedioAnt    :=  DObj.Estoque.CustoReal;
    ValorCusto            :=  DObj.Estoque.CustoReal;
    ValorCustoAnt         :=  DObj.Estoque.CustoReal;
    QtdeMinima            :=  DObj.Estoque.QtdeMinima;
    Detalhes              :=  DObj.Produto.Observaocao;
    SubsTrib              :=  DObj.Estoque.TemST;
    Campanha              := DObj.Produto.Promocao;
    Destaque              := DObj.Produto.Destaque;
    Ativo                 := DObj.Produto.Ativo;
    Imprime               := DObj.Mercadoria.Imprime;
    EstoqueNegativo       := DObj.Estoque.EstoqueNegativa;
    Exclusivo             := DObj.Mercadoria.ExclusivoRevenda;
    Internet              := DObj.Produto.Publicado;
    MaisVendido           := 'N';
    Composicao            := DObj.Mercadoria.TipoComposicao;
    Aplicacao             := DObj.Mercadoria.Aplicacao;
    FinalidadeTributacao  := DObj.Mercadoria.TipoTributacao;
    UtilizaSerie          := DObj.Mercadoria.ControlarSerie;
    Venda                 := 'N';
    Revestimento          := 0;
    Categoria             := DObj.Produto.Categoria;
    ForaLinha             := DObj.Estoque.ForaDeLinha;
    CEST                  := DObj.Mercadoria.CEST;
  End;
  replace;
end;

function TControllerProduto.temmovimento: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'select * ',
                'from TB_ITENS_NFL ',
                'where (ITF_CODPRO =:PRO_CODIGO )'
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := (recordCount > 0);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;

end;

function TControllerProduto.getbyBarCode: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT * ',
                'FROM TB_PRODUTO ',
                'WHERE (PRO_CODIGOBAR =:PRO_CODIGOBAR) ',
                '  and (PRO_CODIGOBAR <> ''SEM GTIN'') '
      ));
      if (REgistro.Codigo > 0) then
        SQL.Add(' AND (PRO_CODIGO <>:PRO_CODIGO)');

      if (REgistro.Codigo > 0) then
        ParamByName('PRO_CODIGO').AsInteger := REgistro.Codigo;

      ParamByName('PRO_CODIGOBAR').AsString := Registro.CodigoBarras;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

Function TControllerProduto.getByDescricao(descricao: String):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_DESCRICAO LIKE :PRO_DESCRICAO )'
      ));
      ParamByName('PRO_DESCRICAO').AsString := concat('%',Descricao,'%');
      Active := True;
      FetchAll;
      if (RecordCount = 1) then
      Begin
        exist := True;
        get(Lc_Qry,Registro);
        Result := 1;
      End
      else
      Begin
        exist := False;
        Result := RecordCount;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getByExternalCodeIfood(CodigoMedida,
  Codigoitem: Integer): TProdutoPizza;
Var
  Lc_Qry : TSTQuery;
  Lc_item : TProdutoPizza;
Begin
  Lc_item := TProdutoPizza.create;
  Lc_item.codigo := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'select  p.pro_codigo, p.pro_descricao, m.med_abreviatura ',
              'from tb_produto p ',
              '  inner join tb_medida m ',
              '  on (m.med_codigo = p.pro_codmed) ',
              'where p.pro_codmed = :CODIGOMEDIDA ',
              'and p.pro_descricao = ( ',
              'select  p.pro_descricao ',
              'from tb_produto p ',
              'where p.pro_codigo in (:CODIGOITEM)) '
      ));
      ParamByName('CODIGOMEDIDA').AsInteger := CodigoMedida;
      ParamByName('CODIGOITEM').AsInteger := CodigoItem;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then
      Begin
        Lc_item.codigo := FieldByName('pro_codigo').AsInteger;
        Lc_item.descricao :=  FieldByName('pro_descricao').AsString;
        Lc_item.Medida :=  FieldByName('med_abreviatura').AsString;
      End;
      REsult := Lc_item;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getbyFactoryProduct:Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_CODIGOFAB =:PRO_CODIGOFAB )'
      ));
      ParamByName('PRO_CODIGOFAB').AsString := Registro.CodigoFabrica;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.getById;
begin
  _getByKey(Registro);
end;

function TControllerProduto.getCusto: Real;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select PRO_VL_CUSTO ',
                'from tb_produto ',
                'where (pro_codigo=:pro_codigo )'
      ));
      ParamByName('pro_codigo').AsInteger := Registro.Codigo;
      Active := True;
      Result := FieldByName('PRO_VL_CUSTO').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getDescricao: String;
var
  Lc_Qry : TSTQuery;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT PRO_DESCRICAO FROM TB_PRODUTO ',
                'where PRO_CODIGO=:PRO_CODIGO '
               ));
      ParamByName('PRO_CODIGO').AsInteger := REGISTRO.Codigo;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByName('PRO_DESCRICAO').asString
      ELSE
        Result := '';
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getField(codigo: Integer; Field: String): String;
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT ', Field ,' FROM TB_PRODUTO ',
                'where PRO_CODIGO=:PRO_CODIGO '
               ));
      ParamByName('PRO_CODIGO').AsInteger := Codigo;
      Active := True;
      FetchAll;
      Result := FieldByName(Field).asString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getFromXML(Fc_Cd_Fornecedor,Fc_cd_Produto,Fc_Cd_Barras:String): Boolean;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT DISTINCT pr.* '+
                   'FROM TB_PRODUTO pr '+
                   '  LEFT OUTER JOIN TB_PROD_FORN tb_prod_forn '+
                   '  ON (tb_prod_forn.PFR_CODPRO = pr.PRO_CODIGO) '+
                   'WHERE ((PFR_PRODUTO =:PFR_PRODUTO) AND (PFR_CODFOR=:PFR_CODFOR) ) '+
                   'OR ((pr.PRO_CODIGOBAR=:PRO_CODIGOBAR) AND (pr.PRO_CODIGOBAR<> '''') AND (pr.PRO_CODIGOBAR IS NOT NULL))  '+
                   'AND (pr.PRO_ATIVO = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PFR_CODFOR').AsString := Fc_Cd_Fornecedor;
      ParamByName('PFR_PRODUTO').AsString := Fc_cd_Produto;
      ParamByName('PRO_CODIGOBAR').AsString := Fc_Cd_Barras;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerProduto.getList(limite:String);
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      if StrToIntDef(limite,0)>0 then
        sql.add(concat('SELECT FIRST ',limite,' * '))
      else
        sql.add('SELECT p.* ');

      sql.add(concat(
                'FROM TB_PRODUTO p '
                ));

      if ( pos('GRP_DESCRICAO',FOrderBy) > 0 ) then
      Begin
        sql.add(concat(
                     '  INNER JOIN tb_grupos g ',
                     '  ON (grp_CODIGO = pro_codGRP) ',
                     '  INNER JOIN tb_subgrupos s ',
                     '  ON (sbg_CODIGO = pro_codSBG) '
                  ));
      End;

      sql.add(concat(
                'WHERE (PRO_CODIGO IS NOT NULL) '
                ));

      //Criei objeto contorller para produto e para menu cardapio  aqui é diferente de automatico -
      if Registro.Tipo = 'P' then
        sql.add(' and (PRO_TIPO =''P'') ')
      else
        sql.add(' and (PRO_TIPO =''A'') ');

      if Registro.Internet = 'S' then
        sql.add(' AND (PRO_INTERNET = ''S'') ');

      if FORderby = '' then
        sql.add(' ORDER BY PRO_CODIGO ')
      else
        sql.add( FORderby );
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TProduto.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.getListSimples(limite: String);
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(CONCAT(
                'SELECT p.PRO_CODIGO, P.PRO_DESCRICAO ',
                'FROM TB_PRODUTO p '
            ));

      sql.add(concat(
                'WHERE (PRO_CODIGO IS NOT NULL) '
                ));

      sql.add(' ORDER BY PRO_CODIGO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TProduto.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerProduto.getPeso: Real;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select PRO_PESO ',
                'from tb_produto ',
                'where (pro_codigo=:pro_codigo )'
      ));
      ParamByName('pro_codigo').AsInteger := Registro.Codigo;
      Active := True;
      Result := FieldByName('PRO_PESO').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProduto.getProdutoAvulso: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  //Na ultima analise 12/12/2020 - Precisa enviar os todos os produtos  - O menu fará o vinculo depois
  //Não deve ser utilizado por enquanto
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT * ',
                'FROM TB_PRODUTO ',
                ' WHERE PRO_DESCRICAO = ''PRODUTO AVULSO'' ',
                ' and PRO_ATIVO = ''S'' '
      ));
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProduto.getProdutoToSincronia;
Var
  Lc_Qry : TSTQuery;
Begin
  //Na ultima analise 12/12/2020 - Precisa enviar os todos os produtos  - O menu fará o vinculo depois
  //Não deve ser utilizado por enquanto
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_TIPO <> ''A'' )',
                ' AND PRO_CODIGO=:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerProduto.getValorBaseTroca: Real;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select (PRO_VL_BASE_TROCA * PRO_PESO) PRO_VL_BASE_TROCA ',
                'from tb_produto ',
                'where (pro_codigo=:pro_codigo )'
      ));
      ParamByName('pro_codigo').AsInteger := Registro.Codigo;
      Active := True;
      Result := FieldByName('PRO_VL_BASE_TROCA').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

{ TProdutoPizza }

procedure TProdutoPizza.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProdutoPizza.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProdutoPizza.setFMedida(const Value: String);
begin
  FMedida := Value;
end;

end.
