unit ControllerCtrlEstoque;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblCtrlEstoque ,Un_MSg,ControllerCtrlEstoqueZerado,FireDAC.Stan.Param,
      System.Generics.Collections, ControllerSyncTable, ControllerComposicao,
  tblSyncTable;

Type
  TListaCtrEstoque = TObjectList<TCtrlEstoque>;

  TProdutoSimples = class
    private
    FCodigo: Integer;
    FEstoque: Integer;
    FComposicao: String;
    procedure setFCodigo(const Value: Integer);
    procedure setFComposicao(const Value: String);
    procedure setFEstoque(const Value: Integer);

    public
      property Codigo : Integer read FCodigo write setFCodigo;
      property Estoque : Integer read FEstoque write setFEstoque;
      property Composicao : String read FComposicao write setFComposicao;
  end;

  TListaProdutoSimples = TObjectList<TProdutoSimples>;

  TProdutoMovimentado = class
    private
    FCodigo: Integer;
    procedure setFCodigo(const Value: Integer);
    public
      property Codigo : Integer read FCodigo write setFCodigo;
  end;
  TListaProdutoMovimentado = TObjectList<TProdutoMovimentado>;

  TControllerCtrlEstoque = Class(TControllerBase)
  private

    FEstoque: Integer;
    FDataFinal: TDate;
    FDataInicial: TDate;
    FDataInventario: TDate;
    FDescricaoProduto: String;
    FCodigoProduto: Integer;
    FMarca: Integer;
    FSubGrupo: Integer;
    FGrupo: Integer;
    FCodigoInventario: Integer;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFEstoque(const Value: Integer);
    procedure setFDataInventario(const Value: TDate);
    procedure setFCodigoProduto(const Value: Integer);
    procedure setFDescricaoProduto(const Value: String);
    procedure setFGrupo(const Value: Integer);
    procedure setFMarca(const Value: Integer);
    procedure setFSubGrupo(const Value: Integer);
    procedure SendEmail;
    function getSaldo:Real;
    function getDescricaoProduto:String;
    procedure setFCodigoInventario(const Value: Integer);
  protected

  public
    Registro : TCtrlEstoque;
    Lista : TListaCtrEstoque;
    ListaProdutoMovimentado : TListaProdutoMovimentado;
    ListaProdutoSimples : TListaProdutoSimples;
    Composicao : TControllerComposicao;
    EstoqueZerado : TControllerCtrlEstoqueZerado;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function Insert:boolean;
    function Update: boolean;
    function UpdateByID:boolean;
    function Save:boolean;
    Function delete:boolean;
    Function deleteByProduto:boolean;
    function getByID:Boolean;
    function getIDbyControls:Integer;
    function getIDbyControlsProducts:Integer;
    procedure getlistSincronia;
    procedure Registra;

    procedure Desregistra(Vinculo : String;
                          Cd_Controle :Integer;
                          Cd_Item_Ctrl:Integer);
    procedure getlistDuplicados;
    procedure getlistByPedido(Cd_Pedido:Integer;Faturado:String);

    function ListarProdutoMovimentado:Boolean;
    function  ListarMovimento:Boolean;
    function getSaldoByListarMovimento : Real;

    procedure AtivarTrighers;
    procedure DesativarTrighers;

    procedure getListaProdutoParaInventario;

    function  RecontagemListarMovimento:Boolean;
    procedure getListaProdutoSimples;
    procedure Recontagem;
    procedure RecontagemGravarMovimento;
    procedure RecontagemDeletarByProduto;
    procedure LimparTodoHistoricoByProduto;
    procedure AjustaGenerator;


    property Estoque  : Integer read FEstoque write setFEstoque;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
    property DataInventario : TDate read FDataInventario write setFDataInventario;

    property Grupo : Integer read FGrupo write setFGrupo;
    property SubGrupo : Integer read FSubGrupo write setFSubGrupo;
    property Marca : Integer read FMarca write setFMarca;
    property CodigoProduto : Integer read FCodigoProduto write setFCodigoProduto;
    property DescricaoProduto : String read FDescricaoProduto write setFDescricaoProduto;
    Property CodigoInventario : Integer read FCodigoInventario write setFCodigoInventario;
  End;

implementation

uses UN_Sistema, Un_Regra_Negocio, Un_tr_send_email;

procedure TControllerCtrlEstoque.AjustaGenerator;
Var
  Lc_Qry : TSTQuery;
  Lc_Sequencia : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT MAX(CET_CODIGO) ID ',
                'FROM TB_CTRL_ESTOQUE '
      ));
      Active := True;
      First;
      Lc_Sequencia := FieldByNAme('ID').AsInteger;
      Active := False;
      sql.clear;
      sql.Add(concat('ALTER SEQUENCE GN_CTRL_ESTOQUE RESTART WITH ' , IntToStr(lC_Sequencia)));
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCtrlEstoque.AtivarTrighers;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add('ALTER TRIGGER TG_ESTOQUE_DELETE ACTIVE;');
      ExecSQL;
      Sql.Clear;
      sql.Add('ALTER TRIGGER TG_ESTOQUE_INSERT ACTIVE;');
      ExecSQL;
      Sql.Clear;
      sql.Add('ALTER TRIGGER TG_ESTOQUE_UPDATE ACTIVE;');
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerCtrlEstoque.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerCtrlEstoque.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCtrlEstoque.Create;
  Lista := TListaCtrEstoque.Create;
  Composicao := TControllerComposicao.Create(Self);
  ListaProdutoMovimentado := TListaProdutoMovimentado.create;
  ListaProdutoSimples := TListaProdutoSimples.create;
  EstoqueZerado := TControllerCtrlEstoqueZerado.Create(Self);
end;


procedure TControllerCtrlEstoque.DesativarTrighers;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add('ALTER TRIGGER TG_ESTOQUE_DELETE INACTIVE;');
      ExecSQL;
      Sql.Clear;
      sql.Add('ALTER TRIGGER TG_ESTOQUE_INSERT INACTIVE;');
      ExecSQL;
      Sql.Clear;
      sql.Add('ALTER TRIGGER TG_ESTOQUE_UPDATE INACTIVE;');
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerCtrlEstoque.Desregistra(Vinculo: String; Cd_Controle,
  Cd_Item_Ctrl: Integer);
Var
  Lc_Qry :TSTQuery;
  LcITem : TCtrlEstoque;
  I : Integer;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      sql.Add(concat(
                  'SELECT C.* ',
                  'from tb_ctrl_estoque C ',
                  'WHERE (CET_VINCULO=:CET_VINCULO) ',
                  ' and  CET_TIPO NOT LIKE ''%CANCELAD%'' ',
                  ' AND  CET_TIPO NOT LIKE ''%DEVOLVID%'' '
      ));
      if (Cd_Controle > 0) then
        SQL.ADD(' AND ( CET_CONTROLE =:CET_CONTROLE ) ')
      else
        SQL.ADD(' AND ( CET_ITEM_CTRL =:CET_ITEM_CTRL) ');

      ParamByName('CET_VINCULO').AsString := Vinculo;

      if (Cd_Controle > 0) then
        ParamByName('CET_CONTROLE').AsInteger := Cd_Controle
      else
        ParamByName('CET_ITEM_CTRL').AsInteger := Cd_Item_Ctrl;
      Active := True;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcITem := TCtrlEstoque.Create;
        get(Lc_Qry,LcITem);
        Lista.add(LcITem);
        Next;
      End;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

  for I := 0 to Lista.Count -1 do
  Begin
    ClonarObj(Lista[I],Registro);
    //Atalizamos o regstro atual com devolvido.
    Registro.Tipo := Copy(concat(Registro.Tipo,' CANCELADA'),1,25);
    Self.update;
    //Aqui define zero no codigo para que seja inserida a inversão do lançamento
    if ( Registro.operacao = 'E' ) then
      Registro.operacao := 'S'
    else
      Registro.operacao := 'E';
    Registro.codigo := 0;
    Registro.Tipo := 'ESTOQUE DEVOLVIDO';
    Self.Insert;
  end;
end;

destructor TControllerCtrlEstoque.Destroy;
begin
  EstoqueZerado.DisposeOf;
  ListaProdutoSimples.DisposeOf;
  ListaProdutoMovimentado.DisposeOf;
  Composicao.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;



