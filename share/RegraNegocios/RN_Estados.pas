unit RN_Estados;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,FireDAC.Stan.Param;

  function Fc_GetInscrSubstTributario(Fc_Estado:String):String;
  procedure Pc_AliquotasUF(Pc_Uf: Integer;Pc_NCM,Pc_OptanteSimples:string);
  function Fc_BuscaCodigoEstado(Fc_Sigla:String): Integer;
  function Fc_BuscaSiglaEstado(Fc_Cd_Ufe:Integer): String;

implementation

uses Un_DM, STDataSet, Un_Regra_Negocio, UN_Sistema, ControllerBase;


function Fc_GetInscrSubstTributario(Fc_Estado:String):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('SELECT UFE_NUMINSC_SUBS FROM TB_UF WHERE  UFE_SIGLA =:UFE_SIGLA');
      ParamByName('UFE_SIGLA').AsAnsiString := Fc_Estado;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        Result := FieldByName('UFE_NUMINSC_SUBS').AsAnsiString
      else
        Result := '';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_AliquotasUF(Pc_Uf: Integer;Pc_NCM,Pc_OptanteSimples:string);
begin
  with DM do
  begin
    Qr_Uf_Mva_NCM.Active := False;
    Qr_Uf_Mva_NCM.ParamByName('UFE_CODIGO').AsInteger := Pc_Uf;
    Qr_Uf_Mva_NCM.Active := True;
    Qr_Uf_Mva_NCM.First;
    //Aliquota interna do Estado de DEstino
    Gb_Aq_St_ICMS := Qr_Uf_Mva_NCM.FieldByname('UFE_ALIQ_INTERNA').AsFloat;
    //Margem de Valor Agregado
    Gb_Mg_VA_St_Icms := Qr_Uf_Mva_NCM.FieldByname('UFE_MR_VL_AGREGADO').AsFloat;
    //Verifica se precisamos pegar o MVA de um NCM especifico
    if Trim(Pc_NCM)<> '' then
      Begin
      IF (Qr_Uf_Mva_NCM.Locate('MUN_CODIGONCM', Pc_NCM, [])) then
        Begin
        Gb_Mg_VA_St_Icms := Qr_Uf_Mva_NCM.FieldByname('MUN_MR_VL_AGREGADO').AsFloat;
        end;
      end;
    //Caso seja empesa optante pelo Simples deixar 50% da aliquota
    if Pc_OptanteSimples = 'S' then
      Begin
      if (Gb_Mg_VA_St_Icms > 0) then
        Begin
        if (Fc_Tb_Geral('L','GRL_G_DECRETO108352014','N') = 'S') then
          Begin
          //Verifica se o Estado é de Santa Catarina
          if (Qr_Uf_Mva_NCM.FieldByname('UFE_SIGLA').AsAnsiString = 'SC') then
            Begin
            Gb_Mg_VA_St_Icms := ((Gb_Mg_VA_St_Icms - 1) * 0.3) + 1
            end
          else
            Begin
            if (Gb_Aq_St_ICMS >= 18) then
              Gb_Mg_VA_St_Icms := ((Gb_Mg_VA_St_Icms - 1) * 0.3) + 1
            else;
              Gb_Mg_VA_St_Icms := ((Gb_Mg_VA_St_Icms - 1) * 0.5) + 1
            end;
          end;
        end;
      end;
    end;
end;

function Fc_BuscaCodigoEstado(Fc_Sigla:String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select UFE_CODIGO FROM TB_UF WHERE UFE_SIGLA=:UFE_SIGLA');
      ParamByName('UFE_SIGLA').AsAnsiString := UpperCase( Fc_Sigla);
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('UFE_CODIGO').AsInteger
      else
        Result := 41;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaSiglaEstado(Fc_Cd_Ufe:Integer): String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select UFE_SIGLA FROM TB_UF WHERE UFE_CODIGO=:UFE_CODIGO');
      ParamByName('UFE_CODIGO').AsInteger := Fc_Cd_Ufe;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('UFE_SIGLA').AsAnsiString
      else
        Result := 'PR';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

end.
