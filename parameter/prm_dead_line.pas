unit prm_dead_line;

interface

uses
  prm_base, tblDeadLine, System.SysUtils;

Type
  TPrmDeadLine = class(TPrmBase)
  private
    FFieldName: TDeadLine;
    procedure setFFieldName(const Value: TDeadLine);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TDeadLine read FFieldName write setFFieldName;
  end;

implementation

{ TPrmDeadLine }

procedure TPrmDeadLine.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmDeadLine.Create;
begin
  FFieldName := TDeadLine.Create;
end;

destructor TPrmDeadLine.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmDeadLine.setFFieldName(const Value: TDeadLine);
begin
  FFieldName := Value;
end;

end.
