unit prm_profile;

interface

uses
  prm_base, tblPerfilUsuario, System.SysUtils;

Type
  TPrmPerfil = class(TPrmBase)
  private
    FFieldName: TPerfilUsuario;
    procedure setFFieldName(const Value: TPerfilUsuario);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TPerfilUsuario read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmPerfil.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPerfil.Create;
begin
  FFieldName := TPerfilUsuario.Create;
end;

destructor TPrmPerfil.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPerfil.setFFieldName(const Value: TPerfilUsuario);
begin
  FFieldName := Value;
end;

end.
