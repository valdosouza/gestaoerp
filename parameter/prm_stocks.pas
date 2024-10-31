unit prm_stocks;

interface

uses
  prm_base, tblestoques, System.SysUtils;

Type
  TPrmstocks = class(TPrmBase)
  private
    FFieldName: TEstoques;
    procedure setFFieldName(const Value: TEstoques);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TEstoques read FFieldName write setFFieldName;
  end;

implementation

{ TPrmstocks }

procedure TPrmstocks.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmstocks.Create;
begin
  FFieldName := TEstoques.Create;
end;

destructor TPrmstocks.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmstocks.setFFieldName(const Value: TEstoques);
begin
  FFieldName := Value;
end;

end.
