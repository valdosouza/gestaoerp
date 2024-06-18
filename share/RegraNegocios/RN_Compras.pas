unit RN_Compras;

interface

uses
  Winapi.Windows, STQuery, SysUtils,ControllerBase;

  Function Fc_UltimoValorUnitarioCompra(Fc_Cd_Produto:Integer):Real;
  Function Fc_ValidaLimiteCompraMensal(Fc_Cd_Pedido,Fc_Cd_Item:Integer;Fc_VL_Pedido,Fc_Vl_Item:Real;Fc_Dt_Compra:TDate):boolean;
  Function Fc_SelecionaItensNota:String;
  Function Fc_MontaSqlCustosItensNota:String;
  procedure Pc_AtualizaCustosProdutos(Pc_Cd_Pedido:Integer;ConsolidaNFCusto:String;Bonifica:Boolean);
  procedure Pc_Ativa_Produtos_Saldo(Pc_Cd_Pedido:Integer);
  Procedure Pc_ExtornaCustoCompra(Pc_Tipo:Integer;Pc_Dataset:TSTQuery);
  Procedure Pc_DeleteREgistroCustos(Pc_Tipo:Integer;PedidoID:Integer);
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, ControllerCustoPedido, Un_Fc_Sored_Procedures, UN_Principal;


Function Fc_UltimoValorUnitarioCompra(Fc_Cd_Produto:Integer):Real;
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    Result := 0;
    LcBase := TControllerBase.create(Nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT FIRST 1 ITF_VL_UNIT '+
              'FROM tb_itens_nfl '+
              '  INNER JOIN tb_pedido '+
              '  ON (PED_CODIGO = ITF_CODPED) '+
              'WHERE (PED_TIPO = 2) AND (ITF_CODPRO = :PRO_CODIGO) '+
              'ORDER BY  PED_DATA DESC ');
      ParamByName('PRO_CODIGO').AsInteger := Fc_Cd_Produto;
      Active := True;
      FetchAll;
      Result := StrToFloatDef(FieldByname('ITF_VL_UNIT').AsAnsiString,0);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_ValidaLimiteCompraMensal(Fc_Cd_Pedido,Fc_Cd_Item:Integer;Fc_VL_Pedido,Fc_Vl_Item:Real;Fc_Dt_Compra:TDate):boolean;
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
  Lc_VL_Limite : Real;
  Lc_Str_Data : String;
  Lc_Vl_Compra : Real;
  Lc_Texto_Compra : String;
