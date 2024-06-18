unit RN_Pedido;

interface

uses
  STDatabase, STQuery, SysUtils, main, RN_Permissao,ControllerItensNfl,
  Classes, System.Math,ControllerCtrlEstoque, System.StrUtils,ControllerBase,STTransaction,
  Vcl.Dialogs;


  procedure Pc_AtualizaTotalPedido(Pc_CODIGO:Integer;
                                    Pc_QT_PRODUTO,
                                    Pc_VL_PRODUTO,
                                    Pc_VL_SERVICO,
                                    Pc_VL_IPI,
                                    Pc_VL_FRETE,
                                    Pc_ALIQ_DESCONTO,
                                    Pc_VL_DESCONTO,
                                    Pc_VL_PEDIDO,
                                    Pc_VL_ODESPESA:Real);
  Function Fc_RetornaCodigoPedido(Fc_Tipo,Fc_Nr_Pedido:String):Integer;

  function Fc_CopiarPedido(Fc_Cd_Pedido,
                           Fc_Nr_Pedido: Integer;
                           Fc_Cd_Estoque:Integer;
                           fc_Tipo:Integer;
                           Fc_AlteraVAlor:String;
                           Fc_Tx_Altera:Real):Integer;
  function Fc_EnviaPedido(FcDataBase : TSTDatabase;
                          FcTransaction : TSTTransaction;
                          Fc_Cd_Pedido: Integer;
                          Fc_Tipo:Integer;
                          Fc_AlteraVAlor:String;
                          Fc_Tx_Altera:Real):Boolean;

  procedure Pc_CopiaItensPedido(Pc_Cd_Pedido: Integer;
                                Pc_Cd_PedNovo: Integer;
                                Fc_Cd_Estoque:Integer;
                                Pc_AtualizaEstoque,
                                Pc_TipoItem:String;
                                Fc_AlteraVAlor:String;
                                Fc_Tx_Altera:Real);

  function Fc_CopiaPedidoNota(Pc_TipoPedido:Integer):integer;
  function Fc_EnviaPedidoNota(Pc_TipoPedido:Integer):integer;
  Function FC_Valida_produto(Fc_Itens:TSTQuery):boolean;


  procedure Pc_ErroCorrigirValores(Pc_Codigo:Integer);
  function Fc_VerificaEstabelecimentoDestino(FcDataBase : TSTDatabase;
                                             FcTransaction : TSTTransaction):Integer;
  function Fc_VerificaProdutoDestino(FcDataBase : TSTDatabase;
                                     FcTransaction : TSTTransaction;
                                     Fc_Cd_Produto:String;
                                     Fc_Descricao:String):Boolean;
  procedure Pc_AtualizaObsPedido(codigo:Integer;Obs:TStringList);
implementation

uses Un_DM, UN_Sistema, UN_MSG, Un_Regra_Negocio, Un_Stored_Procedures, RN_Estoque,
  RN_NotaFiscalEletronica3X,  RN_Crud,RN_Empresa, ControllerPedido, ControllerEmpresa,
  ControllerEndereco;


