unit ControllercCargo;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblCargo ,Un_MSg,System.Generics.Collections;

Type
  TListaCargo = TObjectList<TCargo>;

  TControllerCargo = Class(TControllerBase)

  private

  public
    Registro : TCargo;
    Lista : TListaCargo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerCargo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCargo.Create;
  Lista := TListaCargo.Create;
end;

function TControllerCargo.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCargo.Destroy;
begin
  Registro.DisposeOf;
  lista.DisposeOf;
  inherited;
end;

function TControllerCargo.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARGO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCargo.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARGO');
  SaveObj(Registro);
end;

function TControllerCargo.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCargo.getById;
begin
  _getByKey(Registro);
end;


function TControllerCargo.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TCargo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CARGO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TCargo.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;


end.
