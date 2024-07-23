unit RN_Inventario;

interface

uses
  STQuery, SysUtils, Variants,FireDAC.Stan.Param;

//-------------------------Controle de Inventario ----------------------------------------------

  function Fc_SaldoInventario(Fc_Cd_Produto,Fc_Cd_Estabelecimento:Integer; Fc_Data:TDate):Real;

  function Fc_UltimaDataInventario(pCodmha:Integer):TDate;
  function Fc_UltimoCodigoInventario(Pc_Date:Tdate; Pc_Cd_Estabelecimento:Integer):Integer;
  procedure Pc_Movim_Produto(Pc_cd_Produto:Integer; Pc_Dt_Ini:TDate;Pc_Dt_Fim:TDate);
  Function  Fc_Saldo_Inventario(Pc_cd_Produto:Integer):Real;
  procedure Pc_AjustarDataPedidoAberto(Pc_Data:TDate);
  Function  Fc_ValidaDataPedido(Fc_Data:Tdate;pcodmha:Integer):Boolean;
var
    It_Cd_Inventario : Integer;

    It_Qt_Anterior : Real;
    It_Qt_Ent_Compra : Real;
    It_VL_Ent_Compra : Real;

    It_Qt_Ent_Outra : Real;
    It_VL_Ent_Outra : Real;

    It_Vl_Sai_Venda  : Real;
    It_Qt_Sai_Venda  : Real;

    It_VL_Sai_Outra : Real;
    It_Qt_Sai_Outra : Real;
    It_Vl_Custo_Ant : Real;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet,
  Un_Regra_Negocio,ControllerBase;


function Fc_SaldoInventario(Fc_Cd_Produto,Fc_Cd_Estabelecimento:Integer; Fc_Data:TDate):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := 0;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT first 1 iv.ivt_data, iv.IVT_QT_ATUAL ',
                'FROM TB_INVENTARIO iv ',
                'WHERE (iv.IVT_CODPRO =:IVT_CODPRO) AND (iv.IVT_CODMHA =:IVT_CODMHA) ',
                'order BY 1 desc '
      ));
      ParamByName('IVT_CODPRO').AsInteger := Fc_Cd_Produto;
      ParamByName('IVT_CODMHA').AsInteger := Fc_Cd_Estabelecimento;
      Active := True;
      Result := fieldbyName('IVT_QT_ATUAL').AsFloat;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function Fc_UltimaDataInventario(pCodmha:Integer):TDate;
Var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin

      Lc_SqlTxt := 'SELECT MAX(IVT_DATA) IVT_MAX '+
                   'FROM TB_INVENTARIO '+
                   ' WHERE IVT_CODMHA=:IVT_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_CODMHA').AsInteger := pCodMha;
      Active := True;
      FetchAll;
      if (RecordCount > 0) AND (fieldbyName('IVT_MAX').Value <> null) then
        Result := fieldbyName('IVT_MAX').Value
      else
        Result := StrToDate('01/01/1900');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_UltimoCodigoInventario(Pc_Date:Tdate; Pc_Cd_Estabelecimento:Integer):Integer;
Var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT MAX(IVT_CODIGO) IVT_MAX '+
                   'FROM TB_INVENTARIO '+
                   'WHERE (IVT_DATA <=:IVT_DATA) ';
      if (Pc_Cd_Estabelecimento > 0 ) then
        Lc_SqlTxt := Lc_SqlTxt + ' AND (IVT_CODMHA=:IVT_CODMHA) ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_DATA').AsDate := Pc_Date;
      if (Pc_Cd_Estabelecimento > 0 ) then
        ParamByName('IVT_CODMHA').AsInteger := Pc_Cd_Estabelecimento;
      Active := True;
      FetchAll;
      Result := fieldbyName('IVT_MAX').AsInteger;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_Movim_Produto(Pc_cd_Produto:Integer; Pc_Dt_Ini:TDate;Pc_Dt_Fim:TDate);
