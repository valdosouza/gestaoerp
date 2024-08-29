unit prm_vehicle_brand;

interface

uses
  prm_base, tblvehiclebrand, System.SysUtils;

Type
  TPrmVehicleBrand = class(TPrmBase)
  private
    FFieldName: Tvehiclebrand;
    procedure setFFieldName(const Value: Tvehiclebrand);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : Tvehiclebrand read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmVehicleBrand.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmVehicleBrand.Create;
begin
  inherited;
  FFieldName := Tvehiclebrand.Create;
end;

destructor TPrmVehicleBrand.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmVehicleBrand.setFFieldName(const Value: Tvehiclebrand);
begin
  FFieldName := Value;
end;

end.