begin
  Result := True;
  Lc_VL_Limite := StrToFloatDef(Fc_Tb_Geral('L','CPA_G_CTRL_VL_MENSAL', '0,00'),0);
  if Lc_VL_Limite > 0 then
  Begin
    try
      LcBase := TControllerBase.create(Nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('SELECT SUM((ITF_VL_UNIT - ITF_VL_DESC) * ITF_QTDE) TOTAL '+
                'FROM TB_ITENS_NFL '+
                '  INNER JOIN tb_pedido '+
                '  ON (PED_CODIGO = ITF_CODPED) '+
                'WHERE (PED_TIPO = 2) AND (PED_FATURADO <> ''A'') '+
                'AND (PED_DATA BETWEEN :DATAINI AND :DATAFIM )');
        if Fc_Cd_Pedido > 0 then SQL.Add(' AND (PED_CODIGO <>:PED_CODIGO) ');
        if Fc_Cd_Item   > 0 then SQL.Add(' AND (ITF_CODIGO <>:ITF_CODIGO) ');
        //Passagem de PArametros
        if Fc_Cd_Pedido > 0 then
          ParamByName('PED_CODIGO').AsInteger := Fc_Cd_Pedido;
        if Fc_Cd_Item > 0 then
          ParamByName('ITF_CODIGO').AsInteger := Fc_Cd_Item;
        //Define o primeiro dia do mes em que esta sendo feito o pedido
        Lc_Str_Data := DateToStr(Fc_Dt_Compra);
        Lc_Str_Data := '01/' + Copy(Lc_Str_Data,4,7);
        ParamByName('DATAINI').AsDate := StrToDate(Lc_Str_Data);
        //Define o ultimo dia do mes em que esta sendo feito o pedido
        Lc_Str_Data := DateToStr(Fc_Dt_Compra);
        Lc_Str_Data := Fc_Ult_Dia_Mes(Fc_Dt_Compra) + '/' + Copy(Lc_Str_Data,4,7);
        ParamByName('DATAFIM').AsDate := StrToDate(Lc_Str_Data);
        Active := True;
        FetchAll;
        Lc_Vl_Compra := FieldByname('TOTAL').AsFloat;
        if ((Lc_Vl_Compra + Fc_VL_Pedido + Fc_Vl_Item)> Lc_VL_Limite) then
        Begin
          if (Fc_VL_Pedido > 0) then
          Begin
            Lc_Texto_Compra := 'Valor do último pedido : ' + FloatToStrF(Fc_VL_Pedido ,ffFixed,10,2);
          end
          else
          Begin
            Lc_Texto_Compra := 'Valor do último item   : ' + FloatToStrF(Fc_Vl_Item ,ffFixed,10,2);
          end;
          MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                         'O valor limite mensal para pedidos de compra foi atingido.' + EOLN +
                         'Limite de compra mensal: ' + FloatToStrF(Lc_VL_Limite,ffFixed,10,2) + EOLN +
                         'Valor mensal de compra : ' + FloatToStrF(Lc_Vl_Compra ,ffFixed,10,2) + EOLN +
                         Lc_Texto_Compra + EOLN +
                         'Altere a data do pedido para o próximo mês.' + EOLN,
                          ['OK'], [bEscape], mpAlerta);
          Result:=FALSE;
        end;
      end;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  end;
end;

Function Fc_SelecionaItensNota:String;
begin
  Result :=  'SELECT ITF_CODIGO '+
              'FROM TB_ITENS_NFL Tb_itens_nfl '+
              '   INNER JOIN TB_PEDIDO Tb_pedido '+
              '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
              '   INNER JOIN TB_PRODUTO Tb_produto '+
              '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
              '   INNER JOIN TB_MEDIDA tb_medida '+
              '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
              'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO <>''S'') ';
end;

Function Fc_MontaSqlCustosItensNota():String;
begin
  Result :=  'SELECT  '+
             '  ITF_CODIGO, '+
             '  ITF_QTDE, '+
             '  ITF_VL_UNIT, '+
             '  ITF_VL_CUSTO, '+
             '  ITF_VL_DESC, '+
             '  ICM_VL_BC_NR , '+
             '  ICM_AQ_NR, '+
             '  ICM_VL_NR, '+
             '  ICM_VL_ST, '+
             '  ICM_VL_FRETE, '+
             '  ICM_VL_SEGURO, '+
             '  ICM_VL_OUTRAS, '+
             '  IPI_VL_BC, '+
             '  IPI_AQ_NR,    '+
             '  PRO_VL_CUSTOMED, '+
             '  PRO_VL_CUSTOMEDANT, '+
             '  EST_QTDE, '+
             '  ITF_CODPRO,  '+
             '  ITF_ESTOQUE, '+
             '  N.nfl_dt_emissao, '+
             '  N.nfl_hr_saida '+
             'FROM TB_ITENS_NFL Itens '+
             '  INNER JOIN TB_PRODUTO produto '+
             '  ON (produto.PRO_CODIGO = itens.ITF_CODPRO)   '+
             '  INNER JOIN TB_ESTOQUE estoque                '+
             '  ON (estoque.EST_CODPRO = produto.PRO_CODIGO) '+
             '  INNER JOIN tb_nota_fiscal n                  '+
             '  ON (N.nfl_codigo = Itens.itf_codnfl)         '+
             '  LEFT OUTER JOIN TB_ITENS_ICMS icms           '+
             '  ON (icms.ICM_CODITF = itens.ITF_CODIGO )     '+
             '  LEFT OUTER JOIN TB_ITENS_IPI ipi             '+
             '  ON (ipi.IPI_CODITF = itens.ITF_CODIGO )      '+
             'WHERE (ITF_CODIGO=:ITF_CODIGO)                 '+
             'AND EST_CODETS =:EST_CODETS ';