function TControllerCtrlEstoque.delete: boolean;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_CTRL_ESTOQUE '+
                   'WHERE (CET_VINCULO=:CET_VINCULO) ';
      //Incremento do SQL
      if ( Registro.Ordem > 0) then
        Lc_SqlTxt := Lc_SqlTxt  + 'AND (CET_CONTROLE =:CET_CONTROLE) '
      else
        Lc_SqlTxt := Lc_SqlTxt  + 'AND (CET_ITEM_CTRL =:CET_ITEM_CTRL) ';
      SQL.ADD(Lc_SqlTxt);

      //Passagem de Parametros
      ParamByName('CET_VINCULO').AsString := Registro.Vinculo;

      if ( Registro.Ordem > 0) then
        ParamByName('CET_CONTROLE').AsInteger := Registro.Ordem
      else
        ParamByName('CET_ITEM_CTRL').AsInteger := Registro.Item;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry  );
  End;
end;

function TControllerCtrlEstoque.deleteByProduto: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'DELETE FROM  tb_ctrl_estoque  ',
                'WHERE CET_CODPRO=:CET_CODPRO '
      ));
      ParamByName('CET_CODPRO').AsInteger     := Registro.Produto;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerCtrlEstoque.getByID: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT * ',
                'FROM tb_ctrl_estoque C ',
                'WHERE CET_CODIGO  =:CET_CODIGO '
      ));
      ParamByName('CET_CODIGO').AsInteger     := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (recordcount > 0);
      if  exist then
        get(Lc_qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCtrlEstoque.getDescricaoProduto: String;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := '';
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT PRO_DESCRICAO ',
                'FROM TB_PRODUTO ',
                'WHERE PRO_CODIGO =:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').asInteger   := Registro.Produto;
      Active := True;
      First;
      REsult := FieldByName('PRO_DESCRICAO').AsString;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCtrlEstoque.getIDbyControls:Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT CET_CODIGO ',
                'FROM tb_ctrl_estoque C ',
                'WHERE CET_VINCULO   =:CET_VINCULO ',
                ' AND  CET_CONTROLE  =:CET_CONTROLE ',
                ' AND  CET_ITEM_CTRL =:CET_ITEM_CTRL ',
                ' and ( (CET_TIPO is null)  ',
                ' or ( CET_TIPO NOT LIKE ''%CANCELAD%'' ',
                ' and CET_TIPO NOT LIKE ''%DEVOLVID%'') ) '
      ));
      ParamByName('CET_VINCULO').asstring     := Registro.Vinculo;
      ParamByName('CET_CONTROLE').asInteger   := Registro.Ordem;
      ParamByName('CET_ITEM_CTRL').asInteger  := Registro.Item;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        REsult := FieldByName('CET_CODIGO').AsInteger
      else
        REsult := 0;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCtrlEstoque.getIDbyControlsProducts: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT CET_CODIGO ',
                'FROM tb_ctrl_estoque C ',
                'WHERE CET_VINCULO   =:CET_VINCULO ',
                ' AND  CET_CONTROLE  =:CET_CONTROLE ',
                ' AND  CET_ITEM_CTRL =:CET_ITEM_CTRL ',
                ' AND  CET_CODPRO =:CET_CODPRO ',
                ' and  CET_TIPO NOT LIKE ''%CANCELADA%'' ',
                ' AND  CET_TIPO NOT LIKE ''%DEVOLVID%'' '
      ));
      ParamByName('CET_VINCULO').asstring     := Registro.Vinculo;
      ParamByName('CET_CONTROLE').asInteger   := Registro.Ordem;
      ParamByName('CET_ITEM_CTRL').asInteger  := Registro.Item;
      ParamByName('CET_CODPRO').asInteger  := Registro.Produto;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        REsult := FieldByName('CET_CODIGO').AsInteger
      else
        REsult := 0;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


procedure TControllerCtrlEstoque.getListaProdutoParaInventario;
Var
  Lc_Qry : TSTQuery;
  LcItem : TProdutoSimples;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT distinct pd.PRO_CODIGO, PD.pro_descricao, EST_CODETS, pd.PRO_COMPOSICAO ',
                'from TB_PRODUTO pd ',
                '  inner join tb_estoque et ',
                '  on (et.EST_CODPRO = pd.PRO_CODIGO ) ',
                '  INNER  JOIN TB_GRUPOS ',
                '  ON (GRP_CODIGO = pd.PRO_CODGRP) ',
                '  INNER  JOIN TB_SUBGRUPOS ',
                '  ON (SBG_CODIGO = pd.PRO_CODSBG) ',
                '  INNER JOIN TB_MARCA_PRODUTO ',
                '  ON (MRC_CODIGO = pd.PRO_CODMRC) ',
                ' where EST_CODETS =:EST_CODETS '
      ));


      if FGrupo > 0 then
        sql.Add('AND (pd.PRO_CODGRP =:PRO_CODGRP) ');

      if FSubGrupo > 0 then
        sql.Add('AND (pd.PRO_CODSBG =:PRO_CODSBG) ');

      if Fmarca > 0 then
        sql.Add('AND (pd.PRO_CODMRC =:PRO_CODMRC) ');

      if FCodigoProduto > 0 then
        sql.Add('AND (pd.PRO_CODIGO =:PRO_CODIGO) ');

      if FDescricaoProduto <> '' then
        sql.Add('AND (pd.PRO_DESCRICAO LIKE :PRO_DESCRICAO) ');

      sql.Add('ORDER BY pd.PRO_CODIGO ');

      ParamByName('EST_CODETS').AsInteger:= FEstoque;

      if FGrupo > 0 then ParamByName('PRO_CODGRP').AsInteger:= FGRupo;
      if FSubGrupo > 0 then ParamByName('PRO_CODSBG').AsInteger:=  FSubGrupo;
      if Fmarca > 0 then ParamByName('PRO_CODMRC').AsInteger:= FMarca;
      if FCodigoProduto > 0 then
        ParamByName('PRO_CODIGO').AsInteger := FCodigoProduto;
      if FDescricaoProduto <> '' then
        ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(FDescricaoProduto,1,98) + '%';

      Active := True;
      First;
      ListaProdutoSimples.Clear;
      while not eof do
      Begin
        LcItem := TProdutoSimples.create;
        LcItem.Codigo     := FieldByName('PRO_CODIGO').AsInteger;
        LcItem.Estoque    := FieldByName('EST_CODETS').AsInteger;
        LcItem.Composicao := FieldByName('PRO_COMPOSICAO').AsString;
        ListaProdutoSimples.Add(LcItem);
        Next;
      End;
    End;
  Finally
    FinalizaQuery( Lc_Qry );
  End;


end;

