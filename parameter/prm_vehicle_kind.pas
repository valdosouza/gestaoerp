unit prm_vehicle_kind;

interface

uses
  prm_base, tbltpveiculo, System.SysUtils;

Type
  TPrmVehicleKind = class(TPrmBase)
  private
    FFieldName: TTpVeiculo;
    procedure setFFieldName(const Value: TTpVeiculo);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTpVeiculo read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmVehicleKind.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmVehicleKind.Create;
begin
  FFieldName := TTpVeiculo.Create;
end;

destructor TPrmVehicleKind.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmVehicleKind.setFFieldName(const Value: TTpVeiculo);
begin
  FFieldName := Value;
end;

end.