procedure Pc_AtualizaTotalPedido(Pc_CODIGO:Integer;
                                  Pc_QT_PRODUTO,
                                  Pc_VL_PRODUTO,
                                  Pc_VL_SERVICO,
                                  Pc_VL_IPI,
                                  Pc_VL_FRETE,
                                  Pc_ALIQ_DESCONTO,
                                  Pc_VL_DESCONTO,
                                  Pc_VL_PEDIDO,
                                  Pc_VL_ODESPESA:Real);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_PEDIDO SET '+
              '  PED_QT_PRODUTO =:PED_QT_PRODUTO, '+
              '  PED_VL_PRODUTO =:PED_VL_PRODUTO, '+
              '  PED_VL_SERVICO =:PED_VL_SERVICO, '+
              '  PED_VL_IPI =:PED_VL_IPI, '+
              '  PED_VL_FRETE =:PED_VL_FRETE, '+
              '  PED_ALIQ_DESCONTO =:PED_ALIQ_DESCONTO, '+
              '  PED_VL_DESCONTO=:PED_VL_DESCONTO, '+
              '  PED_VL_PEDIDO=:PED_VL_PEDIDO, '+
              '  PED_VL_ODESPESA =:PED_VL_ODESPESA '+
              'WHERE (PED_CODIGO =:PED_CODIGO)');
      //Passagem de parametro
      ParamByName('PED_CODIGO').AsInteger := Pc_CODIGO;
      ParamByName('PED_QT_PRODUTO').AsFloat := Pc_QT_PRODUTO;
      ParamByName('PED_VL_PRODUTO').AsFloat := Pc_VL_PRODUTO;
      ParamByName('PED_VL_SERVICO').AsFloat := Pc_VL_SERVICO;
      ParamByName('PED_VL_IPI').AsFloat := Pc_VL_IPI;
      ParamByName('PED_VL_FRETE').AsFloat := Pc_VL_FRETE;
      ParamByName('PED_ALIQ_DESCONTO').AsFloat := Pc_ALIQ_DESCONTO;
      ParamByName('PED_VL_DESCONTO').AsFloat := Pc_VL_DESCONTO;
      ParamByName('PED_VL_PEDIDO').AsFloat := Pc_VL_PEDIDO;
      ParamByName('PED_VL_ODESPESA').AsFloat := Pc_VL_ODESPESA;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

