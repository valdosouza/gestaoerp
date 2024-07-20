unit ControllerInventario;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblInventario ,Generics.Collections,ControllerProduto,ControllerCtrlEstoque,
  System.Variants;

Type
  TListaInventario = TObjectList<TInventario>;

  TControllerInventario = Class(TControllerBase)

  private
    FDataFinal: TDate;
    FDataInicial: TDate;
    FCodigoEstoque: Integer;
    FCodigoProduto: Integer;
    FEstabelecimento: Integer;
    FDataUltimoInventario: TDate;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFCodigoEstoque(const Value: Integer);
    procedure setFCodigoProduto(const Value: Integer);
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFDataUltimoInventario(const Value: TDate);

  public
    Registro : TInventario;
    Lista : TListaInventario;
    Produto : TControllerProduto;
    CtrlEstoque : TControllerCtrlEstoque;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function saldo:Real;
    procedure Clear;
    function recontar:Real;
    procedure GerarMovimento;
    procedure DeletarMovimento;
    function GetUltimoSaldo:Real;
    function UltimaDataInventarioProduto:TDate;


    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
    property DataUltimoInventario : TDate read FDataUltimoInventario write setFDataUltimoInventario;
    property CodigoProduto : Integer read FCodigoProduto write setFCodigoProduto;
    property CodigoEstoque : Integer read FCodigoEstoque write setFCodigoEstoque;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;

  End;


implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerInventario.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerInventario.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInventario.Create;
  Produto := TControllerProduto.create(self);
  Lista := TListaInventario.Create;
  CtrlEstoque := TControllerCtrlEstoque.create(self);
end;

procedure TControllerInventario.DeletarMovimento;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_DataInicial : TDate;
  Lc_Operacao : String;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'delete from tb_ctrl_estoque ce ',
                'where ce.cet_codpro =:PRO_CODIGO ',
                ' AND CE.cet_data between :DATA_INI AND :DATA_FIM ',
                ' and ce.cet_codets =:EST_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Self.FCodigoProduto;
      ParamByName('DATA_INI').AsDate      := Self.FDataInicial;
      ParamByName('DATA_FIM').AsDate      := Self.FDataFinal;
      ParamByName('EST_CODIGO').AsInteger := Self.FCodigoEstoque;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInventario.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInventario.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Produto.DisposeOf;
  inherited;
end;

procedure TControllerInventario.GerarMovimento;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_DataInicial : TDate;
  Lc_Operacao : String;
Begin
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
                   ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                   ' AND ( orp.ORP_ESTMP =:EST_CODIGO ) ',
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
                   ' AND ( orp.ORP_ESTMP =:EST_CODIGO )',
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
                   ' AND ( IOS.ios_codvcl =:PRO_CODIGO ) '
                );

      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Self.FCodigoProduto;
      ParamByName('DATA_INI').AsDate      := Self.FDataInicial;
      ParamByName('DATA_FIM').AsDate      := Self.FDataFinal;
      ParamByName('EST_CODIGO').AsInteger := Self.FCodigoEstoque;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        First;
        while not eof do
        Begin
          with CtrlEstoque.Registro do
          Begin
            Codigo      := 0;
            Vinculo     := FieldByName('CET_VINCULO').AsString;
            Ordem       := FieldByName('CET_CONTROLE').AsInteger;
            Item        := FieldByName('CET_ITEM_CTRL').AsInteger;
            Estoque     := FieldByName('CET_CODETS').AsInteger;
            operacao    := FieldByName('CET_OPERACAO').AsString;
            Produto     := FieldByName('CET_CODPRO').AsInteger;
            Quantidade  := FieldByName('CET_QTDE').AsFloat;
            Data        := FieldByName('CET_DATA').AsDateTime;
            Tipo        := FieldByName('CET_TIPO').AsString;
            UpdateAt    := Now;
          End;
          CtrlEstoque.Recontagem;
          Next;
        end;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInventario.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerInventario.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerInventario.recontar: Real;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_DataInicial : TDate;
  Lc_Operacao : String;