end;



procedure Pc_AtualizaCustosProdutos(Pc_Cd_Pedido:Integer;ConsolidaNFCusto:String;Bonifica:Boolean);
Var
  Lc_Qr_Itens : TSTQuery;
  Lc_Qr_Custo : TSTQuery;
  Lc_VL_Custo: Real;
  Lc_Vl_Custo_Medio: Real;
  Lc_Vl_Calculo: Real;
  Lc_Qt_Anterior : real;
  Lc_CustoPedido : TControllerCustoPedido;
  Lc_Vl_Unitario : Real;
Begin
  Try
    Lc_CustoPedido := TControllerCustoPedido.create(Nil);
    //Traz a lista de produtos da Notas
    Lc_Qr_Itens := Lc_CustoPedido.GeraQuery;
    Lc_Qr_Itens.SQL.Add( Fc_SelecionaItensNota );
    Lc_Qr_Itens.ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
    Lc_Qr_Itens.Active := True;
    Lc_Qr_Itens.FetchAll;

    //Monta o componente com o custos dos produtos
    Lc_Qr_Custo := Lc_CustoPedido.GeraQuery; ;
    Lc_Qr_Custo.SQL.Add( Fc_MontaSqlCustosItensNota );

    //Comeca a Atualiação dos custos
    Lc_Qr_Itens.Active := True;
    Lc_Qr_Itens.FetchAll;
    if Lc_Qr_Itens.recordCount > 0 then
    Begin
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Atualização de Custos',
                      Pc_Cd_Pedido,
                      'Itens não encontrado',
                      'CÓDIGO PEDIDO: ' + Pc_Cd_Pedido.ToString);
    End
    else
    Begin
      Pc_Log_Sistema( Gb_CodMha,
                      GB_Cd_Usuario,
                      now,
                      'Atualização de Custos',
                      Pc_Cd_Pedido,
                      concat('Número de Itens:',IntToStr(Lc_Qr_Itens.recordCount)),
                      'CÓDIGO PEDIDO: ' + Pc_Cd_Pedido.ToString);
    End;
    Lc_Qr_Itens.First;
    Pc_AtivaEstabelecimento;
    while not Lc_Qr_Itens.Eof do
    begin
      Lc_Qr_Custo.Active := False;
      Lc_Qr_Custo.ParamByName('ITF_CODIGO').AsInteger := Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
      Lc_Qr_Custo.ParamByName('EST_CODETS').AsInteger := Gb_Estoque;
      Lc_Qr_Custo.Active := True;
      Lc_VL_Custo := 0;

      //Valor Unitario - Grava como ultimo Custo *Limpo
      Lc_Vl_Unitario := Lc_Qr_Custo.FieldByName('ITF_VL_UNIT').AsFloat;

      //Custo Direto ( + )
      Lc_VL_Custo := Lc_VL_Custo + Lc_Qr_Custo.FieldByName('ITF_VL_CUSTO').AsFloat;

      //Desconto Direto ( - )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat > 0) then
        Lc_VL_Custo := Lc_VL_Custo - (Lc_Qr_Custo.FieldByName('ITF_VL_DESC').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat);

      //Registra Custo;
      if (Lc_VL_Custo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) PRECO DE COMPRA';
          BaseCalculo := Lc_VL_Custo;
          ValorOriginal := Lc_VL_Custo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      //ICMS Subs. Tributaria ( + )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat > 0) then
        Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('ICM_VL_ST').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL_Custo   := Lc_VL_Custo + Lc_Vl_Calculo;

      //Registra Custo;
      if (Lc_Vl_Calculo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) ICMS ST';
          BaseCalculo := Lc_Vl_Calculo;
          ValorOriginal := Lc_Vl_Calculo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      //Custo Frete ( + )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat>0) then
        Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('ICM_VL_FRETE').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL_Custo   := Lc_VL_Custo + Lc_Vl_Calculo;

      //Registra Custo;
      if (Lc_Vl_Calculo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) FRETE';
          BaseCalculo := Lc_Vl_Calculo;
          ValorOriginal := Lc_Vl_Calculo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      //Custo Seguro ( + )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat>0) then
        Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('ICM_VL_SEGURO').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL_Custo   := Lc_VL_Custo + Lc_Vl_Calculo;

      //Registra Custo;
      if (Lc_Vl_Calculo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) SEGURO';
          BaseCalculo := Lc_Vl_Calculo;
          ValorOriginal := Lc_Vl_Calculo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      //Custo Oturas Despesas ( + )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat>0) then
        Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('ICM_VL_OUTRAS').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL_Custo   := Lc_VL_Custo + Lc_Vl_Calculo;

      //Registra Custo;
      if (Lc_Vl_Calculo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) OUTRAS DESPESAS';
          BaseCalculo := Lc_Vl_Calculo;
          ValorOriginal := Lc_Vl_Calculo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      //IPI ( + )
      Lc_Vl_Calculo := 0;
      if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat >0) then
        Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('IPI_VL_BC').AsFloat * Lc_Qr_Custo.FieldByName('IPI_AQ_NR').AsFloat;
      Lc_Vl_Calculo := Lc_Vl_Calculo /100;
      Lc_Vl_Calculo := Lc_Vl_Calculo / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
      Lc_VL_Custo   := Lc_VL_Custo + Lc_Vl_Calculo;

      //Registra Custo;
      if (Lc_Vl_Calculo > 0 ) then
      Begin
        Lc_CustoPedido.Clear;
        with Lc_CustoPedido.Registro do
        Begin
          CodigoPedido :=  Pc_cd_Pedido;
          ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
          CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
          Cotacao := 1;
          Descricao := '(+) IPI';
          BaseCalculo := Lc_Vl_Calculo;
          ValorOriginal := Lc_Vl_Calculo;
          ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
          OrigemLancamento := 'A';
        End;
        Lc_CustoPedido.insere;
      End;

      if ( DM.Qr_Estabelecimento.FieldByName('EMP_CRT').AsInteger > 1 ) and
         ( Lc_Qr_Custo.FieldByName('ICM_VL_NR').AsFloat > 0 ) then
      Begin
        //ICMS ( - )
        Lc_Vl_Calculo := 0;
        if (Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat > 0) then
          Lc_Vl_Calculo := Lc_Qr_Custo.FieldByName('ICM_VL_NR').AsFloat / Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat;
        Lc_VL_Custo := Lc_VL_Custo - Lc_Vl_Calculo;

        //Registra Custo;
        if (Lc_Vl_Calculo > 0 ) then
        Begin
          Lc_CustoPedido.Clear;
          with Lc_CustoPedido.Registro do
          Begin
            CodigoPedido :=  Pc_cd_Pedido;
            ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
            CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
            Cotacao := 1;
            Descricao := '(-) ICMS';
            BaseCalculo := Lc_Vl_Calculo * -1;
            ValorOriginal := Lc_Vl_Calculo * -1;
            ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
            OrigemLancamento := 'A';
          End;
          Lc_CustoPedido.insere;
        End;

        DM.Qr_Impostos.Active := True;
        //PIS ( - )
        Lc_Vl_Calculo := 0;
        Lc_Vl_Calculo := ( Lc_Qr_Custo.FieldByName('ITF_VL_CUSTO').AsFloat * DM.Qr_Impostos.FieldByName('IPT_PIS').AsFloat ) / 100;
        Lc_VL_Custo := Lc_VL_Custo - Lc_Vl_Calculo;

        //Registra Custo;
        if (Lc_Vl_Calculo > 0 ) then
        Begin
          Lc_CustoPedido.Clear;
          with Lc_CustoPedido.Registro do
          Begin
            CodigoPedido :=  Pc_cd_Pedido;
            ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
            CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
            Cotacao := 1;
            Descricao := '(-) PIS';
            BaseCalculo := Lc_Vl_Calculo * -1;
            ValorOriginal := Lc_Vl_Calculo * -1;
            ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
            OrigemLancamento := 'A';
          End;
          Lc_CustoPedido.insere;
        End;

        //COFINS ( - )
        Lc_Vl_Calculo := 0;
        Lc_Vl_Calculo := ( Lc_Qr_Custo.FieldByName('ITF_VL_CUSTO').AsFloat * DM.Qr_Impostos.FieldByName('IPT_COFINS').AsFloat ) / 100;
        Lc_VL_Custo := Lc_VL_Custo - Lc_Vl_Calculo;

        //Registra Custo;
        if (Lc_Vl_Calculo > 0 ) then
        Begin
          Lc_CustoPedido.Clear;
          with Lc_CustoPedido.Registro do
          Begin
            CodigoPedido :=  Pc_cd_Pedido;
            ItemPedido :=  Lc_Qr_Itens.FieldByNAme('ITF_CODIGO').AsInteger;
            CodigoProduto :=  Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger;
            Cotacao := 1;
            Descricao := '(-) COFINS';
            BaseCalculo := Lc_Vl_Calculo * -1;
            ValorOriginal := Lc_Vl_Calculo * -1;
            ValorReal := Lc_CustoPedido.Registro.ValorOriginal * Lc_CustoPedido.Registro.Cotacao;
            OrigemLancamento := 'A';
          End;
          Lc_CustoPedido.insere;
        End;
      End;
      //Verifica se o custo será consolidada com o custo de outro produto em uma nota Fiscal

      if Length(Trim(ConsolidaNFCusto)) > 0 then
      Begin
        Lc_CustoPedido.Clear;
        Lc_Vl_Calculo := Lc_CustoPedido.getCustoProduto(ConsolidaNFCusto,Lc_Qr_Custo.FieldByNAme('ITF_CODPRO').AsInteger);
        Lc_VL_Custo := Lc_VL_Custo + Lc_Vl_Calculo;
      End;

      //Define o custo medio que será atualizado
      //Lc_Vl_Custo_Medio := Lc_VL_Custo;

      if (Lc_Qr_Custo.FieldByName('ITF_ESTOQUE').AsString = 'S') then
      Begin
        Lc_Qt_Anterior := (Lc_Qr_Custo.FieldByName('EST_QTDE').AsFloat - Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat);
        if  (Lc_Qt_Anterior > 0) then
        begin
          if Bonifica then
            Lc_Vl_Calculo := (    0       * Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat)
          else
            Lc_Vl_Calculo := (Lc_VL_Custo * Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat);

          Lc_Vl_Calculo := Lc_Vl_Calculo + (Lc_Qr_Custo.FieldByName('PRO_VL_CUSTOMED').AsFloat * Lc_Qt_Anterior);
          Lc_Vl_Calculo := Lc_Vl_Calculo / (Lc_Qt_Anterior + Lc_Qr_Custo.FieldByName('ITF_QTDE').AsFloat);
          Lc_Vl_Custo_Medio := Lc_Vl_Calculo;
        end
        else
        Begin
          Lc_Vl_Custo_Medio := Lc_VL_Custo;
        End;
        //Atualiza o custo no cadastro do produto
        Lc_CustoPedido.Produto.Registro.Codigo :=  Lc_Qr_Custo.FieldByName('ITF_CODPRO').AsInteger;
        Lc_CustoPedido.Produto.getbyId;
        if ( Lc_CustoPedido.Produto.Registro.ValorCusto < Lc_VL_Custo) then
          Lc_CustoPedido.Produto.Registro.ValorCusto := Lc_VL_Custo;
        Lc_CustoPedido.Produto.Registro.ValorCustoMedio :=  Lc_Vl_Custo_Medio;
          Lc_CustoPedido.Produto.AtualizaCusto;
        //Atualizar o Ultimo Custo do produto
        Lc_CustoPedido.AtualizarUltimoCusto(
                Lc_Qr_Custo.FieldByName('nfl_dt_emissao').AsDateTime,
                Lc_Qr_Custo.FieldByName('nfl_hr_saida').AsDateTime,
                Lc_Qr_Custo.FieldByName('ITF_CODPRO').AsInteger,
                Lc_Vl_Unitario
        );
      End;
      Lc_Qr_Itens.Next;
    end;
  Finally
    Lc_CustoPedido.FinalizaQuery(Lc_Qr_Itens);
    Lc_CustoPedido.FinalizaQuery(Lc_Qr_Custo);
    Lc_CustoPedido.DisposeOf;
  End;