procedure TControllerCtrlEstoque.getListaProdutoSimples;
Var
  Lc_Qry : TSTQuery;
  LcItem : TProdutoSimples;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT distinct pd.PRO_CODIGO, PD.pro_descricao, EST_CODETS, pd.PRO_COMPOSICAO ',
                'FROM ( ',
                'SELECT distinct ITF_CODPRO PRO_CODIGO,ITF_CODEST EST_CODETS, PRO_COMPOSICAO ',
                ' from tb_pedido ',
                '  inner join tb_itens_nfl ',
                '  on (ITF_CODPED = PED_CODIGO) ',
                '  INNER JOIN TB_PRODUTO ',
                '  ON (PRO_CODIGO = ITF_CODPRO ) ',
                '  INNER join tb_nota_fiscal ',
                '  on (NFL_CODPED = PED_CODIGO) ',
                'WHERE  (PED_FATURADO = ''S'') ',
                ' AND (PRO_TIPO <> ''S'') ',
                ' AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) ',
                ' AND ( ITF_ESTOQUE = ''S'' ) ',
                ' and ( NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                ' and ( pro_composicao <>2 ) ',
                ' and ( ITF_CODEST =:ETS_CODIGO ) ',
                //--SELECT DOS DOCUMENTOS FATURADOS E COM COMPOSIÇÃO
                'UNION ',
                'SELECT distinct PPD.ppd_codpro_d PRO_CODIGO, ITF_CODEST EST_CODETS, PRO_COMPOSICAO ',
                '  FROM TB_ITENS_NFL ',
                '    INNER JOIN tb_pedido ',
                '    ON (PED_CODIGO = ITF_CODPED) ',
                '    INNER join tb_nota_fiscal ',
                '    on (NFL_CODPED = PED_CODIGO) ',
                '    INNER JOIN tb_prod_prod PPD ',
                '    ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                '    INNER JOIN tb_produto ',
                '    ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                '  WHERE (PED_FATURADO = ''S'') ',
                '  AND (PRO_TIPO <> ''S'') ',
                '  AND (ITF_ESTOQUE = ''S'') ',
                '  and (NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                '  AND tb_produto.pro_composicao = 2 ',
                '  AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //--SELECT DOS DOCUMENTOS NÃO FATURADOS E SEM COMPOSIÇÃO ',
                'union ',
                'SELECT ITF_CODPRO PRO_CODIGO, ITF_CODEST EST_CODETS, PRO_COMPOSICAO ',
                'from tb_pedido ',
                '    inner join tb_itens_nfl ',
                '   on (ITF_CODPED = PED_CODIGO) ',
                '   INNER JOIN TB_PRODUTO ',
                '   ON (PRO_CODIGO = ITF_CODPRO ) ',
                '    LEFT outer JOIN tb_ctrl_estoque ',
                '    ON (tb_ctrl_estoque.cet_item_ctrl = ITF_CODIGO) ',
                ' WHERE  ((PED_TIPO = 1) AND (PED_FATURADO = ''N'')) ',
                '  AND ( PRO_TIPO <> ''S'') ',
                '  AND ( ITF_ESTOQUE = ''S'') ',
                '  and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                '  and ( pro_composicao <>2 ) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //--sELECT DOS DOCUMENTOS NÃO FATURADOS E COM COMPOSIÇÃO ',
                'UNION ',
                'SELECT DISTINCT PPD.ppd_codpro_d PRO_CODIGO, ITF_CODEST EST_CODETS, PRO_COMPOSICAO ',
                '  FROM TB_ITENS_NFL ',
                '    INNER JOIN tb_pedido ',
                '    ON (PED_CODIGO = ITF_CODPED) ',
                '    INNER JOIN tb_prod_prod PPD ',
                '    ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                '    INNER JOIN tb_produto ',
                '    ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                '  WHERE ((PED_TIPO = 1) ',
                '  AND ( PED_FATURADO = ''N'')) ',
                '  AND ( PRO_TIPO <> ''S'') ',
                '  AND ( ITF_ESTOQUE = ''S'') ',
                '  and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                '  AND ( tb_produto.pro_composicao = 2 ) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //--SELECT DOS DOCUMENTOS DE PRODUÇÃO MATERIA PRIMA ',
                'union ',
                'SELECT DISTINCT orpma.PRE_CODPRO PRO_CODIGO, orp.ORP_ESTMP EST_CODETS, PRO_COMPOSICAO ',
                'FROM tb_orp orp ',
                '  INNER JOIN tb_orpprev orpma ',
                '  ON (orpma.PRE_CODORP = orp.ORP_CODIGO) ',
                '  INNER JOIN TB_PRODUTO p ',
                '  on (p.pro_codigo = ORPMA.pre_codpro) ',
                'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                ' AND ( orp.ORP_ESTMP =:ETS_CODIGO ) ',
                //--SELECT DOS DOCUMENTOS DE PRODUÇÃO PRODUTO ACABADO ',
                'UNION ',
                'SELECT DISTINCT orppa.ORL_CODPRO PRO_CODIGO,orp.ORP_ESTMP EST_CODETS , PRO_COMPOSICAO ',
                'FROM tb_orp orp ',
                '  INNER JOIN tb_orpreal orppa ',
                '  ON (orppa.orl_codorp = orp.ORP_CODIGO) ',
                '  INNER JOIN TB_PRODUTO p ',
                '  on (p.pro_codigo = ORPPA.orl_codpro) ',
                'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                ' AND ( orp.ORP_ESTMP =:ETS_CODIGO ) ',
                //--SELECT DOS DOCUMENTOS DE ORDEM DE SERVIÇO - EXINTORES ',
                'UNION ',
                'SELECT DISTINCT IOS.ios_codvcl  PRO_CODIGO, EST_CODETS EST_CODETS, PRO_COMPOSICAO ',
                'FROM tb_ext_itens_ors ios ',
                '     INNER JOIN tb_ext_ordem_servico os ',
                '     ON (os.ors_codigo = ios.ios_codors) ',
                '     INNER join tb_estoque et ',
                '     on (et.est_codpro = ios.ios_codvcl) ',
                '     inner join tb_produto pd ',
                '     on (pd.pro_codigo = ios.ios_codvcl) ',
                ' WHERE os.ors_data between :DATA_INI AND :DATA_FIM ',
                ' AND OS.ors_dt_encerramento IS NOT NULL ',
                ' and pd.pro_tipo = ''C'' ',
                //--Controle de Lotes ',
                'UNION ',
                'SELECT distinct CL.clt_codpro PRO_CODIGO,CL.clt_CODEST  EST_CODETS, PRO_COMPOSICAO ',
                'FROM tb_ctrl_lote cl ',
                ' INNER JOIN tb_movimento_lote ml ',
                ' ON (cl.clt_codigo = ml.mlt_codclt) ',
                '  INNER JOIN TB_PRODUTO P ',
                '  on (p.pro_codigo = CL.clt_codpro) ',
                'WHERE  ML.mlt_sentido = ''E'' and cl.clt_estoque = ''S'' ',
                //lançamento Avulso
                'UNION ',
                'SELECT distinct ce.cet_codpro PRO_CODIGO, ce.cet_codets  EST_CODETS, PRO_COMPOSICAO ',
                'FROM tb_ctrl_estoque ce ',
                '  INNER JOIN TB_PRODUTO P ',
                '  on (p.pro_codigo = ce.cet_codpro) ',
                'WHERE CE.cet_tipo = ''AVULSO'' ',
                //Produto em Inventario
                //pensar num num processo para pegar produtos que
                //Estão zerados no inventario
                //Tem saldo de estoque devido algum erro
                //e não tem movimento algum que o faça participar desta lista.
                //uma opção seria zerar todo o saldo dos produtos desta forma quem tem saldo pelo inventario e quem tem movimento seria recontado
                'UNION ',
                'SELECT distinct iv.ivt_codpro PRO_CODIGO, iv.ivt_codets  EST_CODETS, PRO_COMPOSICAO ',
                'FROM tb_inventario iv ',
                '  INNER JOIN TB_PRODUTO P ',
                '  on (p.pro_codigo = iv.ivt_codpro) ',
                'WHERE iv.ivt_codigo =:ivt_codigo ',
                ' AND IVT_QT_ATUAL > 0 ',
                ') as sl ',
                '  inner join tb_produto pd ',
                '  on (pd.pro_codigo = sl.pro_codigo) ',
                '  INNER  JOIN TB_GRUPOS ',
                '  ON (GRP_CODIGO = pd.PRO_CODGRP) ',
                '  INNER  JOIN TB_SUBGRUPOS ',
                '  ON (SBG_CODIGO = pd.PRO_CODSBG) ',
                '  INNER JOIN TB_MARCA_PRODUTO ',
                '  ON (MRC_CODIGO = pd.PRO_CODMRC) '
      ));

      if FGrupo > 0 then
        sql.Add('AND (pd.PRO_CODGRP =:PRO_CODGRP) ');

      if FSubGrupo > 0 then
        sql.Add('AND (pd.PRO_CODSBG =:PRO_CODSBG) ');

      if Fmarca > 0 then
        sql.Add('AND (pd.PRO_CODMRC =:PRO_CODMRC) ');

      if FCodigoProduto > 0 then
        sql.Add('AND (pd.PRO_CODIGO =:PRO_CODIGO) ');

      if FDescricaoProduto <> '' then
        sql.Add('AND (pd.PRO_DESCRICAO LIKE :PRO_DESCRICAO) ');

      sql.Add('ORDER BY pd.PRO_CODIGO ');

      ParamByName('IVT_CODIGO').AsInteger:= FCodigoInventario;
      ParamByName('ETS_CODIGO').AsInteger:= FEstoque;
      ParamByName('DATA_INI').AsDateTime:= FDataInicial;
      ParamByName('DATA_FIM').AsDateTime:= FDataFinal;

      if FGrupo > 0 then ParamByName('PRO_CODGRP').AsInteger:= FGRupo;
      if FSubGrupo > 0 then ParamByName('PRO_CODSBG').AsInteger:=  FSubGrupo;
      if Fmarca > 0 then ParamByName('PRO_CODMRC').AsInteger:= FMarca;
      if FCodigoProduto > 0 then
        ParamByName('PRO_CODIGO').AsInteger := FCodigoProduto;
      if FDescricaoProduto <> '' then
        ParamByName('PRO_DESCRICAO').AsString := '%' + Copy(FDescricaoProduto,1,98) + '%';

      Active := True;
      First;
      ListaProdutoSimples.Clear;
      while not eof do
      Begin
        LcItem := TProdutoSimples.create;
        LcItem.Codigo     := FieldByName('PRO_CODIGO').AsInteger;
        LcItem.Estoque    := FieldByName('EST_CODETS').AsInteger;
        LcItem.Composicao := FieldByName('PRO_COMPOSICAO').AsString;
        ListaProdutoSimples.Add(LcItem);
        Next;
      End;
    End;
  Finally
    FinalizaQuery( Lc_Qry );
  End;

