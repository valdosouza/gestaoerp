unit prm_menus;

interface

uses
  prm_base, tblMenus, System.SysUtils;

Type
  TPrmMenus = class(TPrmBase)
  private
    FFieldName: TMenus;
    procedure setFFieldName(const Value: TMenus);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TMenus read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmMenus.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmMenus.Create;
begin
  inherited;
  FFieldName := TMenus.Create;
end;

destructor TPrmMenus.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmMenus.setFFieldName(const Value: TMenus);
begin
  FFieldName := Value;
end;

end.
