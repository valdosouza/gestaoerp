unit prm_users;

interface

uses
  prm_base, tblusuario, System.SysUtils;

Type
  TPrmUsers = class(TPrmBase)
  private
    FFieldName: TUsuario;
    procedure setFFieldName(const Value: TUsuario);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TUsuario read FFieldName write setFFieldName;
  end;


implementation


{ TPrmJobPosition }

procedure TPrmUsers.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmUsers.Create;
begin
  FFieldName := TUsuario.Create;
end;

destructor TPrmUsers.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmUsers.setFFieldName(const Value: TUsuario);
begin
  FFieldName := Value;
end;

end.
