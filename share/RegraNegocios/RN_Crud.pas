unit RN_Crud;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,  classes,db,
  ControllerBase,FireDAC.Stan.Param;

  Function Fc_VerificaRegistro(Fc_Tabela:String;Fc_Campo,Fc_Valor,Fc_Retorno : array of string):TStringList;
  function Fc_ApagarRegistro(Fc_Tabela:String;Fc_Campo : array of string;Fc_codigo : array of string):String;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_Regra_Negocio;


Function Fc_VerificaRegistro(Fc_Tabela:String;Fc_Campo,Fc_Valor,Fc_Retorno : array of string):TStringList;
Var
  Lc_Qry:TSTQuery;
  Lc_I : Integer;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Result := TStringList.create;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT ');
      For Lc_I := 0 to High(Fc_Retorno) do
      Begin
        if (Lc_I = 0) then
          SQL.Add(Fc_Retorno[lc_I])
        else
          SQL.Add(',' + Fc_Retorno[lc_I]);
      end;
      SQL.Add(' From ' + Fc_Tabela + ' where ' );
      For Lc_I := 0 to High(Fc_campo) do
      Begin
        if (Lc_I = 0) then
          SQL.Add(Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I])
        else
          SQL.Add(' and ' + Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I]);
      end;
      //Passagem de parametros
      For Lc_I := 0 to High(Fc_campo) do
        ParamByName(Fc_campo[lc_I]).AsString := Trim(Fc_valor[lc_I]);
      Active := True;
      FetchAll;
      if (RecordCount >0) then
      Begin
        For Lc_I := 0 to High(Fc_Retorno) do
        Begin
          Result.add(' ' +FieldByName(Fc_Retorno[Lc_I]).AsString);
        end;
      end
      else
      Begin
        Result.add(' 0') ;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function Fc_ApagarRegistro(Fc_Tabela:String;Fc_Campo : array of string;Fc_codigo : array of string):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_I : Integer;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('DELETE From ' + Fc_Tabela + ' where ');
      For Lc_I := 0 to High(Fc_campo) do
        Begin
        if (Lc_I = 0) then
          SQL.Add(Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I])
        else
          SQL.Add(' and ' + Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I]);
        end;
      //Passagem de parametros
      For Lc_I := 0 to High(Fc_campo) do
        ParamByName(Fc_campo[lc_I]).AsString := Fc_codigo[lc_I];
      Try
        ExecSQL;
        Result := 'OK';
      except
        Result := 'Falhou';
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


end.
