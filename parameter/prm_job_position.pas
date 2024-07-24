unit prm_job_position;

interface

uses
  prm_base, tblCargo, System.SysUtils;

Type
  TPrmJobPosition = class(TPrmBase)
  private
    FFieldName: TCargo;
    procedure setFFieldName(const Value: TCargo);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCargo read FFieldName write setFFieldName;
  end;

implementation

{ TPrmJobPosition }

procedure TPrmJobPosition.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmJobPosition.Create;
begin
  FFieldName := TCargo.Create;
end;

destructor TPrmJobPosition.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmJobPosition.setFFieldName(const Value: TCargo);
begin
  FFieldName := Value;
end;

end.
