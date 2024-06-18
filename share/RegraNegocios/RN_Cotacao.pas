unit RN_Cotacao;

interface

uses
  Forms, Classes,Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,db;

Function Fc_AtualizaCotacao(Fc_CODIGO,
                            Fc_CODPED,
                            Fc_NUMERO,
                            Fc_TIPO,
                            Fc_CODUSU,
                            Fc_DATA,
                            Fc_CODEMP,
                            Fc_FANTASIA,
                            Fc_CODFPG,
                            Fc_PRAZO,
                            Fc_APROVADO,
                            Fc_QT_PRODUTO,
                            Fc_VL_PRODUTO,
                            Fc_VL_SERVICO,
                            Fc_VL_FRETE,
                            Fc_ALIQ_DESCONTO,
                            Fc_VL_DESCONTO,
                            Fc_VL_COTACAO,
                            Fc_CONTATO,
                            Fc_VALIDADE,
                            Fc_PRZ_ENTREGA,
                            Fc_GARANTIA,
                            Fc_FROTA,
                            Fc_EQUIPAMENTO,
                            Fc_TP_FRETE,
                            Fc_EMAIL_E,
                            Fc_CODVDO,
                            Fc_TP_CONTATO,
                            Fc_CODMHA,
                            Fc_CONTATOEMPRESA,
                            Fc_CODTRP,
                            Fc_VL_CUSTO,
                            Fc_OBS_CORTE,
                            Fc_OBS,
                            Fc_DT_ENV_EMAIL,
                            Fc_CODSIT,
                            Fc_SOLICITANTE,
                            Fc_VL_ADICIONAL:String):Integer;

  Procedure Pc_AtualizaTotalCotacao(Fc_CODIGO,
                                    Fc_QT_PRODUTO,
                                    Fc_VL_PRODUTO,
                                    Fc_VL_SERVICO,
                                    Fc_VL_FRETE,
                                    Fc_ALIQ_DESCONTO,
                                    Fc_VL_DESCONTO,
                                    Fc_VL_COTACAO,
                                    Fc_VL_CUSTO,
                                    Fc_VL_ADICIONAL:String);

  Function Fc_AtualizaItensCotacao(FC_CODIGO,
                                   FC_CODCTC,
                                   FC_TIPO,
                                   FC_CODVCL,
                                   FC_DESCRICAO,
                                   FC_QTDE,
                                   FC_VL_UNIT,
                                   FC_DISPON,
                                   FC_AQ_COM,
                                   FC_VL_DESC,
                                   FC_AQ_DESC,
                                   FC_AQ_IPI,
                                   FC_AQ_ICMS,
                                   FC_CODEST,
                                   FC_CODTPR,
                                   FC_VL_CUSTO,
                                   FC_MR_LUCRO,
                                   FC_ALIQ_CT_FINANCEIRO,
                                   FC_PRZ_PRATICADO,
                                   FC_VL_PRATICADO,
                                   FC_AQ_VENDEDOR,
                                   FC_TECIDO,
                                   FC_COR,
                                   FC_CODPED:String):Integer;
  procedure Pc_PreencheDespesaFinanceira(Fc_Cd_Item : Integer);
  Function Fc_AtualizaVendaUnitario(FC_CODIGO,
                                 FC_VL_UNIT,
                                 FC_MR_LUCRO,
                                 FC_ALIQ_CT_FINANCEIRO,
                                 FC_PRZ_PRATICADO,
                                 FC_VL_PRATICADO,
                                 FC_AQ_VENDEDOR:String):Integer;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, Un_Fc_Sored_Procedures, RN_Crud;

