unit RN_Produto;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db, UN_TabelasEmListas,FireDAC.Stan.Param;

    Function  Fc_BuscaDescricaoProduto(Fc_cd_Produto:String):String;
    procedure Pc_VincularCodigoProdutoFornecedor(pro_codigo,Fornecedor,prf_produto:String);
    procedure Pc_DesvincularCodigoProdutoFornecedor(Fc_Cd_Produto,Fc_Cd_Fornecedor:String);
    PROCEDURE Pc_Copia_ProdForn(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
    function Fc_ValidaEscalaUnidadeProduto(Fc_Cd_Produto:Integer;Fc_Qtde:Real):Boolean;
    function Fc_Dt_UltimaCompraProduto(Pc_Cd_Produto:Integer):String;
    function Fc_Dt_UltimaVendaProduto(Pc_Cd_Produto:Integer):String;
    procedure Pc_VerificaDadosNCM;
    procedure Pc_ListaProdutoComboBox(Pc_Lista:TComboBox);
    procedure Pc_CriaRegistroTabelas(Pc_Cd_Produto: Integer; PC_Vl_Normal,PC_Vl_Promocao : Real);
    function Fc_PegaProduto(Fc_Codigo: String;Fc_Tipo:String): String;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, ControllerBase,
  Un_Regra_Negocio, RN_Crud;



Function  Fc_BuscaDescricaoProduto(Fc_cd_Produto:String):String;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin

      Lc_SqlTxt := 'SELECT (PRO_CODIGOFAB || '' - '' || PRO_DESCRICAO) DESCRICAO '+
                   'FROM TB_PRODUTO '+
                   'WHERE (PRO_CODIGO=:PRO_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsString := Fc_cd_Produto;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('DESCRICAO').AsString;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_VincularCodigoProdutoFornecedor(pro_codigo,Fornecedor,prf_produto:String);
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
begin
  if Trim(pro_codigo) <> '' then
  Begin
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Try
      with Lc_Qry do
      Begin
        SQL.Add('delete '+
                'from TB_PROD_FORN '+
                'where (PFR_CODFOR =:PFR_CODFOR) and (PFR_PRODUTO =:PFR_PRODUTO) ');
        ParamByName('PFR_CODFOR').AsString  := fornecedor;
        ParamByName('PFR_PRODUTO').AsString := prf_produto;
        ExecSQL;
        //
        Active := False;
        SQL.Clear;
        SQL.Add('UPDATE OR INSERT INTO TB_PROD_FORN (PFR_CODPRO, PFR_CODFOR, PFR_PRODUTO)'+
                '           VALUES (:PFR_CODPRO, :PFR_CODFOR, :PFR_PRODUTO) '+
                '         MATCHING (PFR_CODPRO, PFR_CODFOR) ');
        ParamByName('PFR_CODPRO').AsString  := pro_codigo;
        ParamByName('PFR_CODFOR').AsString  := fornecedor;
        ParamByName('PFR_PRODUTO').AsString := prf_produto;
        ExecSQL;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  End;
end;

procedure Pc_DesvincularCodigoProdutoFornecedor(Fc_Cd_Produto,Fc_Cd_Fornecedor:String);
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE FROM TB_PROD_FORN WHERE (PFR_CODPRO IS NOT NULL) ');
      if Trim(Fc_Cd_Produto)<> '' then
        SQL.Add('AND (PFR_CODPRO =:PFR_CODPRO) ');
      if Trim(Fc_Cd_Fornecedor)<> '' then
        SQL.Add('AND (PFR_CODFOR =:PFR_CODFOR) ');
      //Passagem de parametros
      if Trim(Fc_Cd_Produto)<> '' then
        ParamByName('PFR_CODPRO').AsString  := Fc_Cd_Produto;
      if Trim(Fc_Cd_Fornecedor)<> '' then
        ParamByName('PFR_CODFOR').AsString  := Fc_Cd_Fornecedor;
      ExecSQL;
      if DM.IBT_Crud.InTransaction then DM.IBT_Crud.Commit;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

PROCEDURE Pc_Copia_ProdForn(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('  SELECT PFR_CODFOR, PFR_PRODUTO FROM tb_prod_forn  '+
              ' WHERE PFR_CODPRO =:PFR_CODPRO  ');
      ParamByName('PFR_CODPRO').AsInteger := Pc_cd_Prod_Ant;
      Active:=true;
      FetchAll;
      First;
      while not Eof do
      begin
        Pc_VincularCodigoProdutoFornecedor(IntToStr(Pc_cd_Prod_novo),
                                           fieldbyname('PFR_CODFOR').AsString,
                                           fieldbyname('PFR_PRODUTO').AsString);
        Next;
      end;
      End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_ValidaEscalaUnidadeProduto(Fc_Cd_Produto:Integer;Fc_Qtde:Real):Boolean;
var
  Lc_Qry: TSTQuery;
  Lc_Escala : Real;
  LcBase : TControllerBase;
begin
  Result := True;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;

  Try
    with Lc_Qry do
    Begin
      SQL.Add('select MED_ESCALA '+
              'FROM tb_produto '+
              'INNER JOIN tb_medida '+
              'ON (MED_CODIGO = PRO_CODMED) '+
              'WHERE PRO_CODIGO =:PRO_CODIGO  AND MED_ESCALA>0  ');
      ParamByName('PRO_CODIGO').AsInteger := Fc_Cd_Produto;
      Active:=true;
      FetchAll;
      First;
      if (recordcount>0) then
      Begin
        if (FieldByName('MED_ESCALA').AsFloat > 0) then
        Begin
          Lc_Escala := Frac(Fc_Qtde / FieldByName('MED_ESCALA').AsFloat);
          if  Lc_Escala > 0 then
          Begin
            MensagemPararExecucao('A escala da medida deste produto não permite a quantidade '+ FloatToStrF(Fc_Qtde,ffFixed,10,2) + EOLN+
                                  'A quantidade deve obeceder a escala de '+ FloatToStrF(FieldByName('MED_ESCALA').AsFloat,ffFixed,10,2));
            Result := False;
            exit;
          End;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_Dt_UltimaCompraProduto(Pc_Cd_Produto:Integer):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT  max(nf.nfl_dt_emissao) DATA '+
              'FROM  TB_ITENS_NFL it '+
              '  inner join tb_pedido pd '+
              '  on (pd.ped_codigo = it.itf_codped) '+
              '  inner join tb_nota_fiscal nf '+
              '  on (nf.nfl_codigo = it.itf_codnfl) '+
              'WHERE (pd.PED_TIPO = 2) AND (pd.ped_faturado = ''S'') '+
              ' AND  (ITF_CODPRO =:ITF_CODPRO)');
      //Data de Compra
      ParamByName('ITF_CODPRO').AsInteger := Pc_Cd_Produto;
      Active := true;
      FetchAll;
      First;
      IF (RecordCount > 0) then
        Result := FieldByName('DATA').AsString
      else
        Result := '';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_Dt_UltimaVendaProduto(Pc_Cd_Produto:Integer):String;
var
  Lc_Qry: TSTQuery;
  Lc_Dias : Integer;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Lc_Dias := StrToIntDef(Fc_Tb_Geral('L','PRO_P_INATIVIDADE','0'),90);
  Try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT  max(nf.nfl_dt_emissao) DATA '+
              'FROM  TB_ITENS_NFL it '+
              '  inner join tb_pedido pd '+
              '  on (pd.ped_codigo = it.itf_codped) '+
              '   inner join tb_nota_fiscal nf '+
              '   on (nf.nfl_codigo = it.itf_codnfl) '+
              'WHERE (pd.PED_TIPO = 1) AND (pd.ped_faturado = ''S'') '+
              ' AND  (ITF_CODPRO =:ITF_CODPRO)');
      ParamByName('ITF_CODPRO').AsInteger := Pc_Cd_Produto;
  //    ParamByName('NFL_DT_EMISSAO').AsDate := (Date - Lc_Dias) ;
      Active := true;
      FetchAll;
      First;
      IF (RecordCount > 0) then
        Result := FieldByName('DATA').AsString
      else
        Result := '';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_VerificaDadosNCM;
