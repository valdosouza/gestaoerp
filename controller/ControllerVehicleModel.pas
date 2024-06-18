unit ControllerVehicleModel;

interface

uses STDatabase,Classes, STQuery,SysUtils,ControllerBase,
      tblVehicleModel ,Un_MSg,Generics.Collections;

Type
  TListaModel = TObjectList<TVehicleModel>;

  TControllerVehicleModel = Class(TControllerBase)

  private

  public
    Registro : TVehicleModel;
    Lista : TListaModel;
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


constructor TControllerVehicleModel.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVehicleModel.Create;
  Lista := TListaModel.Create;
end;

function TControllerVehicleModel.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleModel.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerVehicleModel.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MODELO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerVehicleModel.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_MODELO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerVehicleModel.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleModel.getById;
begin
  _getByKey(Registro);
end;

function TControllerVehicleModel.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleModel;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MODELO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TVehicleModel.Create;
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
