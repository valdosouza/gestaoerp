unit RN_Veiculo;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase, classes,db,ControllerBase;

  Function Fc_VerificaRegistro(Fc_Tabela,Fc_Campo,Fc_Codigo:String):Integer;  
  function Fc_AtualizaVeiculo(Pc_CODIGO: integer;
                               Pc_CODEMP: integer;
                               Pc_PLACA:String;
                               Pc_FROTA: String;
                               Pc_CODTPV: integer;
                               Pc_CODMRC: integer;
                               Pc_CODMOD: integer;
                               Pc_ANO:String;
                               Pc_CODCOR: integer;
                               Pc_CILINDRADA: integer;
                               Pc_KM:String):Integer;

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
      ParamByName(Fc_Campo).AsAnsiString := Fc_Codigo;
      Active := True;
      FetchAll;
      Result := FieldByname('VEI_CODIGO').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_AtualizaVeiculo( Pc_CODIGO: integer;
                            Pc_CODEMP: integer;
                            Pc_PLACA:String;
                            Pc_FROTA: String;
                            Pc_CODTPV: integer;
                            Pc_CODMRC: integer;
                            Pc_CODMOD: integer;
                            Pc_ANO:String;
                            Pc_CODCOR: integer;
                            Pc_CILINDRADA: integer;
                            Pc_KM:String):Integer;
Var
  Lc_Qry:TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    IF Pc_CODIGO = 0 then
      Pc_CODIGO := Fc_VerificaRegistro('TB_VEICULO','VEI_PLACA',Pc_PLACA);
    if Pc_CODIGO > 0 then
      Begin
      SQL.Add('update "TB_VEICULO" set '+
              '  "VEI_CODEMP" = :"VEI_CODEMP" '+
              ', "VEI_PLACA" = :"VEI_PLACA" '+
              ', "VEI_FROTA" = :"VEI_FROTA" '+
              ', "VEI_CODTPV" = :"VEI_CODTPV" '+
              ', "VEI_CODMRC" = :"VEI_CODMRC" '+
              ', "VEI_CODMOD" = :"VEI_CODMOD" '+
              ', "VEI_ANO" = :"VEI_ANO" '+
              ', "VEI_KM" = :"VEI_KM" '+
              ', "VEI_CODCOR" = :"VEI_CODCOR" '+
              ', "VEI_CILINDRADA" = :"VEI_CILINDRADA" '+
              'where "VEI_CODIGO" = :"VEI_CODIGO" ');
      end
    else
      Begin
     pc_CODIGO := Fc_Generator('GN_VEICULO','TB_VEICULO','VEI_CODIGO');
      SQL.Add('insert into "TB_VEICULO"( '+
              '  "VEI_CODIGO" '+
              ', "VEI_CODEMP" '+
              ', "VEI_PLACA" '+
              ', "VEI_FROTA" '+
              ', "VEI_CODTPV" '+
              ', "VEI_CODMRC" '+
              ', "VEI_CODMOD" '+
              ', "VEI_ANO" '+
              ', "VEI_KM" '+
              ', "VEI_CODCOR" '+
              ', "VEI_CILINDRADA") '+
              'values( '+
              '  :"VEI_CODIGO" '+
              ', :"VEI_CODEMP" '+
              ', :"VEI_PLACA" '+
              ', :"VEI_FROTA" '+
              ', :"VEI_CODTPV" '+
              ', :"VEI_CODMRC" '+
              ', :"VEI_CODMOD" '+
              ', :"VEI_ANO" '+
              ', :"VEI_KM" '+
              ', :"VEI_CODCOR" '+
              ', :"VEI_CILINDRADA") ');
      end;

    ParamByName('VEI_CODIGO').Value := Pc_CODIGO;
    ParamByName('VEI_CODEMP').Value := Pc_CODEMP;
    ParamByName('VEI_PLACA').Value := Pc_PLACA;
    ParamByName('VEI_FROTA').Value := Pc_FROTA;
    ParamByName('VEI_CODTPV').Value := Pc_CODTPV;
    ParamByName('VEI_CODMRC').Value := Pc_CODMRC;
    ParamByName('VEI_CODMOD').Value := Pc_CODMOD;
    ParamByName('VEI_ANO').Value := Pc_ANO;
    ParamByName('VEI_CODCOR').Value := Pc_CODCOR;
    ParamByName('VEI_CILINDRADA').Value := Pc_CILINDRADA;
    ParamByName('VEI_KM').Value := Pc_KM;
    ExecSQL;
    if Transaction.InTransaction then Transaction.CommitRetaining;
    Result := Pc_CODIGO;
    end;
end;


end.
