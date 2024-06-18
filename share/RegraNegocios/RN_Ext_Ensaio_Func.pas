unit RN_Ext_Ensaio_Func;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,  classes,db,
  UN_Principal,STTransaction;

  function Fc_AtualizaPVCPTTM(tb_ext_ensaio_func_id,
                              tipo,
                              tb_cliente_id,
                              recep_numero,
                              recep_anofab,
                              recep_codmrc,
                              recep_capacidade,
                              recep_codmed,
                              ampol_numero,
                              ampol_anofab,
                              ampol_codmrc,
                              ampol_capacidade,
                              ampol_codmed,
                              pressurizacao,
                              aprovado,
                              selo,
                              obs:String):Integer;
  function Fc_AtualizaItensEnsarioFunc(tb_ext_ensaio_func_id,
                                       tb_ext_grandeza_tipo_id,
                                       prova,
                                       contra_prova,
                                       testemunha:String):Integer;
  function Fc_GeraNumeroEnsaio(Pc_Cd_Ensaio:integer): Integer;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, RN_Crud;


  function Fc_AtualizaPVCPTTM(tb_ext_ensaio_func_id,
                              tipo,
                              tb_cliente_id,
                              recep_numero,
                              recep_anofab,
                              recep_codmrc,
                              recep_capacidade,
                              recep_codmed,
                              ampol_numero,
                              ampol_anofab,
                              ampol_codmrc,
                              ampol_capacidade,
                              ampol_codmed,
                              pressurizacao,
                              aprovado,
                              selo,
                              obs:String):Integer;


