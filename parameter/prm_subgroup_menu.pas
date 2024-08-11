unit prm_subgroup_menu;

interface

uses
  prm_base, tblSubGrupos, System.SysUtils;

Type
  TPrmSubGroupMenu = class(TPrmBase)
  private
    FFieldName: TSubGrupos;
    procedure setFFieldName(const Value: TSubGrupos);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TSubGrupos read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmSubGroupMenu.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmSubGroupMenu.Create;
begin
  inherited;
  FFieldName := TSubGrupos.Create;
end;

destructor TPrmSubGroupMenu.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmSubGroupMenu.setFFieldName(const Value: TSubGrupos);
begin
  FFieldName := Value;
end;

end.
