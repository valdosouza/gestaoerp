unit Un_Regra_Negocio;
{$R-,Q-} //Switches para desabilitar a chegagem de overflow e de range
        //Para a função de criptografia. Não apagar!

interface

uses
   ACBrdevice,FavoritoButtons,ControllerBase,FireDAC.Stan.Param,
   ACBrBase, ACBrBoleto, ACBrUtil.Math, ACBrBoletoFCFortesFr,
   Un_DM, UN_MSG,  ACBrGAV,Winapi.WinSpool, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Imaging.jpeg, Classes, Vcl.Grids, STQuery, Vcl.Forms,
  SysUtils, Variants, Data.DB, System.Math, UITypes,
  Vcl.Dialogs, Types, IniFiles, Vcl.ExtCtrls, Vcl.Graphics, STDatabase,
  UN_TabelasEmListas;
  

//-------------------------Controle Estabelecimentos-----------------------------------------
  procedure Pc_AtivaEstabelecimento();
  procedure Pc_DefineEmpresaAtiva(Pc_Cd_Empresa:Integer);

  procedure Pc_MultiEmpresaMostraTodas(Pc_Grupo:TGroupBox;Pc_Check : TCheckBox);
  Procedure Pc_HabilitarMultiEmpresa(Pc_Name_LookCombox:TDBLookupComboBox;Pc_CheckMultEmpresa:TCheckBox);
  procedure Pc_DefineEstoqueEmpresa(Pc_Cd_Empresa:Integer);
  procedure Pc_DadosComercioEletronico(Pc_Cd_empresa:Integer);
  procedure Fc_BuscaImagemEmpresa(Img:TPicture; Pc_Descricao:String);
  function Fc_BuscaStreamEmpresa(Pc_Descricao:String):TStream;
  function Fc_BuscaImagemEstabelecimento(Pc_Descricao:String):TStream;


//-------------------------Controle Transportadoras-------------------------------------------
  procedure Pc_AtivaTransportadora(Pc_Cd_Codigo:Integer);
//-------------------------Usuarios do Sistema  ---------------------------------------------
  procedure Pc_MontaUsuario(Pc_Lista: TComboBox);

  Function Fc_CriaPrimeiroUsuario():Boolean;
  function Fc_Cd_Vendedor_Usuario(Pc_Cd_Usuario:Integer):Integer;


//-------------------------Permissões de Usuarios do Sistema  -------------------------------
  Procedure Pc_Apaga_permissoes(Pc_Cd_Usuario:Integer);



//-------------------------Atualiza Cidades -------------------------------------------------
  function Fc_BuscaCodigoCidade(fc_IBGE:Integer; Fc_Descricao,Fc_UF:String): Integer;

//-----------------------------------Enderecos -------------------------------------------------
  procedure Pc_DeFineListaEndereco(Pc_Cd_Cliente:Integer);


//-----------------------------------Tributação -------------------------------------------------
   function Fc_BuscaCodigoCFOP(fc_CFOP:String): Integer;
   function Fc_BuscaCodigoCSOSN(Fc_CSOSN:String): Integer;
   function Fc_BuscaCodigoModalFrete(fc_Frete:String): Integer;
//------------------------- Cadastro e pesquisa de Produtos--------------------------------------
  function Fc_ProdutosVendidos(Fc_DataIni,Fc_DataFim:TDAte):String;
  function Fc_ProcuraProdutoDescricao(Fc_Produto: string):Integer;
  function Fc_ProcuraProdutoCodigo(Fc_Cd_Produto: integer):String;
  function Fc_ProcuraRegistraMedida(Fc_Medida,Fc_Especial: string):Integer;
  function Fc_ProcuraRegistraMarca(Fc_Marca : string):Integer;
  function Fc_ProcuraRegistraEmbalagem(Fc_Embalagem, Fc_Abreviatura : string):Integer;
  function Fc_ProcuraRegistraGrupo(Fc_Grupo : string):Integer;
  function Fc_ProcuraRegistraSubGrupo(fC_SubGrupo,Fc_Grupo : string):Integer;
  procedure Pc_CriaTabelasPreco(Pc_Cd_Produto: Integer;Pc_VL_Custo,Pc_Vl_CustoMedio:Real);


//------------------------- Cadastro e pesquisa de Tabelas de Preço------------------------------
  function Fc_CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,Fc_Aq_Margem:real;CasaDecimal:Integer):Real;
  function Fc_CalcularMargemPeloPreco(Fc_Vl_Custo,Fc_Vl_Venda:real;CasaDecimal:Integer):Real;

//------------------------- Cadastro e pesquisa de Empresas--------------------------------------




//-------------------------Controle de Pedidos -------------------------------------------------



  function Fc_ValidaDesconto(Fc_Vl_Total:REal; Fc_Vl_Desconto:Real;Fc_Prazo:String): Boolean;
  function Fc_VL_Desconto(fc_Tipo: Char;Fc_Vl_Total:REal; Fc_Aq_Desconto:Real;Fc_Vl_Desconto:Real): Real;


//-------------------------Controle de Separação de mercadoria ----------------------------------
  procedure Pc_SeparacaoMercadoria(Pc_cd_Pedido:Integer;
                                   Pc_cd_Item:Integer;
                                   Pc_Cd_Produto:Integer;
                                   Pc_Dt_Prevista : TDATE;
                                   Pc_Qtde : Real);

  procedure Pc_DevolveSeparacaoMercadoria(Pc_cd_Despacho:Integer;
                                          Pc_cd_Item:Integer);
  procedure Pc_ExcluirSeparacaoMercadoria(Pc_cd_Despacho:Integer;
                                          Pc_cd_Item:Integer);
  procedure Pc_LiberarSeparacaoMercadoria(Pc_cd_Pedido:Integer);
  Function Fc_VerificaExistenciaSeparacaoMercadoria(Fc_cd_Pedido:Integer;Fc_Estagio:String):Boolean;




//-------------------------Controle de Cheques -------------------------------------------------
  function Fc_PesquisaNumeroCheque(Fc_cd_Cheque:Integer):String;

//-------------------------Módulo de Compras -------------------------------------------------
  Function Fc_Dt_Ultima_Compra(Fc_Cd_Empresa:Integer):String;

  //-------------------------Módulo de Vendas -------------------------------------------------


  Function Fc_Dt_Ultima_Venda(Fc_Cd_Empresa:Integer):String;

  Function Fc_Vl_S_T_Venda(Fc_NotaFiscal:Boolean;
                            Fc_Periodo:Boolean;
                            Fc_Dt_Inicio:TDate;
                            Fc_Dt_Fim:TDate;
                            Fc_Cd_Cliente:Integer;
                            Fc_Nm_Cliente:String;
                            Fc_Cd_Transportadora:Integer;
                            Fc_Cd_VendedorCliente:Integer;
                            Fc_Cd_VendedorPedido:Integer;
                            Fc_End_Regiao:String;
                            Fc_cd_Estabelecimento:Integer):Real;


  Function Fc_Vl_Frete_Cotacao(Fc_Numero:String;
                               Fc_Periodo:Boolean;
                               Fc_Dt_Inicio:TDate;
                               Fc_Dt_Fim:TDate;
                               Fc_Cd_Cliente:Integer;
                               Fc_Nm_Cliente:String;
                               Fc_Cd_VendedorCliente:Integer;
                               Fc_Cd_VendedorPedido:Integer;
                               Fc_End_Regiao:String;
                               Fc_cd_Estabelecimento:Integer):Real;

//------------------------- Sistema de Cobrança por Boleto ----------------------------------
  procedure Pc_MostraListaCarteira(Pc_Cd_Banco:Integer);


//------------------------- Operação com componentes------ ----------------------------------
  procedure Pc_LimpaStringGrid(Pc_Grid : TStringGrid);
  procedure Del_Linha_StringGrid(Pc_strGrid: TStringGrid; LinhaADeletar:Integer;LinhaFixa:Integer);

//--------------------------Funções e Validação da Nota Fiscal Eletronica---------------------
  function Fc_ChaveDanfe_XMl(Fc_cd_Nota:Integer):String;

  Function Fc_ConteudoXML(pc_cod_nota:integer):string;

  procedure Pc_CancelaVendaComercioEletronico(Pc_Cd_Pedido:Integer);
  procedure Pc_Retornodevolucao(Pc_Dataset:TSTQuery);

  procedure Pc_AtualizarItensNota(Pc_Sentido,Pc_Status:String;Pc_Cd_Nota,Pc_cd_Pedido:Integer;Pc_Dataset:TSTQuery);
  procedure Pc_ApagaICMS_FCP(Pc_Cd_Nota:Integer);
  Procedure Pc_AtualizacaoEstoqueNota(Pc_StatusNF:String;Pc_Tp_Pedido:Integer;Pc_cd_Pedido:Integer);
  procedure Pc_AtualizarItensDevolucao(Pc_Sentido:String;Pc_DataSet:TSTQuery);
  procedure Pc_apagaItensNfl_complementar(pc_cd_nfl:Integer);




//--------------------------Funções para negocios especificos-----------------------------------
  function Fc_codigosNegocio():String;

//--------------------------Controle da tela de Pizzaria-----------------------------------------
  function  Fc_LocalizaComponente(Fc_Parent : TComponent; Pc_Alvo:TClass):TComponent;
  function  Fc_LocalizaComponentePorNome(Fc_Parent : TComponent; Pc_Alvo:TClass;Pc_Nome:String;Pc_tamanho:Integer):TComponent;
  function Fc_VerificaItemGridSelecionado(Pc_Grid : TStringGrid;pc_Coluna:Integer):Boolean;

  //--------------------------GAVETA-----------------------------------------
  Function Fc_ValidaAberturaGaveta(Usa:Boolean):Boolean;
  procedure Pc_ConfiguraGavetaACBR;
  procedure Pc_AbreGaveta;
  procedure Pc_AbreGavetaViaImpressaoEpson(Aporta:String);
  procedure Pc_AbreGavetaViaImpressaoBematech(Aporta:String);
  procedure Pc_AbreGavetaBematech(ModeloBematech:Integer);
  //--------------------------GUILHOTINA-----------------------------------------
  procedure Pc_AcionaGuilhotina(Aporta:String);
  procedure Pc_AcionaGuilhotinaEpson(Aporta:String);
  procedure Pc_AcionaGuilhotinaDiebold(Aporta:String);
  procedure Pc_AcionaGuilhotinaBematech(ModeloBematech:Integer);



var

//-------------------------Permissões de Usuarios do Sistema  -------------------------------

//-------------------------Formas de Pagamentos  --------------------------------------------

//-------------------------Atualiza Unidades da Federação -------------------------------------------------
  //Aliquota interna do UF de DEstino
  Gb_Aq_St_ICMS : Real;
  //Margem de Valor Agregado para UF de DEstino
  Gb_Mg_VA_St_Icms : Real;

//-------------------------Atualiza Cidades -------------------------------------------------

//------------------------- Cadastro e pesquisa de Produtos--------------------------------------

//------------------------- Cadastro e pesquisa de Empresas--------------------------------------

//-------------------------Controle de Despacho -------------------------------------------------



//-------------------------Controle de Cheques -------------------------------------------------


