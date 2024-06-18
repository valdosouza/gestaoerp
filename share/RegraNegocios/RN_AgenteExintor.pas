unit RN_AgenteExintor;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db;

    Function Fc_Ag_ValorComprado(Fc_Nr_Lote:String):TStringList;
    Function Fc_Ag_ValorUsado(Fc_Nr_Lote:String):real;
    Function Fc_Ag_ValorQuebra(Fc_Nr_Lote:String):real;
    function Fc_VerificaExistenciaLoteNoItem(fc_item:Integer;Fc_Tipo:String):boolean;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio;


Function Fc_Ag_ValorComprado(Fc_Nr_Lote:String):TStringList;
Var
  Lc_Qry:TSTQuery;
Begin
  Result := TStringList.Create;
  Result.Clear;
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('select '+
            'NFL_NUMERO, '+
            'NFL_DT_EMISSAO, '+
            'ITF_VL_UNIT , '+
            'SUM(MLT_QTDE) ITF_QTDE '+
            'from tb_itens_nfl '+
            '    INNER JOIN TB_MOVIMENTO_LOTE '+
            '    ON (MLT_CODVCL = ITF_CODIGO) '+
            '    INNER JOIN tb_ctrl_lote '+
            '    ON (CLT_CODIGO = MLT_CODCLT) '+
            '    INNER JOIN tb_nota_fiscal '+
            '    ON (NFL_CODIGO = ITF_CODNFL) '+
            'WHERE MLT_CODVCL > 0   AND ( (MLT_TIPO = ''COMPRA'') or ( (MLT_TIPO = ''AJUSTE'') and (MLT_SENTIDO = ''E'') ) )'+
            'AND CLT_NUMERO=:CLT_NUMERO '+
            'GROUP BY 1,2,3 ');
    ParamByName('CLT_NUMERO').AsAnsiString := Fc_Nr_Lote;
    Active := True;
    Result.Add(FieldByName('NFL_NUMERO').AsAnsiString);
    Result.Add(FieldByName('ITF_VL_UNIT').AsAnsiString);
    Result.Add(FieldByName('ITF_QTDE').AsAnsiString);
    Result.Add(FieldByName('NFL_DT_EMISSAO').AsAnsiString);
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

Function Fc_Ag_ValorUsado(Fc_Nr_Lote:String):real;
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
    SQL.Add('select '+
            'CLT_NUMERO, '+
            'SUM(IOS_QTDE) IOS_VL_USADO '+
            'from TB_EXT_ORDEM_SERVICO '+
            '  INNER JOIN TB_EXT_ITENS_ORS '+
            '  ON (IOS_CODORS = ORS_CODIGO) '+
            '  INNER JOIN tb_movimento_lote '+
            '  ON (tb_movimento_lote.MLT_CODVCL = IOS_CODIGO ) '+
            '  INNER JOIN TB_CTRL_LOTE '+
            '  ON (CLT_CODIGO = MLT_CODCLT) '+
            'WHERE CLT_NUMERO =:CLT_NUMERO AND MLT_TIPO = ''EXT_RASTREADO'' '+
            'GROUP BY 1');
    ParamByName('CLT_NUMERO').AsAnsiString := Fc_Nr_Lote;
    Active := True;
    Result := FieldByName('IOS_VL_USADO').AsFloat;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

Function Fc_Ag_ValorQuebra(Fc_Nr_Lote:String):real;
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
    SQL.Add('select '+
            'CLT_NUMERO, '+
            'SUM(MLT_QTDE) MLT_VL_QUEBRA '+
            'from TB_CTRL_LOTE '+
            '  INNER JOIN tb_movimento_lote '+
            '  ON (tb_movimento_lote.MLT_CODCLT = CLT_CODIGO ) '+
            'WHERE CLT_NUMERO =:CLT_NUMERO AND MLT_TIPO = ''EXT_QUEBRA'' '+
            'GROUP BY 1');
    ParamByName('CLT_NUMERO').AsAnsiString := Fc_Nr_Lote;
    Active := True;
    Result := FieldByName('MLT_VL_QUEBRA').AsFloat;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function Fc_VerificaExistenciaLoteNoItem(fc_item:Integer;Fc_Tipo:String):boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT CLT_CODIGO '+
            'FROM TB_CTRL_LOTE '+
            '   INNER JOIN TB_MOVIMENTO_LOTE '+
            '   ON (MLT_CODCLT = CLT_CODIGO) '+
            'WHERE MLT_CODVCL=:MLT_CODVCL and MLT_TIPO=:MLT_TIPO ');
    ParamByName('MLT_CODVCL').AsInteger := fc_item;
    ParamByName('MLT_TIPO').AsAnsiString := Fc_Tipo;
    Active := True;
    FetchAll;
    result := (RecordCount>0);
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

end.