Function Fc_RetornaCodigoPedido(Fc_Tipo,Fc_Nr_Pedido:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT PED_CODIGO FROM TB_PEDIDO WHERE (PED_TIPO=:PED_TIPO) AND (PED_NUMERO=:PED_NUMERO) ');
      //Passagem de parametro
      ParamByName('PED_TIPO').AsAnsiString := Fc_Tipo;
      ParamByName('PED_NUMERO').AsAnsiString := Fc_Nr_Pedido;
      Active := True;
      FetchAll;
      Result := StrToIntDef(FieldByName('PED_CODIGO').AsAnsiString,0);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_CopiarPedido(Fc_Cd_Pedido,Fc_Nr_Pedido: Integer;Fc_Cd_Estoque:Integer;Fc_Tipo:Integer;Fc_AlteraVAlor:String;Fc_Tx_Altera:Real):Integer;
var
  Lc_TipoItem : String;
  PedidoCopia : TControllerPedido;
begin
  TRy
    PedidoCopia := TControllerPedido.Create(nil);
    PedidoCopia.Registro.Codigo := Fc_Cd_Pedido;
    PedidoCopia.Registro.CodigoEstabelecimento := Gb_Codmha;
    PedidoCopia.getbyId;
    if PedidoCopia.exist then
    Begin
      PedidoCopia.Registro.Codigo := 0;
      PedidoCopia.Registro.CodigoWeb := 0;
      with PedidoCopia.Registro do
      Begin
        if (fc_Tipo = 0) then
        Begin
          case Tipo of
            1: Lc_TipoItem := 'V';
            2: Lc_TipoItem := 'C';
            3: Lc_TipoItem := 'A';
            4: Lc_TipoItem := 'V';
          end;
        end
        else
        Begin
          case fc_Tipo of
            1: Lc_TipoItem := 'V';
            2: Lc_TipoItem := 'C';
            3: Lc_TipoItem := 'A';
            4: Lc_TipoItem := 'V';
          end;
        end;

        if (Fc_Nr_Pedido > 0)  then
          Numero := Fc_Nr_Pedido
        else
          numero := 0;

        if (Fc_Tipo > 0) then Tipo := Fc_Tipo;
        Data := DATE;
        if (Fc_AlteraVAlor = 'A') then
        Begin
          ValorProdutos     := RoundTo( ValorProdutos + ( ( ValorProdutos * Fc_Tx_Altera)/100),-2);
          ValorIPI          := RoundTo( ValorIPI + ( ( ValorIPI * Fc_Tx_Altera)/100),-2);
          ValorFrete        := RoundTo( ValorFrete + ( ( ValorFrete * Fc_Tx_Altera)/100),-2);
          AliqDesconto      := RoundTo( AliqDesconto + ( ( AliqDesconto * Fc_Tx_Altera)/100),-2);
          ValorDesconto     := RoundTo( ValorDesconto + ( (ValorDesconto * Fc_Tx_Altera)/100),-2);
          ValorPedido       := RoundTo( ValorPedido + ( (ValorPedido * Fc_Tx_Altera)/100),-2);
        end
        else
        Begin
          if (Fc_AlteraVAlor = 'D') then
          Begin
            ValorProdutos := RoundTo( ValorProdutos - ( ( ValorProdutos * Fc_Tx_Altera)/100),-2);
            ValorIPI      := RoundTo( ValorIPI - ( ( ValorIPI * Fc_Tx_Altera)/100),-2);
            ValorFrete    := RoundTo( ValorFrete - ( ( ValorFrete * Fc_Tx_Altera)/100),-2);
            AliqDesconto  := RoundTo( AliqDesconto - ( ( AliqDesconto * Fc_Tx_Altera)/100),-2);
            ValorDesconto := RoundTo( ValorDesconto - ( ( ValorDesconto * Fc_Tx_Altera)/100),-2);
            ValorPedido   := RoundTo( ValorPedido - ( ( ValorPedido * Fc_Tx_Altera)/100),-2);
          end;
        end;
        Faturado := 'N';
        EmUso := '';
      End;
      PedidoCopia.salva;
      if (fc_Tipo = 1) OR (fc_Tipo = 4) then
        Pc_CopiaItensPedido(Fc_Cd_Pedido,
                            PedidoCopia.Registro.Codigo,
                            Fc_Cd_Estoque,
                            'S',
                            Lc_TipoItem,
                            Fc_AlteraVAlor,
                            Fc_Tx_Altera)
      else
        Pc_CopiaItensPedido(Fc_Cd_Pedido,
                            PedidoCopia.Registro.Codigo,
                            Fc_Cd_Estoque,
                            'N',
                            Lc_TipoItem,
                            Fc_AlteraVAlor,
                            Fc_Tx_Altera);
      Result := PedidoCopia.Registro.Codigo;
    End;
  Finally
    FreeAndNil(PedidoCopia);
  End;
end;

procedure Pc_CopiaItensPedido(Pc_Cd_Pedido: Integer;
                              Pc_Cd_PedNovo: Integer;
                              Fc_Cd_Estoque:Integer;
                              Pc_AtualizaEstoque,
                              Pc_TipoItem:String;
                              Fc_AlteraVAlor:String;
                              Fc_Tx_Altera:Real);
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Cd_Item : Integer;
  Lc_Vl_Unitario : Real;
  Lc_AQ_DESC : Real;
  Lc_VL_DESC : Real;
  Lc_Vl_IPI : real;
  Lc_Casa_Decimais : Integer;
  Lc_Cd_Tabela : Integer;
  lcItem : TControllerItensNfl;
  LcCtrlEstoque : TControllerCtrlEstoque;
begin
  TRy
    LcCtrlEstoque := TControllerCtrlEstoque.create(nil);
    Lc_Qry := LcCtrlEstoque.GeraQuery;
    lcItem := TControllerItensNfl.create(nil);
    With Lc_Qry,lcItem.registro do
    Begin
      Lc_SqlTxt := 'SELECT tb_itens_nfl.*, IPI_VL_BC, IPI_AQ_NR '+
                   'FROM TB_ITENS_NFL '+
                   '  LEFT OUTER JOIN TB_ITENS_IPI '+
                   '  ON (IPI_CODITF = ITF_CODIGO) '+
                   'WHERE ITF_CODPED=:PED_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      while not Eof do
      begin
        if (FieldByName('IPI_VL_BC').AsFloat > 0) then
        Begin
          Lc_Vl_IPI := FieldByName('IPI_VL_BC').AsFloat * (FieldByName('IPI_AQ_NR').AsFloat /100);
          Lc_Vl_IPI := Lc_Vl_IPI / FieldByName('ITF_QTDE').AsFloat;
        end
        else
        Begin
          Lc_Vl_IPI := 0;
        end;
        //Colocamos como padrão 2 casas decimais
        Lc_Casa_Decimais := 2;
        if (Fc_AlteraVAlor = 'A') then
        Begin
          Lc_AQ_DESC := FieldByName('ITF_AQ_DESC').AsFloat + ( (FieldByName('ITF_AQ_DESC').AsFloat * Fc_Tx_Altera)/100);
          Lc_VL_DESC := FieldByName('ITF_VL_DESC').AsFloat + ( (FieldByName('ITF_VL_DESC').AsFloat * Fc_Tx_Altera)/100);
          Lc_Vl_Unitario := FieldByName('ITF_VL_UNIT').AsFloat + ( (FieldByName('ITF_VL_UNIT').AsFloat * Fc_Tx_Altera)/100);
          Lc_Vl_ipi := Lc_Vl_ipi + ( (Lc_Vl_ipi * Fc_Tx_Altera)/100);
        end
        else
        Begin
          if (Fc_AlteraVAlor = 'D') then
          Begin
            Lc_AQ_DESC := FieldByName('ITF_AQ_DESC').AsFloat - ( (FieldByName('ITF_AQ_DESC').AsFloat * Fc_Tx_Altera)/100);
            Lc_VL_DESC := FieldByName('ITF_VL_DESC').AsFloat - ( (FieldByName('ITF_VL_DESC').AsFloat * Fc_Tx_Altera)/100);
            Lc_Vl_Unitario := FieldByName('ITF_VL_UNIT').AsFloat - ( (FieldByName('ITF_VL_UNIT').AsFloat * Fc_Tx_Altera)/100);
            Lc_Vl_ipi := Lc_Vl_ipi - ( (Lc_Vl_ipi * Fc_Tx_Altera)/100);
          end
          else
          Begin
            Lc_AQ_DESC := FieldByName('ITF_AQ_DESC').AsFloat;
            Lc_VL_DESC := FieldByName('ITF_VL_DESC').AsFloat;
            Lc_Vl_Unitario := FieldByName('ITF_VL_UNIT').AsFloat;
            //Em caso de cópia utilizamos o numero de casas configurado no sistema
            Lc_Casa_Decimais := StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0) + 2;
          end;
        end;

        Lc_Vl_Unitario := Lc_Vl_Unitario + Lc_Vl_IPI;
        if FieldByName('ITF_CODTPR').AsInteger > 0 then
          Lc_Cd_Tabela := FieldByName('ITF_CODTPR').AsInteger
        else
          Lc_Cd_Tabela := 1;

        Codigo            := 0;
        Sequencia         := fIeldByName('ITF_SEQUENCIA').AsInteger;
        CodigoPedido      := Pc_Cd_PedNovo;
        CodigoNota        := 0;
        CodigoProduto     := FieldByName('ITF_CODPRO').AsInteger;
        Quantidade        := FieldByName('ITF_QTDE').AsFloat;
        ValorCusto        := FieldByName('ITF_VL_CUSTO').AsFloat;
        ValorUnitario     := RoundTo(Lc_Vl_Unitario,(Lc_Casa_Decimais * -1));
        Despachar         := FieldByName('ITF_DESPACHO').AsString;
        Estoque           := fIeldByName('ITF_ESTOQUE').AsString;
        AliqComissao      := RoundTo(Lc_AQ_DESC,(Lc_Casa_Decimais * -1));
        ValorDesconto     := RoundTo(Lc_VL_DESC,(Lc_Casa_Decimais * -1));
        AliqDesconto      := FieldByName('ITF_AQ_DESC').AsFloat;
        AliqIPI           := FieldByName('ITF_AQ_IPI').AsFloat;
        Operacao          := Pc_TipoItem;
        AliqICMS          := fIeldByName('ITF_AQ_ICMS').AsFloat;
        CodigoEstoque     := Fc_Cd_Estoque;
        CodigoTabela      := Lc_Cd_Tabela;
        Altura            := fIeldByName('ITF_ALTURA').AsFloat;
        Largura           := fIeldByName('ITF_LARGURA').AsFloat;
        Sentido           := fIeldByName('ITF_SENTIDO').AsString;
        PedidoCompra      := fIeldByName('ITF_COMPRA').AsString;
        ItemCompra        := fIeldByName('ITF_ITEM_COMPRA').AsString;
        ImpostoAproximado := fIeldByName('ITF_IMP_APROX').AsFloat;
        NumeroPecas       := fIeldByName('ITF_NR_PECAS').AsFloat;
        lcItem.insere;

        //Atualiza Estoque
        if (Pc_AtualizaEstoque = 'S') and (FieldByName('ITF_CODEST').AsInteger > 0) then
        Begin
          with LcCtrlEstoque.Registro do
          Begin
            Codigo      := 0;
            Terminal    := Gb_Terminal;
            Vinculo     := 'P';
            Ordem       := Pc_Cd_PedNovo;
            Item        := lcItem.Registro.codigo;
            Estoque     := FieldByName('ITF_CODEST').AsInteger;
            operacao    := 'S';
            Produto     := FieldByName('ITF_CODPRO').AsInteger;
            Quantidade  := FieldByName('ITF_QTDE').AsFloat;
            Data        := DAte;

            case AnsiIndexStr(UpperCase( FieldByName('ITF_OPER').AsString), ['V','C','A','D','T']) of
              0:Tipo := 'Venda';
              1:Tipo := 'Compra';
              2:Tipo := 'Ajuste';
              3:Tipo := 'Venda - Devolução';
              4:Tipo := 'Venda - Troca';
            end;
            UpdateAt    := Now;
          End;
          LcCtrlEstoque.Registra;
        end;
        Next;
      end;
    end;
  Finally
    LcCtrlEstoque.FinalizaQuery(Lc_Qry);
    lcItem.DisposeOf;
    LcCtrlEstoque.DisposeOf;
  End;