end;

procedure Pc_Ativa_Produtos_Saldo(Pc_Cd_Pedido:Integer);
Var
  Lc_Qry: TSTQuery;
  Lc_Qry_Upd: TSTQuery;
  LcBase : TControllerBase;
  Lc_cd_Produto : String;
  Lc_ComercioEletronico : boolean;
Begin
  try
    LcBase := TControllerBase.create(Nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT PRO_ATIVO, ITF_CODPRO '+
                   'FROM TB_ITENS_NFL Tb_itens_nfl '+
                   '   INNER JOIN TB_PEDIDO Tb_pedido '+
                   '   ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
                   '   INNER JOIN TB_PRODUTO Tb_produto '+
                   '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
                   '   INNER JOIN TB_MEDIDA tb_medida '+
                   '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED) '+
                   'WHERE (ITF_CODPED =:PED_CODIGO) AND (PRO_TIPO <>''S'') ');
      ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
      Active := True;
      FetchAll;
      end;

    Lc_Qry_Upd := LcBase.GeraQuery;
    with Lc_Qry_Upd do
    Begin
      Sql.add('UPDATE TB_PRODUTO SET '+
                   'PRO_ATIVO = ''S'', '+
                   'PRO_FORA_LINHA = ''N'' '+
                   'WHERE PRO_CODIGO=:PRO_CODIGO ');
      Lc_Qry.First;
      while not Lc_Qry.Eof do
      Begin
        if (Lc_Qry.FieldByname('PRO_ATIVO').AsAnsiString = 'N') Then
        Begin
          Active := False;
          ParamByName('PRO_CODIGO').AsInteger := Lc_Qry.FieldByname('ITF_CODPRO').AsInteger;
          ExecSQL;
        end;
        Lc_Qry.Next;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_Qry_Upd);
    LcBase.DisposeOf;
  end;