var
  Lc_Qry: TSTQuery;
  //Lc_Form : TFr_Pesq_NCM;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select NCM_CHAVE '+
              'from tb_ncm_controle '+
              'where :NCM_HOJE between NCM_DT_INI AND NCM_DT_FIM');
      ParamByName('NCM_HOJE').AsDate := Date;
      Active := true;
      FetchAll;
      First;
      IF (RecordCount = 0) then
      Begin
        MensagemPararExecucao('A tabela de NCM está sendo controlada por data.');
//        try
//          Lc_Form := TFr_Pesq_NCM.create(nil);
//          Lc_Form.It_Visualizar := False;
//          Lc_Form.ShowModal;
//        finally
//          Lc_Form.disposeOf;
//        end;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;



procedure Pc_ListaProdutoComboBox(Pc_Lista:TComboBox);
Begin
  with DM_ListaConsultas do
  Begin
    if not Qr_ListaProduto.Active then
      Qr_ListaProduto.Active := true;
    Pc_Lista.Clear;
    Qr_ListaProduto.First;
    while not Qr_ListaProduto.Eof do
    Begin
      Pc_Lista.Items.Add(Qr_ListaProduto.FieldByname('PRO_DESCRICAO').AsString);
      Qr_ListaProduto.Next;
    end;
  end;
end;