Function Fc_AtualizaCotacao(Fc_CODIGO,
                            Fc_CODPED,
                            Fc_NUMERO,
                            Fc_TIPO,
                            Fc_CODUSU,
                            Fc_DATA,
                            Fc_CODEMP,
                            Fc_FANTASIA,
                            Fc_CODFPG,
                            Fc_PRAZO,
                            Fc_APROVADO,
                            Fc_QT_PRODUTO,
                            Fc_VL_PRODUTO,
                            Fc_VL_SERVICO,
                            Fc_VL_FRETE,
                            Fc_ALIQ_DESCONTO,
                            Fc_VL_DESCONTO,
                            Fc_VL_COTACAO,
                            Fc_CONTATO,
                            Fc_VALIDADE,
                            Fc_PRZ_ENTREGA,
                            Fc_GARANTIA,
                            Fc_FROTA,
                            Fc_EQUIPAMENTO,
                            Fc_TP_FRETE,
                            Fc_EMAIL_E,
                            Fc_CODVDO,
                            Fc_TP_CONTATO,
                            Fc_CODMHA,
                            Fc_CONTATOEMPRESA,
                            Fc_CODTRP,
                            Fc_VL_CUSTO,
                            Fc_OBS_CORTE,
                            Fc_OBS,
                            Fc_DT_ENV_EMAIL,
                            Fc_CODSIT,
                            Fc_SOLICITANTE,
                            Fc_VL_ADICIONAL:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_COTACAO',['CTC_CODIGO'],[Fc_CODIGO],['CTC_CODIGO'])).Strings[0],0) > 0 then
      Begin //Atualiza
      SQL.Add('update "TB_COTACAO" set '+
              ' "CTC_CODIGO" = :"CTC_CODIGO" '+
              ', "CTC_CODPED" = :"CTC_CODPED" '+
              ', "CTC_NUMERO" = :"CTC_NUMERO" '+
              ', "CTC_TIPO" = :"CTC_TIPO" '+
              ', "CTC_CODUSU" = :"CTC_CODUSU" '+
              ', "CTC_DATA" = :"CTC_DATA" '+
              ', "CTC_CODEMP" = :"CTC_CODEMP" '+
              ', "CTC_FANTASIA" = :"CTC_FANTASIA" '+
              ', "CTC_CODFPG" = :"CTC_CODFPG" '+
              ', "CTC_PRAZO" = :"CTC_PRAZO" '+
              ', "CTC_APROVADO" = :"CTC_APROVADO" '+
              ', "CTC_QT_PRODUTO" = :"CTC_QT_PRODUTO" '+
              ', "CTC_VL_PRODUTO" = :"CTC_VL_PRODUTO" '+
              ', "CTC_VL_SERVICO" = :"CTC_VL_SERVICO" '+
              ', "CTC_VL_FRETE" = :"CTC_VL_FRETE" '+
              ', "CTC_ALIQ_DESCONTO" = :"CTC_ALIQ_DESCONTO" '+
              ', "CTC_VL_DESCONTO" = :"CTC_VL_DESCONTO" '+
              ', "CTC_VL_COTACAO" = :"CTC_VL_COTACAO" '+
              ', "CTC_CONTATO" = :"CTC_CONTATO" '+
              ', "CTC_VALIDADE" = :"CTC_VALIDADE" '+
              ', "CTC_PRZ_ENTREGA" = :"CTC_PRZ_ENTREGA" '+
              ', "CTC_GARANTIA" = :"CTC_GARANTIA" '+
              ', "CTC_FROTA" = :"CTC_FROTA" '+
              ', "CTC_EQUIPAMENTO" = :"CTC_EQUIPAMENTO" '+
              ', "CTC_TP_FRETE" = :"CTC_TP_FRETE" '+
              ', "CTC_EMAIL_E" = :"CTC_EMAIL_E" '+
              ', "CTC_CODVDO" = :"CTC_CODVDO" '+
              ', "CTC_TP_CONTATO" = :"CTC_TP_CONTATO" '+
              ', "CTC_CODMHA" = :"CTC_CODMHA" '+
              ', "CTC_CONTATOEMPRESA" = :"CTC_CONTATOEMPRESA" '+
              ', "CTC_CODTRP" = :"CTC_CODTRP" '+
              ', "CTC_VL_CUSTO" = :"CTC_VL_CUSTO" '+
              ', "CTC_OBS_CORTE" = :"CTC_OBS_CORTE" '+
              ', "CTC_OBS" = :"CTC_OBS" '+
              ', "CTC_DT_ENV_EMAIL" = :"CTC_DT_ENV_EMAIL" '+
              ', "CTC_CODSIT" = :"CTC_CODSIT" '+
              ', "CTC_SOLICITANTE" = :"CTC_SOLICITANTE" '+
              ', "CTC_VL_ADICIONAL" = :"CTC_VL_ADICIONAL" '+
              'where "CTC_CODIGO" = :"CTC_CODIGO" ');
      end
    else
      Begin //Insere
      Fc_CODIGO := IntToStr(Fc_Generator('GN_COTACAO','','CTC_CODIGO'));
      SQL.Add('insert into "TB_COTACAO"( '+
              '  "CTC_CODIGO" '+
              ', "CTC_CODPED" '+
              ', "CTC_NUMERO" '+
              ', "CTC_TIPO" '+
              ', "CTC_CODUSU" '+
              ', "CTC_DATA" '+
              ', "CTC_CODEMP" '+
              ', "CTC_FANTASIA" '+
              ', "CTC_CODFPG" '+
              ', "CTC_PRAZO" '+
              ', "CTC_APROVADO" '+
              ', "CTC_QT_PRODUTO" '+
              ', "CTC_VL_PRODUTO" '+
              ', "CTC_VL_SERVICO" '+
              ', "CTC_VL_FRETE" '+
              ', "CTC_ALIQ_DESCONTO" '+
              ', "CTC_VL_DESCONTO" '+
              ', "CTC_VL_COTACAO" '+
              ', "CTC_CONTATO" '+
              ', "CTC_VALIDADE" '+
              ', "CTC_PRZ_ENTREGA" '+
              ', "CTC_GARANTIA" '+
              ', "CTC_FROTA" '+
              ', "CTC_EQUIPAMENTO" '+
              ', "CTC_TP_FRETE" '+
              ', "CTC_EMAIL_E" '+
              ', "CTC_CODVDO" '+
              ', "CTC_TP_CONTATO" '+
              ', "CTC_CODMHA" '+
              ', "CTC_CONTATOEMPRESA" '+
              ', "CTC_CODTRP" '+
              ', "CTC_VL_CUSTO" '+
              ', "CTC_OBS_CORTE" '+
              ', "CTC_OBS" '+
              ', "CTC_DT_ENV_EMAIL" '+
              ', "CTC_CODSIT" '+
              ', "CTC_SOLICITANTE" '+
              ', "CTC_VL_ADICIONAL") '+
              'values( '+
              '  :"CTC_CODIGO" '+
              ', :"CTC_CODPED" '+
              ', :"CTC_NUMERO" '+
              ', :"CTC_TIPO" '+
              ', :"CTC_CODUSU" '+
              ', :"CTC_DATA" '+
              ', :"CTC_CODEMP" '+
              ', :"CTC_FANTASIA" '+
              ', :"CTC_CODFPG" '+
              ', :"CTC_PRAZO" '+
              ', :"CTC_APROVADO" '+
              ', :"CTC_QT_PRODUTO" '+
              ', :"CTC_VL_PRODUTO" '+
              ', :"CTC_VL_SERVICO" '+
              ', :"CTC_VL_FRETE" '+
              ', :"CTC_ALIQ_DESCONTO" '+
              ', :"CTC_VL_DESCONTO" '+
              ', :"CTC_VL_COTACAO" '+
              ', :"CTC_CONTATO" '+
              ', :"CTC_VALIDADE" '+
              ', :"CTC_PRZ_ENTREGA" '+
              ', :"CTC_GARANTIA" '+
              ', :"CTC_FROTA" '+
              ', :"CTC_EQUIPAMENTO" '+
              ', :"CTC_TP_FRETE" '+
              ', :"CTC_EMAIL_E" '+
              ', :"CTC_CODVDO" '+
              ', :"CTC_TP_CONTATO" '+
              ', :"CTC_CODMHA" '+
              ', :"CTC_CONTATOEMPRESA" '+
              ', :"CTC_CODTRP" '+
              ', :"CTC_VL_CUSTO" '+
              ', :"CTC_OBS_CORTE" '+
              ', :"CTC_OBS" '+
              ', :"CTC_DT_ENV_EMAIL" '+
              ', :"CTC_CODSIT" '+
              ', :"CTC_SOLICITANTE" '+
              ', :"CTC_VL_ADICIONAL")');
      end;

    //Tratamento de algumas variaveis

    //Passagem de Parametros
    ParamByName('CTC_CODIGO').AsInteger := StrToInt(Fc_CODIGO);
    ParamByName('CTC_CODPED').AsInteger := StrToInt(Fc_CODPED);
    ParamByName('CTC_NUMERO').AsAnsiString := Fc_NUMERO;
    ParamByName('CTC_TIPO').AsAnsiString := Fc_TIPO;
    ParamByName('CTC_CODUSU').AsInteger := StrToInt(Fc_CODUSU);
    ParamByName('CTC_DATA').AsDate := StrToDate(Fc_DATA);
    ParamByName('CTC_CODEMP').AsInteger := StrToInt(Fc_CODEMP);
    ParamByName('CTC_FANTASIA').AsAnsiString := Fc_FANTASIA;
    ParamByName('CTC_CODFPG').AsInteger := StrToInt(Fc_CODFPG);
    ParamByName('CTC_PRAZO').AsAnsiString := Fc_PRAZO;
    ParamByName('CTC_APROVADO').AsAnsiString := Fc_APROVADO;
    ParamByName('CTC_QT_PRODUTO').AsFloat := StrToFloatDef(Fc_QT_PRODUTO,0);
    ParamByName('CTC_VL_PRODUTO').AsFloat := StrToFloatDef(Fc_VL_PRODUTO,0);
    ParamByName('CTC_VL_SERVICO').AsFloat := StrToFloatDef(Fc_VL_SERVICO,0);
    ParamByName('CTC_VL_FRETE').AsFloat := StrToFloatDef(Fc_VL_FRETE,0);
    ParamByName('CTC_ALIQ_DESCONTO').AsFloat := StrToFloatDef(Fc_ALIQ_DESCONTO,0);
    ParamByName('CTC_VL_DESCONTO').AsFloat := StrToFloatDef(Fc_VL_DESCONTO,0);
    ParamByName('CTC_VL_COTACAO').AsFloat := StrToFloatDef(Fc_VL_COTACAO,0);
    ParamByName('CTC_CONTATO').AsAnsiString := Fc_CONTATO;
    ParamByName('CTC_VALIDADE').AsAnsiString := Fc_VALIDADE;
    ParamByName('CTC_PRZ_ENTREGA').AsAnsiString := Fc_PRZ_ENTREGA;
    ParamByName('CTC_GARANTIA').AsAnsiString := Fc_GARANTIA;
    ParamByName('CTC_FROTA').AsAnsiString := Fc_FROTA;
    ParamByName('CTC_EQUIPAMENTO').AsAnsiString := Fc_EQUIPAMENTO;
    ParamByName('CTC_TP_FRETE').AsAnsiString := Fc_TP_FRETE;
    ParamByName('CTC_EMAIL_E').AsAnsiString := Fc_EMAIL_E;
    ParamByName('CTC_CODVDO').AsInteger := StrToInt(Fc_CODVDO);
    ParamByName('CTC_TP_CONTATO').AsAnsiString := Fc_TP_CONTATO;
    ParamByName('CTC_CODMHA').AsInteger := StrToInt(Fc_CODMHA);
    ParamByName('CTC_CONTATOEMPRESA').AsAnsiString := Fc_CONTATOEMPRESA;
    ParamByName('CTC_CODTRP').AsInteger := StrToInt(Fc_CODTRP);
    ParamByName('CTC_VL_CUSTO').AsFloat := StrToFloatDef(Fc_VL_CUSTO,0);
    ParamByName('CTC_OBS_CORTE').AsAnsiString := Fc_OBS_CORTE;
    ParamByName('CTC_OBS').AsAnsiString := Fc_OBS;
    ParamByName('CTC_DT_ENV_EMAIL').AsAnsiString := Fc_DT_ENV_EMAIL;
    ParamByName('CTC_CODSIT').AsInteger := StrToInt(Fc_CODSIT);
    ParamByName('CTC_SOLICITANTE').AsAnsiString := Fc_SOLICITANTE;
    ParamByName('CTC_VL_ADICIONAL').AsFloat := StrToFloatDef(Fc_VL_ADICIONAL,0);
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Result := StrToIntDef(Fc_CODIGO,0);
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
      Result := 0;
    end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

Procedure Pc_AtualizaTotalCotacao(Fc_CODIGO,
                                  Fc_QT_PRODUTO,
                                  Fc_VL_PRODUTO,
                                  Fc_VL_SERVICO,
                                  Fc_VL_FRETE,
                                  Fc_ALIQ_DESCONTO,
                                  Fc_VL_DESCONTO,
                                  Fc_VL_COTACAO,
                                  Fc_VL_CUSTO,
                                  Fc_VL_ADICIONAL:String);
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Add('update "TB_COTACAO" set '+
            '  "CTC_QT_PRODUTO" = :"CTC_QT_PRODUTO" '+
            ', "CTC_VL_PRODUTO" = :"CTC_VL_PRODUTO" '+
            ', "CTC_VL_SERVICO" = :"CTC_VL_SERVICO" '+
            ', "CTC_VL_FRETE" = :"CTC_VL_FRETE" '+
            ', "CTC_ALIQ_DESCONTO" = :"CTC_ALIQ_DESCONTO" '+
            ', "CTC_VL_DESCONTO" = :"CTC_VL_DESCONTO" '+
            ', "CTC_VL_COTACAO" = :"CTC_VL_COTACAO" '+
            ', "CTC_VL_CUSTO" = :"CTC_VL_CUSTO" '+
            ', "CTC_VL_ADICIONAL" = :"CTC_VL_ADICIONAL" '+
            'where "CTC_CODIGO" = :"CTC_CODIGO" ');

    //Tratamento de algumas variaveis

    //Passagem de Parametros
    ParamByName('CTC_CODIGO').AsInteger := StrToInt(Fc_CODIGO);
    ParamByName('CTC_QT_PRODUTO').AsFloat := StrToFloatDef(Fc_QT_PRODUTO,0);
    ParamByName('CTC_VL_PRODUTO').AsFloat := StrToFloatDef(Fc_VL_PRODUTO,0);
    ParamByName('CTC_VL_SERVICO').AsFloat := StrToFloatDef(Fc_VL_SERVICO,0);
    ParamByName('CTC_VL_FRETE').AsFloat := StrToFloatDef(Fc_VL_FRETE,0);
    ParamByName('CTC_ALIQ_DESCONTO').AsFloat := StrToFloatDef(Fc_ALIQ_DESCONTO,0);
    ParamByName('CTC_VL_DESCONTO').AsFloat := StrToFloatDef(Fc_VL_DESCONTO,0);
    ParamByName('CTC_VL_COTACAO').AsFloat := StrToFloatDef(Fc_VL_COTACAO,0);
    ParamByName('CTC_VL_CUSTO').AsFloat := StrToFloatDef(Fc_VL_CUSTO,0);
    ParamByName('CTC_VL_ADICIONAL').AsFloat := StrToFloatDef(Fc_VL_ADICIONAL,0);
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
    end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


Function Fc_AtualizaItensCotacao(FC_CODIGO,
                                 FC_CODCTC,
                                 FC_TIPO,
                                 FC_CODVCL,
                                 FC_DESCRICAO,
                                 FC_QTDE,
                                 FC_VL_UNIT,
                                 FC_DISPON,
                                 FC_AQ_COM,
                                 FC_VL_DESC,
                                 FC_AQ_DESC,
                                 FC_AQ_IPI,
                                 FC_AQ_ICMS,
                                 FC_CODEST,
                                 FC_CODTPR,
                                 FC_VL_CUSTO,
                                 FC_MR_LUCRO,
                                 FC_ALIQ_CT_FINANCEIRO,
                                 FC_PRZ_PRATICADO,
                                 FC_VL_PRATICADO,
                                 FC_AQ_VENDEDOR,
                                 FC_TECIDO,
                                 FC_COR,
                                 FC_CODPED:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_ITENS_CTC',['ICT_CODIGO'],[FC_CODIGO],['ICT_CODIGO'])).Strings[0],0) > 0 then
      Begin //Atualiza
      SQL.Add('update TB_ITENS_CTC set '+
              ' ICT_CODIGO = :ICT_CODIGO '+
              ', ICT_CODCTC = :ICT_CODCTC '+
              ', ICT_TIPO = :ICT_TIPO '+
              ', ICT_CODVCL = :ICT_CODVCL '+
              ', ICT_DESCRICAO = :ICT_DESCRICAO '+
              ', ICT_QTDE = :ICT_QTDE '+
              ', ICT_VL_UNIT = :ICT_VL_UNIT '+
              ', ICT_DISPON = :ICT_DISPON '+
              ', ICT_AQ_COM = :ICT_AQ_COM '+
              ', ICT_VL_DESC = :ICT_VL_DESC '+
              ', ICT_AQ_DESC = :ICT_AQ_DESC '+
              ', ICT_AQ_IPI = :ICT_AQ_IPI '+
              ', ICT_AQ_ICMS = :ICT_AQ_ICMS '+
              ', ICT_CODEST = :ICT_CODEST '+
              ', ICT_CODTPR = :ICT_CODTPR '+
              ', ICT_VL_CUSTO = :ICT_VL_CUSTO '+
              ', ICT_MR_LUCRO = :ICT_MR_LUCRO '+
              ', ICT_ALIQ_CT_FINANCEIRO = :ICT_ALIQ_CT_FINANCEIRO '+
              ', ICT_PRZ_PRATICADO = :ICT_PRZ_PRATICADO '+
              ', ICT_VL_PRATICADO = :ICT_VL_PRATICADO '+
              ', ICT_AQ_VENDEDOR = :ICT_AQ_VENDEDOR '+
              ', ICT_TECIDO = :ICT_TECIDO '+
              ', ICT_COR = :ICT_COR '+
              ', ICT_CODPED = :ICT_CODPED '+
              'where ICT_CODIGO = :ICT_CODIGO ');
      end
    else
      Begin //Insere
      Fc_CODIGO := IntToStr(Fc_Generator('GN_ITENS_CTC','','ICT_CODIGO'));
      SQL.Add('insert into TB_ITENS_CTC( '+
              '  ICT_CODIGO '+
              ', ICT_CODCTC '+
              ', ICT_TIPO '+
              ', ICT_CODVCL '+
              ', ICT_DESCRICAO '+
              ', ICT_QTDE '+
              ', ICT_VL_UNIT '+
              ', ICT_DISPON '+
              ', ICT_AQ_COM '+
              ', ICT_VL_DESC '+
              ', ICT_AQ_DESC '+
              ', ICT_AQ_IPI '+
              ', ICT_AQ_ICMS '+
              ', ICT_CODEST '+
              ', ICT_CODTPR '+
              ', ICT_VL_CUSTO '+
              ', ICT_MR_LUCRO '+
              ', ICT_ALIQ_CT_FINANCEIRO '+
              ', ICT_PRZ_PRATICADO '+
              ', ICT_VL_PRATICADO '+
              ', ICT_AQ_VENDEDOR '+
              ', ICT_TECIDO '+
              ', ICT_COR '+
              ', ICT_CODPED) '+
              'values( '+
              '  :ICT_CODIGO '+
              ', :ICT_CODCTC '+
              ', :ICT_TIPO '+
              ', :ICT_CODVCL '+
              ', :ICT_DESCRICAO '+
              ', :ICT_QTDE '+
              ', :ICT_VL_UNIT '+
              ', :ICT_DISPON '+
              ', :ICT_AQ_COM '+
              ', :ICT_VL_DESC '+
              ', :ICT_AQ_DESC '+
              ', :ICT_AQ_IPI '+
              ', :ICT_AQ_ICMS '+
              ', :ICT_CODEST '+
              ', :ICT_CODTPR '+
              ', :ICT_VL_CUSTO '+
              ', :ICT_MR_LUCRO '+
              ', :ICT_ALIQ_CT_FINANCEIRO '+
              ', :ICT_PRZ_PRATICADO '+
              ', :ICT_VL_PRATICADO '+
              ', :ICT_AQ_VENDEDOR '+
              ', :ICT_TECIDO '+
              ', :ICT_COR '+
              ', :ICT_CODPED) ');
      end;

    //Tratamento de algumas variaveis

    //Passagem de Parametros
    ParamByName('ICT_CODIGO').AsInteger := StrToIntDef(FC_CODIGO,0);
    ParamByName('ICT_CODCTC').AsInteger := StrToIntDef(FC_CODCTC,0);
    ParamByName('ICT_TIPO').AsAnsiString := FC_TIPO;
    ParamByName('ICT_CODVCL').AsInteger := StrToIntDef(FC_CODVCL,0);
    ParamByName('ICT_DESCRICAO').AsAnsiString := FC_DESCRICAO;
    ParamByName('ICT_QTDE').AsFloat := StrToFloatDef(FC_QTDE,0);
    ParamByName('ICT_VL_UNIT').AsFloat := StrToFloatDef(FC_VL_UNIT,0);
    ParamByName('ICT_DISPON').AsAnsiString := FC_DISPON;
    ParamByName('ICT_AQ_COM').AsFloat := StrToFloatDef(FC_AQ_COM,0);
    ParamByName('ICT_VL_DESC').AsFloat := StrToFloatDef(FC_VL_DESC,0);
    ParamByName('ICT_AQ_DESC').AsFloat := StrToFloatDef(FC_AQ_DESC,0);
    ParamByName('ICT_AQ_IPI').AsFloat := StrToFloatDef(FC_AQ_IPI,0);
    ParamByName('ICT_AQ_ICMS').AsFloat := StrToFloatDef(FC_AQ_ICMS,0);
    ParamByName('ICT_CODEST').AsInteger := StrToIntDef(FC_CODEST,0);
    ParamByName('ICT_CODTPR').AsInteger := StrToIntDef(FC_CODTPR,0);
    ParamByName('ICT_VL_CUSTO').AsFloat := StrToFloatDef(FC_VL_CUSTO,0);
    ParamByName('ICT_MR_LUCRO').AsFloat := StrToFloatDef(FC_MR_LUCRO,0);
    ParamByName('ICT_ALIQ_CT_FINANCEIRO').AsFloat := StrToFloatDef(FC_ALIQ_CT_FINANCEIRO,0);
    ParamByName('ICT_PRZ_PRATICADO').AsAnsiString := FC_PRZ_PRATICADO;
    ParamByName('ICT_VL_PRATICADO').AsFloat := StrToFloatDef(FC_VL_PRATICADO,0);
    ParamByName('ICT_AQ_VENDEDOR').AsFloat := StrToFloatDef(FC_AQ_VENDEDOR,0);
    ParamByName('ICT_TECIDO').AsAnsiString := FC_TECIDO;
    ParamByName('ICT_COR').AsAnsiString := FC_COR;
    ParamByName('ICT_CODPED').AsInteger := StrToIntDef(FC_CODPED,0);
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Result := StrToIntDef(Fc_CODIGO,0);
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
      Result := 0;
    end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure Pc_PreencheDespesaFinanceira(Fc_Cd_Item : Integer);
Var
  Lc_Itens : TSTQuery;
  Lc_SqlTxt : String;
  Lc_Vl_Custo : real;
Begin
  Lc_Itens := TSTQuery.Create(Application);
  with Lc_Itens do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt :='SELECT FTC_CODIGO,FTC_CODICT,FTC_CODITF,FTC_TIPO,FTC_DESC_INSUMO,FTC_TX_PARTIC '+
                'FROM TB_FICHA_TECNICA tb_ficha_tecnica '+
                'where (FTC_TIPO = ''E'') AND (FTC_CODVCL=:FTC_CODVCL) and (ftc_codpro = 0)     ';
    SQL.Add(Lc_SqlTxt);
    Pc_AtivaEstabelecimento;
    ParamByName('FTC_CODVCL').AsAnsiString := DM.Qr_Estabelecimento.FieldByname('EMP_CODIGO').AsAnsiString;
    Active := True;
    FetchAll;
    First;
    while not Eof do
      Begin
      Pc_Fr_FichaTecnica('I',
                         0,
                         'V',
                         Fc_Cd_Item,
                         0,
                         0,
                         FieldByName('FTC_DESC_INSUMO').AsAnsiString,
                         'UND',
                         0,
                         0,
                         FieldByName('FTC_TX_PARTIC').AsFloat,
                         0);

      Next;
      end;
    end;
  Lc_Itens.Close;
  FreeAndNil(Lc_Itens);
end;

Function Fc_AtualizaVendaUnitario(FC_CODIGO,
                                 FC_VL_UNIT,
                                 FC_MR_LUCRO,
                                 FC_ALIQ_CT_FINANCEIRO,
                                 FC_PRZ_PRATICADO,
                                 FC_VL_PRATICADO,
                                 FC_AQ_VENDEDOR:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Add('update TB_ITENS_CTC set '+
            ' ICT_CODIGO = :ICT_CODIGO '+
            ', ICT_MR_LUCRO = :ICT_MR_LUCRO '+
            ', ICT_ALIQ_CT_FINANCEIRO = :ICT_ALIQ_CT_FINANCEIRO '+
            ', ICT_PRZ_PRATICADO = :ICT_PRZ_PRATICADO '+
            ', ICT_VL_PRATICADO = :ICT_VL_PRATICADO '+
            ', ICT_AQ_VENDEDOR = :ICT_AQ_VENDEDOR '+
            'where ICT_CODIGO = :ICT_CODIGO ');

    //Tratamento de algumas variaveis

    //Passagem de Parametros
    ParamByName('ICT_CODIGO').AsInteger := StrToIntDef(FC_CODIGO,0);
    ParamByName('ICT_MR_LUCRO').AsFloat := StrToFloatDef(FC_MR_LUCRO,0);
    ParamByName('ICT_ALIQ_CT_FINANCEIRO').AsFloat := StrToFloatDef(FC_ALIQ_CT_FINANCEIRO,0);
    ParamByName('ICT_PRZ_PRATICADO').AsAnsiString := FC_PRZ_PRATICADO;
    ParamByName('ICT_VL_PRATICADO').AsFloat := StrToFloatDef(FC_VL_PRATICADO,0);
    ParamByName('ICT_AQ_VENDEDOR').AsFloat := StrToFloatDef(FC_AQ_VENDEDOR,0);
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Result := 0;
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
      Result := 0;
    end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


end.
