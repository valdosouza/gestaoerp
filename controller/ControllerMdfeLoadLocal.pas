unit ControllerMdfeLoadLocal;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
     dbClient, tblMdfeLoadLocal ,Un_MSg,Generics.Collections,
  ControllerCidade;

Type
  TListaLoadlocal = TObjectList<TMdfeLoadLocal>;

  TControllerMdfeLoadLocal = Class(TControllerBase)
  private

  public
    Registro : TMdfeLoadLocal;
    Lista : TListaLoadlocal;
    Cidade : TControllerCidade;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure Clear;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    function getlist:Boolean;
  End;

implementation

{ TControllerMdfeLoadLocal }

procedure TControllerMdfeLoadLocal.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeLoadLocal.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeLoadLocal.Create;
  Lista := TListaLoadlocal.Create;
  Cidade := TControllerCidade.Create(Self);
end;

function TControllerMdfeLoadLocal.delete: boolean;
begin
   Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeLoadLocal.Destroy;
begin
  Cidade.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeLoadLocal.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeLoadLocal.getlist:Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TMdfeLoadLocal;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM tb_mdfe_load_local ',
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
        LITem := TMdfeLoadLocal.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerMdfeLoadLocal.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeLoadLocal.salva: boolean;
begin
  SaveObj(Registro);

end;

function TControllerMdfeLoadLocal.update: Boolean;
begin
    Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
