unit RN_LUCRATIVIDADE;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,DBCtrls, RN_Empresa;

  function Fc_AtualizaLucratividade(tb_itensnlf_id,
                                    tb_pedido_iD,
                                    tb_kind_lucratividade_id,
                                    operation,
                                    current_value:String):Integer;
  Function Fc_AbreTelaLucratividade(Pc_Cd_Pedido,Pc_Cd_Item:Integer):TRetornoDados;

implementation

uses Un_DM, RN_Crud, Un_Lucratividade;

function Fc_AtualizaLucratividade(tb_itensnlf_id,
                                  tb_pedido_id,
                                  tb_kind_lucratividade_id,
                                  operation,
                                  current_value:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Codigo : Integer;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Lc_Codigo := StrToIntDef(TStringList(Fc_VerificaRegistro('tb_lucratividade',['tb_itensnlf_id','tb_kind_lucratividade_id'],[tb_itensnlf_id,tb_kind_lucratividade_id],['tb_itensnlf_id','tb_kind_lucratividade_id'])).Strings[0],0);
    if (Lc_Codigo > 0) then
    Begin //Atualiza
      SQL.Add('update "TB_LUCRATIVIDADE" set '+
              ' "TB_ITENSNLF_ID" = :"TB_ITENSNLF_ID" '+
              ', "TB_PEDIDO_ID" = :"TB_PEDIDO_ID" '+
              ', "TB_KIND_LUCRATIVIDADE_ID" = :"TB_KIND_LUCRATIVIDADE_ID" '+
              ', "OPERATION" = :"OPERATION" '+
              ', "CURRENT_VALUE" = :"CURRENT_VALUE" '+
              'where '+
              '  "TB_ITENSNLF_ID" = :"TB_ITENSNLF_ID" and '+
              '  "TB_KIND_LUCRATIVIDADE_ID" = :"TB_KIND_LUCRATIVIDADE_ID" ');
      end
    else
      Begin//Insere
      SQL.Add('insert into "TB_LUCRATIVIDADE"( '+
              '  "TB_ITENSNLF_ID" '+
              ', "TB_PEDIDO_ID" '+
              ', "TB_KIND_LUCRATIVIDADE_ID" '+
              ', "OPERATION" '+
              ', "CURRENT_VALUE") '+
              'values( '+
              '  :"TB_ITENSNLF_ID" '+
              ', :"TB_PEDIDO_ID" '+
              ', :"TB_KIND_LUCRATIVIDADE_ID" '+
              ', :"OPERATION" '+
              ', :"CURRENT_VALUE")');
      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros
    ParamByName('TB_ITENSNLF_ID').AsAnsiString := tb_itensnlf_id;
    ParamByName('TB_PEDIDO_ID').AsAnsiString := tb_pedido_iD;
    ParamByName('TB_KIND_LUCRATIVIDADE_ID').AsAnsiString :=  tb_kind_lucratividade_id;
    ParamByName('OPERATION').AsAnsiString := operation;
    ParamByName('CURRENT_VALUE').AsFloat := StrToFloatDef(current_value,0); 
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToIntDef(tb_itensnlf_id,0);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);

end;

Function Fc_AbreTelaLucratividade(Pc_Cd_Pedido,Pc_Cd_Item:Integer):TRetornoDados;
Var
  Lc_Form : TFr_Lucratividade;
Begin
  Lc_Form := TFr_Lucratividade.Create(Application);
  Lc_Form.It_Cd_Pedido := Pc_Cd_Pedido;
  Lc_Form.It_Cd_Item := Pc_Cd_Item;
  Lc_Form.ShowModal;
  FreeAndNil(Lc_Form);
end;

end.