end;

function Fc_CopiaPedidoNota(Pc_TipoPedido:Integer):integer;
//Var
//  Lc_Form : TFr_CopiaPedidoNota;
begin
  ShowMessage('Verificar');
//  TRy
//    Result := 0;
//    Lc_Form := TFr_CopiaPedidoNota.Create(nil);
//    Lc_Form.It_Tipo_Pedido := Pc_TipoPedido;
//    Lc_Form.ShowModal;
//    if Lc_Form.It_Confirma then
//      Result := Lc_Form.It_cd_Pedido;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;

function Fc_EnviaPedidoNota(Pc_TipoPedido:Integer):integer;
//Var
//  Lc_Form : TFr_EnviaPedidoNota;
begin
  ShowMessage('Verificar');
//  Try
//    Result := 0;
//    Lc_Form := TFr_EnviaPedidoNota.Create(nil);
//    Lc_Form.It_Tipo_Pedido := Pc_TipoPedido;
//    Lc_Form.ShowModal;
//    if Lc_Form.It_Confirma then
//      Result := Lc_Form.It_cd_Pedido;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;

function Fc_EnviaPedido(FcDataBase : TSTDatabase;
                        FcTransaction : TSTTransaction;
                        Fc_Cd_Pedido: Integer;
                        Fc_Tipo:Integer;
                        Fc_AlteraVAlor:String;
                        Fc_Tx_Altera:Real):Boolean;