implementation

//-------------------------Controle de Registros em Geral------------------------------------

uses UN_Sistema, main, RN_Permissao,RN_Despacho,Un_stored_procedures, RN_EStoque,
     un_mp2032;

//-------------------------Controle Estabelecimentos-----------------------------------------

procedure Pc_AtivaEstabelecimento();
Begin
  with DM.Qr_Estabelecimento do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    First;
    //Gb_PAF_NFE_e := ( DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString = 'SC' );
    Gb_PAF_NFE_e := ( Fc_Tb_Geral('L','GRL_G_PAF_NFCE','N') = 'S');
  end;
end;



procedure Pc_DefineEmpresaAtiva(Pc_Cd_Empresa:Integer);
//Var
//  Lc_Qry : TSTQuery;
//  LcBase : TControllerBase;
Begin
  {
  with Fr_Principal do
  Begin
    if Pc_Cd_Empresa = 0 then
    Begin
      try
        LcBase := TControllerBase.create(nil);
        Lc_Qry := LcBase.GeraQuery;
        with Lc_Qry do
        Begin
          SQL.add('Select EMP_CODIGO, EMP_FANTASIA FROM TB_EMPRESA WHERE (EMP_TIPO = ''0'') ');
          Active := True;
          Fetchall;
          If RecordCount = 0 then
          Begin
            MensagemPararExecucao('O cadastro do Estabelecimento está incompleto.');
            if not Assigned(Fr_MinhaEmpresa) then (Application.CreateForm(TFr_MinhaEmpresa, Fr_MinhaEmpresa));
            Fr_MinhaEmpresa.ShowModal;
          end
          else
          Begin
            GB_NM_Empresa := FieldByname('EMP_FANTASIA').AsString;
            Gb_CodMha := FieldByname('EMP_CODIGO').AsInteger;
            Pc_AtivaEstabelecimento;
          end;
        End;
      finally
        LcBase.FinalizaQuery(Lc_Qry);
        LcBase.DisposeOf;
      end;
    end
    else
    Begin
      Gb_CodMha := Pc_Cd_Empresa;
      Pc_AtivaEstabelecimento;
      GB_NM_Empresa := DM.Qr_Estabelecimento.FieldByname('EMP_FANTASIA').AsString;
      Gb_CodMha := DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger;
    end;
    Fc_BuscaImagemEmpresa(Fr_Principal.Img_Principal.Picture, 'PAINEL');
    Pc_DefineEstoqueEmpresa(Gb_CodMha);
    Pc_DadosComercioEletronico(Gb_CodMha);
    //Define se compartilha os produtos entre as empresas
    GB_ProdCompartilha := (Fc_Tb_Geral('L','PRO_G_COMPARTILHA','S') = 'S');
    IF (Menu =  MnuOper) then Pc_MenuOperacao else
    IF (Menu =  MnuFin) then Pc_MenuFinanceiro else
    IF (Menu =  MnuBco) then Pc_MenuBanco else
    IF (Menu =  MnuPsl) then PC_MenuPessoal else
      Pc_MenuOperacao
  End;
  }
end;


procedure Pc_MultiEmpresaMostraTodas(Pc_Grupo:TGroupBox;Pc_Check : TCheckBox);
Var
  Lc_Nivel : Integer;
begin
  //Guarda o nivel atual do Usuario
  Lc_Nivel := Gb_Nivel;
  //Permite o acesso a esta funcionalidade a todos os usuarios
  Gb_Nivel := 1;
  //Recoloca o nivel do usuario
  //Pc_Grupo.Enabled := Fc_MultiEmpresa AND Fc_HabilitaPermissao('MultiEmpresa','VISUALIZAR','S');
  Gb_Nivel :=Lc_Nivel;
  Pc_Check.Checked :=Fc_Tb_Geral('L','GRL_G_MULTIEMP_MOSTRATODAS','N') = 'S';
end;

Procedure Pc_HabilitarMultiEmpresa(Pc_Name_LookCombox:TDBLookupComboBox; Pc_CheckMultEmpresa:TCheckBox);
//Var
//  Lc_Nivel : Integer;
begin
  {
  //Guarda o nivel atual do Usuario
  Lc_Nivel := Gb_Nivel;
  Gb_Nivel := 1;
  if Fc_HabilitaPermissao('AnaliseMultiEmpresa','VISUALIZAR','S') then
    Begin
    IF Pc_CheckMultEmpresa.Checked then
    Begin
      Pc_Name_LookCombox.KeyValue := Null;
      Pc_Name_LookCombox.Enabled := False;
    end
    else
    Begin
      Pc_AtivaEstabelecimento;
      Pc_Name_LookCombox.KeyValue := DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsInteger;
      Pc_Name_LookCombox.KeyValue:=Gb_CodMha;
      if Fc_MultiEmpresa then
      begin
        Pc_Name_LookCombox.Enabled :=true;
      end
      else
      begin
        Pc_Name_LookCombox.KeyValue := Gb_CodMha;
        Pc_Name_LookCombox.Enabled :=false;
      end;
    end;
  end
  else
    Begin
    Pc_Name_LookCombox.KeyValue := Gb_CodMha;
    Pc_Name_LookCombox.Enabled := False;
    end;
  Gb_Nivel := Lc_Nivel ;
  }
end;


procedure Pc_DefineEstoqueEmpresa(Pc_Cd_Empresa:Integer);
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT ETS_CODIGO ' +
                 'FROM  TB_ESTOQUES ' +
                 'WHERE (ETS_CODMHA =:ETS_CODMHA) AND (ETS_PRINCIPAL = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ETS_CODMHA').AsInteger := Pc_Cd_Empresa;
      Active := True;
      FetchAll;
      Gb_Estoque := 0;
      if (  RecordCount > 0) then
      Begin
        Gb_Estoque := FieldByname('ETS_CODIGO').AsInteger;
      end
      else
      Begin
        MensagemPararExecucao('Não foi definido um estoque principal.' + EOLN +
                              'Verifique no cadastro de minha Empresa.');
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_DadosComercioEletronico(Pc_Cd_empresa:Integer);
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT EMP_CNPJ, INT_WWW,INT_WEBSERVICE,INT_CODWSR,INT_FTP_PATH,INT_DIR_IMAGES ' +
                   'FROM TB_EMPRESA '+
                   '  INNER JOIN TB_INTERNET ' +
                   '  ON (EMP_CODIGO = INT_CODMHA) '+
                   'WHERE (INT_CODMHA =:INT_CODMHA) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('INT_CODMHA').AsInteger := Pc_Cd_Empresa;
      Active := True;
      Gb_site         := FieldByname('INT_WWW').AsString;
      Gb_webservice   := Lc_Qry.FieldByname('INT_WEBSERVICE').AsString;
      gb_Web_Path_img := Lc_Qry.FieldByname('INT_DIR_IMAGES').AsString;
      Gb_Cd_WsR       := Lc_Qry.FieldByname('INT_CODWSR').AsInteger;
      Gb_CNPJ         := Lc_Qry.FieldByname('EMP_CNPJ').AsString;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Fc_BuscaImagemEmpresa(Img:TPicture; Pc_Descricao:String);
var
  Lc_Qry : TSTQuery;
  St_Image : TStream;
  Lc_jpg : TJPEGImage;
  LcBase : TControllerBase;
begin
  St_Image := nil;
  Lc_jpg := TJPEGImage.Create;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
   try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT IMG_IMAGEM FROM TB_IMG_EMPRESA '+
                   'WHERE (IMG_CODEMP=:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ');
      ParamByName('IMG_CODEMP').AsInteger := Gb_CodMha;
      ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
      Active := True;
      FetchAll;

      St_Image := CreateBlobStream(FieldByName('IMG_IMAGEM'),bmRead);
      if St_Image.Size > 0 then
      begin
        Lc_jpg.LoadFromStream(St_Image);
        Img.Assign(Lc_jpg);
      end
      else
        Img.Graphic := nil;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
    FreeAndNil(St_Image);
    FreeAndNil(Lc_jpg);
  end;
end;

function Fc_BuscaStreamEmpresa(Pc_Descricao:String):TStream;
var
  Lc_Qry : TSTQuery;
  St_Image:TStream;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Result := Nil;
  Try
    with Lc_Qry do
      Begin
      SQL.Add('SELECT IMG_IMAGEM FROM TB_IMG_EMPRESA '+
                   'WHERE (IMG_CODEMP=:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ');
      ParamByName('IMG_CODEMP').AsInteger := Gb_CodMha;
      ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
      Active := True;
      FetchAll;

      St_Image := CreateBlobStream(FieldByName('IMG_IMAGEM'),bmRead);
      if St_Image.Size > 0 then
        begin
        Result := (St_Image);
        end
      else
        Result := nil;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaImagemEstabelecimento(Pc_Descricao:String):TStream;
var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Result := TStream.Create;
  Try
    with Lc_Qry do
      Begin
      SQL.Add('SELECT IMG_IMAGEM FROM TB_IMG_EMPRESA '+
                   'WHERE (IMG_CODEMP=:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ');
      ParamByName('IMG_CODEMP').AsInteger := Gb_CodMha;
      ParamByName('IMG_DESCRICAO').AsString := Pc_Descricao;
      Active := True;
      FetchAll;

      Result := CreateBlobStream(FieldByName('IMG_IMAGEM'),bmRead);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


//-------------------------Controle Transportadoras-------------------------------------------
procedure Pc_AtivaTransportadora(Pc_Cd_Codigo:Integer);
Begin
  with DM.Qr_Transportadora do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').asInteger := Pc_Cd_Codigo;
    Active := True;
    FetchAll;
  end;
end;

//-------------------------Usuarios do Sistema  ---------------------------------------------
procedure Pc_MontaUsuario(Pc_Lista: TComboBox);
Var
  Lc_Qry :TSTQuery;
  LcBase : TControllerBase;
BEgin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Pc_Lista.Items.Clear;
  Pc_Lista.Clear;
  Try
    with Lc_Qry do
    Begin
      SQL.add(concat(
                'SELECT * FROM TB_USUARIO  ',
                'WHERE (USU_ATIVO = ''S'') ',
                'ORDER BY USU_LOGIN        '
      ));
      Active := True;
      First;
      while not Eof do
      begin
        Pc_Lista.Items.Add(FieldByName('USU_LOGIN').AsString);
        Next;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


Function Fc_CriaPrimeiroUsuario():Boolean;
Var
  Lc_Qry :TSTQuery;
  LcBase : TControllerBase;
BEgin
  Result := True;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT USU_CODIGO ',
              'FROM TB_USUARIO '
          ));
      Active := True;
      FetchAll;
      if (recordCount = 0 )then
      begin
//        try
//          Lc_Form := TFr_Usuario.Create(nil);
//          Lc_Form.It_Novo_Usuario := True;
//          Lc_Form.ShowModal;
//        finally
//          Lc_Form.DisposeOf;
//          Active := False;
//          Active := True;
//          FetchAll;
//          Result := (recordCount > 0 );
//        end;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

{Retorna o codigo do vendedor que esta atrelado ao usuario ou
 Retorna o codigo do Vendedor que está logado
 Caso contrario retorna o codigo do primeiro vendedor da lista}

