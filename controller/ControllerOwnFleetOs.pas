unit ControllerOwnFleetOs;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblOwnFleetOs ,Un_MSg,Generics.Collections,prmbase,ControllerVehicle;

Type
  TListaOwnFleetOs = TObjectList<TOwnFleetOs>;


  TControllerOwnFleetOs = Class(TControllerBase)
  private
    function getNextNumero:Integer;
  public
    Registro : TOwnFleetOs;
    Vehicle : TControllerVehicle;
    Lista : TListaOwnFleetOs;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure clear;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerOwnFleetOs.clear;
begin
  clearObj(Registro);
end;

constructor TControllerOwnFleetOs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOwnFleetOs.Create;
  Lista := TListaOwnFleetOs.Create;
  Vehicle := TControllerVehicle.Create(Self);
end;

function TControllerOwnFleetOs.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


destructor TControllerOwnFleetOs.Destroy;
begin
  Vehicle.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerOwnFleetOs.insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextNumero;

    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;



function TControllerOwnFleetOs.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextNumero;

    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerOwnFleetOs.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerOwnFleetOs.getById;
begin
  _getByKey(Registro);
  Vehicle.Registro.Placa := Registro.Placa;
  Vehicle.getAll;
end;

function TControllerOwnFleetOs.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TOwnFleetOs;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_OWN_FLEET_OS '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TOwnFleetOs.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;



function TControllerOwnFleetOs.getNextNumero: Integer;
var
  Lc_Qry : TSTQuery;
  LITem : TOwnFleetOs;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT MAX(ID) ID ',
                      'FROM TB_OWN_FLEET_OS '));
      Active := True;
      FetchAll;
      if recordCount > 0 then
        Result := FieldByName('ID').AsInteger + 1
      else
        Result := 1;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