Begin
  Result := 0;
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
                   ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                    ' and ( ITF_CODEST =:EST_CODIGO ) ',
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
                   ' AND ( orp.ORP_ESTMP =:EST_CODIGO ) ',
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
                   ' AND ( orp.ORP_ESTMP =:EST_CODIGO )',
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
                   ' AND ( IOS.ios_codvcl =:PRO_CODIGO ) '
                );

      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Self.FCodigoProduto;
      ParamByName('DATA_INI').AsDate      := Self.FDataInicial;
      ParamByName('DATA_FIM').AsDate      := Self.FDataFinal;
      ParamByName('EST_CODIGO').AsInteger := Self.FCodigoEstoque;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        First;
        Result := 0;
        while not eof do
        Begin
          if FieldByName('CET_OPERACAO').AsString = 'E' then
            REsult := Result + FieldByName('CET_QTDE').AsFloat
          else
            REsult := Result - FieldByName('CET_QTDE').AsFloat;
          Next;
        end;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInventario.saldo: Real;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT IVT_QT_ATUAL '+
                   'FROM TB_INVENTARIO '+
                   'WHERE (IVT_CODPRO =:IVT_CODPRO) AND (IVT_DATA=:IVT_DATA) AND (IVT_CODMHA =:IVT_CODMHA) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_CODPRO').AsInteger := Registro.Produto;
      ParamByName('IVT_CODMHA').AsInteger := Registro.Estabelecimento;
      ParamByName('IVT_DATA').AsDate      := Registro.Data;
      Active := True;
      Result := fieldbyName('IVT_QT_ATUAL').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInventario.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerInventario.setFCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TControllerInventario.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerInventario.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TControllerInventario.setFDataUltimoInventario(const Value: TDate);
begin
  FDataUltimoInventario := Value;
end;

procedure TControllerInventario.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TControllerInventario.setFCodigoEstoque(const Value: Integer);
begin
  FCodigoEstoque := Value;
end;


function TControllerInventario.UltimaDataInventarioProduto:TDate;
Var
  Lc_Qry: TSTQuery;
begin
  Result := Date;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin

      SQL.Add(concat(
                'SELECT MAX(IVT_DATA) IVT_MAX ',
                'FROM TB_INVENTARIO ',
                'WHERE IVT_CODPRO =:IVT_CODPRO ',
                ' AND (IVT_CODETS =:IVT_CODETS) ',
                ' AND (IVT_CODMHA=:IVT_CODMHA) '

      ));
      ParamByName('IVT_CODPRO').AsInteger := FCodigoProduto;
      ParamByName('IVT_CODETS').AsInteger := FCodigoEstoque;
      ParamByName('IVT_CODMHA').AsInteger := FEstabelecimento;
      Active := True;
      FetchAll;
      if (RecordCount > 0) AND (fieldbyName('IVT_MAX').Value <> null) then
        Result := fieldbyName('IVT_MAX').Value
      else
        Result := StrToDate('01/01/1900');
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerInventario.GetUltimoSaldo: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TInventario;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT first 1 iv.ivt_data, iv.IVT_QT_ATUAL ',
                'FROM TB_INVENTARIO iv ',
                'WHERE (iv.IVT_CODPRO =:IVT_CODPRO) ',
                ' AND (iv.IVT_CODMHA =:IVT_CODMHA) ',
                ' AND (iv.IVT_CODETS =:IVT_CODETS) ',
                ' AND (iv.IVT_DATA =:IVT_DATA) ',
                'order BY 1 desc '
      ));
      ParamByName('IVT_DATA').AsDateTime := Self.FDataUltimoInventario;
      ParamByName('IVT_CODPRO').AsInteger := Self.FCodigoProduto;
      ParamByName('IVT_CODETS').AsInteger := Self.FCodigoEstoque;
      ParamByName('IVT_CODMHA').AsInteger := Self.FEstabelecimento;
      Active := True;
      FetchAll;
      if ( RecordCount > 0) then
        Result := FieldByName('IVT_QT_ATUAL').AsFloat
      else
        Result := 0;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerInventario.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerInventario.getById;
begin
  _getByKey(Registro);
end;


function TControllerInventario.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TInventario;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_INVENTARIO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TInventario.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