Var
  Lc_Qry : TSTQuery;
  Lc_sqlTxt : String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_sqlTxt := 'SELECT  SUM(ITF_QTDE)ITF_QT_TOTAL, SUM(ITF_QTDE * ITF_VL_UNIT) ITF_SUBTOTAL, SUM((ITF_QTDE * ITF_VL_UNIT)* (ITF_AQ_IPI/100) ) ITF_VL_IPI '+
                   'FROM TB_NOTA_FISCAL nota '+
                   '  INNER JOIN TB_PEDIDO pedido '+
                   '  ON (pedido.PED_CODIGO = nota.NFL_CODPED) '+
                   '  INNER JOIN  TB_ITENS_NFL itens '+
                   '  ON (itens.ITF_CODNFL  = nota.NFL_CODIGO ) '+
                   'WHERE (ITF_CODPRO =:ITF_CODPRO) AND PED_TIPO =:PED_TIPO AND (NFL_STATUS =''F'') AND '+
                   '(NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) AND (NFL_TIPO LIKE :NFL_TIPO) '+
                   'GROUP BY ITF_CODPRO '+
                   'ORDER BY ITF_CODPRO ';
      SQL.Add(Lc_sqlTxt);

      //Atualiza as compras do periodo
      ParamByName('ITF_CODPRO').AsInteger := Pc_cd_Produto;
      ParamByName('DATAINI').AsDate := Pc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Pc_Dt_Fim;
      ParamByName('PED_TIPO').AsAnsiString := '2';
      ParamByName('NFL_TIPO').AsAnsiString := 'E%';
      Active := True;
      It_Qt_Ent_Compra := FieldByName('ITF_QT_TOTAL').AsFloat;
      It_VL_Ent_Compra := FieldByName('ITF_SUBTOTAL').AsFloat + FieldByName('ITF_VL_IPI').AsFloat;


        //Atualiza as outras entradas do periodo
      Active := False;
      ParamByName('ITF_CODPRO').AsInteger := Pc_cd_Produto;
      ParamByName('DATAINI').AsDate := Pc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Pc_Dt_Fim;
      ParamByName('PED_TIPO').AsAnsiString := '3';
      ParamByName('NFL_TIPO').AsAnsiString := 'E%';
      Active := True;
      It_Qt_Ent_Outra := FieldByName('ITF_QT_TOTAL').AsFloat;
      It_VL_Ent_Outra := FieldByName('ITF_SUBTOTAL').AsFloat + FieldByName('ITF_VL_IPI').AsFloat;

      //Atualiza as vendas do periodo
      Active := False;
      ParamByName('ITF_CODPRO').AsInteger := Pc_cd_Produto;
      ParamByName('DATAINI').AsDate := Pc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Pc_Dt_Fim;
      ParamByName('PED_TIPO').AsAnsiString := '1';
      ParamByName('NFL_TIPO').AsAnsiString := 'S%';
      Active := True;
      It_Qt_Sai_Venda := FieldByName('ITF_QT_TOTAL').AsFloat;
      It_Vl_Sai_Venda := FieldByName('ITF_SUBTOTAL').AsFloat + FieldByName('ITF_VL_IPI').AsFloat;


      //Atualiza as outras saidas do periodo
      Active := False;
      ParamByName('ITF_CODPRO').AsInteger := Pc_cd_Produto;
      ParamByName('DATAINI').AsDate := Pc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Pc_Dt_Fim;
      ParamByName('PED_TIPO').AsAnsiString := '3';
      ParamByName('NFL_TIPO').AsAnsiString := 'S%';
      Active := True;
      It_Qt_Sai_Outra := FieldByName('ITF_QT_TOTAL').AsFloat;
      It_Vl_Sai_Outra := FieldByName('ITF_SUBTOTAL').AsFloat + FieldByName('ITF_VL_IPI').AsFloat;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


Function Fc_Saldo_Inventario(Pc_cd_Produto:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  Lc_sqlTxt : String;
  LcBase : TControllerBase;
begin
  Result := 0;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT IVT_CODIGO, IVT_VL_CUSTO, IVT_QT_ATUAL '+
                   'FROM TB_INVENTARIO '+
                   'WHERE (IVT_CODIGO=:IVT_CODIGO) '+
                   ' AND (IVT_CODPRO=:IVT_CODPRO) '+
                   'and (IVT_CODMHA=:IVT_CODMHA)';
      SQL.Add(Lc_SqlTxt);
      ParamByName('IVT_CODIGO').AsInteger := It_Cd_Inventario;
      ParamByName('IVT_CODPRO').AsInteger := Pc_cd_Produto;
      Active := True;
      FetchAll;
      First;
      IF RecordCount > 0 then
        Result := FieldByName('IVT_QT_ATUAL').AsFloat
      else
       It_Qt_Anterior := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_AjustarDataPedidoAberto(Pc_Data:TDate);
Var
  Lc_Qry : TSTQuery;
  Lc_sqlTxt : String;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'UPDATE TB_PEDIDO SET '+
                   ' PED_DATA =:PED_DATA '+
                   'WHERE PED_FATURADO = ''N'' '+
                   'and PED_DATA <=:PED_DATA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_DATA').AsDate := Pc_Data;
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      //Cria SQL para selecionar os pedidos em Aberto
      Close;
      SQL.Clear;
      Lc_SqlTxt := 'SELECT PED_CODIGO '+
                   'FROM TB_PEDIDO '+
                   'WHERE PED_FATURADO = ''N'' ';
      SQL.Add(Lc_SqlTxt);
      Active := True;
      First;
      while not eof do
      Begin
        //Pc_AlteraDataEstoquePedidoAberto(FieldByName('PED_CODIGO').AsInteger,Pc_Data);
        Next;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_ValidaDataPedido(Fc_Data:Tdate;pcodmha:Integer):Boolean;
Var
  Lc_Dt_Inventario : TDate;
Begin
  Result:=TRUE;
  //Verifica Inventario
  Lc_Dt_Inventario := Fc_UltimaDataInventario(pcodmha);
  if Fc_Data < Lc_Dt_Inventario then
    Begin
    MensagemPararExecucao('A data não pode ser menor que ' + DateToStr(Lc_Dt_Inventario) +'.');
    Result := FAlse;
    end;
end;

end.


