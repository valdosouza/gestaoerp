unit RN_VehicleSo;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,   classes,db,ControllerBase;
  
  function Fc_UpdateVehicleSo(Fc_TB_INSTITUTION_ID,
                              Fc_TB_BUDGET_ID,
                              Fc_MOBILE,
                              Fc_TB_VEHICLE_ID,
                              fc_tb_Order_Id:String):Integer;


implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, RN_Crud;


function Fc_UpdateVehicleSo(Fc_TB_INSTITUTION_ID,
                            Fc_TB_BUDGET_ID,
                            Fc_MOBILE,
                            Fc_TB_VEHICLE_ID,
                            fc_tb_Order_Id:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Result:TStringList;
  LcBase : TControllerBase;
begin
  try
    Lc_Result := TStringList.Create;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
       //REsultado
      Lc_Result := Fc_VerificaRegistro('tb_vehicle_so',['TB_INSTITUTION_ID','TB_BUDGET_ID','MOBILE'],[Fc_TB_INSTITUTION_ID,Fc_TB_BUDGET_ID,Fc_MOBILE],['TB_BUDGET_ID']);
      if (StrToIntDef(Lc_Result.ValueFromIndex[0],0) >0) then
      Begin
        SQL.Add('update "TB_VEHICLE_SO" set '+
                ' "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" = :"TB_BUDGET_ID" '+
                ', "MOBILE" = :"MOBILE" '+
                ', "TB_VEHICLE_ID" = :"TB_VEHICLE_ID" '+
                ', "TB_ORDER_ID" = :"TB_ORDER_ID" '+
                'where '+
                '  "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" and '+
                '  "TB_BUDGET_ID" = :"TB_BUDGET_ID" and '+
                '  "MOBILE" = :"MOBILE" ');
      end
      else
      Begin
        SQL.Add('insert into "TB_VEHICLE_SO"( '+
                '  "TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" '+
                ', "MOBILE" '+
                ', "TB_VEHICLE_ID" '+
                ', "TB_ORDER_ID") '+
                'values( '+
                '  :"TB_INSTITUTION_ID" '+
                ', :"TB_BUDGET_ID" '+
                ', :"MOBILE" '+
                ', :"TB_VEHICLE_ID" '+
                ', :"TB_ORDER_ID") ');
      end;

      ParamByName('TB_INSTITUTION_ID').AsAnsiString := Fc_TB_INSTITUTION_ID;
      ParamByName('TB_BUDGET_ID').AsAnsiString := Fc_TB_BUDGET_ID;
      ParamByName('MOBILE').AsAnsiString := Fc_MOBILE;
      ParamByName('TB_VEHICLE_ID').AsAnsiString := Fc_TB_VEHICLE_ID;
      ParamByName('TB_ORDER_ID').AsAnsiString := fc_tb_Order_Id;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


end.
