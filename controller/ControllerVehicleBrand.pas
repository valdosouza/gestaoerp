unit ControllerVehicleBrand;

interface

uses STDatabase,Classes, STQuery,SysUtils,ControllerBase,
      tblVehicleBrand ,Un_MSg,Generics.Collections;

Type
  TListaBrand = TObjectList<TVehicleBrand>;

  TControllerVehicleBrand = Class(TControllerBase)

  private

  protected

  public
    Registro : TVehicleBrand;
    Lista : TListaBrand;
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


constructor TControllerVehicleBrand.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVehicleBrand.Create;
  Lista := TListaBrand.Create;
end;

function TControllerVehicleBrand.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleBrand.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerVehicleBrand.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MARCAMODELO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerVehicleBrand.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_MARCAMODELO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerVehicleBrand.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleBrand.getById;
begin
  _getByKey(Registro);
end;

function TControllerVehicleBrand.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleBrand;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MARCA_VEICULO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TVehicleBrand.Create;
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
