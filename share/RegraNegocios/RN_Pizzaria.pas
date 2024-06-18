unit RN_Pizzaria;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db, RN_Itens_Vda_Avulso,ControllerCtrlEstoque;

  function Fc_BuscaPorTelefone(Fc_Fone:String):TStringList;
  function Fc_BuscaPedido(Fc_Cd_Pedido:Integer):TStringList;
  function fc_AtualizaItensPizzaria(Fc_CODITF,
                                    Fc_NR_ITEM,
                                    Fc_DESCRICAO,
                                    Fc_Qtde,
                                    Fc_Vl_Unit,
                                    Fc_OBS,
                                    Fc_CODGRC,
                                    Fc_CODSBG,
                                    Fc_CORTESIA:String):Integer ;

    function Fc_GeraProximoNrItem(Fc_Cd_Pedido:Integer):Integer;
    procedure Pc_GravaItemVenda(Pc_Cd_Pedido,Pc_Nr_Item, Pc_Cd_Produto,Pc_Cd_Garcon,Pc_cd_SubGrupo:Integer;
                                             Pc_Descricao,Pc_Obs,pc_Cortesia:String;
                                             Pc_Qtde,Pc_VL_Unit,Pc_VL_Desc:Real;
                                             Pc_Dt_Operacao:TDate;
                                             Pc_Nr_Sabores : Integer;
                                             Pc_SubTotal: REal;
                                             Pc_MostraValor:Boolean);

  implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, Un_CopiaPedidoNota, Un_Fc_Sored_Procedures, RN_Estoque,
  Un_EnviaPedidoNota, RN_Crud;