var
  Lc_TipoItem : String;
  ObjEmpresa : TControllerEmpresa;
  PedidoCopia : TControllerPedido;
  Lc_cd_Empresa : Integer;
begin
  Try
    Result := True;
    PedidoCopia := TControllerPedido.Create(nil);
    PedidoCopia.Registro.Codigo := Fc_Cd_Pedido;
    PedidoCopia.Registro.CodigoEstabelecimento := Gb_Codmha;
    PedidoCopia.getbyId;
    if PedidoCopia.exist then
    Begin
      PedidoCopia.Registro.Codigo := 0;
      PedidoCopia.Registro.Faturado := 'N';
    End
    else
    Begin
      Result := False;
      exit;
    End;

    with PedidoCopia.Registro do
    Begin
      Codigo := 0;
      if (fc_Tipo = 0) then
      Begin
        case Tipo of
          1: Lc_TipoItem := 'V';
          2: Lc_TipoItem := 'C';
          3: Lc_TipoItem := 'A';
          4: Lc_TipoItem := 'V';
        end;
      end
      else
      Begin
        case fc_Tipo of
          1: Lc_TipoItem := 'V';
          2: Lc_TipoItem := 'C';
          3: Lc_TipoItem := 'A';
          4: Lc_TipoItem := 'V';
        end;
      end;
      Numero := 0;
      if (Fc_Tipo > 0) then Tipo := Fc_Tipo;
      Data := DATE;
      ObjEmpresa := TControllerEmpresa.create(nil);
      ObjEmpresa.Registro.Codigo := Empresa;
      ObjEmpresa.GetById;
      Empresa := Fc_BuscaCodigoEmpresa(FcDataBase,FcTransaction, ObjEmpresa.Registro.CpfCNPJ);
      if Empresa = 0 then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       ' Por favor Registre o cliente no Banco Dados de Destino. ' +EOLN +
                       ' Verifique e tente novamente.'+EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
      end;

      Endereco := Fc_BuscaCodigoEndereco(FcDataBase,FcTransaction,Empresa);
      if Endereco = 0 then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       ' Por favor Registre o endereço do cliente no Banco Dados de Destino. ' +EOLN +
                       ' Verifique e tente novamente.'+EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result := False;
      End;

      if Result then
      Begin
        if (Fc_AlteraVAlor = 'A') then
        Begin
          ValorProdutos     := RoundTo( ValorProdutos + ( ( ValorProdutos * Fc_Tx_Altera)/100),-2);
          ValorIPI          := RoundTo( ValorIPI + ( ( ValorIPI * Fc_Tx_Altera)/100),-2);
          ValorFrete        := RoundTo( ValorFrete + ( ( ValorFrete * Fc_Tx_Altera)/100),-2);
          AliqDesconto      := RoundTo( AliqDesconto + ( ( AliqDesconto * Fc_Tx_Altera)/100),-2);
          ValorDesconto     := RoundTo( ValorDesconto + ( (ValorDesconto * Fc_Tx_Altera)/100),-2);
          ValorPedido       := RoundTo( ValorPedido + ( (ValorPedido * Fc_Tx_Altera)/100),-2);
        end
        else
        Begin
          if (Fc_AlteraVAlor = 'D') then
          Begin
            ValorProdutos := RoundTo( ValorProdutos - ( ( ValorProdutos * Fc_Tx_Altera)/100),-2);
            ValorIPI      := RoundTo( ValorIPI - ( ( ValorIPI * Fc_Tx_Altera)/100),-2);
            ValorFrete    := RoundTo( ValorFrete - ( ( ValorFrete * Fc_Tx_Altera)/100),-2);
            AliqDesconto  := RoundTo( AliqDesconto - ( ( AliqDesconto * Fc_Tx_Altera)/100),-2);
            ValorDesconto := RoundTo( ValorDesconto - ( ( ValorDesconto * Fc_Tx_Altera)/100),-2);
            ValorPedido   := RoundTo( ValorPedido - ( ( ValorPedido * Fc_Tx_Altera)/100),-2);
          end;
        end;
        Faturado := 'N';
        EmUso := '';

        CodigoEstabelecimento := Fc_VerificaEstabelecimentoDestino(FcDataBase,FcTransaction);
        //PedidoCopia.AlteraBancoDados('N');
        //Determina o usuario
        PedidoCopia.getUsuario;
        PedidoCopia.salva;
        //PedidoCopia.AlteraBancoDados('S');
      End;
    End;
  Finally
    FreeAndNil(PedidoCopia);
    FreeAndNil(ObjEmpresa);
  End;
