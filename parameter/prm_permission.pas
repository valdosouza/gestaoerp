unit prm_permission;

interface

uses
  prm_base, tblPermissao, System.SysUtils;

Type
  TPrmPermission = class(TPrmBase)
  private
    FFieldName: TPermissao;
    procedure setFFieldName(const Value: TPermissao);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TPermissao read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmPermission.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPermission.Create;
begin
  FFieldName := TPermissao.Create;
end;

destructor TPrmPermission.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPermission.setFFieldName(const Value: TPermissao);
begin
  FFieldName := Value;
end;

end.