function Fc_AtualizaEmpresa(Fc_Fone,
                            Fc_Nome,
                            Fc_Obs_Linha_1,
                            Fc_Obs,
                            Fc_Ativa:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Retorno:TStringList;
  Lc_Cd_Empresa : String;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IBT_Crud;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    //Prepara a Variavel para pegar o retorno
    if not DM.IBT_Crud.InTransaction then DM.IBT_Crud.StartTransaction;
    Lc_Retorno := TStringList.Create;
    Lc_Retorno := Fc_VerificaRegistro('TB_ENDERECO',['END_FONE'],[Fc_Fone],['END_CODEMP']);
    Lc_Cd_Empresa := Lc_Retorno.Strings[0];
    if (StrToIntDef(Lc_Cd_Empresa,0)>0) then
      Begin //Atualiza
      SQL.Add('update "TB_EMPRESA" set '+
              ' "EMP_NOME" = :"EMP_NOME" '+
              ',"EMP_FANTASIA" = :"EMP_FANTASIA" '+
              ',"EMP_ATIVA" =:"EMP_ATIVA" '+
              ',"EMP_OBSERV" = :"EMP_OBSERV" '+
              'where "EMP_CODIGO" = :"EMP_CODIGO" ');
      end
    else
      Begin
      SQL.add('insert into "TB_EMPRESA"( '+
              '  "EMP_CODIGO" '+
              ', "EMP_TIPO" '+
              ', "EMP_NOME" '+
              ', "EMP_FANTASIA" '+
              ', "EMP_OBSERV" '+
              ', "EMP_DT_CADASTRO" '+
              ', "EMP_PESSOA" '+
              ', "EMP_MULTIPLICADOR" '+
              ', "EMP_CONSUMIDOR" '+
              ', "EMP_MICRO" '+
              ', "EMP_ATIVA") '+
              'values( '+
              '  :"EMP_CODIGO" '+
              ', :"EMP_TIPO" '+
              ', :"EMP_NOME" '+
              ', :"EMP_FANTASIA" '+
              ', :"EMP_OBSERV" '+
              ', :"EMP_DT_CADASTRO" '+
              ', :"EMP_PESSOA" '+
              ', :"EMP_MULTIPLICADOR" '+
              ', :"EMP_CONSUMIDOR" '+
              ', :"EMP_MICRO" '+
              ', :"EMP_ATIVA") ');


      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros
    if (StrToIntDef(Lc_Cd_Empresa,0)>0) then
    Begin
      ParamByName('EMP_CODIGO').AsAnsiString := Lc_Cd_Empresa;
      ParamByName('EMP_NOME').AsAnsiString := Trim(Fc_NOME);
      ParamByName('EMP_FANTASIA').AsAnsiString := Trim(Fc_Nome);
      ParamByName('EMP_OBSERV').AsAnsiString := Trim(Fc_Obs_Linha_1 + #13 + Fc_Obs);
      ParamByName('EMP_ATIVA').AsAnsiString := Trim(Fc_Ativa);
    end
    else
    Begin
      Lc_Cd_Empresa := IntToStr(Fc_Generator('GN_EMPRESA','TB_EMPRESA','EMP_CODIGO'));
      ParamByName('EMP_CODIGO').AsAnsiString := Lc_Cd_Empresa;
      ParamByName('EMP_TIPO').AsAnsiString := '1';
      ParamByName('EMP_NOME').AsAnsiString := Trim(Fc_Nome);
      ParamByName('EMP_FANTASIA').AsAnsiString := Trim(Fc_Nome);
      ParamByName('EMP_OBSERV').AsAnsiString := Trim(Fc_Obs_Linha_1 + #13 + Fc_Obs);
      ParamByName('EMP_PESSOA').AsAnsiString := 'F';
      ParamByName('EMP_MULTIPLICADOR').AsAnsiString := '1';
      ParamByName('EMP_CONSUMIDOR').AsAnsiString := 'S';
      ParamByName('EMP_MICRO').AsAnsiString := 'N';
      ParamByName('EMP_ATIVA').AsAnsiString := Trim(Fc_Ativa);
    end;
      Try
        ExecSQL;
        if DM.IBT_Crud.InTransaction then DM.IBT_Crud.CommitRetaining;
        Result := StrToInt(Lc_Cd_Empresa);
      except
        if DM.IBT_Crud.InTransaction then DM.IBT_Crud.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function Fc_BuscaPorTelefone(Fc_Fone:String):TStringList;
Var
  Lc_Qry:TSTQuery;
Begin
  Result := TStringList.Create();
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IBT_Crud;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add(' SELECT '+
            ' END_CODIGO, '+
            ' END_FONE, '+
            ' EMP_CODIGO, '+
            ' EMP_NOME, '+
            ' END_CEP, '+
            ' END_ENDER, '+
            ' END_NUMERO, '+
            ' END_COMPLEM, '+
            ' END_BAIRRO, '+
            ' EMP_OBSERV, '+
            ' EMP_ATIVA '+
            ' FROM TB_EMPRESA tb_empresa '+
            '    INNER JOIN TB_ENDERECO tb_endereco '+
            '    ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
            'WHERE (END_FONE =:END_FONE)');
    ParamByName('END_FONE').AsAnsiString := Fc_Fone;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
    Begin
      Result.Append( FieldByName('END_CODIGO').AsAnsiString);
      Result.Append( FieldByName('END_FONE').AsAnsiString);
      Result.Append( FieldByName('EMP_CODIGO').AsAnsiString);
      Result.Append( FieldByName('EMP_NOME').AsAnsiString);
      Result.Append( FieldByName('END_CEP').AsAnsiString);
      Result.Append( FieldByName('END_ENDER').AsAnsiString);
      Result.Append( FieldByName('END_NUMERO').AsAnsiString);
      Result.Append( FieldByName('END_COMPLEM').AsAnsiString);
      Result.Append( FieldByName('END_BAIRRO').AsAnsiString);
      Result.Append( FieldByName('EMP_OBSERV').AsAnsiString);
      Result.Append( FieldByName('EMP_ATIVA').AsAnsiString);
    end
    else
    Begin
      Result.Append('0');
    end
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_BuscaPedido(Fc_Cd_Pedido:Integer):TStringList;
Var
  Lc_Qry:TSTQuery;
  Lc_I : Integer;
Begin
  Result := TStringList.Create();
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IBT_Crud;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('select '+
            'PED_CODIGO, '+
            'PED_NUMERO, '+
            'PED_TP_CONTATO, '+
            'PED_VL_PRODUTO, '+
            'PED_VL_ODESPESA, '+
            'PED_VL_DESCONTO, '+
            'PED_VL_FRETE, '+
            'PED_VL_PEDIDO, '+
            'PED_OBS, '+
            'END_CODIGO, '+
            'END_FONE, '+
            'EMP_CODIGO, '+
            'EMP_NOME, '+
            'END_CEP, '+
            'END_ENDER, '+
            'END_NUMERO, '+
            'END_COMPLEM, '+
            'END_BAIRRO, '+
            'EMP_OBSERV, '+
            'EMP_ATIVA '+
            'FROM TB_PEDIDO '+
            '   INNER JOIN TB_EMPRESA ON (EMP_CODIGO = PED_CODEMP) '+
            '   INNER JOIN TB_ENDERECO ON (END_CODIGO = PED_CODEND) '+
            'WHERE PED_CODIGO=:PED_CODIGO');
    ParamByName('PED_CODIGO').AsInteger := Fc_Cd_Pedido;
    Active := True;
    FetchAll;
    if (RecordCount > 0) then
    Begin
      For Lc_I:= 0 to FieldCount -1 do
      begin
        if (Fields.Fields[Lc_I].DataType = ftFloat) OR (Fields.Fields[Lc_I].DataType = ftBCD) then
          Result.Append( FloatToStrF(Fields[Lc_I].AsFloat,ffFixed,10,2))
        else
          Result.Append( Fields[Lc_I].AsAnsiString);
      end;
    end
    else
    Begin
      Result.Append('0');
    end
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;


function fc_AtualizaItensPizzaria(Fc_CODITF,
                                  Fc_NR_ITEM,
                                  Fc_DESCRICAO,
                                  Fc_Qtde,
                                  Fc_Vl_Unit,
                                  Fc_OBS,
                                  Fc_CODGRC,
                                  Fc_CODSBG,
                                  Fc_CORTESIA:String):Integer ;
Var
  Lc_Qry:TSTQuery;
  Lc_Retorno:TStringList;
  Lc_Cd_Item : String;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IBT_Crud;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    //Prepara a Variavel para pegar o retorno
    if not DM.IBT_Crud.InTransaction then DM.IBT_Crud.StartTransaction;
    Lc_Retorno := TStringList.Create;
    Lc_Retorno := Fc_VerificaRegistro('TB_ITENS_RTR',['ITR_CODITF'],[Fc_CODITF],['ITR_CODITF']);
    Lc_Cd_Item := Lc_Retorno.Strings[0];
    if (StrToIntDef(Lc_Cd_Item,0)>0) then
      Begin //Atualiza
      SQL.Add('update "TB_ITENS_RTR" set '+
              '  "ITR_NR_ITEM" = :"ITR_NR_ITEM" '+
              ', "ITR_DESCRICAO" = :"ITR_DESCRICAO" '+
              ', "ITR_QTDE" =:"ITR_QTDE" '+
              ', "ITR_VL_UNIT" =:"ITR_VL_UNIT" '+
              ', "ITR_OBS" = :"ITR_OBS" '+
              ', "ITR_CODGRC" = :"ITR_CODGRC" '+
              ', "ITR_CODSBG" = :"ITR_CODSBG" '+
              ', "ITR_CORTESIA" = :"ITR_CORTESIA" '+
              'where "ITR_CODITF" = :"ITR_CODITF"');
      end
    else
      Begin
      SQL.add('insert into "TB_ITENS_RTR"( '+
              '  "ITR_CODITF" '+
              ', "ITR_NR_ITEM" '+
              ', "ITR_DESCRICAO" '+
              ', "ITR_QTDE" '+
              ', "ITR_VL_UNIT" '+
              ', "ITR_OBS" '+
              ', "ITR_CODGRC" '+
              ', "ITR_CODSBG" '+
              ', "ITR_CORTESIA") '+
              'values( '+
              '  :"ITR_CODITF" '+
              ', :"ITR_NR_ITEM" '+
              ', :"ITR_DESCRICAO" '+
              ', :"ITR_QTDE" '+
              ', :"ITR_VL_UNIT" '+
              ', :"ITR_OBS" '+
              ', :"ITR_CODGRC" '+
              ', :"ITR_CODSBG" '+
              ', :"ITR_CORTESIA")');
      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros
    ParamByName('ITR_CODITF').AsAnsiString := Fc_CODITF;
    ParamByName('ITR_NR_ITEM').AsAnsiString := Fc_NR_ITEM;
    ParamByName('ITR_DESCRICAO').AsAnsiString := Fc_DESCRICAO;
    ParamByName('ITR_QTDE').AsFloat := StrToFloatDef(Fc_Qtde,0);
    ParamByName('ITR_VL_UNIT').AsFloat := StrToFloatDef(Fc_Vl_Unit,0);
    ParamByName('ITR_OBS').AsAnsiString := Fc_OBS;
    ParamByName('ITR_CODGRC').AsAnsiString := Fc_CODGRC;
    ParamByName('ITR_CODSBG').AsAnsiString := Fc_CODSBG;
    ParamByName('ITR_CORTESIA').AsAnsiString := Fc_CORTESIA;
      Try
        ExecSQL;
        if DM.IBT_Crud.InTransaction then DM.IBT_Crud.CommitRetaining;
        Result := StrToInt(Fc_CODITF);
      except
        if DM.IBT_Crud.InTransaction then DM.IBT_Crud.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_GeraProximoNrItem(Fc_Cd_Pedido:Integer):Integer;
Var
  Qry : TSTQuery;
Begin
  Try
    Qry := TSTQuery.Create(Application);
    with Qry do
    Begin
      Database := dm.IBD_Gestao;
      Transaction := DM.IBT_Crud;
      Forcedrefresh := True;
      active := False;
      sql.Add('select Max(itr_nr_item) ITR_ULT_ITEM '+
              'from tb_itens_rtr '+
              '  inner join tb_itens_nfl '+
              '  on (ITF_CODIGO = itr_coditf) '+
              'where itf_codped =:PED_CODIGO ');
      paramByName('PED_CODIGO').asinteger := Fc_cd_Pedido;
      active := True;
      FetchAll;
      if (recordCount > 0) then
        Result := FieldByName('ITR_ULT_ITEM').AsInteger + 1
      else
        Result := 1;
    end;
  Finally
    Qry.close;
    Qry.DisposeOf;
  End;
end;

procedure Pc_GravaItemVenda(Pc_Cd_Pedido,
                            Pc_Nr_Item,
                            Pc_Cd_Produto,
                            Pc_Cd_Garcon,
                            Pc_cd_SubGrupo:Integer;
                            Pc_Descricao,
                            Pc_Obs,
                            pc_Cortesia:String;
                            Pc_Qtde,
                            Pc_VL_Unit,
                            Pc_VL_Desc:Real;
                            Pc_Dt_Operacao:TDate;
                            Pc_Nr_Sabores : Integer;
                            Pc_SubTotal: REal;
                            Pc_MostraValor:Boolean);
Var
  Lc_Cd_Item : Integer;
  Lc_Estoque : String;
  Lc_QtdeLocal : Real;
  LcCtrlEstoque : TControllerCtrlEstoque;
begin
  Try
    LcCtrlEstoque := TControllerCtrlEstoque.create(nil);
    Lc_Estoque := 'S';
    Lc_Cd_Item := 0;

    //Grava os Valores em Variavel local
    Lc_Cd_Item :=Fc_AtualizaItensNfl(DM.IBT_Crud,
                                      'I',
                                      Lc_Cd_Item,
                                      Pc_Cd_Pedido,
                                      0,
                                      Pc_Cd_Produto,
                                      Pc_Qtde,
                                      0,  //E_CustoUnitario.Text
                                      Pc_VL_Unit,
                                      0,  //E_Aq_Desconto.Text
                                      Pc_VL_Desc,
                                      0,  //E_Aq_Com.Text
                                      'V',
                                      Lc_Estoque,
                                      'S',
                                      0,  //E_Aq_IPI.Text
                                      0,  //E_Aq_Icms.Text
                                      Gb_Estoque,
                                      1,
                                      '',
                                      0,
                                      0,
                                      0);
    //Insere na tabela de Itens Avuldos usado na emissão do NFC-e
    Fc_InsereItenVdaAvulso(IntToStr(Lc_Cd_Item),
                           'UND',
                           Pc_DESCRICAO);
    if Pc_MostraValor then
      Lc_QtdeLocal := Pc_Qtde
    else
      Lc_QtdeLocal := 0;

    fc_AtualizaItensPizzaria(IntToStr(Lc_Cd_Item),
                             IntToStr(Pc_Nr_Item),
                             Pc_DESCRICAO,
                             FloatToStrF(Lc_QtdeLocal,ffFixed,10,2),
                             FloatToStrF(Pc_SubTotal,ffFixed,10,2),
                             Copy(Pc_OBS,1,250),
                             IntToStr(Pc_Cd_Garcon),
                             IntToStr(Pc_cd_SubGrupo),
                             pc_Cortesia);
    with LcCtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := Gb_Terminal;
      Vinculo     := 'P';
      Ordem       := Pc_Cd_Pedido;
      Item        := Lc_Cd_Item;
      Estoque     := Gb_Estoque;
      operacao    := 'S';
      Produto     := Pc_Cd_Produto;
      Quantidade  := Pc_Qtde;
      Data        := Pc_Dt_Operacao;
      Tipo        := 'Venda';
      UpdateAt    := Now;
    End;
    LcCtrlEstoque.Registra;
  Finally
    LcCtrlEstoque.DisposeOf
  End;
end;

end.


