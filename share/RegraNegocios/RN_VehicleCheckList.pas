unit RN_VehicleCheckList;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,  classes,db,ControllerBase;

  function Fc_UpdateVehicleCheckList(TB_INSTITUTION_ID,
                                      TB_BUDGET_ID,
                                      TB_ORDER_ID,
                                      MOBILE,
                                      CHECKLIST,
                                      KM,
                                      FUEL,
                                      ABS,
                                      CIGARETTE_LIGHTER,
                                      AERIAL,
                                      CONDITIONED_AIR,
                                      HOT_AIR,
                                      HUB_CAPS,
                                      WRENCH,
                                      HYDRAULIC_STEERING,
                                      DOCTS,
                                      EXTINGUISHER,
                                      HOIST,
                                      MANUAL,
                                      FRONT_TYRE,
                                      STEPE_TYRE,
                                      BACK_TYRE,
                                      RADIO,
                                      CARPET,
                                      TRIANGLE,
                                      VALVES,
                                      OTHER,
                                      OBS,
                                      ENTRANCE_DATE,
                                      ENTRANCE_HOUR,
                                      PRISMA:String):Integer;


implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, RN_Crud;



  function Fc_UpdateVehicleCheckList(TB_INSTITUTION_ID,
                                      TB_BUDGET_ID,
                                      TB_ORDER_ID,
                                      MOBILE,
                                      CHECKLIST,
                                      KM,
                                      FUEL,
                                      ABS,
                                      CIGARETTE_LIGHTER,
                                      AERIAL,
                                      CONDITIONED_AIR,
                                      HOT_AIR,
                                      HUB_CAPS,
                                      WRENCH,
                                      HYDRAULIC_STEERING,
                                      DOCTS,
                                      EXTINGUISHER,
                                      HOIST,
                                      MANUAL,
                                      FRONT_TYRE,
                                      STEPE_TYRE,
                                      BACK_TYRE,
                                      RADIO,
                                      CARPET,
                                      TRIANGLE,
                                      VALVES,
                                      OTHER,
                                      OBS,
                                      ENTRANCE_DATE,
                                      ENTRANCE_HOUR,
                                      PRISMA:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Result:TStringList;
  LcBase : TControllerBase;
begin
  Try
    Lc_Result := TStringList.Create;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      //REsultado
      Lc_Result := Fc_VerificaRegistro('TB_VEHICLE_CHECKLIST',['TB_INSTITUTION_ID','TB_BUDGET_ID','TB_ORDER_ID'],
                                                              [TB_INSTITUTION_ID,TB_BUDGET_ID,TB_ORDER_ID],
                                                              ['TB_INSTITUTION_ID','TB_BUDGET_ID','TB_ORDER_ID']);

      if (StrToIntDef( Trim( Lc_Result.Strings[0] ) ,0 )>0) then
      Begin
        SQL.Add('update "TB_VEHICLE_CHECKLIST" set '+
                '   "TB_INSTITUTION_ID" = :"TB_INSTITUTION_ID" '+
                '  ,"TB_BUDGET_ID" = :"TB_BUDGET_ID" '+
                '  ,"TB_ORDER_ID" =:"TB_ORDER_ID" '+
                '  , "MOBILE" = :"MOBILE" '+
                '  , "CHECKLIST" = :"CHECKLIST" '+
                '  , "KM" = :"KM" '+
                '  , "FUEL" = :"FUEL" '+
                '  , "ABS" = :"ABS" '+
                '  , "CIGARETTE_LIGHTER" = :"CIGARETTE_LIGHTER" '+
                '  , "AERIAL" = :"AERIAL" '+
                '  , "CONDITIONED_AIR" = :"CONDITIONED_AIR" '+
                '  , "HOT_AIR" = :"HOT_AIR" '+
                '  , "HUB_CAPS" = :"HUB_CAPS" '+
                '  , "WRENCH" = :"WRENCH" '+
                '  , "HYDRAULIC_STEERING" = :"HYDRAULIC_STEERING" '+
                '  , "DOCTS" = :"DOCTS" '+
                '  , "EXTINGUISHER" = :"EXTINGUISHER" '+
                '  , "HOIST" = :"HOIST" '+
                '  , "MANUAL" = :"MANUAL" '+
                '  , "FRONT_TYRE" = :"FRONT_TYRE" '+
                '  , "STEPE_TYRE" = :"STEPE_TYRE" '+
                '  , "BACK_TYRE" = :"BACK_TYRE" '+
                '  , "RADIO" = :"RADIO" '+
                '  , "CARPET" = :"CARPET" '+
                '  , "TRIANGLE" = :"TRIANGLE" '+
                '  , "VALVES" = :"VALVES" '+
                '  , "OTHER" = :"OTHER" '+
                '  , "OBS" = :"OBS" '+
                '  , "ENTRANCE_DATE" = :"ENTRANCE_DATE" '+
                '  , "ENTRANCE_HOUR" = :"ENTRANCE_HOUR" '+
                '  , PRISMA =:PRISMA '+
                '  where '+
                '    "TB_INSTITUTION_ID" =:"TB_INSTITUTION_ID" and '+
                '    "TB_BUDGET_ID" =:"TB_BUDGET_ID" and '+
                '    "TB_ORDER_ID" =:"TB_ORDER_ID" ');
      end
      else
      Begin
        SQL.Add('insert into "TB_VEHICLE_CHECKLIST"( '+
                '  "TB_INSTITUTION_ID" '+
                ', "TB_BUDGET_ID" '+
                ', "TB_ORDER_ID" '+
                ', "MOBILE" '+
                ', "CHECKLIST" '+
                ', "KM" '+
                ', "FUEL" '+
                ', "ABS" '+
                ', "CIGARETTE_LIGHTER" '+
                ', "AERIAL" '+
                ', "CONDITIONED_AIR" '+
                ', "HOT_AIR" '+
                ', "HUB_CAPS" '+
                ', "WRENCH" '+
                ', "HYDRAULIC_STEERING" '+
                ', "DOCTS" '+
                ', "EXTINGUISHER" '+
                ', "HOIST" '+
                ', "MANUAL" '+
                ', "FRONT_TYRE" '+
                ', "STEPE_TYRE" '+
                ', "BACK_TYRE" '+
                ', "RADIO" '+
                ', "CARPET" '+
                ', "TRIANGLE" '+
                ', "VALVES" '+
                ', "OTHER" '+
                ', "OBS" '+
                ', "ENTRANCE_DATE" '+
                ', "ENTRANCE_HOUR" '+
                ', PRISMA) '+
                'values( '+
                '  :"TB_INSTITUTION_ID" '+
                ', :"TB_BUDGET_ID" '+
                ', :"TB_ORDER_ID" '+
                ', :"MOBILE" '+
                ', :"CHECKLIST" '+
                ', :"KM" '+
                ', :"FUEL" '+
                ', :"ABS" '+
                ', :"CIGARETTE_LIGHTER" '+
                ', :"AERIAL" '+
                ', :"CONDITIONED_AIR" '+
                ', :"HOT_AIR" '+
                ', :"HUB_CAPS" '+
                ', :"WRENCH" '+
                ', :"HYDRAULIC_STEERING" '+
                ', :"DOCTS" '+
                ', :"EXTINGUISHER" '+
                ', :"HOIST" '+
                ', :"MANUAL" '+
                ', :"FRONT_TYRE" '+
                ', :"STEPE_TYRE" '+
                ', :"BACK_TYRE" '+
                ', :"RADIO" '+
                ', :"CARPET" '+
                ', :"TRIANGLE" '+
                ', :"VALVES" '+
                ', :"OTHER" '+
                ', :"OBS" '+
                ', :"ENTRANCE_DATE" '+
                ', :"ENTRANCE_HOUR" '+
                ', :PRISMA)');
      end;

      ParamByName('TB_INSTITUTION_ID').AsAnsiString :=  TB_INSTITUTION_ID;
      ParamByName('TB_BUDGET_ID').AsAnsiString := TB_BUDGET_ID ;
      ParamByName('TB_ORDER_ID').AsAnsiString := TB_ORDER_ID;
      ParamByName('MOBILE').AsAnsiString := MOBILE;
      ParamByName('CHECKLIST').AsAnsiString := CHECKLIST;
      ParamByName('KM').AsAnsiString := KM;
      ParamByName('FUEL').AsAnsiString := FUEL;
      ParamByName('ABS').AsAnsiString :=      ABS;
      ParamByName('CIGARETTE_LIGHTER').AsAnsiString := CIGARETTE_LIGHTER;
      ParamByName('AERIAL').AsAnsiString := AERIAL;
      ParamByName('CONDITIONED_AIR').AsAnsiString :=CONDITIONED_AIR;
      ParamByName('HOT_AIR').AsAnsiString := HOT_AIR;
      ParamByName('HUB_CAPS').AsAnsiString := HUB_CAPS;
      ParamByName('WRENCH').AsAnsiString := WRENCH;
      ParamByName('HYDRAULIC_STEERING').AsAnsiString := HYDRAULIC_STEERING;
      ParamByName('DOCTS').AsAnsiString := DOCTS;
      ParamByName('EXTINGUISHER').AsAnsiString := EXTINGUISHER;
      ParamByName('HOIST').AsAnsiString := HOIST;
      ParamByName('MANUAL').AsAnsiString := MANUAL;
      ParamByName('FRONT_TYRE').AsAnsiString :=FRONT_TYRE;
      ParamByName('STEPE_TYRE').AsAnsiString := STEPE_TYRE;
      ParamByName('BACK_TYRE').AsAnsiString := BACK_TYRE;
      ParamByName('RADIO').AsAnsiString := RADIO;
      ParamByName('CARPET').AsAnsiString := CARPET;
      ParamByName('TRIANGLE').AsAnsiString := TRIANGLE;
      ParamByName('VALVES').AsAnsiString := VALVES;
      ParamByName('OTHER').AsAnsiString := OTHER;
      ParamByName('OBS').AsAnsiString := OBS;
      ParamByName('ENTRANCE_DATE').AsAnsiString := ENTRANCE_DATE;
      ParamByName('ENTRANCE_HOUR').AsAnsiString := ENTRANCE_HOUR;
      ParamByName('PRISMA').AsAnsiString := PRISMA;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

end.
