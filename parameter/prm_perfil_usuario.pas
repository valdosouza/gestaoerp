unit prm_permissao_perfil;

interface

uses
  prm_base, tblPerfilUsuario, System.SysUtils;

Type
  TPrmPerfilUsuario = class(TPrmBase)
  private
    FFieldName: TPerfilUsuario;
    procedure setFFieldName(const Value: TPerfilUsuario);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TPerfilUsuario read FFieldName write setFFieldName;
  end;

implementation

{ TPrmPerfilUsuario }

procedure TPrmPerfilUsuario.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPerfilUsuario.Create;
begin
  FFieldName := TPerfilUsuario.Create;
end;

destructor TPrmPerfilUsuario.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPerfilUsuario.setFFieldName(const Value: TPerfilUsuario);
begin
  FFieldName := Value;
end;

end.
