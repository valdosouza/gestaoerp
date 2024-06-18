unit RN_Historico_Bancario;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,TypInfo,Un_DM, RN_CRUD;

  Type
    TGenericEntity = class(TObject)
    private

    public

  end;
  Function Fc_Update
  function Fc_AtualizaHistoricoBancario(Fc_CODIGO,
                                        Fc_DESCRICAO:String):Integer;


  Function Fc_PegaHistoricoBancario(Fc_Descricao: String): Integer;
implementation


function Fc_AtualizaHistoricoBancario(Fc_CODIGO,
                                      Fc_DESCRICAO:String):Integer;
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
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_HISTBANCARIO',['HTB_CODIGO'],[Fc_CODIGO],['HTB_CODIGO'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_HISTBANCARIO" set '+
              '  "HTB_DESCRICAO" = :"HTB_DESCRICAO" '+
              'where  "HTB_CODIGO" =:"HTB_CODIGO"');
      end
    else
      Begin//Insere
      SQL.Add('insert into "TB_HISTBANCARIO"( '+
              '  "HTB_CODIGO" '+
              ', "HTB_DESCRICAO") '+
              'values( '+
              '  :"HTB_CODIGO" '+
              ', :"HTB_DESCRICAO")');
      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros
    ParamByName('HTB_CODIGO').AsAnsiString := Fc_CODIGO;
    ParamByName('HTB_DESCRICAO').AsAnsiString := Fc_Descricao;
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

function Fc_PegaHistoricoBancario(Fc_Descricao: String): Integer;
var
  lc_qry:TSTQuery;
  sql_txt:String;
begin
  lc_qry := TSTQuery.Create(Application);
  with lc_qry do
    Begin
    Database:= DM.IBD_Gestao;
    Transaction:= DM.IB_Transacao;
    SQL.Clear;
    sql_txt:= ' select HTB_CODIGO FROM TB_HISTBANCARIO '+
              ' WHERE HTB_DESCRICAO = :DESCRICAO ';
    SQL.Add(sql_txt);
    ParamByName('DESCRICAO').AsAnsiString:= Fc_Descricao;
    Open;
    FetchAll;
    First;
    if (RecordCount >= 1) then
      Begin
      Result:= FIELDBYNAME('HTB_CODIGO').AsInteger;
      end
    else
      Begin
      SQL.Clear;
      sql_txt:= 'insert into "TB_FORMAPAGTO"( '+
                '  "FPT_CODIGO" '+
                ', "FPT_DESCRICAO" '+
                ', "FPT_BLOQUEA") '+
                'values( '+
                '  :"FPT_CODIGO" '+
                ', :"FPT_DESCRICAO" '+
                ', :"FPT_BLOQUEA") ';
      SQL.Add(sql_txt);
      Result := Fc_Generator('GN_FORMAPAGTO','TB_FORMAPAGTO','FPT_CODIGO');
      ParamByName('FPT_CODIGO').AsInteger := Result;
      ParamByName('FPT_DESCRICAO').AsAnsiString := Fc_Descricao;
      ParamByName('FPT_BLOQUEA').AsAnsiString := 'N';
      ExecSQL;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      end;
    end;
  lc_qry.Close;
  freeandnil(lc_qry);
end;

end.