end;

procedure TControllerCtrlEstoque.getlistByPedido(Cd_Pedido:Integer;Faturado:String);
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  Lc_Complemento : String;
  LcReg : TCtrlEstoque;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      if (Faturado = 'S') then
        Lc_Complemento := '         substring(NFL_TIPO FROM 1 FOR 1) CET_OPERACAO , '
      else
        Lc_Complemento := '         ''S'' CET_OPERACAO , ';

      Lc_SqlTxt := 'SELECT  0 CET_CODIGO, '+
                   '        ''P'' CET_VINCULO, '+
                   '         PED_CODIGO CET_CONTROLE, '+
                   '         ITF_CODIGO CET_ITEM_CTRL, '+
                   '         ITF_CODEST CET_CODETS, '+
                   Lc_Complemento +
                   '         ITF_CODPRO CET_CODPRO, '+
                   '         ITF_QTDE CET_QTDE, '+
                   '         PED_DATA CET_DATA, '+
                    IntToStr(Gb_Terminal)+ ' CET_TERMINAL, '+
                   ' current_timestamp UPDATE_AT, '+
                   ' case itf_oper '+
                   ' when ''V'' then ''VENDA'' '+
                   ' when ''C'' then ''COMPRA'' '+
                   ' when ''A'' then ''AJUSTE'' '+
                   '     else '+
                   '    ''INFORMAR'' '+
                   ' end as  CET_TIPO  '+
                   ' from tb_pedido '+
                   '   inner join tb_itens_nfl '+
                   '   on (ITF_CODPED = PED_CODIGO) '+
                   '   INNER JOIN TB_PRODUTO '+
                   '   ON (PRO_CODIGO = ITF_CODPRO) '+
                   '   left outer join tb_nota_fiscal '+
                   '   on (NFL_CODPED = PED_CODIGO) '+
                   '   LEFT outer JOIN tb_ctrl_estoque '+
                   '   ON (tb_ctrl_estoque.cet_item_ctrl = ITF_CODIGO) '+
                   ' WHERE (PRO_TIPO <> ''S'') '+
                   ' AND PED_CODIGO =:PED_CODIGO '+
                   ' AND ITF_ESTOQUE = ''S'' ';
//                   'AND ((cet_item_ctrl IS NULL) or (cet_item_ctrl =0) ) ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := cd_Pedido;
      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        LcReg := TCtrlEstoque.Create;
        LcReg.Codigo      := 0;
        LcReg.Vinculo     := FieldByName('CET_VINCULO').AsString;
        LcReg.Ordem       := FieldByName('CET_CONTROLE').AsInteger;
        LcReg.Item        := FieldByName('CET_ITEM_CTRL').AsInteger;
        LcReg.Estoque     := FieldByName('CET_CODETS').AsInteger;
        LcReg.Terminal    := FieldByName('CET_TERMINAL').AsInteger;
        LcReg.operacao    := FieldByName('CET_OPERACAO').AsString;
        LcReg.Produto     := FieldByName('CET_CODPRO').AsInteger;
        LcReg.Quantidade  := FieldByName('CET_QTDE').AsFloat;
        LcReg.Data        := FieldByName('CET_DATA').AsDateTime;
        LcReg.UpdateAt    := FieldByName('UPDATE_AT').AsDateTime;
        LcReg.Tipo        := FieldByName('CET_TIPO').AsString;
        Lista.Add(LcReg);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCtrlEstoque.getlistDuplicados;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                ' SELECT CE.cet_item_ctrl, COUNT(CE.cet_item_ctrl) ',
                ' FROM TB_PRODUTO PR ',
                '    INNER JOIN tb_ctrl_estoque CE ',
                '   ON (CE.cet_codpro = PR.pro_codigo) ',
                '   INNER JOIN TB_ITENS_NFL I ',
                '   ON (I.itf_codigo = CE.cet_item_ctrl) and (I.itf_codped = CE.cet_controle) ',
                '   INNER JOIN TB_PEDIDO PE ',
                '   ON (PE.ped_codigo = I.itf_codped) ',
                ' WHERE PR.pro_composicao = ''1'' ',
                ' AND PR.pro_ativo = ''S'' ',
                ' AND CE.cet_item_ctrl > 0 ',
                ' AND ce.cet_codets = 1 ',
                ' AND I.itf_oper= ''V'' ',
                ' and ce.cet_vinculo = ''P'' ',
                ' AND PED_DATA >= ''08/01/2018'' ',
                ' AND PED_TIPO  =1 ',
                ' GROUP by 1 ',
                ' having  COUNT(CE.cet_item_ctrl) > 1 '
      ));
      Active := True;
      First;
      while not eof do
      Begin
        next;
      End;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerCtrlEstoque.getlistSincronia;
Var
  LcSyncTable : TSyncTAble;
  LcSyT : TControllerSyncTable;
  Lc_Qry:TSTQuery;
  LcReg :  TCtrlEstoque;
begin
  Lc_Qry := GeraQuery;
  TRY
    LcSyT := TControllerSyncTable.Create(nil);
    with LcSyT.Registro do
    Begin
      Codigo := 'TB_CTRL_ESTOQUE';
      //R - Recieve / S - Send / W - Web
      Sentido := 'W';
    End;
    LcSyncTable := LcSyT.getTime;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'Select * ',
                'from TB_CTRL_ESTOQUE ',
                'where UPDATE_AT>=:UPDATE_AT ',
                'ORDER BY UPDATE_AT ASC '
          ));
      ParamByName('UPDATE_AT').AsDateTime := LcSyncTable.Data + LcSyncTable.Hora;
      Active := True;
      First;
      while not eof do
      Begin
        LcReg := TCtrlEstoque.Create;
        get(Lc_Qry,LcReg);
        Lista.Add(LcReg);
        Next;
      End;
    End;
  FINALLY
    FreeAndNil(LcSyT);
  END;
end;


function TControllerCtrlEstoque.getSaldo: Real;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select et.est_qtde ',
                'from tb_estoque et ',
                'where et.est_codets =:est_codets ',
                'and et.est_codpro =:est_codpro '
      ));
      ParamByName('est_codets').asInteger    := Registro.Estoque;
      ParamByName('est_codpro').asInteger   := Registro.Produto;
      Active := True;
      FetchAll;
      Result := FieldByName('est_qtde').AsFloat
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCtrlEstoque.getSaldoByListarMovimento: Real;
Var
  I : Integer;
begin
  Result := 0;
  for I := 0 to Lista.Count - 1 do
  Begin
    if ( Lista[I].operacao = 'S') then
      Result := Result - Lista[I].Quantidade
    else
      Result := Result + Lista[I].Quantidade;
  End;
end;

function TControllerCtrlEstoque.Insert: boolean;
begin
  Try
    if Registro.Terminal = 0 then
      Registro.Terminal := Gb_Terminal;
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CTRL_ESTOQUE');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False
  End;
end;

