unit RN_Lanca_Banco;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,TypInfo,Un_DM;

  Function Fc_PegaHistoricoBancario(Fc_Descricao: String): Integer;
implementation



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
