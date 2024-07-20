unit ControllerMdfeunLoadLocal;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
     dbClient, tblMdfeLoadLocal ,Un_MSg,Generics.Collections,
  ControllerCidade, TblMdfeUnloadLocal;

Type
  TListaUnloadlocal = TObjectList<TMdfeUnloadLocal>;

  TControllerMdfeUnloadLocal = Class(TControllerBase)
  private

  public
    Registro : TMdfeUnloadLocal;
    Lista : TListaUnloadlocal;
    Cidade : TControllerCidade;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    function getlist:Boolean;
    function getchave:TStringList;
    procedure Clear;
  End;

implementation

{ TControllerMdfeUnloadLocal }

procedure TControllerMdfeUnloadLocal.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeUnloadLocal.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeUnloadLocal.Create;
  Lista := TListaUnloadlocal.Create;
  Cidade := TControllerCidade.Create(Self);
end;

function TControllerMdfeUnloadLocal.delete: boolean;
begin
   Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeUnloadLocal.Destroy;
begin
  Cidade.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeUnloadLocal.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeUnloadLocal.getchave: TStringList;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat(
                'SELECT R.nfe_arquivo ',
                'FROM tb_retorno_nfe R ',
                '  INNER JOIN tb_nota_fiscal N ',
                '  ON (N.nfl_codigo = R.nfe_codnfl) ',
                '  INNER JOIN TB_PEDIDO P ',
                '  ON (P.ped_codigo = N.nfl_codped) ',
                '  INNER JOIN TB_ENDERECO E ',
                '  ON (E.end_codigo = P.PED_CODEND) ',
                '  INNER JOIN TB_CIDADE C ',
                '  ON (C.cdd_codigo = E.END_CODCDD) ',
                '  INNER JOIN tb_mdfe_nfe MN ',
                '  ON (MN.tb_invoice_id = N.nfl_codigo) ',
                'WHERE C.cdd_codigo =:CDD_CODIGO ',
                'AND MN.tb_institution_id =:tb_institution_id ',
                'AND MN.tb_mdfe_id=:tb_mdfe_id '
              ));
      ParamByName('tb_institution_id').AsInteger  := REgistro.Estabelecimento;
      ParamByName('tb_mdfe_id').AsInteger         := REgistro.MDFE;
      ParamByName('CDD_CODIGO').AsInteger         := REgistro.Cidade;
      Active := True;
      FetchAll;
      First;
      Result := TStringList.Create;
      while not eof  do
      begin
        Result.Append(Copy(FieldByName('nfe_arquivo').AsString,1,44));
        next;
      end;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerMdfeUnloadLocal.getlist:Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TMdfeUnloadLocal;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM tb_mdfe_Unload_local ',
                'WHERE (tb_institution_id=:tb_institution_id) ',
                'and (tb_mdfe_id=:tb_mdfe_id )'
              ));
      ParamByName('tb_institution_id').AsInteger := REgistro.Estabelecimento;
      ParamByName('tb_mdfe_id').AsInteger := REgistro.MDFE;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMdfeUnloadLocal.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerMdfeUnloadLocal.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeUnloadLocal.salva: boolean;
begin
  SaveObj(Registro);

end;

function TControllerMdfeUnloadLocal.update: Boolean;
begin
    Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
