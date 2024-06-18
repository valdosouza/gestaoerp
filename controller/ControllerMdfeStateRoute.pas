unit ControllerMdfeStateRoute;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeStateRoute ,Un_MSg,Generics.Collections, dbClient,
      ControllerUf;

Type
  TListaStateRoute = TObjectList<TMdfeStateRoute>;

  TControllerMdfeStateRoute = Class(TControllerBase)
    Lista : TListaStateRoute;
  private

  public
    Registro : TMdfeStateRoute;
    Uf : TControllerUf;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    procedure Clear;
    function getlist: Boolean;
  End;

implementation

{ TControllerMdfeStateRoute }

procedure TControllerMdfeStateRoute.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeStateRoute.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeStateRoute.Create;
  Lista := TListaStateRoute.Create;
  Uf := TControllerUf.Create(self);
end;

function TControllerMdfeStateRoute.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeStateRoute.Destroy;
begin
  Uf.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeStateRoute.getbyId;
begin
  _getByKey(Registro);

end;

function TControllerMdfeStateRoute.insere: boolean;
begin

  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeStateRoute.salva: boolean;
begin
  SaveObj(Registro);

end;

function TControllerMdfeStateRoute.update: Boolean;
begin
   Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeStateRoute.getlist:Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TMdfeStateRoute ;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat('SELECT * ',
                     'FROM tb_mdfe_state_route ',
                     'WHERE tb_institution_id=:tb_institution_id ',
                     'and tb_mdfe_id=:tb_mdfe_id '
          ));
      ParamByName('tb_institution_id').AsInteger := REgistro.Estabelecimento;
      ParamByName('tb_mdfe_id').AsInteger := REgistro.MDFE;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMdfeStateRoute.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.