end;

Function FC_Valida_produto(Fc_Itens:TSTQuery):boolean;
Var
  lc_obs : TStringList;
  LcSAldo : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    Result:= True;
    lc_obs := TStringList.Create;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Fc_Itens do
    Begin
      Lc_Qry.SQL.Add('SELECT PRO_CODIGO,EST_QTDE, PRO_EST_NEG '+
                     'FROM TB_PRODUTO tb_produto '+
                     '  INNER JOIN TB_ESTOQUE tb_estoque '+
                     '  ON (tb_estoque.EST_CODPRO = tb_produto.PRO_CODIGO) '+
                     'WHERE (PRO_CODIGO =:PRO_CODIGO) AND EST_CODETS=:ETS_CODIGO ');
      //FAz o loop nos itens
      First;
      while not Eof do
      Begin
        IF (FieldByName('ITF_ESTOQUE').AsAnsiString = 'S') then
        Begin
          if FieldByName('PRO_EST_NEG').AsString = 'N' then
          Begin
            Lc_Qry.Active := False;
            Lc_Qry.ParamByName('PRO_CODIGO').AsInteger := FieldByName('ITF_CODPRO').AsInteger;
            Lc_Qry.ParamByName('ETS_CODIGO').AsInteger := FieldByName('ITF_CODEST').AsInteger;
            Lc_Qry.Active := True;
            Lc_Qry.First;
            LcSAldo := 0;
            case AnsiIndexStr(UpperCase(Fc_Itens.FieldByName('ITF_OPER').AsString), ['V','C','A']) of
              0 : LcSaldo :=  (Lc_Qry.FieldByName('EST_QTDE').AsFloat + FieldByName('ITF_QTDE').AsFloat) - FieldByName('ITF_QTDE').AsFloat;
              2 : LcSaldo :=  Lc_Qry.FieldByName('EST_QTDE').AsFloat  - FieldByName('ITF_QTDE').AsFloat;
            end;
           if LcSaldo <0 then
            Begin
              Result := False;
              lc_obs.Add(FieldByName('ITF_CODPRO').AsAnsiString + ' - ' + FieldByName('PRO_DESCRICAO').AsAnsiString + ' = ' + FloatToStrF(Lc_Qry.FieldByName('EST_QTDE').AsFloat,ffFixed,10,2));
            end;
          End;
        End;
        Next;
      end;

      {//if ( not result ) and not GB_Liberado then
      //Não funcionou
        if not (Fc_VerificaPermissao('Fr_Pedido_Vda','Pedido de Venda','AUTORIZAR', GB_Cd_Usuario,'N')) then
        Begin
      end
      else
      Begin
        Result := True;
        if (Gb_Nivel = 0)  then Gb_Liberado := False;
      End

      }
      if ( not result )  then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'Problemas de Saldo de Produtos com os seguintes itens:.'+EOLN+EOLN+
                        lc_obs.Text + EOLN +
                       'Caso Necessário Peça Autorização.' + EOLN,
                        ['OK'], [bEscape], mpAlerta);
        Result := False;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
    lc_obs.DisposeOf;
  End;