function TControllerCtrlEstoque.RecontagemListarMovimento: Boolean;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  Lc_item : TCtrlEstoque;
Begin
  Result := False;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      ///SELECT DOS DOCUMENTOS FATURADOS E SEM COMPOSIÇÃO
      SQL.Clear;
      Lc_SqlTxt := concat(
                   'SELECT  0 CET_CODIGO, ',
                   '   1 CET_TERMINAL, ',
                   '   ''P'' CET_VINCULO, ',
                   '   PED_CODIGO CET_CONTROLE, ',
                   '   ITF_CODIGO CET_ITEM_CTRL, ',
                   '   ITF_CODEST CET_CODETS, ',
                   '   substring(NFL_TIPO FROM 1 FOR 1) CET_OPERACAO , ',
                   '   ITF_CODPRO CET_CODPRO, ',
                   '   ITF_QTDE CET_QTDE, ',
                   '   NFL_DT_EMISSAO CET_DATA, ',
                   '   current_timestamp UPDATE_AT, ',
                   '   case itf_oper ',
                   '   when ''V'' then ''VENDA'' ',
                   '   when ''C'' then ''COMPRA'' ',
                   '   when ''A'' then ''AJUSTE'' ',
                   '       else ',
                   '      ''INFORMAR'' ',
                   ' end as  CET_TIPO ',
                   ' from tb_pedido ',
                   '  inner join tb_itens_nfl ',
                   '  on (ITF_CODPED = PED_CODIGO) ',
                   '  INNER JOIN TB_PRODUTO ',
                   '  ON (PRO_CODIGO = ITF_CODPRO ) ',
                   '  INNER join tb_nota_fiscal ',
                   '  on (NFL_CODPED = PED_CODIGO) ',
                   'WHERE  (PED_FATURADO = ''S'') ',
                   ' AND (PRO_TIPO <> ''S'') ',
                   ' AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) '
        );

      Lc_SqlTxt := concat(
                   Lc_SqlTxt,
                   ' AND ( ITF_CODPRO =:PRO_CODIGO ) ',
                   ' AND ( ITF_ESTOQUE = ''S'' ) ',
                   ' and ( NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                   ' and ( pro_composicao <>2 ) ',
                   ' and ( ITF_CODEST =:ETS_CODIGO ) ',
      ///SELECT DOS DOCUMENTOS FATURADOS E COM COMPOSIÇÃO
                   'UNION ',
                   '  SELECT 0 CET_CODIGO, ',
                   '         1 CET_TERMINAL, ',
                   '         ''P'' CET_VINCULO, ',
                   '         PED_CODIGO CET_CONTROLE, ',
                   '         ITF_CODIGO CET_ITEM_CTRL, ',
                   '         ITF_CODEST CET_CODETS, ',
                   '         ''S'' CET_OPERACAO , ',
                   '         PPD.ppd_codpro_d CET_CODPRO, ',
                   '         (ITF_QTDE *PPD_QTDE) CET_QTDE, ',
                   '         NFL_DT_EMISSAO CET_DATA, ',
                   '         current_timestamp UPDATE_AT, ',
                   '         case itf_oper ',
                   '         when ''V'' then ''VENDA'' ',
                   '         when ''C'' then ''COMPRA'' ',
                   '         when ''A'' then ''AJUSTE'' ',
                   '             else ',
                   '            ''INFORMAR'' ',
                   '       end as  CET_TIPO ',
                   '  FROM TB_ITENS_NFL ',
                   '    INNER JOIN tb_pedido ',
                   '    ON (PED_CODIGO = ITF_CODPED) ',
                   '    INNER join tb_nota_fiscal ',
                   '    on (NFL_CODPED = PED_CODIGO) ',
                   '    INNER JOIN tb_prod_prod PPD ',
                   '    ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                   '    INNER JOIN tb_produto ',
                   '    ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                   '  WHERE (PED_FATURADO = ''S'') ',
                   '  AND (PRO_TIPO <> ''S'') ',
                   '  AND (ITF_ESTOQUE = ''S'') ',
                   '  and (NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                   '  AND tb_produto.pro_composicao = 2 ',
                   '  AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) ',
                    ' AND ( ITF_CODPRO =:PRO_CODIGO ) ',
                    ' and ( ITF_CODEST =:ETS_CODIGO ) ',
      //SELECT DOS DOCUMENTOS NÃO FATURADOS E SEM COMPOSIÇÃO
                    'union ',
                    'SELECT 0 CET_CODIGO, ',
                    '        1 CET_TERMINAL, ',
                    '        ''P'' CET_VINCULO, ',
                    '        PED_CODIGO CET_CONTROLE, ',
                    '        ITF_CODIGO CET_ITEM_CTRL, ',
                    '        ITF_CODEST CET_CODETS, ',
                    '        ''S'' CET_OPERACAO , ',
                    '        ITF_CODPRO CET_CODPRO, ',
                    '        ITF_QTDE CET_QTDE, ',
                    '        PED_DATA CET_DATA, ',
                    '        current_timestamp UPDATE_AT, ',
                    '        case itf_oper ',
                    '        when ''V'' then ''VENDA'' ',
                    '        when ''C'' then ''COMPRA'' ',
                    '        when ''A'' then ''AJUSTE'' ',
                    '            else ',
                    '           ''INFORMAR'' ',
                    '      end as  CET_TIPO ',
                    'from tb_pedido ',
                    '   inner join tb_itens_nfl ',
                    '   on (ITF_CODPED = PED_CODIGO) ',
                    '   INNER JOIN TB_PRODUTO ',
                    '   ON (PRO_CODIGO = ITF_CODPRO ) ',
                    '   LEFT outer JOIN tb_ctrl_estoque ',
                    '   ON (tb_ctrl_estoque.cet_item_ctrl = ITF_CODIGO) ',
                    'WHERE  ((PED_TIPO = 1) AND (PED_FATURADO = ''N'')) ',
                    ' AND ( PRO_TIPO <> ''S'') ',
                    ' AND ( ITF_ESTOQUE = ''S'') ',
                    ' and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                    ' and ( pro_composicao <>2 ) ',
                    ' AND ( ITF_CODPRO =:PRO_CODIGO ) ',
                    ' and ( ITF_CODEST =:ETS_CODIGO ) ',
      ///SELECT DOS DOCUMENTOS NÃO FATURADOS E COM COMPOSIÇÃO
                    ' UNION ',
                    ' SELECT 0 CET_CODIGO, ',
                    '        1 CET_TERMINAL, ',
                    '        ''P'' CET_VINCULO, ',
                    '        PED_CODIGO CET_CONTROLE, ',
                    '        ITF_CODIGO CET_ITEM_CTRL, ',
                    '        ITF_CODEST CET_CODETS, ',
                    '        ''S'' CET_OPERACAO , ',
                    '        PPD.ppd_codpro_d CET_CODPRO, ',
                    '        (ITF_QTDE *PPD_QTDE) CET_QTDE, ',
                    '        PED_DATA CET_DATA, ',
                    '        current_timestamp UPDATE_AT, ',
                    '        case itf_oper ',
                    '        when ''V'' then ''VENDA'' ',
                    '        when ''C'' then ''COMPRA'' ',
                    '        when ''A'' then ''AJUSTE'' ',
                    '            else ',
                    '           ''INFORMAR'' ',
                    '      end as  CET_TIPO ',
                    ' FROM TB_ITENS_NFL ',
                    '   INNER JOIN tb_pedido ',
                    '   ON (PED_CODIGO = ITF_CODPED) ',
                    '   INNER JOIN tb_prod_prod PPD ',
                    '   ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                    '   INNER JOIN tb_produto ',
                    '   ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                    ' WHERE ((PED_TIPO = 1) ',
                    ' AND ( PED_FATURADO = ''N'')) ',
                    ' AND ( PRO_TIPO <> ''S'') ',
                    ' AND ( ITF_ESTOQUE = ''S'') ',
                    ' and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                    ' AND ( tb_produto.pro_composicao = 2 ) ',
                    ' AND ( ITF_CODPRO =:PRO_CODIGO ) ',
                    ' and ( ITF_CODEST =:ETS_CODIGO ) ',
      //SELECT DOS DOCUMENTOS DE PRODUÇÃO MATERIA PRIMA
                   ' union ',
                   'SELECT 0 CET_CODIGO, ',
                   '       1 CET_TERMINAL, ',
                   '       ''M'' CET_VINCULO, ',
                   '       orp.orp_codigo CET_CONTROLE, ',
                   '       orpma.PRE_CODIGO CET_ITEM_CTRL, ',
                   '       orp.ORP_ESTMP CET_CODETS, ',
                   '       ''S'' CET_OPERACAO , ',
                   '       orpma.PRE_CODPRO CET_CODPRO, ',
                   '       PRE_QTDUNI CET_QTDE, ',
                   '       orp.ORP_DTCAD CET_DATA, ',
                   '       current_timestamp UPDATE_AT, ',
                   '       ''PRODUÇÃO MP'' as  CET_TIPO ',
                   'FROM tb_orp orp ',
                   '  INNER JOIN tb_orpprev orpma ',
                   '  ON (orpma.PRE_CODORP = orp.ORP_CODIGO) ',
                   'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                   ' AND ( orpma.PRE_CODPRO =:PRO_CODIGO ) ',
                   ' AND ( orp.ORP_ESTMP =:ETS_CODIGO ) ',
      //SELECT DOS DOCUMENTOS DE PRODUÇÃO PRODUTO ACABADO
                   'UNION ',
                   'SELECT 0 CET_CODIGO, ',
                   '       1 CET_TERMINAL, ',
                   '       ''O'' CET_VINCULO, ',
                   '       orp.orp_codigo CET_CONTROLE, ',
                   '       orppa.ORL_CODIGO CET_ITEM_CTRL, ',
                   '       orp.ORP_ESTMP CET_CODETS, ',
                   '       ''E'' CET_OPERACAO , ',
                   '       orppa.ORL_CODPRO CET_CODPRO, ',
                   '       orppa.ORL_QTDTOT CET_QTDE, ',
                   '       orp.ORP_DTCAD CET_DATA, ',
                   '       current_timestamp UPDATE_AT, ',
                   '       ''PRODUÇÃO MP'' as  CET_TIPO ',
                   'FROM tb_orp orp ',
                   '  INNER JOIN tb_orpreal orppa ',
                   '  ON (orppa.orl_codorp = orp.ORP_CODIGO) ',
                   'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                   ' AND ( orppa.ORL_CODPRO =:PRO_CODIGO ) ',
                   ' AND ( orp.ORP_ESTMP =:ETS_CODIGO )',
      //SELECT DOS DOCUMENTOS DE ORDEM DE SERVIÇO - EXINTORES
                   ' UNION ',
                   ' SELECT 0 CET_CODIGO, ',
                   '         1 CET_TERMINAL, ',
                   '         ''E'' CET_VINCULO, ',
                   '         ios.ios_codors CET_CONTROLE, ',
                   '         ios.ios_codigo CET_ITEM_CTRL, ',
                   '         EST_CODETS CET_CODETS, ',
                   '         ''S'' CET_OPERACAO , ',
                   '         IOS.ios_codvcl  CET_CODPRO, ',
                   '         IOS.ios_qtde CET_QTDE, ',
                   '         os.ors_data CET_DATA, ',
                   '         current_timestamp UPDATE_AT, ',
                   '         ''EXTINTOR'' CET_TIPO ',
                   ' FROM tb_ext_itens_ors ios ',
                   '     INNER JOIN tb_ext_ordem_servico os ',
                   '     ON (os.ors_codigo = ios.ios_codors) ',
                   '     INNER join tb_estoque et ',
                   '     on (et.est_codpro = ios.ios_codvcl) ',
                   '     inner join tb_produto pd ',
                   '     on (pd.pro_codigo = ios.ios_codvcl) ',
                   ' WHERE os.ors_data between :DATA_INI AND :DATA_FIM ',
                   ' AND OS.ors_dt_encerramento IS NOT NULL ',
                   ' and pd.pro_tipo = ''C'' ',
                   ' AND ( IOS.ios_codvcl =:PRO_CODIGO ) ',
      //Controle de Lotes
                  ' UNION ',
                  'SELECT 0 CET_CODIGO, ',
                  '       1 CET_TERMINAL, ',
                  '       ''L'' CET_VINCULO, ',
                  '       cl.clt_codigo CET_CONTROLE, ',
                  '       ml.mlt_codigo CET_ITEM_CTRL, ',
                  '       CL.clt_CODEST  CET_CODETS, ',
                  '       ML.mlt_sentido CET_OPERACAO , ',
                  '       CL.clt_codpro CET_CODPRO, ',
                  '       ML.mlt_qtde CET_QTDE, ',
                  '       ML.mlt_data CET_DATA, ',
                  '      current_timestamp UPDATE_AT, ',
                  '      ''LOTE'' as  CET_TIPO ',
                  'FROM tb_ctrl_lote cl ',
                  ' INNER JOIN tb_movimento_lote ml ',
                  ' ON (cl.clt_codigo = ml.mlt_codclt) ',
                  'WHERE  ( cl.clt_codpro =:PRO_CODIGO ) ',
                  'AND ML.mlt_sentido = ''E'' and cl.clt_estoque = ''S'' '
                );

      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := FCodigoProduto;
      ParamByName('DATA_INI').AsDate      := FDataInicial;
      ParamByName('DATA_FIM').AsDate      := FDataFinal;
      ParamByName('ETS_CODIGO').AsInteger := FEstoque;
      Active := True;
      FetchAll;
      Lista.clear;
      while not eof do
      Begin
        Lc_item := TCtrlEstoque.create;
        get(Lc_Qry,Lc_item);
        Lista.Add(Lc_item);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
    DisposeOf;
  End;
end;

procedure TControllerCtrlEstoque.LimparTodoHistoricoByProduto;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    //Verifica o ultimo inventario registrado no sistema
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                      'DELETE FROM TB_CTRL_ESTOQUE ',
                      'WHERE (CET_CODETS=:CET_CODETS) ',
                      ' AND  (CET_CODPRO=:CET_CODPRO) '
                  ));
      ParamByName('CET_CODETS').AsInteger := FEstoque;
      ParamByName('CET_CODPRO').AsInteger := FCodigoProduto;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
    DisposeOf;
  End;
