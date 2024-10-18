unit ControllerTributacao;

interface
uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
       tblTributacao , System.Generics.Collections, prm_taxation;

Type
  TListaTributacao = TObjectList<TTributacao>;

  TControllerTributacao = Class(TControllerBase)

  private
    FParametros: TPrmTaxation;
    procedure setFParametros(const Value: TPrmTaxation);

  public
    Registro : TTributacao;
    Lista : TListaTributacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function insert:boolean;
    function salva:boolean;
    function migra:Boolean;
    procedure getList;
    procedure Clear;
    Function delete:boolean;

    property Parametros : TPrmTaxation read FParametros write setFParametros;
    procedure search;
  End;


implementation

{ TControllerTributacao }

uses Un_Regra_Negocio, ENV;

procedure TControllerTributacao.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerTributacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTributacao.Create;
  Lista := TListaTributacao.Create;
  FParametros := TPrmTaxation.Create;
end;

function TControllerTributacao.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTributacao.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

procedure TControllerTributacao.getById;
begin
  _getbykey(Registro);
end;

procedure TControllerTributacao.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TTributacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TRIBUTACAO ',
                      'WHERE TRB_CODIGO IS NOT NULL '
                    ));
      //Incremento SQL
      if Registro.Produto >0 then
        sql.add(' AND TRB_CODPRO =:TRB_CODPRO');
      //Passsagem de Parametros
      if Registro.Produto >0 then
        ParamByName('TRB_CODPRO').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TTributacao.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerTributacao.insert: boolean;
begin
  TRy
    Registro.Codigo := Generator('GN_TRIBUTACAO');
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

function TControllerTributacao.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerTributacao.salva: boolean;
begin
  TRy
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

procedure TControllerTributacao.setFParametros(const Value: TPrmTaxation);
begin
  FParametros := Value;
end;