function Fc_Cd_Vendedor_Usuario(Pc_Cd_Usuario:Integer):Integer;
Var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase :TControllerBase;
BEgin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT USU_CODIGO FROM TB_USUARIO tb_usuario               '+
                   '  LEFT OUTER JOIN TB_COLABORADOR tb_colaborador            '+
                   '  ON (tb_colaborador.CLB_CODUSU =  tb_usuario.USU_CODIGO)  '+
                   'WHERE (USU_CODIGO =:USU_CODIGO)                            ';
      SQL.Add(Lc_SqlTxt);
      Active := True;
      FetchAll;
      if RecordCount >0 then
      Begin
        Result := FieldByName('USU_CODIGO').AsInteger;
      end
      else
      Begin
        if GB_Cd_Vendedor > 0 then
        Begin
          Result := GB_Cd_Vendedor;
        end
        else
        Begin
          DM_ListaConsultas.Pc_ListaVendedor;
          Result := DM_ListaConsultas.Qr_ListaVendedor.FieldByname('CLB_CODIGO').AsInteger;
        end;
      end;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

//-------------------------Permissões de Usuarios do Sistema  -------------------------------

Procedure Pc_Apaga_permissoes(Pc_Cd_Usuario:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase :TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(' delete from tb_permissao where per_codusu =:per_codusu');
      ParamByName('per_codusu').AsInteger := Pc_Cd_Usuario;
      ExecSQL;
   end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

//-------------------------Formas de Pagamentos  --------------------------------------------



//-------------------------Atualiza Unidades da Federação -------------------------------------------------

//-------------------------Atualiza Cidades -------------------------------------------------

function Fc_BuscaCodigoCidade(fc_IBGE:Integer; Fc_Descricao,Fc_UF:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      if (fc_IBGE > 0) then
        Begin
        SQL.Add('select CDD_CODIGO FROM TB_CIDADE WHERE CDD_IBGE=:CDD_IBGE');
        ParamByName('CDD_IBGE').AsInteger := fc_IBGE;
        end
      else
        Begin
        SQL.Add('select CDD_CODIGO '+
                'FROM TB_CIDADE '+
                'WHERE CDD_DESCRICAO=:CDD_DESCRICAO AND CDD_UF =:CDD_UF');
        ParamByName('CDD_DESCRICAO').AsString := UpperCase( Fc_Descricao );
        ParamByName('CDD_UF').AsString := UpperCase( Fc_UF );
        end;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('CDD_CODIGO').AsInteger
      else
        Result := 4004;
      end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

//-----------------------------------Enderecos -------------------------------------------------
procedure Pc_DeFineListaEndereco(Pc_Cd_Cliente:Integer);
Begin
  with DM.Qr_Endereco do
    Begin
    Close;
    ParamByName('EMP_CODIGO').AsInteger := Pc_Cd_Cliente;
    Active := True;
    FetchAll;
    First;
    end;
end;


//-----------------------------------Tributação -------------------------------------------------
function Fc_BuscaCodigoCFOP(fc_CFOP:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      SQL.Add('select NAT_CODIGO FROM TB_NATUREZA WHERE NAT_CFOP=:NAT_CFOP');
      ParamByName('NAT_CFOP').AsString := fc_CFOP;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('NAT_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoCSOSN(Fc_CSOSN:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select TBI_CODIGO FROM TB_TRIB_ICMS_SN WHERE TBI_GRUPO=:TBI_GRUPO');
      ParamByName('TBI_GRUPO').AsString := fc_CSOSN;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('TBI_CODIGO').AsInteger
      else
        Result := 1;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoModalFrete(fc_Frete:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select MDF_CODIGO FROM TB_MODAL_FRETE WHERE MDF_GRUPO=:MDF_GRUPO');
      ParamByName('MDF_GRUPO').AsString := fc_Frete;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('MDF_CODIGO').AsInteger
      else
        Result := 1;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function Fc_ProdutosVendidos(Fc_DataIni,Fc_DataFim:TDAte):String;
Var
  Lc_Qry : TSTQuery;
  Lc_Upd : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Lc_Upd := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      //Cria a tabela de atualizãção
      //Atualiza a situação de venda como (N)ão para todos os produtos
      Lc_Upd.SQL.Add('UPDATE TB_PRODUTO SET PRO_VENDA= ''N'' ');
      Lc_Upd.ExecSQL;
      if Lc_Upd.Transaction.InTransaction then Lc_Upd.Transaction.Commit;
      //Prepara a query para atualizar somente os vendidos
      Lc_Upd.Active := False;
      Lc_Upd.SQL.Clear;
      Lc_Upd.SQL.Add('UPDATE TB_PRODUTO SET PRO_VENDA= ''S'' WHERE (PRO_CODIGO=:PRO_CODIGO)');

      //Cria a Tabela de Consulta de venda
      SQL.Clear;
      SQL.Add(Concat(
                'select DISTINCT ITF_CODPRO ',
                'FROM TB_ITENS_NFL I ',
                '    INNER JOIN tb_nota_fiscal N ',
                '    ON (n.nfl_codigo = I.itf_codnfl) ',
                'WHERE N.nfl_status = ''F'' ',
                'AND (N.nfl_dt_emissao BETWEEN :DATAINI AND :DATAFIM) '
      ));
      ParamByName('DATAINI').AsDate:= Fc_DataIni;
      ParamByName('DATAFIM').AsDate:= Fc_DataFim;
      Active := true;
      FetchAll;
      First;
      while not Eof do
      Begin
        if not Lc_Upd.Transaction.InTransaction then Lc_Upd.Transaction.StartTransaction;
        Lc_Upd.Active := False;
        Lc_Upd.ParamByName('PRO_CODIGO').AsInteger := FieldByName('ITF_CODPRO').AsInteger;
        Lc_Upd.ExecSQL;
        if Lc_Upd.Transaction.InTransaction then Lc_Upd.Transaction.Commit;
        Next;
      end;
    end;
    Result := '';
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_UPd);
    LcBase.DisposeOf;
  End;

end;


function Fc_ProcuraProdutoDescricao(Fc_Produto: string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql_txt:= ' select PRO_CODIGO FROM TB_PRODUTO '+
                ' WHERE PRO_DESCRICAO = :PRO_DESCRICAO ';
      SQL.Add(sql_txt);
      ParamByName('PRO_DESCRICAO').AsString:= Fc_Produto;
      Open;
      FetchAll;
      if (RecordCount >= 1) then
        Result := FieldByName('PRO_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_ProcuraProdutoCodigo(Fc_Cd_Produto: integer):String;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      sql_txt:= ' select PRO_DESCRICAO FROM TB_PRODUTO '+
                ' WHERE PRO_CODIGO = :PRO_CODIGO ';
      SQL.Add(sql_txt);
      ParamByName('PRO_CODIGO').AsInteger:= Fc_Cd_Produto;
      Open;
      FetchAll;
      if (RecordCount >= 1) then
        Result := FieldByName('PRO_DESCRICAO').AsString
      else
        Result := '';
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_ProcuraRegistraMedida(Fc_Medida,Fc_Especial: string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      if Trim(Fc_Medida)<> '' then
        Begin
        sql_txt:= ' select MED_CODIGO FROM TB_MEDIDA '+
                  ' WHERE MED_DESCRICAO = :MED_DESCRICAO ';
        SQL.Add(sql_txt);
        ParamByName('MED_DESCRICAO').AsString:= Fc_Medida;
        end
      else
        Begin
        sql_txt:= ' select MED_CODIGO FROM TB_MEDIDA '+
                  ' WHERE MED_ESPECIAL = :MED_ESPECIAL ';
        SQL.Add(sql_txt);
        ParamByName('MED_ESPECIAL').AsString:= Fc_Especial;
        end;
      Open;
      FetchAll;
      First;
      if (RecordCount >= 1) then
      Begin
        Result:= FIELDBYNAME('MED_CODIGO').AsInteger;
      end
      else
      Begin
        SQL.Clear;
        sql_txt:= 'insert into "TB_MEDIDA"( '+
                  '  "MED_CODIGO" '+
                  ', "MED_DESCRICAO" '+
                  ', "MED_ABREVIATURA" '+
                  ', "MED_ESCALA" '+
                  ', "MED_PROPORCAO" '+
                  ', "MED_ESPECIAL") '+
                  'values( '+
                  '  :"MED_CODIGO" '+
                  ', :"MED_DESCRICAO" '+
                  ', :"MED_ABREVIATURA" '+
                  ', :"MED_ESCALA" '+
                  ', :"MED_PROPORCAO" '+
                  ', :"MED_ESPECIAL") ';
        SQL.Add(sql_txt);
        Result := Fc_Generator('GN_MEDIDA','TB_MEDIDA','MED_CODIGO');
        ParamByName('MED_CODIGO').AsInteger := Result;
        ParamByName('MED_DESCRICAO').AsString := Fc_Medida;
        ParamByName('MED_ABREVIATURA').AsString := Copy(Fc_Medida,1,3);
        ParamByName('MED_ESCALA').AsInteger := 0;
        ParamByName('MED_PROPORCAO').AsFloat := 100;
        ParamByName('MED_ESPECIAL').AsString := Fc_Especial;
        ExecSQL;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_ProcuraRegistraMarca(Fc_Marca : string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  try
    with Lc_Qry do
      Begin
      sql_txt:= ' select MRC_CODIGO FROM TB_MARCA_PRODUTO '+
                ' WHERE MRC_DESCRICAO = :MRC_DESCRICAO ';
      SQL.Add(sql_txt);
      ParamByName('MRC_DESCRICAO').AsString:= Fc_Marca;
      Open;
      FetchAll;
      First;
      if (RecordCount >= 1) then
        Begin
        Result:= FIELDBYNAME('MRC_CODIGO').AsInteger;
        end
      else
        Begin
        SQL.Clear;
        sql_txt:= 'insert into "TB_MARCA_PRODUTO"( '+
                  '  "MRC_CODIGO" '+
                  ', "MRC_DESCRICAO" '+
                  ', "MRC_CODFAB") '+
                  'values( '+
                  '  :"MRC_CODIGO" '+
                  ', :"MRC_DESCRICAO" '+
                  ', :"MRC_CODFAB") ';
        SQL.Add(sql_txt);
        Result := Fc_Generator('GN_MARCAPRODUTO','TB_MARCA_PRODUTO','MRC_CODIGO');
        ParamByName('MRC_CODIGO').AsInteger := Result;
        ParamByName('MRC_DESCRICAO').AsString := Fc_Marca;
        ParamByName('MRC_CODFAB').AsInteger := 0;
        ExecSQL;
        end;
      end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

end;

function Fc_ProcuraRegistraEmbalagem(Fc_Embalagem, Fc_Abreviatura : string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      sql_txt:= ' select EMB_CODIGO FROM TB_EMBALAGEM '+
                ' WHERE EMB_DESCRICAO = :EMB_DESCRICAO ';
      SQL.Add(sql_txt);
      ParamByName('EMB_DESCRICAO').AsString:= Fc_Embalagem;
      Open;
      FetchAll;
      First;
      if (Lc_Qry.RecordCount >= 1) then
        Begin
        Result:= Lc_Qry.FIELDBYNAME('EMB_CODIGO').AsInteger;
        end
      else
      Begin
        SQL.Clear;
        sql_txt:= 'insert into "TB_EMBALAGEM"( '+
                  '  "EMB_CODIGO" '+
                  ', "EMB_DESCRICAO" '+
                  ', "EMB_ABREVIATURA") '+
                  'values( '+
                  '  :"EMB_CODIGO" '+
                  ', :"EMB_DESCRICAO" '+
                  ', :"EMB_ABREVIATURA") ';

        SQL.Add(sql_txt);
        Result := Fc_Generator('GN_EMBALAGEM','TB_EMBALAGEM','EMB_CODIGO');
        ParamByName('EMB_CODIGO').AsInteger := Result;
        ParamByName('EMB_DESCRICAO').AsString := Fc_Embalagem;
        ParamByName('EMB_ABREVIATURA').AsString := Fc_Abreviatura;
        ExecSQL;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_ProcuraRegistraGrupo(Fc_Grupo : string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      sql_txt:= ' select GRP_CODIGO FROM TB_GRUPOS '+
                ' WHERE GRP_DESCRICAO = :GRP_DESCRICAO ';
      SQL.Add(sql_txt);
      ParamByName('GRP_DESCRICAO').AsString:= Fc_Grupo;
      Open;
      FetchAll;
      First;
      if (Lc_Qry.RecordCount >= 1) then
      Begin
        Result:= Lc_Qry.FIELDBYNAME('GRP_CODIGO').AsInteger;
      end
      else
      Begin
        SQL.Clear;
        sql_txt:= 'insert into "TB_GRUPOS"( '+
                  '  "GRP_CODIGO" '+
                  ', "GRP_DESCRICAO") '+
                  'values( '+
                  '  :"GRP_CODIGO" '+
                  ', :"GRP_DESCRICAO") ';

        SQL.Add(sql_txt);
        Result := Fc_Generator('GN_GRUPO','TB_GRUPOS','GRP_CODIGO');
        ParamByName('GRP_CODIGO').AsInteger := Result;
        ParamByName('GRP_DESCRICAO').AsString := Fc_Grupo;
        ExecSQL;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_ProcuraRegistraSubGrupo(fC_SubGrupo,Fc_Grupo : string):Integer;
var
  Lc_Qry:TSTQuery;
  sql_txt:String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
   Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql_txt:= ' select SBG_CODIGO FROM TB_SUBGRUPOS '+
                ' INNER JOIN TB_GRUPOS '+
                ' ON (GRP_CODIGO = SBG_CODGRP) '+
                ' WHERE GRP_DESCRICAO = :GRP_DESCRICAO '+
                ' AND SBG_DESCRICAO=:SBG_DESCRICAO' ;
      SQL.Add(sql_txt);
      ParamByName('SBG_DESCRICAO').AsString:= fC_SubGrupo;
      ParamByName('GRP_DESCRICAO').AsString:= Fc_Grupo;
      Open;
      FetchAll;
      First;
      if (Lc_Qry.RecordCount >= 1) then
      Begin
        Result:= Lc_Qry.FIELDBYNAME('SBG_CODIGO').AsInteger;
      end
      else
      Begin
        SQL.Clear;
        sql_txt:= 'insert into "TB_SUBGRUPOS"( '+
                  '  "SBG_CODIGO" '+
                  ', "SBG_CODGRP" '+
                  ', "SBG_DESCRICAO") '+
                  'values( '+
                  '  :"SBG_CODIGO" '+
                  ', :"SBG_CODGRP" '+
                  ', :"SBG_DESCRICAO")';

        SQL.Add(sql_txt);
        Result := Fc_Generator('GN_SUBGRUPO','TB_SUBGRUPOS','SBG_CODIGO');
        ParamByName('SBG_CODIGO').AsInteger := Result;
        ParamByName('SBG_CODGRP').AsInteger := Fc_ProcuraRegistraGrupo(Fc_Grupo);
        ParamByName('SBG_DESCRICAO').AsString := fC_SubGrupo;
        ExecSQL;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_CriaTabelasPreco(Pc_Cd_Produto: Integer;Pc_VL_Custo,Pc_Vl_CustoMedio:Real);
var
  Lc_SqlTxt: string;
  Lc_Qry_Tabelas :TSTQuery;
  Lc_Qry_Insere :TSTQuery;
  LcBase : TControllerBase;
begin
  //Cria a Consulta de Tabelas Disponiveis
  LcBase := TControllerBase.create(nil);
  Lc_Qry_Tabelas := LcBase.GeraQuery;
  Lc_Qry_Insere := LcBase.GeraQuery;
  Try
    with Lc_Qry_Tabelas do
    BEgin
      Lc_SqlTxt := 'SELECT TPR_CODIGO, TPR_MAR_LRC, TPR_CASA_DECIMAL '+
                   'FROM tb_tabela_preco '+
                   'WHERE ( TPR_ATIVA = ''S'') AND TPR_CODIGO NOT IN( '+
                   'SELECT DISTINCT TPR_CODIGO '+
                   'FROM tb_tabela_preco '+
                   '  inner JOIN tb_preco '+
                   '  ON (tb_preco.prc_codtpr = tb_tabela_preco.TPR_CODIGO) '+
                  '    INNER JOIN tb_produto '+
                   '  ON (tb_produto.pro_codigo = tb_preco.prc_codpro) '+
                  'WHERE PRO_CODIGO =:PRO_CODIGO) AND ( TPR_ATIVA = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      Active := True;
      FetchAll;
      First;
      IF (RecordCount > 0) then
      Begin
        //Inclui o Sql que vai inserir a tabela para cada produto

        Lc_SqlTxt := 'insert into "TB_PRECO" ('+
                     '    "PRC_CODIGO" '+
                     '  , "PRC_CODTPR" '+
                     '  , "PRC_CODPRO" '+
                     '  , "PRC_VL_VDA" '+
                     '  , "PRC_MAR_LRC" '+
                     '  , "PRC_AQ_COM")'+
                     '  values( '+
                     '    :"PRC_CODIGO" '+
                     '  , :"PRC_CODTPR" '+
                     '  , :"PRC_CODPRO" '+
                     '  , :"PRC_VL_VDA" '+
                     '  , :"PRC_MAR_LRC" '+
                     '  , :"PRC_AQ_COM" )';
        Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
        while not Eof do
        begin
          Lc_Qry_Insere.Active := False;
          Lc_Qry_Insere.ParamByName('PRC_CODIGO').AsInteger := Fc_Generator('GN_PRECO','','PRC_CODIGO');
          Lc_Qry_Insere.ParamByName('PRC_CODTPR').AsInteger := FieldByName('TPR_CODIGO').AsInteger;
          Lc_Qry_Insere.ParamByName('PRC_CODPRO').AsInteger := Pc_Cd_Produto;
          if (FieldByName('TPR_MAR_LRC').AsFloat > 0) then
          Begin
            if (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','R') = 'R') then
              Lc_Qry_Insere.ParamByName('PRC_VL_VDA').AsFloat := Fc_CalcularPrecoPelaMargemLucro(
                                                                          Pc_Vl_CustoMedio,
                                                                          FieldByName('TPR_MAR_LRC').AsFloat,
                                                                          FieldByName('TPR_CASA_DECIMAL').AsInteger)
            else
              Lc_Qry_Insere.ParamByName('PRC_VL_VDA').AsFloat := Fc_CalcularPrecoPelaMargemLucro(
                                                                          Pc_VL_Custo,
                                                                          FieldByName('TPR_MAR_LRC').AsFloat,
                                                                          FieldByName('TPR_CASA_DECIMAL').AsInteger);
          end;
          Lc_Qry_Insere.ParamByName('PRC_MAR_LRC').AsFloat := FieldByName('TPR_MAR_LRC').AsFloat;
          Lc_Qry_Insere.ParamByName('PRC_AQ_COM').AsFloat := 0;
          Lc_Qry_Insere.ExecSQL;
          Next;
        end;
      end;
    end;
  Finally
    LcBase.FinalizaQuery( Lc_Qry_Tabelas );
    LcBase.FinalizaQuery( Lc_Qry_Insere );
    LcBase.DisposeOf;
  End;
end;

//------------------------- Cadastro e pesquisa de Tabelas de Preço------------------------------

function Fc_CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,Fc_Aq_Margem:real;CasaDecimal:Integer):Real;
Var
  LcFrac : Real;
  LcInt : Integer;
begin
  Result := 0;
  If (Fc_Vl_Custo > 0) then
  Begin
    if (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '1') then
    Begin
      //Preço de Custo / [( 100 - Taxa de Lucro ) / 100 ]
      Result := Fc_Vl_Custo / (( 100 - Fc_Aq_Margem) /100);
    end
    else
    Begin
      //Preço de Custo + (Preço de Custo * Taxa de Lucro)
      Result := Fc_Vl_Custo + (Fc_Vl_Custo * (Fc_Aq_Margem/100));
    end;
    //casa decimal zero, arredonda para cima para evitar prejuizos
    if CasaDecimal = 0  then
    Begin
      //casa decimal zero, arredonda para cima para evitar prejuizos
      LcInt := trunc(Result);
      LcFrac := Frac(Result);
      if LcFrac > 0 then
        Result := LcInt + 1;
    End
    else
    Begin
      Result := RoundABNT(Result,CasaDecimal);
    End;
  end;
end;

function Fc_CalcularMargemPeloPreco(Fc_Vl_Custo,Fc_Vl_Venda:real;CasaDecimal:Integer):Real;
begin
  if (Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','') = '1') then
  Begin
    //Preço de Custo / [( 100 - Taxa de Lucro ) / 100 ]
    if Fc_Vl_Venda > 0 then
      Result := ( 1 - ( Fc_Vl_Custo / Fc_Vl_Venda ) ) * 100
    else
      Result := ( 1 - ( Fc_Vl_Custo / 1 ) ) * 100;
    Result := RoundABNT(Result,2);
  end
  else
  Begin
    //Preço de Custo + (Preço de Custo * Taxa de Lucro)
    if (Fc_Vl_custo > 0) then
      Result := ( ( Fc_Vl_Venda - Fc_Vl_Custo ) / Fc_Vl_Custo ) * 100
    else
      Result := ( ( Fc_Vl_Venda - Fc_Vl_Custo ) / 1 ) * 100;
    Result := RoundABNT(Result,2);
  end;

end;

//------------------------- Cadastro e pesquisa de Empresas--------------------------------------









//-------------------------Controle de Pedidos -------------------------------------------------




function Fc_ValidaDesconto(Fc_Vl_Total:REal; Fc_Vl_Desconto:Real;Fc_Prazo:String): Boolean;
var
  Lc_Aliq_Perm: real;
  Lc_Aliq_Desc: real;
  Lc_Aliq_Desc_Vista:Real;
begin
  Result := true;
  if (Fc_Vl_Total > 0) and (Fc_Vl_Desconto > 0) then
  Begin
    Lc_Aliq_Desc_Vista := StrToFloatDef(Fc_Tb_Geral('L','VDA_G_DESC_PAGTO_VISTA',''),0);
    Lc_Aliq_Perm := StrToFloatDef(Fc_Tb_Geral('L', 'VDA_G_DESC_MAX_GERAL', ''),0);
    Lc_Aliq_Desc := (Fc_Vl_Desconto / Fc_Vl_Total) * 100;
    Lc_Aliq_Desc := RoundTo( Lc_Aliq_Desc,-2);
    IF (Lc_Aliq_Desc < 0) then Lc_Aliq_Desc := 0;
    //Valida a utilização do Desconto
    if (Lc_Aliq_Perm >= Lc_Aliq_Desc) or //Verifica o desconto normal
      ((Lc_Aliq_Desc <= Lc_Aliq_Desc_Vista) and (Fc_Prazo = '000')) or
        Gb_Liberado then
    begin
      if (Gb_Nivel = 0)  then Gb_Liberado := False;
    end
    else
    begin
      if not (Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','AUTORIZAR', GB_Cd_Usuario,'N')) then
      Begin

        MensagemPararExecucao('Percentual máximo de Desconto ' + FloatToStr(Lc_Aliq_Perm) + '%.' + EOLN +
                              'Caso Necessário Peça Autorização.');
        Result := False;
      end;
    end;
  end;
end;

function Fc_VL_Desconto(fc_Tipo: Char;Fc_Vl_Total:REal; Fc_Aq_Desconto:Real;Fc_Vl_Desconto:Real): Real;
var
   Lc_Aliq_Perm: real;
begin
  Lc_Aliq_Perm := StrToFloatDef(Fc_Tb_Geral('L', 'VDA_G_DESC_MAX_GERAL', ''),0);
  if (fc_Tipo = 'V') then
    Begin
    if (Fc_Vl_Total > 0) then
    Begin
      Fc_Aq_Desconto := (Fc_Vl_Desconto / Fc_Vl_Total) * 100;
      Fc_Aq_Desconto := RoundTo( Fc_Aq_Desconto,-2);
    End
    else
      Fc_Aq_Desconto := 0;
    end;
  Result := Fc_Aq_Desconto;
end;


//-------------------------Controle de Despacho -------------------------------------------------


//-------------------------Controle de Separação de mercadoria -------------------------------------------------
procedure Pc_SeparacaoMercadoria(Pc_cd_Pedido:Integer;
                                 Pc_cd_Item:Integer;
                                 Pc_Cd_Produto:Integer;
                                 Pc_Dt_Prevista : TDATE;
                                 Pc_Qtde : Real);
Var
  Lc_Qry : TSTQuery;

  Lc_Cd_Dsp_Aguardando : Integer;
  Lc_Qtde_Aguardando : Real;

  Lc_Cd_Dsp_Pendente : Integer;
  Lc_Qtde_Pendente : Real;

  Lc_Cd_Dsp_Separada : Integer;
  Lc_Qtde_Separada : Real;

  Lc_Qtde_saldo : real;
  Lc_Dt_Devolucao : TDate;
  LcBase : TControllerBase;
Begin
  Lc_Dt_Devolucao := Date;
  Lc_Cd_Dsp_Aguardando := 0;
  Lc_Qtde_Aguardando := 0;
  Lc_Cd_Dsp_Pendente := 0;
  Lc_Qtde_Pendente := 0;
  Lc_Cd_Dsp_Separada := 0;
  Lc_Qtde_Separada := 0;
  Lc_Qtde_saldo := 0;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DSP_CODIGO,DSP_CODPRO, DSP_QTDE, DSP_SITUACAO, DSP_DT_REALIZADA '+
              'FROM TB_DESPACHO '+
              'WHERE (DSP_CODITF =:ITF_CODIGO) '+
              '  AND (DSP_SITUACAO=:DSP_SITUACAO) ');

      //Quarda a quantidade Aguardando e o codigo
      Active := False;
      ParamByName('ITF_CODIGO').AsInteger   := Pc_Cd_Item;
      ParamByName('DSP_SITUACAO').AsString  := 'A';
      Active := True;
      Lc_Cd_Dsp_Aguardando  := FieldbyName('DSP_CODIGO').AsInteger;
      Lc_Qtde_Aguardando    := FieldbyName('DSP_QTDE').AsFloat;

      //Quarda a quantidade Se houver produto Pendente de Liberação
      Active := False;
      ParamByName('ITF_CODIGO').AsInteger   := Pc_Cd_Item;
      ParamByName('DSP_SITUACAO').AsString  := 'P';
      Active := True;
      Lc_Cd_Dsp_Pendente  := FieldbyName('DSP_CODIGO').AsInteger;
      Lc_Qtde_Pendente    := FieldbyName('DSP_QTDE').AsFloat;

      //Quarda a quantidade Se houver produto Separado/Entregue
      Active := False;
      ParamByName('ITF_CODIGO').AsInteger   := Pc_Cd_Item;
      ParamByName('DSP_SITUACAO').AsString  := 'S';
      Active := True;
      Lc_Cd_Dsp_Separada  := FieldbyName('DSP_CODIGO').AsInteger;
      Lc_Qtde_Separada    := FieldbyName('DSP_QTDE').AsFloat;
      //Verificar se a quantidade informada é diferente da anterior
      if ((Lc_Qtde_Aguardando + Lc_Qtde_Pendente + Lc_Qtde_Separada) = Pc_Qtde) then
      Begin
        //Se as quantidades forem iguais saimos da função sem fazer nada
        Exit;
      end;


      if ( (Lc_Qtde_Aguardando + Lc_Qtde_Pendente + Lc_Qtde_Separada) = 0) and (Pc_Qtde > 0) then
      Begin
        Pc_InsereDespacho(Pc_cd_Pedido,
                          Pc_Cd_Item,
                          Pc_cd_Produto,
                          Pc_Dt_Prevista,
                          Pc_Qtde,
                          'A');
      end
      else
      Begin
        //Se a quantidade aguardando for maior que zero então alteramos o despacho
        if (Lc_Qtde_Aguardando > 0) then
        Begin
          Lc_Qtde_saldo := Pc_Qtde - (Lc_Qtde_Separada + Lc_Qtde_Pendente);
          //Verifica se Altera a Quantidade do Produto que esta aguardando liberação
          if ( Lc_Qtde_saldo > 0 ) then
            Pc_AlteraQtdeDespacho(Lc_Cd_Dsp_Aguardando,Lc_Qtde_saldo)
          else
            Pc_ExcluirSeparacaoMercadoria(Lc_Cd_Dsp_Aguardando,Pc_cd_Item);
          if (Lc_Qtde_saldo > 0) then  Pc_Qtde := Pc_Qtde - Lc_Qtde_saldo;
        end;

        //Se a quantidade Pendente for maior que zero então alteramos o despacho Pendente
        if (Lc_Qtde_Pendente > 0) then
        Begin
          Lc_Qtde_saldo := Pc_Qtde - (Lc_Qtde_Separada);
          //Verifica se Altera a Quantidade do Produto que esta aguardando liberação
          if ( Lc_Qtde_saldo > 0 ) then
            Pc_AlteraQtdeDespacho(Lc_Cd_Dsp_Pendente,Lc_Qtde_saldo)
          else
            Pc_ExcluirSeparacaoMercadoria(Lc_Cd_Dsp_Pendente,Pc_cd_Item);
          if (Lc_Qtde_saldo > 0) then  Pc_Qtde := Pc_Qtde - Lc_Qtde_saldo;
        end;

        //Se a quantidade Separada for maior que zero então alteramos o despacho entregue e criamos uma devolução
        Lc_Qtde_saldo := Pc_Qtde - Lc_Qtde_Separada;
        //Verifica se Altera a Quantidade do Produto que esta aguardando liberação
        if ( Lc_Qtde_saldo <= 0 ) then
        Begin
          if (Pc_Qtde >0) then
            Pc_AlteraQtdeDespacho(Lc_Cd_Dsp_Separada,Pc_Qtde)
          else
            Pc_ExcluirSeparacaoMercadoria(Lc_Cd_Dsp_Separada,Pc_cd_Item);

            //Pede a devolução da saldo
            Pc_InsereDespacho(Pc_cd_Pedido,
                              Pc_Cd_Item,
                              Pc_cd_Produto,
                              Lc_Dt_Devolucao,
                              (Lc_Qtde_saldo * -1),
                              'D');
        end
        else
        Begin
          if ( Lc_Qtde_saldo > 0 ) then
          Begin
            Pc_InsereDespacho(Pc_cd_Pedido,
                              Pc_Cd_Item,
                              Pc_cd_Produto,
                              Pc_Dt_Prevista,
                              Lc_Qtde_saldo,
                              'A');
          end;
        end;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_DevolveSeparacaoMercadoria(Pc_cd_Despacho:Integer;
                                        Pc_cd_Item:Integer);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_SITUACAO = ''D'' ' ;
      if Pc_cd_Despacho > 0 then
        Lc_Sql := Lc_Sql + 'WHERE (DSP_CODIGO =:DSP_CODIGO) '
      else
        Lc_Sql := Lc_Sql + 'WHERE (DSP_CODITF =:DSP_CODITF) ';
      SQL.Add(Lc_Sql);
      if Pc_cd_Despacho > 0 then
        ParamByName('DSP_CODIGO').AsInteger := Pc_cd_Despacho
      else
        ParamByName('DSP_CODITF').AsInteger := Pc_Cd_Item;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_ExcluirSeparacaoMercadoria(Pc_cd_Despacho:Integer;
                                        Pc_cd_Item:Integer);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'DELETE FROM TB_DESPACHO  ';
      if Pc_cd_Despacho > 0 then
        Lc_Sql := Lc_Sql + 'WHERE (DSP_CODIGO =:DSP_CODIGO) '
      else
        Lc_Sql := Lc_Sql + 'WHERE (DSP_CODITF =:DSP_CODITF) ';
      SQL.Add(Lc_Sql);
      if Pc_cd_Despacho > 0 then
        ParamByName('DSP_CODIGO').AsInteger := Pc_cd_Despacho
      else
        ParamByName('DSP_CODITF').AsInteger := Pc_Cd_Item;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_LiberarSeparacaoMercadoria(Pc_cd_Pedido:Integer);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_SITUACAO = ''P'', '+
                '  DSP_CONFERIDO = 0 '+
                'WHERE (DSP_CODPED =:DSP_CODPED) '+
                '  AND (DSP_SITUACAO = ''A'') ';

      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODPED').AsInteger := Pc_cd_Pedido;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_VerificaExistenciaSeparacaoMercadoria(Fc_cd_Pedido:Integer;Fc_Estagio:String):Boolean;
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'SELECT DSP_SITUACAO '+
                'FROM TB_DESPACHO '+
                'WHERE (DSP_CODPED =:DSP_CODPED) ';

      if Trim(Fc_Estagio)<> '' then
        Lc_Sql := Lc_Sql + '  AND (DSP_SITUACAO =:DSP_SITUACAO) ';
      SQL.Add(Lc_Sql);
      if Trim(Fc_Estagio)<> '' then
        ParamByName('DSP_SITUACAO').AsString := Fc_Estagio;
      ParamByName('DSP_CODPED').AsInteger := Fc_cd_Pedido;
      Active := True;
      FetchAll;
      Result := (RecordCount >0);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

//-------------------------Controle de Cheques -------------------------------------------------
function Fc_PesquisaNumeroCheque(Fc_cd_Cheque:Integer):String;
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'SELECT CHQ_NUMERO '+
                'FROM TB_CHEQUES '+
                'WHERE CHQ_CODIGO=:CHQ_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('CHQ_CODIGO').AsInteger := Fc_cd_Cheque;
      Active := True;
      FetchAll;
      if recordCount > 0 then
        Result := FieldByname('CHQ_NUMERO').AsString
      else
        Result := 'Nº CHEQUE NÃO ENCONTRADO';
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

//-------------------------Módulo de Compras -------------------------------------------------
Function Fc_Dt_Ultima_Compra(Fc_Cd_Empresa:Integer):String;
var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(Nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT MAX(NFL_DT_EMISSAO) NFL_DT_ULTIMA ',
              'FROM tb_nota_fiscal ',
              '  INNER JOIN TB_PEDIDO ',
              '  ON (PED_CODIGO = NFL_CODPED)',
              'WHERE (NFL_CODEMP = :EMP_CODIGO) ',
              ' AND ( (PED_TIPO = 1 ) OR (PED_TIPO = 4 ) ) '
      ));
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Empresa;
      Active := True;
      FetchAll;
      if (recordcount>0) then
      Begin
        if ( FieldByName('NFL_DT_ULTIMA').AsString <> '30/12/1899' ) and
           ( FieldByName('NFL_DT_ULTIMA').AsString <> '' ) then
          Result := FieldByName('NFL_DT_ULTIMA').AsString
        else
          Result := '';
      end
      else
      Begin
        Result := '';
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

//-------------------------Módulo de Vendas -------------------------------------------------
Function Fc_Dt_Ultima_Venda(Fc_Cd_Empresa:Integer):String;
Begin


end;


Function Fc_Vl_S_T_Venda(Fc_NotaFiscal:Boolean;
                          Fc_Periodo:Boolean;
                          Fc_Dt_Inicio:TDate;
                          Fc_Dt_Fim:TDate;
                          Fc_Cd_Cliente:Integer;
                          Fc_Nm_Cliente:String;
                          Fc_Cd_Transportadora:Integer;
                          Fc_Cd_VendedorCliente:Integer;
                          Fc_Cd_VendedorPedido:Integer;
                          Fc_End_Regiao:String;
                          Fc_cd_Estabelecimento:Integer):Real;
Var
  Lc_Qry:TSTQuery;
  Lc_SqlTxt : String;
  Lc_Aux : String;
  LcBase : TControllerBase;
Begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT Sum(NFL_VL_ICMS_SUBST) as VL_VENDA '+
                    'FROM TB_NOTA_FISCAL tb_nota_fiscal '+
                    '    INNER JOIN TB_PEDIDO tb_pedido '+
                    '    ON (tb_pedido.PED_CODIGO = tb_nota_fiscal.NFL_CODPED) '+
                    '    INNER JOIN TB_EMPRESA tb_cliente '+
                    '    ON (tb_cliente.EMP_CODIGO = tb_nota_fiscal.NFL_CODEMP) ';

      if (Trim(Fc_End_Regiao) <> '') then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +
                    '  INNER JOIN TB_ENDERECO tb_endereco '+
                    '  ON (tb_endereco.END_CODIGO = tb_pedido.PED_CODIGO) ';
        end;


      Lc_SqlTxt := Lc_SqlTxt + ' WHERE (NFL_CODIGO IS NOT NULL) AND (NFL_TIPO = ''SI'') AND (PED_TIPO = 1)  AND (NFL_STATUS = ''F'')   ';
      //Montado o Sql por Crierio Preenchido

  //    if (Fc_PedidoFechado or Fc_NotaFiscal)
      if Fc_NotaFiscal then
          Lc_SqlTxt := Lc_SqlTxt + 'AND (NFL_NUMERO <>'''') ';

      //Negocio que não devem aparecer no relatorio - Ver tela de Negocio
      Lc_Aux := Trim(Fc_codigosNegocio);
      If Length(Lc_Aux) > 0 then
        Lc_SqlTxt := Lc_SqlTxt + 'AND ((PED_CODNEG NOT IN (' + Lc_Aux + ')) or (PED_CODNEG IS NULL))';

      if Fc_Periodo then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM  ';
        end;

      if (fc_cd_Cliente >0) then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODEMP =:NFL_CODEMP) ';
        end;

      if (Trim(Fc_Nm_Cliente) <> '') then
        Begin
        Lc_SqlTxt := Lc_SqlTxt + 'AND ( (tb_cliente.EMP_NOME LIKE :CLI_NOME) OR (tb_cliente.EMP_FANTASIA LIKE :CLI_NOME) )';
        end;

      if (Fc_Cd_Transportadora >0) then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND (NFL_CODTRP =:NFL_CODTRP) ';
        end;

      if (Fc_Cd_VendedorCliente >0) then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:EMP_CODVDOR) ';
        end;

      if (Fc_Cd_VendedorPedido >0) then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND (PED_CODVDO =:PED_CODVDO) ';
        end;

      if (Trim(Fc_End_Regiao) <> '') then
        Begin
        Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
        end;


      if (Fc_cd_Estabelecimento>0) then
        Begin
        Lc_SqlTxt := Lc_SqlTxt + ' AND (NFL_CODMHA =:NFL_CODMHA) ';
        end;


      SQL.Add(Lc_SqlTxt);
      //Passando os parametros para a Consulta

      if Fc_Periodo then
        Begin
        ParamByName('DATAINI').AsDate := Fc_Dt_Inicio;
        ParamByName('DATAFIM').AsDate := Fc_Dt_Fim;
        end;

      if (fc_cd_Cliente >0) then
        Begin
        ParamByName('NFL_CODEMP').AsInteger := Fc_Cd_Cliente;
        end;

      if (Trim(Fc_NM_Cliente) <> '') then
        Begin
        ParamByName('CLI_NOME').AsString := '%' + Fc_Nm_Cliente + '%';
        end;

      if (Fc_Cd_Transportadora >0) then
        Begin
        ParamByName('NFL_CODTRP').AsInteger := Fc_Cd_Transportadora;
        end;

      if (Fc_Cd_VendedorCliente >0) then
        Begin
        ParamByName('EMP_CODVDOR').AsInteger := Fc_Cd_VendedorCliente;
        end;

      if (Fc_Cd_VendedorPedido >0) then
        Begin
        ParamByName('PED_CODVDO').AsInteger := Fc_Cd_VendedorPedido;
        end;

      if (Trim(Fc_End_Regiao) <> '') then
        Begin
        ParamByName('END_REGIAO').AsString:= '%' + Fc_End_Regiao + '%';
        end;

      if (Fc_cd_Estabelecimento>0) then
        Begin
        ParamByName('NFL_CODMHA').AsInteger := Fc_cd_Estabelecimento;
        end;

      Active := true;
      FetchAll;
      Result := FieldByName('VL_VENDA').AsFloat;
      Screen.Cursor:=crDefault;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;



Function Fc_Vl_Frete_Cotacao(Fc_Numero:String;
                             Fc_Periodo:Boolean;
                             Fc_Dt_Inicio:TDate;
                             Fc_Dt_Fim:TDate;
                             Fc_Cd_Cliente:Integer;
                             Fc_Nm_Cliente:String;
                             Fc_Cd_VendedorCliente:Integer;
                             Fc_Cd_VendedorPedido:Integer;
                             Fc_End_Regiao:String;
                             Fc_cd_Estabelecimento:Integer):Real;
Var
  Lc_Qry:TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
Begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt :=
      'SELECT  sum(CTC_VL_FRETE) CTC_VL_TL_FRETE '+
      ' FROM TB_COTACAO tb_cotacao '+
      '  LEFT OUTER JOIN TB_EMPRESA tb_cliente '+
      '  ON (tb_cliente.EMP_CODIGO = tb_cotacao.CTC_CODEMP) '+
      'WHERE (CTC_CODIGO IS NOT NULL) ';

      if (Trim(Fc_Numero) <> '') then
        Begin
        Lc_SqlTxt := Lc_SqlTxt + ' AND (CTC_NUMERO LIKE :CTC_NUMERO) ';
        end
      else
        Begin
        if Fc_Periodo then
          Begin
          Lc_SqlTxt := Lc_SqlTxt +'AND CTC_DATA BETWEEN :DATAINI AND :DATAFIM  ';
          end;

        if (fc_cd_Cliente >0) then
          Begin
          Lc_SqlTxt := Lc_SqlTxt +'AND (CTC_CODEMP =:CTC_CODEMP) ';
          end;

        if (Trim(Fc_Nm_Cliente) <> '') then
          Begin
          Lc_SqlTxt := Lc_SqlTxt + 'AND ( (tb_cliente.EMP_NOME LIKE :CLI_NOME) OR (tb_cliente.EMP_FANTASIA LIKE :CLI_NOME) )';
          end;

        if (Fc_Cd_VendedorCliente >0) then
          Begin
          Lc_SqlTxt := Lc_SqlTxt +'AND (EMP_CODVDOR =:EMP_CODVDOR) ';
          end;

        if (Fc_Cd_VendedorPedido >0) then
          Begin
          Lc_SqlTxt := Lc_SqlTxt +'AND (CTC_CODVDO =:CTC_CODVDO) ';
          end;

        if (Trim(Fc_End_Regiao) <> '') then
          Begin
          Lc_SqlTxt := Lc_SqlTxt +'AND (END_REGIAO LIKE :END_REGIAO)';
          end;
        end;

      if (Fc_cd_Estabelecimento>0) then
      Begin
        Lc_SqlTxt := Lc_SqlTxt + ' AND (CTC_CODMHA =:CTC_CODMHA) ';
      end;


      SQL.Add(Lc_SqlTxt);
      //Passando os parametros para a Consulta

      if (Trim(Fc_Numero) <> '') then
        Begin
        ParamByName('CTC_NUMERO').AsString := '%' + Fc_Numero + '%';
        end
      else
        Begin
        if Fc_Periodo then
          Begin
          ParamByName('DATAINI').AsDate := Fc_Dt_Inicio;
          ParamByName('DATAFIM').AsDate := Fc_Dt_Fim;
          end;

        if (fc_cd_Cliente >0) then
          Begin
          ParamByName('NFL_CODEMP').AsInteger := Fc_Cd_Cliente;
          end;

        if (Trim(Fc_NM_Cliente) <> '') then
          Begin
          ParamByName('CTC_FANTASIA').AsString := '%' + Fc_Nm_Cliente + '%';
          end;

        if (Fc_Cd_VendedorCliente >0) then
          Begin
          ParamByName('EMP_CODVDOR').AsInteger := Fc_Cd_VendedorCliente;
          end;

        if (Fc_Cd_VendedorPedido >0) then
          Begin
          ParamByName('PED_CODVDO').AsInteger := Fc_Cd_VendedorPedido;
          end;

        if (Trim(Fc_End_Regiao) <> '') then
          Begin
          ParamByName('END_REGIAO').AsString:= '%' + Fc_End_Regiao + '%';
          end;
        end;

      if (Fc_cd_Estabelecimento>0) then
        Begin
        ParamByName('CTC_CODMHA').AsInteger := Fc_cd_Estabelecimento;
        end;

      Active := true;
      FetchAll;
      Result := FieldByName('CTC_VL_TL_FRETE').AsFloat;
      Screen.Cursor:=crDefault;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


//------------------------- Sistema de Cobrança por Boleto ----------------------------------
procedure Pc_MostraListaCarteira(Pc_Cd_Banco:Integer);
Begin
  with DM.Qr_Carteira_Cobranca do
  Begin
    Active := False;
    ParamByName('CTR_CODBCO').AsInteger := Pc_Cd_Banco;
    Active := True;
  end;
end;


//------------------------- Operação com componentes------ ----------------------------------
procedure Pc_LimpaStringGrid(Pc_Grid : TStringGrid);
Var
  Lc_I,Lc_J : Integer;
Begin
  For Lc_I := 1 to Pc_Grid.RowCount - 1 do
    For Lc_J := 0 to Pc_Grid.ColCount do
      Pc_Grid.Cells[Lc_J,Lc_I] := '';
  Pc_Grid.RowCount := 2;
end;

procedure Del_Linha_StringGrid(Pc_strGrid: TStringGrid; LinhaADeletar:Integer;LinhaFixa:Integer);
var
  Lc_I, Lc_J: Integer;
  Lc_Linha : Integer;
  Lc_Lista: array of array of string;
begin
  SetLength(Lc_Lista, Pc_strGrid.RowCount, Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados
  Lc_Linha := 0;
  for Lc_I := 0 to Pc_strGrid.RowCount - 1 do
  begin
    if (Lc_I <> LinhaADeletar) then
    begin
      for Lc_J := 0 to Pc_strGrid.ColCount - 1 do
        Lc_Lista[Lc_Linha, Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      Lc_Linha := Lc_Linha + 1;
    end;
  end;

  //Lipma a Frid
  Pc_LimpaStringGrid(Pc_strGrid);
  if  ( LinhaFixa > 0 ) then
    Pc_strGrid.RowCount := LinhaFixa;
  //Grava novamente os dados que não foram marcados e que estão na matriz
  For Lc_I := 0 to ( Lc_Linha -  1 ) do
  begin
    if  ( LinhaFixa = 0 ) then  Pc_strGrid.RowCount := Lc_I + 1;
    for Lc_J := 0 to Pc_strGrid.ColCount - 1 do
    Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
  end;
end;

//--------------------------Validação de Fatuamento Pedido Ajuste/Compra/Venda/Web

function Fc_ChaveDanfe_XMl(Fc_cd_Nota:Integer):String;
Var
  Lc_SqlTxt : String;
  Lc_Tamanho: Integer;
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    BEgin
      Lc_SqlTxt := 'SELECT NFE_CODSIT, NFE_ARQUIVO FROM TB_RETORNO_NFE WHERE (NFE_CODNFL=:NFE_CODNFL)';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFE_CODNFL').AsInteger := Fc_Cd_Nota;
      Active := True;
      FetchAll;
      Lc_Tamanho := length(FieldByName('NFE_ARQUIVO').AsString)-51;
      Result := copy(FieldByName('NFE_ARQUIVO').AsString,Lc_Tamanho,length(FieldByName('NFE_ARQUIVO').AsString));

    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;




Function Fc_ConteudoXML(pc_cod_nota:integer):string;
var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    BEgin
      SQL.Add('select NFE_ARQUIVO                    ');
      SQL.Add('from  TB_RETORNO_NFE   TB_RETORNO_NFE   ');
      SQL.Add(' WHERE NFE_CODNFL =:NFE_CODNFL       ');
      ParamByName('NFE_CODNFL').AsInteger := pc_cod_nota;
      Active := True;
      FetchAll;
      Result:= Lc_Qry.fieldbyname('NFE_ARQUIVO').AsString;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_CancelaVendaComercioEletronico(Pc_Cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Nr_Pedido : Integer;
  LcBase : TControllerBase;
Begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      Lc_SqlTxt := 'SELECT PED_NUMERO FROM TB_PEDIDO '+
                   'WHERE PED_CODIGO=:PED_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
      Active := true;
      FetchAll;
      Lc_Nr_Pedido := FieldByName('PED_NUMERO').AsInteger;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'UPDATE TB_PAG_ELETRONICO '+
                   'SET PGE_CD_STATUS =3 '+
                   'WHERE PGE_CODPED =:PED_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := Lc_Nr_Pedido;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery( Lc_Qry );
    LcBase.DisposeOf;
  End;
end;


procedure Pc_Retornodevolucao(Pc_Dataset:TSTQuery);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
      Begin
      SQL.Add('DELETE FROM TB_ITENS_DEV WHERE ITD_CODITF_DEST =:ITF_CODIGO');
      Pc_Dataset.Active := True;
      Pc_Dataset.First;
      while not Pc_Dataset.Eof do
      begin
        if not Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.StartTransaction;
        Active := False;
        ParamByName('ITF_CODIGO').AsInteger := Pc_Dataset.FieldByname('ITF_CODIGO').AsInteger;
        ExecSQL;
        if Lc_Qry.Transaction.InTransaction then Lc_Qry.Transaction.Commit;
        Pc_Dataset.Next;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_AtualizarItensNota(Pc_Sentido,Pc_Status:String;Pc_Cd_Nota,Pc_cd_Pedido:Integer;Pc_Dataset:TSTQuery);
var
  Lc_cd_Nota : Integer;
begin
  if (Pc_Sentido ='SI') then
    Pc_sentido:='E'
  else
  if (Pc_Sentido ='EI') OR (Pc_Sentido ='EE') then
    Pc_sentido:='S';

  //Verifica se a nota foi autorizada
  if Pc_Status = 'AUTORIZADA' THEN
    Lc_cd_Nota := Pc_Cd_Nota
  else
    Lc_cd_Nota := 0;

  //Atualiza os itens Primarios da nota
  with Pc_Dataset do
    Begin
    First;
    while not Eof do
      begin
      Fc_AtualizaItensNfl( DM.IB_Transacao,
                           'E',
                           FieldByName('ITF_CODIGO').AsInteger,
                           Pc_Cd_Pedido,
                           Lc_cd_Nota,
                           FieldByName('ITF_CODPRO').AsInteger,
                           FieldByName('ITF_QTDE').AsFloat,
                           FieldByName('ITF_VL_CUSTO').AsFloat,
                           FieldByName('ITF_VL_UNIT').AsFloat,
                           FieldByName('ITF_AQ_DESC').AsFloat,
                           FieldByName('ITF_VL_DESC').AsFloat,
                           FieldByName('ITF_AQ_COM').AsFloat,
                           FieldByName('ITF_OPER').AsString,
                           FieldByName('ITF_ESTOQUE').AsString,
                           'N',
                           FieldByName('ITF_AQ_IPI').AsFloat,
                           FieldByName('ITF_AQ_ICMS').AsFloat,
                           FieldByName('ITF_CODEST').AsInteger,
                           FieldByName('ITF_CODTPR').AsInteger,
                           Pc_sentido,
                           FieldByName('ITF_IMP_APROX').AsFloat,0,0);
      Next;
      end;
    end;
end;

procedure Pc_ApagaICMS_FCP(Pc_Cd_Nota:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add('DELETE FROM TB_ICMS_FCP WHERE TB_NOTA_FISCAL_ID=:TB_NOTA_FISCAL_ID ');
      ParamByName('TB_NOTA_FISCAL_ID').AsInteger := Pc_Cd_Nota;
      ExecSQL;

    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
End;

Procedure Pc_AtualizacaoEstoqueNota(Pc_StatusNF:String;Pc_Tp_Pedido:Integer;Pc_cd_Pedido:Integer);
Begin
  //Verifica se a nota foi autorizada - 1
  if ((Pc_StatusNF = 'AUTORIZADA') OR ((Pc_Tp_Pedido <> 1) AND (Pc_Tp_Pedido <> 4))) THEN
  Begin
    Pc_Delete_Estoque('P',Pc_cd_Pedido,0);
  end;
end;

procedure Pc_AtualizarItensDevolucao(Pc_Sentido:String;Pc_DataSet:TSTQuery);
begin
  if (Pc_Sentido ='SI') then
    Pc_Sentido:='S'
  else
  if (Pc_Sentido ='EI') OR (Pc_Sentido ='EE') then
    Pc_Sentido:='E';
  with Pc_DataSet do
    Begin
    //Atualiza os itens Primarios da nota
    Active := True;
    First;
    while not Eof do
      begin
      Fc_AtualizaItensNfl( DM.IB_Transacao,
                           'E',
                           FieldByName('ITF_CODIGO').AsInteger,
                           FieldByName('ITF_CODPED').AsInteger,
                           0,
                           FieldByName('ITF_CODPRO').AsInteger,
                           FieldByName('ITF_QTDE').AsFloat,
                           FieldByName('ITF_VL_CUSTO').AsFloat,
                           FieldByName('ITF_VL_UNIT').AsFloat,
                           FieldByName('ITF_AQ_DESC').AsFloat,
                           FieldByName('ITF_VL_DESC').AsFloat,
                           FieldByName('ITF_AQ_COM').AsFloat,
                           'D',
                           FieldByName('ITF_ESTOQUE').AsString,
                           'N',
                           FieldByName('ITF_AQ_IPI').AsFloat,
                           FieldByName('ITF_AQ_ICMS').AsFloat,
                           FieldByName('ITF_CODEST').AsInteger,
                           FieldByName('ITF_CODTPR').AsInteger,
                           Pc_sentido,
                           0,0,0);
      Next;
      end;
    end;
end;

procedure Pc_apagaItensNfl_complementar(pc_cd_nfl:Integer);
var
  lc_qry:TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  lc_qry:= LcBase.GeraQuery;
  Try
    with lc_qry do
    Begin
      SQL.Add(' delete from tb_itens_icms where ICM_CODNFL =:ICM_CODNFL');
      ParamByName('ICM_CODNFL').AsInteger:= pc_cd_nfl;
      ExecSQL;

      Active:=false;
      SQL.Clear;
      SQL.Add(' delete from tb_itens_nfl where itf_codNFL =:itf_codNFL');
      ParamByName('itf_codNFL').AsInteger:= pc_cd_nfl;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


//--------------------------Funções para negocios especificos-----------------------------------
function Fc_codigosNegocio():String;
var
  lc_qry:TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  lc_qry:= LcBase.GeraQuery;
  Try
    with lc_qry do
    Begin
      SQL.Add('Select NEG_CODIGO FROM TB_NEGOCIO WHERE (NEG_EXCLUSIVO = ''S'')');
      Active := True;
      First;
      while not eof do
      Begin
        if bof then
          Result := fieldByName('NEG_CODIGO').AsString
        else
          Result := Result + ',' + fieldByName('NEG_CODIGO').AsString;
        next;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


//--------------------------Controle da tela de Pizzaria-----------------------------------------
function  Fc_LocalizaComponente(Fc_Parent : TComponent; Pc_Alvo:TClass):TComponent;
Var
  Lc_I : Integer;
Begin
  Result := Nil;
  for Lc_I := 0 to Fc_Parent.ComponentCount - 1 do
  begin
    if (Fc_Parent.Components[Lc_I].ClassType = Pc_Alvo) then
    begin
      Result := Fc_Parent.Components[Lc_I];
      Break;
    end
    else
    begin
      continue;
    end;
  end;
end;

function  Fc_LocalizaComponentePorNome(Fc_Parent : TComponent; Pc_Alvo:TClass;Pc_Nome:String;Pc_tamanho:Integer):TComponent;
Var
  Lc_I : Integer;
Begin
  Result := Nil;
  for Lc_I := 0 to Fc_Parent.ComponentCount - 1 do
  begin
    if (Fc_Parent.Components[Lc_I].ClassType = Pc_Alvo) then
    begin
      if (copy(Fc_Parent.Components[Lc_I].Name,1,Pc_tamanho) = Pc_Nome) then
      Begin
        Result := Fc_Parent.Components[Lc_I];
        Break;
      end;
    end
    else
    begin
      continue;
    end;
  end;
end;

function Fc_VerificaItemGridSelecionado(Pc_Grid : TStringGrid;pc_Coluna:Integer):Boolean;
Var
  Lc_I : Integer;
Begin
  Result := False;
  For Lc_I := 1 to Pc_Grid.RowCount - 1 do
    Begin
    if Pc_Grid.Cells[pc_Coluna,Lc_I] = 'X' then
      Begin
      Result := true;
      break;
      end;
    end;
  if not Result then
    Begin
    MensagemPararExecucao('Nenhum registro foi selecionado.');
    end;
end;



procedure Pc_AbreGavetaViaImpressaoEpson(Aporta:String);
Var
  Lc_Finaliza: TextFile;
Begin
  //Aciona a Guilhotina
  AssignFile(Lc_Finaliza,APorta);
  Rewrite(Lc_Finaliza);
  Writeln(Lc_Finaliza, #027+ #112 + #000 + #010 + #100'');
  CloseFile(Lc_Finaliza);
end;

procedure Pc_AbreGavetaViaImpressaoBematech(Aporta:String);
Var
  s_cmdtx : String;
  lComando : String;
  lRetorno : Integer;
  lPorta: String;
Begin
  lRetorno := 0;
  try
    try
      lPorta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', 'USB');
      FechaPorta();
      lRetorno := IniciaPorta( lPorta);
    except
      on E : Exception do
         ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    end;
    if ( lRetorno = 1 ) then
    Begin
      //Abrir Gaveta
      lComando := concat(#27 ,#118 , #140);
      ComandoTX( lComando, Length( lComando ));
    End;
  finally
    FechaPorta();
  end;
  s_cmdtx:=#27+#118#140;
  ComandoTX(s_cmdtx,length (s_cmdtx));
end;

procedure Pc_AbreGavetaViaImpressaoDiebold(Aporta:String);
var
  Handle: THandle;
  CaracteresImpressos: DWORD;
  Documento: TDocInfo1;
  TextoString : String;
  TextoUnicode: string;
begin
  if not OpenPrinter(PChar('IM4X3T/TSP143'), Handle, nil) then
  begin
    ShowMessage('Impressora DIEBOLD não encontrada');
    Exit;
  end;
  Documento.pDocName := PChar(concat('comandoAbrirGaveta'));
  Documento.pOutputFile := nil;
  Documento.pDataType := 'RAW';

  StartDocPrinter(Handle, 1, @Documento);

  StartPagePrinter(Handle);

  TextoUnicode := #27#69 + '';
  TextoString := String(TextoUnicode);
  WritePrinter(Handle, PAnsiChar(TextoString), Length(TextoString), CaracteresImpressos);

  //Apenas notifica o Windows que a página finalizou.
  //Nenhum controle é aplicado a impressora.
  EndPagePrinter(Handle);

  //Finaliza o documento no Spool
  EndDocPrinter(Handle);

  //Fecha a impressora
  ClosePrinter(Handle);

end;

procedure Pc_AbreGavetaBematech(ModeloBematech:Integer);
Var
  lComando : String;
  lRetorno : Integer;
  lPorta: String;
begin
  lRetorno := ConfiguraModeloImpressora( ModeloBematech );
  try
    try
      lPorta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', 'USB');
      FechaPorta();
      lRetorno := IniciaPorta( lPorta);

    except
      on E : Exception do
         ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
    end;
    if ( lRetorno = 1 ) then
    Begin
      //Abrir Gaveta
      lComando := concat(#27 ,#118 , #140);
      ComandoTX( lComando, Length( lComando ));
    End;
  finally
    FechaPorta();
  end;
end;

Function Fc_ValidaAberturaGaveta(Usa:Boolean):Boolean;
//var
//  Lc_Form : TFr_Liberacao;
Begin
  Result := true;
  if not Usa then
    Begin
    MensagemPararExecucao('A Abertura da gaveta não foi ativada nas configurações.');
    Result := False;
    exit;
    end;

  if Fc_HabilitaPermissao('Fr_FrenteCaixa','ABRIR GAVETA','S') then
  Begin
    Result := True;
    exit;
  End;

  if (not Gb_Liberado) or (Gb_Nivel = 0) then
  Begin
    MensagemPararExecucao('A Abertura da gaveta é permitida apenas para usuário Administrador.' + EOLN +
                          '        Solicite autorização.');
    try
      ShowMessage('Verificar');
//      Lc_Form := TFr_Liberacao.Create(nil);
//      Lc_Form.Liberado := False;
//      Lc_Form.It_Interface := 'Fr_FrenteCaixa';
//      Lc_Form.It_Nome_Menu := 'Frente de Caixa';
//      Lc_Form.It_Privilegio := 'AUTORIZAR';
//      Lc_Form.ShowModal;
      if (Gb_Liberado) then
      Begin
        Gb_Liberado := False;
        Result := True;
        exit;
      end
      else
      Begin
        Gb_Liberado := False;
        Result := False;
        exit;
      end;
    finally
      //FreeAndNil(Lc_Form);
    end;

  end;
end;

procedure Pc_ConfiguraGavetaACBR;
Var
  Lc_Gvta : Integer;
Begin
  ShowMessage('Verificar');
  {
  with Fr_Principal.Acb_Gaveta do
  Begin
    Desativar;
    Lc_Gvta := (StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_MODELO', ''),0)-1);
    case Lc_Gvta of
      0:Modelo := gavImpressoraComum;
      1:Modelo := gavImpressoraECF;
      3:Modelo := gavSerialGerbo;
      4:Modelo := gavSerialMenno;
    end;
    Porta := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', '');
    StrComando := Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '');
    Lc_Gvta :=StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_ACA_ANTEC', ''),0)-1;
    case Lc_Gvta of
      0:AberturaAntecipada := aaAguardar;
      1:AberturaAntecipada := aaException;
      2:AberturaAntecipada := aaIgnorar;
    end;
  End;
  }
End;

procedure Pc_AbreGaveta;
//Var
//  Lc_Gvta : Integer;
//  LcModelo : Integer;
begin
    ShowMessage('Verificar');
  {
  if (Fc_Aq_Geral('L', 'NFCE', 'NFCE_ESCPOS_ATIVA_INI', 'N') = 'S') then
  Begin
    Fr_Principal.ACBrPosPrinter.Device.Ativar;
    Fr_Principal.ACBrPosPrinter.AbrirGaveta;
  End
  else
  Begin
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = 'Impressora Epson (via Impressão)') then
    Begin
        Pc_AbreGavetaViaImpressaoEpson(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', ''));
    end
    else
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = '#027,v,#140 | Bematech') then
    Begin
        Pc_AbreGavetaViaImpressaoBematech(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', ''));
    end
    else
    if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = 'Impressora Diebold  (via Impressão)') then
    Begin
        Pc_AbreGavetaViaImpressaoDiebold(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_PORTA', ''));
    end
    else
    Begin
      if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = 'Impressora Bematech (via DLL)') then
      Begin
          LcModelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL', '1'),0);
          case LcModelo of
            2: Pc_AbreGavetaBematech(7);
            3: Pc_AbreGavetaBematech(5);
            4: Pc_AbreGavetaBematech(5);
            6: Pc_AbreGavetaBematech(8);
          else
            Pc_AbreGavetaBematech(7);
          end;
      end
      else
      Begin
        Fr_Principal.Acb_Gaveta.Ativar;
        Fr_Principal.Acb_Gaveta.AbreGaveta;
        Fr_Principal.Acb_Gaveta.Desativar;
      end;
    End;
  end;
  }
end;

procedure Pc_AcionaGuilhotina(Aporta:String);
Var
  LcModelo :Integer;
Begin
  if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = 'Impressora Epson (via Impressão)') then
    Pc_AcionaGuilhotinaEpson(Aporta)
  else
  if (Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_GVT_STR_ABERT', '') = 'Impressora Diebold  (via Impressão)') then
    Pc_AcionaGuilhotinaDiebold(Aporta)
  else
  Begin
    LcModelo := StrToIntDef(Fc_Aq_Geral('L','CONTROLE DE FRENTE','FRT_P_MOD_MATRICIAL', '1'),0);
    case LcModelo of
      2: Pc_AcionaGuilhotinaBematech(7);
      3: Pc_AcionaGuilhotinaBematech(5);
      4: Pc_AcionaGuilhotinaBematech(5);
      6: Pc_AcionaGuilhotinaBematech(8);
    else
      Pc_AcionaGuilhotinaBematech(7);
    end;
  End;
End;

procedure Pc_AcionaGuilhotinaEpson(Aporta:String);
Var
  Lc_Finaliza: TextFile;
Begin
  //Aciona a Guilhotina
  AssignFile(Lc_Finaliza,APorta);
  Rewrite(Lc_Finaliza);
  Writeln(Lc_Finaliza, #27+ #105);
  CloseFile(Lc_Finaliza);

End;

procedure Pc_AcionaGuilhotinaDiebold(Aporta:String);
Var
  Lc_Finaliza: TextFile;
Begin
  //Aciona a Guilhotina
  AssignFile(Lc_Finaliza,APorta);
  Rewrite(Lc_Finaliza);
  Writeln(Lc_Finaliza, #27+ 'w');
  CloseFile(Lc_Finaliza);
End;

procedure Pc_AcionaGuilhotinaBematech(ModeloBematech:Integer);
Var
  lRetorno : Integer;
  ArquivoIni: TIniFile;
  Lc_NameArq: string;
  Lc_Porta: string;
begin
  Lc_NameArq := GbPathExe + 'mp2032.ini';
  ArquivoIni := TIniFile.Create(Lc_NameArq);
  try
    Lc_Porta := '1';
    Lc_Porta := ArquivoIni.ReadString('Sistema', 'ControlePorta', Lc_Porta);
    lRetorno := IniciaPorta(Lc_Porta );
    if (lRetorno = 1 )then
    Begin
      lRetorno := ConfiguraModeloImpressora( ModeloBematech );
      // 0 Parcial - 1 Total
      AcionaGuilhotina( 1 );
    End;
  finally
    FreeAndNil(ArquivoIni);
    FechaPorta;
  end;
End;


end.