procedure Pc_CriaRegistroTabelas(Pc_Cd_Produto: Integer; PC_Vl_Normal,PC_Vl_Promocao : Real);
var
  Lc_Qry_Tabelas: TSTQuery;
  Lc_Qry_Precos: TSTQuery;
  Lc_Qry_Insere: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Vl_Venda : Real;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  //Cria a Consulta de Tabelas Disponiveis
  Lc_Qry_Tabelas := LcBase.GeraQuery;
  //Consulta que cria um Tabela para cada item
  Lc_Qry_Precos := LcBase.GeraQuery;

  //Cria a Sql que insere a registro de preco
  Lc_Qry_Insere := LcBase.GeraQuery;
  Try
    Lc_SqlTxt := 'SELECT TPR_CODIGO ' +
                 'FROM TB_TABELA_PRECO tb_tabela '+
                 'WHERE ( TPR_ATIVA = ''S'' ) ';
    Lc_Qry_Tabelas.SQL.Add(Lc_SqlTxt);
    Lc_Qry_Tabelas.Active := True;
    Lc_Qry_Tabelas.FetchAll;
    Lc_Qry_Tabelas.First;



    //consulta Tabela de cada produto
    Lc_SqlTxt := 'SELECT PRC_CODIGO, PRC_VL_VDA ' +
                 'FROM TB_PRECO tb_preco '+
                 'WHERE (PRC_CODTPR =:PRC_CODTPR) AND (PRC_CODPRO=:PRC_CODPRO) ';
    Lc_Qry_Precos.SQL.Add(Lc_SqlTxt);

    //Inclui o Sql que vai inserir o Estoque para cada produto
    Lc_Qry_Insere.Active := False;
    Lc_Qry_Insere.SQL.Clear;
    Lc_SqlTxt := 'insert into "TB_PRECO"( '+
                 '    "PRC_CODIGO" '+
                 '  , "PRC_CODTPR" '+
                 '  , "PRC_CODPRO" '+
                 '  , "PRC_VL_VDA" '+
                 '  , "PRC_AQ_COM")'+
                 '  values('+
                 '    :"PRC_CODIGO" '+
                 '  , :"PRC_CODTPR" '+
                 '  , :"PRC_CODPRO" '+
                 '  , :"PRC_VL_VDA" '+
                 '  , :"PRC_AQ_COM" )';
    Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
    while not Lc_Qry_Tabelas.Eof do
    begin
      Lc_Qry_Precos.Active := False;
      Lc_Qry_Precos.ParamByName('PRC_CODTPR').AsInteger := Lc_Qry_Tabelas.FieldByname('TPR_CODIGO').AsInteger;
      Lc_Qry_Precos.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
      Lc_Qry_Precos.Active := True;
      Lc_Qry_Precos.FetchAll;
      if (Lc_Qry_Precos.RecordCount = 0) then
      begin
        Lc_Qry_Insere.Active := False;
        Lc_Qry_Insere.ParamByName('PRC_CODIGO').AsInteger := Fc_Generator('GN_PRECO','','');
        Lc_Qry_Insere.ParamByName('PRC_CODTPR').AsInteger := Lc_Qry_Tabelas.FieldByName('TPR_CODIGO').AsInteger;
        Lc_Qry_Insere.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
        if Lc_Qry_Tabelas.FieldByname('TPR_CODIGO').AsInteger = 2 then
          Lc_Qry_Insere.ParamByName('PRC_VL_VDA').AsFloat := PC_Vl_Promocao
        else
          Lc_Qry_Insere.ParamByName('PRC_VL_VDA').AsFloat := PC_Vl_Normal;
        Lc_Qry_Insere.ParamByName('PRC_AQ_COM').AsFloat := 0;
        Lc_Qry_Insere.Active := True;
      end;
      Lc_Qry_Tabelas.Next;
      end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry_Tabelas);
    LcBase.FinalizaQuery(Lc_Qry_Precos);
    LcBase.FinalizaQuery(Lc_Qry_Insere);
    LcBase.DisposeOf;
  End;
end;


function Fc_PegaProduto(Fc_Codigo: String;Fc_Tipo:String): String;
var
  Lc_SQL: String;
  Lc_Qry: TSTQuery;
  Lc_Tp_Descricao : String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SQL := 'SELECT PRO_CODIGO, PRO_DESCRICAO FROM TB_PRODUTO '+
                'WHERE PRO_CODIGO=:PRO_CODIGO' ;
      if (Trim(Fc_Tipo) <> '') then
        Lc_SQL := Lc_SQL + ' and (PRO_TIPO = ''' + Fc_Tipo + ''') ' ;

      SQL.Add(Lc_SQL);
      ParamByName('PRO_CODIGO').AsString := Fc_Codigo;
      Active := True;

      if RecordCount > 0 then
      begin
        Result := FieldByName('PRO_DESCRICAO').AsString;
      end
      else
      begin
        if Fc_Tipo = 'S' then Lc_Tp_Descricao := 'Serviço'
        else
        if Fc_Tipo = 'P' then Lc_Tp_Descricao := 'Produto Acabado'
        else
        if Fc_Tipo = 'M' then Lc_Tp_Descricao := 'Matéria Prima'
        else
          Lc_Tp_Descricao := 'Produto';
        MensagemPararExecucao(Lc_Tp_Descricao + ' não encontrado.');
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;


end.