Var
  Lc_Qry:TSTQuery;
  Lc_Result:TStringList;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  Lc_Result := TStringList.create;
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Lc_Result := Fc_VerificaRegistro('TB_EXT_TIPO_ENSAIO',['TB_EXT_ENSAIO_FUNC_ID','TIPO'],[tb_ext_ensaio_func_id,tipo],['TB_EXT_ENSAIO_FUNC_ID','TIPO']);

    if (StrToIntDef(Lc_Result.Strings[0],0) > 0) then
      Begin //Atualiza
      SQL.Add('update "TB_EXT_TIPO_ENSAIO" set '+
              ' "TB_EXT_ENSAIO_FUNC_ID" = :"TB_EXT_ENSAIO_FUNC_ID" '+
              ', "TIPO" = :"TIPO" '+
              ', "TB_CLIENTE_ID" = :"TB_CLIENTE_ID" '+
              ', "RECEP_NUMERO" = :"RECEP_NUMERO" '+
              ', "RECEP_ANOFAB" = :"RECEP_ANOFAB" '+
              ', "RECEP_CODMRC" = :"RECEP_CODMRC" '+
              ', "RECEP_CAPACIDADE" = :"RECEP_CAPACIDADE" '+
              ', "RECEP_CODMED" = :"RECEP_CODMED" '+
              ', "AMPOL_NUMERO" = :"AMPOL_NUMERO" '+
              ', "AMPOL_ANOFAB" = :"AMPOL_ANOFAB" '+
              ', "AMPOL_CODMRC" = :"AMPOL_CODMRC" '+
              ', "AMPOL_CAPACIDADE" = :"AMPOL_CAPACIDADE" '+
              ', "AMPOL_CODMED" = :"AMPOL_CODMED" '+
              ', "PRESSURIZACAO" = :"PRESSURIZACAO" '+
              ', "APROVADO" = :"APROVADO" '+
              ', "SELO" = :"SELO" '+
              ', "OBS" = :"OBS" '+
              ' where "TB_EXT_ENSAIO_FUNC_ID" = :"TB_EXT_ENSAIO_FUNC_ID" and '+
              '  "TIPO" = :"TIPO"');
      end
    else
      Begin //Insere
      SQL.Add('insert into "TB_EXT_TIPO_ENSAIO"( '+
              '  "TB_EXT_ENSAIO_FUNC_ID" '+
              ', "TIPO" '+
              ', "TB_CLIENTE_ID" '+
              ', "RECEP_NUMERO" '+
              ', "RECEP_ANOFAB" '+
              ', "RECEP_CODMRC" '+
              ', "RECEP_CAPACIDADE" '+
              ', "RECEP_CODMED" '+
              ', "AMPOL_NUMERO" '+
              ', "AMPOL_ANOFAB" '+
              ', "AMPOL_CODMRC" '+
              ', "AMPOL_CAPACIDADE" '+
              ', "AMPOL_CODMED" '+
              ', "PRESSURIZACAO" '+
              ', "APROVADO" '+
              ', "SELO" '+
              ', "OBS") '+
              'values( '+
              '  :"TB_EXT_ENSAIO_FUNC_ID" '+
              ', :"TIPO" '+
              ', :"TB_CLIENTE_ID" '+
              ', :"RECEP_NUMERO" '+
              ', :"RECEP_ANOFAB" '+
              ', :"RECEP_CODMRC" '+
              ', :"RECEP_CAPACIDADE" '+
              ', :"RECEP_CODMED" '+
              ', :"AMPOL_NUMERO" '+
              ', :"AMPOL_ANOFAB" '+
              ', :"AMPOL_CODMRC" '+
              ', :"AMPOL_CAPACIDADE" '+
              ', :"AMPOL_CODMED" '+
              ', :"PRESSURIZACAO" '+
              ', :"APROVADO" '+
              ', :"SELO" '+
              ', :"OBS")');
      end;
    //Tratamento de algumas variaveis


    //Passagem de Parametros
    ParamByName('TB_EXT_ENSAIO_FUNC_ID').AsAnsiString := tb_ext_ensaio_func_id;
    ParamByName('TIPO').AsAnsiString := tipo;
    ParamByName('TB_CLIENTE_ID').AsAnsiString := tb_cliente_id;
    ParamByName('RECEP_NUMERO').AsAnsiString := recep_numero;
    ParamByName('RECEP_ANOFAB').AsAnsiString := recep_anofab;
    ParamByName('RECEP_CODMRC').AsAnsiString := recep_codmrc;
    ParamByName('RECEP_CAPACIDADE').AsAnsiString := recep_capacidade;
    ParamByName('RECEP_CODMED').AsAnsiString := recep_codmed;
    ParamByName('AMPOL_NUMERO').AsAnsiString := ampol_numero;
    ParamByName('AMPOL_ANOFAB').AsAnsiString := ampol_anofab;
    ParamByName('AMPOL_CODMRC').AsAnsiString := ampol_codmrc;
    ParamByName('AMPOL_CAPACIDADE').AsAnsiString :=  ampol_capacidade;
    ParamByName('AMPOL_CODMED').AsAnsiString := ampol_codmed;
    ParamByName('PRESSURIZACAO').AsAnsiString := pressurizacao;
    ParamByName('APROVADO').AsAnsiString := aprovado;
    ParamByName('SELO').AsAnsiString := selo;
    ParamByName('OBS').AsAnsiString := obs;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function Fc_AtualizaItensEnsarioFunc(tb_ext_ensaio_func_id,
                                     tb_ext_grandeza_tipo_id,
                                     prova,
                                     contra_prova,
                                     testemunha:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Campo,Lc_Valor,Lc_Retorno,Lc_Result:TStringList;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  Lc_Campo := TStringList.create;
  Lc_Valor := TStringList.create;
  Lc_Retorno := TStringList.create;
  Lc_Result := TStringList.create;
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;

    Lc_Result := Fc_VerificaRegistro('TB_EXT_ITENS_ENSAIO_FUNC',
                                     ['TB_EXT_ENSAIO_FUNC_ID','TB_EXT_GRANDEZA_TIPO_ID'],
                                     [tb_ext_ensaio_func_id,tb_ext_grandeza_tipo_id],
                                     ['TB_EXT_ENSAIO_FUNC_ID','TB_EXT_GRANDEZA_TIPO_ID']);

    if (StrToIntDef(Lc_Result.Strings[0],0) > 0) then
      Begin //Atualiza
      SQL.Add('update "TB_EXT_ITENS_ENSAIO_FUNC" set '+
              ' "TB_EXT_ENSAIO_FUNC_ID" = :"TB_EXT_ENSAIO_FUNC_ID" '+
              ', "TB_EXT_GRANDEZA_TIPO_ID" = :"TB_EXT_GRANDEZA_TIPO_ID" '+
              ', "PROVA" = :"PROVA" '+
              ', "CONTRA_PROVA" = :"CONTRA_PROVA" '+
              ', "TESTEMUNHA" = :"TESTEMUNHA" '+
              'where '+
              '  "TB_EXT_ENSAIO_FUNC_ID"   =:"TB_EXT_ENSAIO_FUNC_ID" and '+
              '  "TB_EXT_GRANDEZA_TIPO_ID" =:"TB_EXT_GRANDEZA_TIPO_ID" ');
      end
    else
      Begin //Insere
      SQL.Add('insert into "TB_EXT_ITENS_ENSAIO_FUNC"( '+
              '  "TB_EXT_ENSAIO_FUNC_ID" '+
              ', "TB_EXT_GRANDEZA_TIPO_ID" '+
              ', "PROVA" '+
              ', "CONTRA_PROVA" '+
              ', "TESTEMUNHA") '+
              'values( '+
              '  :"TB_EXT_ENSAIO_FUNC_ID" '+
              ', :"TB_EXT_GRANDEZA_TIPO_ID" '+
              ', :"PROVA" '+
              ', :"CONTRA_PROVA" '+
              ', :"TESTEMUNHA")');
      end;
    //Tratamento de algumas variaveis


    //Passagem de Parametros
    ParamByName('TB_EXT_ENSAIO_FUNC_ID').AsAnsiString := tb_ext_ensaio_func_id;
    ParamByName('TB_EXT_GRANDEZA_TIPO_ID').AsAnsiString := tb_ext_grandeza_tipo_id;
    ParamByName('PROVA').AsFloat := StrToFloatDef(prova,0);
    ParamByName('CONTRA_PROVA').AsFloat := StrToFloatDef(contra_prova,0);
    ParamByName('TESTEMUNHA').AsFloat := StrToFloatDef(testemunha,0);
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

function Fc_GeraNumeroEnsaio(Pc_Cd_Ensaio:integer): Integer;
var
  Lc_Qry: TSTQuery;
  Lc_Sql: String;
  lc_transacao:TSTTransaction;
begin
  lc_transacao := TSTTransaction.Create(Application);
  lc_transacao.DefaultDatabase:= DM.IBD_Gestao;
  lc_transacao.Params.Clear;

  lc_transacao.Params.Add('read_committed');
  lc_transacao.Params.Add('rec_version');
  lc_transacao.Params.Add('wait');
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    if not Lc_Transacao.InTransaction then Lc_Transacao.StartTransaction;
    Database:= DM.IBD_Gestao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Transaction:= lc_transacao;
    SQL.Clear;
    Lc_Sql := 'SELECT MAX(NUMERO) FROM TB_EXT_ENSAIO_FUNC '+
              'WHERE CODMHA=:CODMHA ';

    SQL.Add(Lc_Sql);
    ParamByName('CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    ApplyUpdates;
    Result := FieldByName('MAX').AsInteger + 1;
    if lc_transacao.inTransaction then lc_transacao.Commit;
    if not Lc_Transacao.InTransaction then Lc_Transacao.StartTransaction;
    Lc_Sql:='';
    Lc_Sql:= ' update TB_EXT_ENSAIO_FUNC set '+
             ' NUMERO =:NUMERO '+
             ' where ID = :ID AND CODMHA = :CODMHA  ';
    SQL.Clear;
    SQL.Add(Lc_Sql);
    ParamByName('NUMERO').Value:= Result;
    ParamByName('ID').AsInteger:=Pc_Cd_Ensaio;
    ParamByName('CODMHA').AsInteger:= Gb_CodMha;
    ExecSQL;
    if lc_transacao.inTransaction then lc_transacao.Commit;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
  FreeAndNil(lc_transacao);
end;


end.
