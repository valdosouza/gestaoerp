unit RN_SyncTable;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,ControllerBase;


   function Fc_SyncTableUpdate(id:String;updatet_at:String; operador:String):String;
   function Fc_SyncTableGetUpdateAt(id:String;operador:Integer):String;

implementation

uses Un_DM, RN_Crud, Un_Regra_Negocio, UN_Sistema, STDataSet;


function Fc_SyncTableUpdate(id:String;
                            updatet_at:String;
                            operador:String):String;
Var
  Lc_Qry:TSTQuery;
  Lc_St_data:String;
  Lc_St_Time:String;
  Lc_Registro : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE OR INSERT INTO TB_SYNC_TABLE (ID, DT_UPDATE, TM_UPDATE, OPERATOR) ');
      SQL.Add('VALUES (:ID, :DT_UPDATE, :TM_UPDATE, :OPERATOR) ');
      SQL.Add(' MATCHING (ID,OPERATOR) ');

      //Tratamento de Algumas Variaveis
      //2014-06-15 19:05:55
      Lc_St_data := Copy(updatet_at,9,2) + '/' + Copy(updatet_at,6,2) + '/' + Copy(updatet_at,1,4);
      Lc_St_Time := Copy(updatet_at,12,8);

      //Passagem de Parametros

      ParamByName('id').AsAnsiString :=  id;
      ParamByName('OPERATOR').AsAnsiString :=  operador;
      ParamByName('dt_update').AsAnsiString := Lc_St_data;
      ParamByName('tm_update').AsAnsiString := Lc_St_Time;
      ExecSQL;
      Result := Id;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_SyncTableGetUpdateAt(id:String;operador:Integer):String;
Var
  Lc_Qry:TSTQuery;
  Lc_Data : String;
  Lc_DataTime : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select dt_update, tm_update '+
              'from tb_sync_table '+
              'where ( id =:id )'+
              ' and (operator=:operator) ' );
      ParamByName('id').AsAnsiString :=  id;
      ParamByName('operator').AsInteger :=  operador;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
      Begin
        //2014-06-15 19:05:55 - 01/01/2000
        Lc_Data := FieldByname('dt_update').AsAnsiString;
        Lc_Data := Copy(Lc_Data,7,4) + '-' + Copy(Lc_Data,4,2) + '-' + Copy(Lc_Data,1,2);
        Lc_DataTime := Lc_Data + ' ' + FieldByname('tm_update').AsAnsiString;
      end
      else
      Begin
        Lc_DataTime := '2014-01-01 00:00:00';
      end;
      Result := Lc_DataTime;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


end.
