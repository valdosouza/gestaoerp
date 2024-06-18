unit RN_Annotation;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db;


   function Fc_AtualizaAnnotation(id,
                                  identify,
                                  dt_record,
                                  link_id1,
                                  link_id2,
                                  reference,
                                  observation:String):integer;

implementation

uses Un_DM, RN_Crud, Un_Regra_Negocio, UN_Sistema;


function Fc_AtualizaAnnotation(id,
                              identify,
                              dt_record,
                              link_id1,
                              link_id2,
                              reference,
                              observation:String):integer;
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
    if (StrToIntDef(TStringList(Fc_VerificaRegistro('TB_ANNOTATION',['ID'],[ID],['ID'])).Strings[0],0) > 0) then
    Begin //Atualiza
      SQL.Add('update tb_annotation set '+
              'identify =:identify, '+
              'dt_record =:dt_record, '+
              'link_id1 =:link_id1, '+
              'link_id2 =:link_id2, '+
              'reference =:reference, '+
              'observation =:observation '+
              'where id =:id');
      end
    else
      Begin//Insere
      SQL.Add('insert into tb_annotation( '+
              '  id, '+
              '  identify, '+
              '  dt_record, '+
              '  link_id1, '+
              '  link_id2, '+
              '  reference, '+
              '  observation) '+
              'Values( '+
              '  :id, '+
              '  :identify, '+
              '  :dt_record, '+
              '  :link_id1, '+
              '  :link_id2, '+
              '  :reference, '+
              '  :observation) ');              
      id := IntToStr(Fc_Generator('GN_ANNOTATION','TB_ANNOTATION','ID'));
      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros

    ParamByName('id').AsAnsiString :=  id;
    ParamByName('identify').AsAnsiString :=  identify;
    ParamByName('dt_record').AsAnsiString :=  dt_record;
    ParamByName('link_id1').AsAnsiString :=  link_id1;
    ParamByName('link_id2').AsAnsiString :=  link_id2;
    ParamByName('reference').AsAnsiString := reference;
    ParamByName('observation').AsAnsiString := observation;

      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToInt(Id);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;




end.