end;

function TControllerCtrlEstoque.ListarMovimento: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcItem : TCtrlEstoque;
Begin
  Result := False;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      ///SELECT DOS DOCUMENTOS FATURADOS E SEM COMPOSIÇÃO
      SQL.Clear;
      SQL.Add(concat(
              'SELECT * ',
              'FROM TB_CTRL_ESTOQUE ',
              'WHERE CET_CODETS =:CET_CODETS ',
              'AND (CET_CODPRO =:CET_CODPRO) '
      ));
      ParamByName('CET_CODETS').AsInteger := FEstoque;
      ParamByName('CET_CODPRO').AsInteger := FCodigoProduto;
      Active := True;
      FetchAll;
      Lista.clear;
      while not eof do
      Begin
        LcItem := TCtrlEstoque.create;
        get(Lc_Qry,LcItem);
        Lista.Add(LcItem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlEstoque.ListarProdutoMovimentado: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcItem : TProdutoMovimentado;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    Result := False;
    with Lc_Qry do
    Begin
      ///SELECT DOS DOCUMENTOS FATURADOS E SEM COMPOSIÇÃO
      SQL.Clear;
      SQL.Add(concat(
                'SELECT DISTINCT PRO_CODIGO ',
                'FROM ( ',
                'SELECT ',
                '   ITF_CODPRO PRO_CODIGO ',
                ' from tb_pedido ',
                '  inner join tb_itens_nfl ',
                '  on (ITF_CODPED = PED_CODIGO) ',
                '  INNER JOIN TB_PRODUTO ',
                '  ON (PRO_CODIGO = ITF_CODPRO ) ',
                '  INNER join tb_nota_fiscal ',
                '  on (NFL_CODPED = PED_CODIGO) ',
                'WHERE  (PED_FATURADO = ''S'') ',
                ' AND (PRO_TIPO <> ''S'') ',
                ' AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) ',
                ' AND ( ITF_ESTOQUE = ''S'' ) ',
                ' and ( NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                ' and ( pro_composicao <>2 ) ',
                ' and ( ITF_CODEST =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS FATURADOS E COM COMPOSIÇÃO
                'UNION ',
                '  SELECT ',
                '         PPD.ppd_codpro_d PRO_CODIGO ',
                '  FROM TB_ITENS_NFL ',
                '    INNER JOIN tb_pedido ',
                '    ON (PED_CODIGO = ITF_CODPED) ',
                '    INNER join tb_nota_fiscal ',
                '    on (NFL_CODPED = PED_CODIGO) ',
                '    INNER JOIN tb_prod_prod PPD ',
                '    ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                '    INNER JOIN tb_produto ',
                '    ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                '  WHERE (PED_FATURADO = ''S'') ',
                '  AND (PRO_TIPO <> ''S'') ',
                '  AND (ITF_ESTOQUE = ''S'') ',
                '  and (NFL_DT_EMISSAO between :DATA_INI AND :DATA_FIM ) ',
                '  AND tb_produto.pro_composicao = 2 ',
                '  AND ((NFL_STATUS <> ''C'') or (NFL_STATUS IS NULL)) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS NÃO FATURADOS E SEM COMPOSIÇÃO
                ' union ',
                ' SELECT ',
                '         ITF_CODPRO PRO_CODIGO ',
                ' from tb_pedido ',
                '    inner join tb_itens_nfl ',
                '    on (ITF_CODPED = PED_CODIGO) ',
                '    INNER JOIN TB_PRODUTO ',
                '    ON (PRO_CODIGO = ITF_CODPRO ) ',
                '    LEFT outer JOIN tb_ctrl_estoque ',
                '    ON (tb_ctrl_estoque.cet_item_ctrl = ITF_CODIGO) ',
                ' WHERE  ((PED_TIPO = 1) AND (PED_FATURADO = ''N'')) ',
                '  AND ( PRO_TIPO <> ''S'') ',
                '  AND ( ITF_ESTOQUE = ''S'') ',
                '  and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                '  and ( pro_composicao <>2 ) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS NÃO FATURADOS E COM COMPOSIÇÃO
                '  UNION ',
                '  SELECT ',
                '         PPD.ppd_codpro_d PRO_CODIGO ',
                '  FROM TB_ITENS_NFL ',
                '    INNER JOIN tb_pedido ',
                '    ON (PED_CODIGO = ITF_CODPED) ',
                '    INNER JOIN tb_prod_prod PPD ',
                '    ON (PPD.ppd_codpro_m = ITF_CODPRO) ',
                '    INNER JOIN tb_produto ',
                '    ON (PRO_CODIGO = PPD.ppd_codpro_m) ',
                '  WHERE ((PED_TIPO = 1) ',
                '  AND ( PED_FATURADO = ''N'')) ',
                '  AND ( PRO_TIPO <> ''S'') ',
                '  AND ( ITF_ESTOQUE = ''S'') ',
                '  and ( PED_DATA between :DATA_INI AND :DATA_FIM ) ',
                '  AND ( tb_produto.pro_composicao = 2 ) ',
                '  and ( ITF_CODEST =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS DE PRODUÇÃO MATERIA PRIMA
                ' union ',
                'SELECT ',
                '       orpma.PRE_CODPRO PRO_CODIGO ',
                'FROM tb_orp orp ',
                '  INNER JOIN tb_orpprev orpma ',
                '  ON (orpma.PRE_CODORP = orp.ORP_CODIGO) ',
                'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                ' AND ( orp.ORP_ESTMP =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS DE PRODUÇÃO PRODUTO ACABADO
                'UNION ',
                'SELECT ',
                '       orppa.ORL_CODPRO PRO_CODIGO ',
                'FROM tb_orp orp ',
                '  INNER JOIN tb_orpreal orppa ',
                '  ON (orppa.orl_codorp = orp.ORP_CODIGO) ',
                'WHERE (orp.ORP_DTCAD between :DATA_INI AND :DATA_FIM ) ',
                ' AND ( orp.ORP_ESTMP =:ETS_CODIGO ) ',
                //SELECT DOS DOCUMENTOS DE ORDEM DE SERVIÇO - EXINTORES
                ' UNION ',
                ' SELECT ',
                '         IOS.ios_codvcl  PRO_CODIGO ',
                ' FROM tb_ext_itens_ors ios ',
                '     INNER JOIN tb_ext_ordem_servico os ',
                '     ON (os.ors_codigo = ios.ios_codors) ',
                '     INNER join tb_estoque et ',
                '     on (et.est_codpro = ios.ios_codvcl) ',
                '     inner join tb_produto pd ',
                '     on (pd.pro_codigo = ios.ios_codvcl) ',
                ' WHERE os.ors_data between :DATA_INI AND :DATA_FIM ',
                ' AND OS.ors_dt_encerramento IS NOT NULL ',
                ' and pd.pro_tipo = ''C'' ',
                //Controle de Lotes
                ' UNION ',
                'SELECT ',
                '       CL.clt_codpro PRO_CODIGO ',
                'FROM tb_ctrl_lote cl ',
                ' INNER JOIN tb_movimento_lote ml ',
                ' ON (cl.clt_codigo = ml.mlt_codclt) ',
                'WHERE   ML.mlt_sentido = ''E'' ',
                '  and cl.clt_estoque = ''S'' ',
                '  AND ml.mlt_data between :DATA_INI AND :DATA_FIM ',
                ')'

      ));
      ParamByName('DATA_INI').AsDate      := FDataInicial;
      ParamByName('DATA_FIM').AsDate      := FDataFinal;
      ParamByName('ETS_CODIGO').AsInteger := FEstoque;
      Active := True;
      FetchAll;
      ListaProdutoMovimentado.clear;
      while not eof do
      Begin
        LcItem := TProdutoMovimentado.create;
        LcItem.Codigo := FieldByName('PRO_CODIGO').AsInteger;
        ListaProdutoMovimentado.Add(LcItem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCtrlEstoque.Recontagem;
Var
  Lc_Qtde : String;
  Lc_Qry : TSTQuery;
  LcReg : TCtrlEstoque;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                   'SELECT ',
                   '  PRO_CODIGO, ',
                   '  PRO_COMPOSICAO, ',
                   '  PPD_QTDE , ',
                   '  PPD_CODPRO_D ',
                   'FROM TB_PRODUTO tb_produto ',
                   '   LEFT OUTER JOIN TB_PROD_PROD tb_prod_prod ',
                   '   ON (tb_prod_prod.PPD_CODPRO_M = tb_produto.PRO_CODIGO) ',
                   'WHERE PRO_CODIGO =:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      if ((FieldByname('PRO_COMPOSICAO').AsString = '1') or (FieldByname('PRO_COMPOSICAO').AsString = '3')) then
      Begin
        Self.insert;
      end;
      if ((FieldByname('PRO_COMPOSICAO').AsString = '2') or (FieldByname('PRO_COMPOSICAO').AsString = '3')) then
      Begin
        //Registra o produto da composicao
        while not Eof do
        Begin
          if (trim(Lc_Qry.FieldByname('PPD_CODPRO_D').AsString)<> '') then
          Begin
            LcReg := TCtrlEstoque.Create;
            LcReg.Codigo      := 0;
            LcReg.Vinculo     := Registro.Vinculo;
            LcReg.Ordem       := Registro.Ordem;
            LcReg.Item        := Registro.Item;
            LcReg.Estoque     := Registro.Estoque;
            LcReg.operacao    := Registro.operacao;
            LcReg.Produto     := Lc_Qry.FieldByname('PPD_CODPRO_D').AsInteger;
            Lc_Qtde           := FloatToStrF(FieldByname('PPD_QTDE').AsFloat,ffFixed,10,6);
            LcReg.Quantidade  := StrToFloatDef(Lc_Qtde,0) * Registro.Quantidade;
            LcReg.Data        := Registro.Data;
            Self.Insert;
          End;
          Next;
        end;
      end;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCtrlEstoque.RecontagemDeletarByProduto;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    //Verifica o ultimo inventario registrado no sistema
    with Lc_Qry do
    Begin
      if not Transaction.InTransaction then Transaction.StartTransaction;

      SQL.Add(concat(
                      'DELETE FROM TB_CTRL_ESTOQUE ',
                      'WHERE (CET_DATA<:CET_DATA) '
      ));
      ParamByName('CET_DATA').AsDate := FDataInventario;
      ExecSQL;
      if Transaction.InTransaction then Transaction.Commit;

      if not Transaction.InTransaction then Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                      'DELETE FROM TB_CTRL_ESTOQUE ',
                      'WHERE (CET_CODETS=:CET_CODETS) ',
                      ' AND (CET_CODPRO=:CET_CODPRO) ',
                      ' AND (CET_DATA>=:CET_DATA) ',
                      ' and ( ',
                      '        ( upper(CET_TIPO) = ''AJUSTE'' ) ',
                      '     OR ( upper(CET_TIPO) = ''COMPRA'' ) ',
                      '     OR ( upper(CET_TIPO) = ''ENTRADA XML'' ) ',
                      '     OR ( upper(CET_TIPO) = ''INFORMAR'' ) ',
                      '     OR ( upper(CET_TIPO) = ''PRODUÇÃO MP'' ) ',
                      '     OR ( upper(CET_TIPO) = ''PRODUÇÃO PA'' ) ',
                      '     OR ( upper(CET_TIPO) = ''VENDA'' ) ',
                      '     OR ( upper(CET_TIPO) = ''EXTINTOR'' ) ',
                      '     OR ( upper(CET_TIPO) = ''LOTE'' ) ',
                      '     OR ( CET_TIPO is null ) ',
                      '     OR ( upper(CET_TIPO) = ''ESTOQUE DEVOLVIDO'' ) ',
                      '     OR ( upper(CET_TIPO) = ''VENDA CANCELADA'' ) ',
                      '     OR ( upper(CET_TIPO) = ''COMPRA CANCELADA'' ) ',
                      '     OR ( upper(CET_TIPO) = ''AJUSTE CANCELADA'' ) ',
                      '     ) '
                  ));
      ParamByName('CET_CODETS').AsInteger := FEstoque;
      ParamByName('CET_CODPRO').AsInteger := FCodigoProduto;
      ParamByName('CET_DATA').AsDate := FDataInventario;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
    DisposeOf;
  End;
end;

procedure TControllerCtrlEstoque.RecontagemGravarMovimento;
Var
  I : Integer;
begin
  for I := 0 to Lista.Count - 1 do
  Begin
    ClonarObj(Lista[I],Registro);
    Recontagem; //Estou fazendo externamento por que já tenho a informação de composição - 16/02/2022
  End;
end;

procedure TControllerCtrlEstoque.Registra;
Var
  Lc_Qtde : String;
  Lc_Qry : TSTQuery;
  LcReg : TCtrlEstoque;
Begin
  Lc_Qry := GeraQuery;
  Try
    //Insere os novos registros referente a este item
    with Lc_Qry do
    BEgin
      Active := false;
      SQL.Clear;
      SQL.Add(concat(
                 'SELECT ',
                 '  PRO_CODIGO, ',
                 '  PRO_COMPOSICAO, ',
                 '  PPD_QTDE , ',
                 '  PPD_CODPRO_D ',
                 'FROM TB_PRODUTO tb_produto ',
                 '   LEFT OUTER JOIN TB_PROD_PROD tb_prod_prod ',
                 '   ON (tb_prod_prod.PPD_CODPRO_M = tb_produto.PRO_CODIGO) ',
                 'WHERE PRO_CODIGO =:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      if ((FieldByname('PRO_COMPOSICAO').AsString = '1') or (FieldByname('PRO_COMPOSICAO').AsString = '3')) then
      Begin
        Save;
        SendEmail;
      end;
      if ((FieldByname('PRO_COMPOSICAO').AsString = '2') or (FieldByname('PRO_COMPOSICAO').AsString = '3')) then
      Begin
        //Registra o produto da composicao
        LcReg := TCtrlEstoque.Create;
        ClonarObj(Registro,LcReg);
        while not Eof do
        Begin
          if (trim(FieldByname('PPD_CODPRO_D').AsString)<> '') then
          Begin
            Registro.Codigo      := 0;
            Registro.Vinculo     := LcReg.Vinculo;
            Registro.Ordem       := LcReg.Ordem;
            Registro.Item        := LcReg.Item;
            Registro.Estoque     := LcReg.Estoque;
            Registro.operacao    := LcReg.operacao;
            Registro.Produto     := FieldByname('PPD_CODPRO_D').AsInteger;
            Lc_Qtde := FloatToStrF(FieldByname('PPD_QTDE').AsFloat,ffFixed,10,6);
            Registro.Quantidade  := StrToFloatDef(Lc_Qtde,0) * Registro.Quantidade;
            Registro.Data        := LcReg.Data;
            Registro.UpdateAt    := Now;
            Registro.Codigo := getIDbyControlsProducts;
            if ( Registro.Codigo = 0) then
              Self.Insert
            else
              Self.UpdateByID;
            SendEmail;
          End;
          Next;
        end;
      end;

    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlEstoque.Save: boolean;
begin
  Try
    if Registro.Terminal = 0 then
      Registro.Terminal := Gb_Terminal;
    if (Registro.Codigo > 0 ) and ( Registro.Terminal >0 ) then
    Begin
      Self.UpdateByID;
    end
    else
    Begin
      Registro.Codigo := getIDbyControls;
      if ( Registro.Codigo = 0) then
        Self.Insert
      else
        Self.UpdateByID;
    End;
    Result := True;
  Except
    Result := False
  End;
end;



procedure TControllerCtrlEstoque.SendEmail;
var
  LcEmail : TTRSendEmail;
  LcSaldo : Real;
begin
  if EstoqueZerado.NotificaEmail then
  Begin
    if Registro.operacao = 'S' then
    Begin
      LcSaldo := getSaldo;
      if (LcSaldo <= 0 ) then
      Begin
        EstoqueZerado.Registro.Codigo := 0;
        EstoqueZerado.Registro.Data := Now;
        EstoqueZerado.Registro.Estoque := Registro.Estoque;
        EstoqueZerado.Registro.Produto := Registro.Produto;
        EstoqueZerado.Registro.SaldoEncontrado := LcSaldo;
        EstoqueZerado.insert;

        LcEmail := TTRSendEmail.Create;
        LcEmail.Modulo            := 'ESTOQUE';
        LcEmail.CodigoProduto     := EstoqueZerado.Registro.Produto;
        LcEmail.DescricaoProduto  := getDescricaoProduto;
        LcEmail.SaldoEstoque      := EstoqueZerado.Registro.SaldoEncontrado;
        LcEmail.DataHora          := EstoqueZerado.Registro.Data;
        LcEmail.Start;
      End;
    End;
  End;
end;

procedure TControllerCtrlEstoque.setFCodigoInventario(const Value: Integer);
begin
  FCodigoInventario := Value;
end;

procedure TControllerCtrlEstoque.setFCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TControllerCtrlEstoque.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerCtrlEstoque.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TControllerCtrlEstoque.setFDataInventario(const Value: TDate);
begin
  FDataInventario := Value;
end;

procedure TControllerCtrlEstoque.setFDescricaoProduto(const Value: String);
begin
  FDescricaoProduto := Value;
end;

procedure TControllerCtrlEstoque.setFEstoque(const Value: Integer);
begin
  FEstoque := Value;
end;

procedure TControllerCtrlEstoque.setFGrupo(const Value: Integer);
begin
  FGrupo := Value;
end;

procedure TControllerCtrlEstoque.setFMarca(const Value: Integer);
begin
  FMarca := Value;
end;


procedure TControllerCtrlEstoque.setFSubGrupo(const Value: Integer);
begin
  FSubGrupo := Value;
end;

function TControllerCtrlEstoque.Update: boolean;
begin
  Try
    updateObj(Registro);
    Result := True;
  Except
    Result := False
  End;
end;

function TControllerCtrlEstoque.UpdateByID: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.ADD(CONCAT(
                'UPDATE TB_CTRL_ESTOQUE SET ',
                'CET_CODETS=:CET_CODETS, ',
                'CET_QTDE =:CET_QTDE ',
                'WHERE (CET_CODIGO=:CET_CODIGO) '
      ));
      //Passagem de Parametros
      ParamByName('CET_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('CET_CODETS').AsInteger := Registro.Estoque;
      ParamByName('CET_QTDE').AsFloat := Registro.Quantidade;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

{ TProdutoMovimentado }

procedure TProdutoMovimentado.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

{ TProdutoSimples }

procedure TProdutoSimples.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProdutoSimples.setFComposicao(const Value: String);
begin
  FComposicao := Value;
end;

procedure TProdutoSimples.setFEstoque(const Value: Integer);
begin
  FEstoque := Value;
end;

end.
