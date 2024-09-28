unit prm_coating;

interface

uses
  prm_base, tblCoating, System.SysUtils;

Type
  TPrmCoating = class(TPrmBase)
  private
    FFieldName: TCoating;
    procedure setFFieldName(const Value: TCoating);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCoating read FFieldName write setFFieldName;
  end;

implementation

{ TPrmCoating }

procedure TPrmCoating.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCoating.Create;
begin
  FFieldName := TCoating.Create;
end;

destructor TPrmCoating.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCoating.setFFieldName(const Value: TCoating);
begin
  FFieldName := Value;
end;

end.
