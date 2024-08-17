unit prm_interface;

interface

uses
  prm_base, tblInterface, System.SysUtils;

Type
  TPrmInterface = class(TPrmBase)
  private
    FFieldName: TInterface;
    procedure setFFieldName(const Value: TInterface);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TInterface read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmInterface.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmInterface.Create;
begin
  inherited;
  FFieldName := TInterface.Create;
end;

destructor TPrmInterface.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmInterface.setFFieldName(const Value: TInterface);
begin
  FFieldName := Value;
end;

end.