end;

Procedure Pc_ExtornaCustoCompra(Pc_Tipo:Integer;Pc_Dataset:TSTQuery);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  if (Pc_Tipo = 2) then
  Begin
    Try
      LcBase := TControllerBase.create(Nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('UPDATE TB_PRODUTO SET '+
                'PRO_VL_CUSTO =PRO_VL_CUSTOANT, '+
                'PRO_VL_CUSTOMED = PRO_VL_CUSTOMEDANT '+
                'WHERE (PRO_CODIGO   =:PRO_CODIGO) ');

        Pc_Dataset.Active := True;
        Pc_Dataset.First;
        while not Pc_Dataset.Eof do
        Begin
          Active := False;
          ParamByName('PRO_CODIGO').AsInteger := Pc_Dataset.FieldByName('ITF_CODPRO').AsInteger;
          ExecSQL;
          Pc_Dataset.Next;
        end;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  end;
end;

Procedure Pc_DeleteREgistroCustos(Pc_Tipo:Integer;PedidoID:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  if (Pc_Tipo = 2) then
  Begin
    Try
      LcBase := TControllerBase.create(Nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('DELETE FROM TB_CUSTO_PEDIDO '+
                'WHERE (CTP_CODPED   =:PED_CODIGO) ');
        ParamByName('PED_CODIGO').AsInteger := PedidoID;
        ExecSQL;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  end;
end;

end.
