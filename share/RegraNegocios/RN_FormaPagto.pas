unit RN_FormaPagto;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db, ControllerFormaPagamento;


   function Fc_PegaParteFormaPgto(Fc_Descricao: String): Integer;
   function Fc_PegaFormaPgto(Fc_Descricao: String): Integer;
   function getIdFormaPgto(Fc_Descricao: String;Parts:String ): Integer;

   function Fc_PegaCentroCustoFormaPagto(Fc_Cd_FormaPagto: Integer): Integer;
   function Fc_PegaContaResultadoFormaPagto(Fc_Cd_FormaPagto: Integer): Integer;

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_Regra_Negocio, ControllerBase;


function Fc_PegaParteFormaPgto(Fc_Descricao: String): Integer;
var
  LcForma : TControllerFormaPagamento;
begin
  try
    LcForma := TControllerFormaPagamento.Create(nil);
    LcForma.Registro.Descricao := Fc_Descricao;
    LcForma.getByPartDescription;
    if not LcForma.exist then
      LcForma.autocreate(Fc_Descricao);

    Result:= LcForma.Registro.Codigo;
  finally
    LcForma.disposeOf;
  end;
end;

function Fc_PegaFormaPgto(Fc_Descricao: String): Integer;
var
  LcForma : TControllerFormaPagamento;
begin
  try
    LcForma := TControllerFormaPagamento.Create(nil);
    LcForma.Registro.Descricao := Fc_Descricao;
    LcForma.getByDescricao;
    if not LcForma.exist then
      LcForma.autocreate(Fc_Descricao);

    Result:= LcForma.Registro.Codigo;
  finally
    LcForma.disposeOf;
  end;
end;

function getIdFormaPgto(Fc_Descricao: String;Parts:String ): Integer;
Begin
  if (Parts = 'P' ) then
    Result := Fc_PegaFormaPgto(Fc_Descricao)
  else
    Result := Fc_PegaParteFormaPgto(Fc_Descricao);
End;

function Fc_PegaCentroCustoFormaPagto(Fc_Cd_FormaPagto: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' select FPT_CODPLC_D ',
                ' from TB_FORMAPAGTO ',
                ' WHERE FPT_CODIGO =:FPT_CODIGO '
      ));
      ParamByName('FPT_CODIGO').AsInteger:= Fc_Cd_FormaPagto;
      Active := True;
      FetchAll;
      if (RecordCount >= 1) then
        Result:= FIELDBYNAME('FPT_CODPLC_D').AsInteger
      else
        Result:= 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_PegaContaResultadoFormaPagto(Fc_Cd_FormaPagto: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' select FPT_CODPLC_C ',
                ' from TB_FORMAPAGTO ',
                ' WHERE FPT_CODIGO =:FPT_CODIGO '
      ));
      ParamByName('FPT_CODIGO').AsInteger:= Fc_Cd_FormaPagto;
      Active := True;
      FetchAll;
      if (RecordCount >= 1) then
        Result:= FIELDBYNAME('FPT_CODPLC_C').AsInteger
      else
        Result:= 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

end.
