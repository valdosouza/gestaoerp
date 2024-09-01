unit prm_permissao_perfil;

interface

uses
  prm_base, tblPermissaoPerfil, System.SysUtils;

Type
  TPrmPermissaoPerfil = class(TPrmBase)
  private
    FFieldName: TPermissaoPerfil;
    procedure setFFieldName(const Value: TPermissaoPerfil);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TPermissaoPerfil read FFieldName write setFFieldName;
  end;

implementation

{ TPrmPerfilUsuario }

procedure TPrmPermissaoPerfil.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPermissaoPerfil.Create;
begin
  FFieldName := TPermissaoPerfil.Create;
end;

destructor TPrmPermissaoPerfil.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPermissaoPerfil.setFFieldName(const Value: TPermissaoPerfil);
begin
  FFieldName := Value;
end;

end.
