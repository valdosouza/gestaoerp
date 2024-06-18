unit RN_ServiceOrder;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase, classes,db;

  Function Fc_VerificaRegistro(Fc_Tabela,Fc_Campo,Fc_Codigo:String):Integer;
  function Fc_UpdateVehicleSo(Fc_INSTITUTION_ID,
                              Fc_TB_BUDGET_ID,
                              Fc_MOBILE,
                              Fc_TB_VEHICLE_ID:String):Integer;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio;


Function Fc_VerificaRegistro(Fc_Tabela,Fc_Campo,Fc_Codigo:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT VEI_CODIGO From ' + Fc_Tabela + ' where ' + Fc_Campo + ' =:' + Fc_Campo);
      ParamByName(Fc_Campo).AsString := Fc_Codigo;
      Active := True;
      FetchAll;
      Result := FieldByname('VEI_CODIGO').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_UpdateVehicleSo(Fc_TB_INSTITUTION_ID,
                            Fc_TB_BUDGET_ID,
                            Fc_MOBILE,
                            Fc_TB_VEHICLE_ID:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      IF Pc_CODIGO = 0 then
        Pc_CODIGO := Fc_VerificaRegistro('TB_VEICULO','VEI_PLACA',Pc_PLACA);
      if Pc_CODIGO > 0 then
      Begin
        SQL.Add('update "TB_VEHICLE_SO" set '+
                ' "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" = :"TB_BUDGET_ID" '+
                ', "MOBILE" = :"MOBILE" '+
                ', "TB_VEHICLE_ID" = :"TB_VEHICLE_ID" '+
                'where '+
                '  "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" and '+
                '  "TB_BUDGET_ID" = :"TB_BUDGET_ID" and '+
                '  "MOBILE" = :"MOBILE" ');
      end
      else
      Begin
       pc_CODIGO := Fc_Generator('GN_VEICULO','TB_VEICULO','VEI_CODIGO');
        SQL.Add('insert into "TB_VEHICLE_SO"( '+
                '  "TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" '+
                ', "MOBILE" '+
                ', "TB_VEHICLE_ID") '+
                'values( '+
                '  :"TB_INSTITUTION_ID" '+
                ', :"TB_BUDGET_ID" '+
                ', :"MOBILE" '+
                ', :"TB_VEHICLE_ID")');
      end;

      ParamByName('TB_INSTITUTION_ID').AsString := Fc_INSTITUTION_ID;
      ParamByName('TB_BUDGET_ID').AsString := Fc_TB_BUDGET_ID;
      ParamByName('MOBILE').AsString := Fc_INSTITUTION_ID;
      ParamByName('TB_VEHICLE_ID').AsString := Fc_INSTITUTION_ID;
      ExecSQL;
      Result := Pc_CODIGO;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


end.
