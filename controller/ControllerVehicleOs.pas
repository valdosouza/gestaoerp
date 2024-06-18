unit ControllerVehicleOs;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblVehicleOs, controllerVehicle ,Un_MSg;

Type
  TControllerVehicleOs = Class(TControllerBase)
  private

  public
    Registro : TVehicleOs;
    Vehicle :  TcontrollerVehicle;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getByCotacao;
    procedure getByPedido;
    procedure getbyId;
    Function delete:boolean;
    procedure clear;
  End;

implementation

uses RN_Estoque, RN_Produto;

procedure TControllerVehicleOs.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerVehicleOs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVehicleOs.Create;
  Vehicle := TcontrollerVehicle.create(Self);
end;

function TControllerVehicleOs.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleOs.Destroy;
begin
  FreeAndNil(Vehicle);
  Registro.DisposeOf;
  inherited;
end;


function TControllerVehicleOs.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerVehicleOs.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerVehicleOs.getByCotacao;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add('SELECT * FROM TB_VEHICLE_SO '+
              'WHERE (TB_INSTITUTION_ID =:TB_INSTITUTION_ID) '+
              ' AND ( TB_BUDGET_ID =:TB_BUDGET_ID )');
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.CodigoEstabelecimento;
      ParamByName('TB_BUDGET_ID').AsInteger := Registro.CodigoCotacao;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerVehicleOs.getByPedido;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add('SELECT * FROM TB_VEHICLE_SO '+
              'WHERE (TB_INSTITUTION_ID =:TB_INSTITUTION_ID) '+
              ' AND (TB_ORDER_ID =:TB_ORDER_ID)');
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.CodigoEstabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;


end.
