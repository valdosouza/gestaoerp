unit ControllerMdfeConductor;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeConductor ,Un_MSg,Generics.Collections,
  ControllerColaborador;

Type

  TListaConductor = TObjectList<TMdfeConductor>;
  TControllerMdfeConductor = Class(TControllerBase)
  private

  public
    Registro : TMdfeConductor;
    Lista : TListaConductor;
    Colaborador : TControllerColaborador;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    function getlist:Boolean;
    procedure Clear;
  End;

implementation

{ TControllerMdfeConductor }

procedure TControllerMdfeConductor.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeConductor.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeConductor.Create;
  Lista := TListaConductor.Create;
  Colaborador := TControllerColaborador.Create(self);
end;

function TControllerMdfeConductor.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeConductor.Destroy;
begin
  Colaborador.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerMdfeConductor.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeConductor.getlist: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TMdfeconductor;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM tb_mdfe_conductor ',
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
        LITem := TMdfeConductor.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerMdfeConductor.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeConductor.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerMdfeConductor.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