end;


procedure Pc_ErroCorrigirValores(Pc_Codigo:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('update "TB_PEDIDO" '+
              'set '+
              ' "PED_QT_PRODUTO" = :"PED_QT_PRODUTO" '+
              ', "PED_VL_PRODUTO" = :"PED_VL_PRODUTO" '+
              ', "PED_VL_IPI" = :"PED_VL_IPI" '+
              ', "PED_VL_FRETE" = :"PED_VL_FRETE" '+
              ', "PED_ALIQ_DESCONTO" = :"PED_ALIQ_DESCONTO" '+
              ', "PED_VL_DESCONTO" = :"PED_VL_DESCONTO" '+
              ', "PED_VL_PEDIDO" = :"PED_VL_PEDIDO" '+
              ', "PED_VL_SERVICO" = :"PED_VL_SERVICO" '+
              ', "PED_VL_ODESPESA" = :"PED_VL_ODESPESA" '+
              ', "PED_VL_CREDITO" = :"PED_VL_CREDITO" '+
              'where PED_CODIGO=:PED_CODIGO');
      Active := False;
      ParamByName('PED_QT_PRODUTO').AsFloat := 0;
      ParamByName('PED_VL_PRODUTO').AsFloat := 0;
      ParamByName('PED_VL_IPI').AsFloat := 0;
      ParamByName('PED_VL_FRETE').AsFloat := 0;
      ParamByName('PED_ALIQ_DESCONTO').AsFloat := 0;
      ParamByName('PED_VL_DESCONTO').AsFloat := 0;
      ParamByName('PED_VL_PEDIDO').AsFloat := 0;
      ParamByName('PED_VL_SERVICO').AsFloat := 0;
      ParamByName('PED_VL_ODESPESA').AsFloat := 0;
      ParamByName('PED_VL_CREDITO').AsFloat := 0;
      ParamByName('PED_CODIGO').AsInteger := Pc_Codigo;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_VerificaEstabelecimentoDestino(FcDataBase : TSTDatabase;
                                           FcTransaction : TSTTransaction):Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Database := FcDataBase;
      Transaction := FcTransaction;
      ForcedRefresh := True;
      CachedUpdates := True;
      SQL.Clear;
      SQL.Add('SELECT EMP_CODIGO '+
              'FROM TB_EMPRESA '+
              'WHERE EMP_TIPO = 0');
      Active := True;
      Fetchall;
      Result := FieldByName('EMP_CODIGO').AsInteger;
    end;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  End;
end;

function Fc_VerificaProdutoDestino(FcDataBase : TSTDatabase;
                                   FcTransaction : TSTTransaction;
                                   Fc_Cd_Produto:String;
                                   Fc_Descricao:String):Boolean;
Var
  Lc_Qry : TSTQuery;

Begin
  if ( StrToIntDef( Fc_Cd_Produto ,0) = 0 ) then
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Para enviar o pedido, é necessário que '+EOLN+
                   'O código do produto de destino esteja referenciado'+EOLN+
                   'no campo codigo do fornecedor'+EOLN+
                   'Verifique o produto ' + Fc_Descricao +EOLN,
                   ['OK'], [bEscape], mpInformacao);
    Result := False;
    Exit;
  End;
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Database := FcDataBase;
      Transaction := FcTransaction;
      ForcedRefresh := True;
      CachedUpdates := True;
      SQL.Clear;
      //pESQUISA O CODIGO INTERNO NO DESTINO ATRAVES DO CODIGO DO FORNECEDOR DE ORIGEM
      SQL.Add('SELECT PRO_CODIGO '+
              'FROM TB_PRODUTO '+
              'WHERE PRO_CODIGO =:PRO_CODIGO ');
      ParamByName('PRO_CODIGO').AsString := Fc_Cd_Produto;
      Active := True;
      Fetchall;
      if ( RecordCount > 0 ) then
        Result := True
      else
        Result := False;
    end;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  End;
end;

procedure Pc_AtualizaObsPedido(codigo:Integer;Obs:TStringList);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('update "TB_PEDIDO" '+
              'set '+
              ' "PED_OBS" = :"PED_OBS" '+
              'where "PED_CODIGO" = :"PED_CODIGO"');
      //Tratamento de Algumas Variaveis

      //Passagem de Parametros
      ParamByName('PED_CODIGO').AsInteger := CODIGO;
      ParamByName('PED_OBS').AsAnsiString := Obs.Text;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;
end.


