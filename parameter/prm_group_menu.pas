unit prm_group_menu; //TB_GRUPOS

interface

uses
  prm_base, tblGrupos, System.SysUtils;

Type
  TPrmGroupMenu = class(TPrmBase)
  private
    FFieldName: TGrupos;
    procedure setFFieldName(const Value: TGrupos);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TGrupos read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmGroupMenu.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmGroupMenu.Create;
begin
  inherited;
  FFieldName := TGrupos.Create;
end;

destructor TPrmGroupMenu.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmGroupMenu.setFFieldName(const Value: TGrupos);
begin
  FFieldName := Value;
end;

end.