procedure TControllerTributacao.search;
var
  Lc_Qry : TSTQuery;
  LITem : TTributacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        ' SELECT TRI.*, NAT_CFOP, UFE_SIGLA, ICMS_NR.TBI_GRUPO TRB_CST, ICMS_SN.TBI_GRUPO TRB_CSOSN, OBS.OBS_DESCRICAO '+
        '   FROM TB_TRIBUTACAO TRI '+
        '   JOIN TB_NATUREZA ON (NAT_CODIGO = TRB_CODNAT) '+
        '   LEFT OUTER JOIN TB_OBSERVACAO OBS ON (OBS.OBS_CODIGO = TRI.TRB_CODOBS) '+
        '   LEFT OUTER JOIN TB_UF UF ON (UF.UFE_CODIGO = TRI.TRB_ESTADO) '+
        '   LEFT OUTER JOIN TB_TRIB_ICMS_NR ICMS_NR ON (ICMS_NR.TBI_CODIGO =TRB_CODTBI_ICMS_NR) '+
        '   LEFT OUTER JOIN TB_TRIB_ICMS_SN ICMS_SN ON (ICMS_SN.TBI_CODIGO =TRB_CODTBI_ICMS_SN) '+
        '  WHERE TRB_CODIGO IS NOT NULL '+
        '    and TRI.TRB_CODMHA = :TRB_CODMHA ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODIGO = :TRB_CODIGO';
        ParamByName('TRB_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Estabelecimento > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODMHA = :TRB_CODMHA';
        ParamByName('TRB_CODMHA').AsInteger := FParametros.FieldName.Estabelecimento;
      end;

      if FParametros.FieldName.NCM <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CODIGONCM LIKE :TRB_CODIGONCM';
        ParamByName('TRB_CODIGONCM').AsString := Concat('%',FParametros.FieldName.NCM,'%');
      end;

      if FParametros.FieldName.Consumidor = SIGLA_S then
      begin
        SQL.Text := SQL.Text + ' AND TRB_CONSUMIDOR = :TRB_CONSUMIDOR';
        ParamByName('TRB_CONSUMIDOR').AsString := FParametros.FieldName.Consumidor;
      end;

      SQL.Text := SQL.Text + ' ORDER BY TRB_ESTADO, TRB_CONSUMIDOR, TRB_CODNAT ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTributacao.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        LITem.NAT_CFOP := Lc_Qry.FieldByName('NAT_CFOP').AsString;
        LITem.UFE_SIGLA := Lc_Qry.FieldByName('UFE_SIGLA').AsString;
        LITem.TRB_CST := Lc_Qry.FieldByName('TRB_CST').AsString;
        LITem.TRB_CSOSN := Lc_Qry.FieldByName('TRB_CSOSN').AsString;
        LITem.OBS_DESCRICAO := Lc_Qry.FieldByName('OBS_DESCRICAO').AsString;

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;
{
procedure TFr_Tributacao.PC_Buscar;
var
  Sqltxt:string;
  LC_CONSUM_FINAL, LC_CODUFE,LC_CODNAT, Lc_NCM:Boolean;

begin

  IF Fm_ListaCFOP_UF.Dblcb_lista.Text = '' THEN LC_CODNAT   :=FALSE ELSE LC_CODNAT:=True;
  IF Fm_ListaCFOP_UF.Fm_ListaBuscaEstado.DBLCB_UF.Text = '' THEN LC_CODUFE :=FALSE ELSE LC_CODUFE:=True;
  IF CHBX_BUSCA_CONSUMIDOR.Checked then LC_CONSUM_FINAL :=true Else LC_CONSUM_FINAL:=false;
  IF E_Busca_NCM.Text = '' THEN Lc_NCM   :=FALSE ELSE Lc_NCM:=True;

  sqltxt := '';
  Screen.Cursor:=crHourGlass;
  if Qr_Pesquisa.Transaction.InTransaction then Qr_Pesquisa.Transaction.Commit;
  if not Qr_Pesquisa.Transaction.InTransaction then Qr_Pesquisa.Transaction.StartTransaction;

  Qr_Pesquisa.Close;
  Qr_Pesquisa.Sql.Clear;

  Sqltxt := ' SELECT TRB_CODIGO, NAT_CFOP, UFE_SIGLA, TRB_CONSUMIDOR,TRB_MICRO, TRB_ORIGEM, '+
            ' ICMS_NR.TBI_GRUPO TRB_CST, ICMS_SN.TBI_GRUPO TRB_CSOSN, TRB_ST_ICMS, TRB_AQ_ICMS, '+
            ' TRB_RD_BS_ICMS,TRB_RD_AQ_ICMS, OBS_DESCRICAO, TRB_CODIGONCM '+
            ' FROM TB_TRIBUTACAO TRI '+
            '   INNER JOIN TB_NATUREZA '+
            '   ON (NAT_CODIGO = TRB_CODNAT) '+
            '   LEFT OUTER  JOIN TB_OBSERVACAO OBS'+
            '   ON (OBS.OBS_CODIGO = TRI.TRB_CODOBS) '+
            '   LEFT OUTER JOIN TB_UF UF '+
            '   ON (UF.UFE_CODIGO = TRI.TRB_ESTADO) '+
            '   LEFT OUTER JOIN TB_TRIB_ICMS_NR ICMS_NR '+
            '   ON (ICMS_NR.TBI_CODIGO =TRB_CODTBI_ICMS_NR) '+
            '   LEFT OUTER JOIN TB_TRIB_ICMS_SN ICMS_SN '+
            '   ON (ICMS_SN.TBI_CODIGO =TRB_CODTBI_ICMS_SN) '+
            ' WHERE (TRB_CODIGO IS NOT NULL) '+
            ' and TRI.TRB_CODMHA = :TRB_CODMHA ';

  if (Fm_ListaCFOP_UF.RG_Tipo_S_E.ItemIndex = 0) then
    Sqltxt:=Sqltxt+'AND (NAT_SENTIDO = ''S'') '
  else
    Sqltxt:=Sqltxt+'AND (NAT_SENTIDO = ''E'') ';

  if (FProduto > 0) then
    Sqltxt:=Sqltxt+'AND (TRB_CODPRO = :TRB_CODPRO) '
  ELSE
    Sqltxt:=Sqltxt+'AND (TRB_CODPRO = 0)';

  if (FEmpresa > 0) then
    Sqltxt:=Sqltxt+'AND (TRB_CODEMP = :TRB_CODEMP) '
  ELSE
    Sqltxt:=Sqltxt+'AND (TRB_CODEMP = 0)';

   IF LC_CODUFE THEN
    Sqltxt := Sqltxt + 'AND (TRB_ESTADO = :TRB_ESTADO) ';

   IF LC_CODNAT THEN
  Sqltxt := Sqltxt + 'AND TRB_CODNAT = :TRB_CODNAT ';

  if LC_CONSUM_FINAL then
     Sqltxt := Sqltxt + 'AND TRB_CONSUMIDOR = ''S'' ';

  if LC_NCM then
     Sqltxt := Sqltxt + 'AND TRB_CODIGONCM =:TRB_CODIGONCM ';

  Qr_Pesquisa.SQL.Add(sqltxt + ' ORDER BY  TRB_ESTADO, TRB_CONSUMIDOR, TRB_CODNAT ');

  if (FProduto > 0) then Qr_Pesquisa.ParamByName('TRB_CODPRO').AsInteger := FProduto;
  if (FEmpresa > 0) then Qr_Pesquisa.ParamByName('TRB_CODEMP').AsInteger := FEmpresa;

  IF LC_CODUFE THEN Qr_Pesquisa.ParamByName('TRB_ESTADO').AsInteger := Fm_ListaCFOP_UF.Fm_ListaBuscaEstado.DBLCB_UF.KeyValue;
  IF LC_CODNAT then Qr_Pesquisa.ParamByName('TRB_CODNAT').AsInteger := Fm_ListaCFOP_UF.Dblcb_Lista.KeyValue;
  IF LC_NCM then Qr_Pesquisa.ParamByName('TRB_CODIGONCM').AsString := E_Busca_NCM.Text;

  Qr_Pesquisa.ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;

  Qr_Pesquisa.Open;
  Screen.Cursor:=crDefault;
end;

}

end.
