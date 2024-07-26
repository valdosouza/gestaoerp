unit prm_virtual_shop;

interface

uses
  prm_base, tblVirtualShop, System.SysUtils;

Type
  TPrmVirtualShop = class(TPrmBase)
  private
    FFieldName: TVirtualShop;
    procedure setFFieldName(const Value: TVirtualShop);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TVirtualShop read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmVirtualShop.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmVirtualShop.Create;
begin
  inherited;
  FFieldName := TVirtualShop.Create;
end;

destructor TPrmVirtualShop.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmVirtualShop.setFFieldName(const Value: TVirtualShop);
begin
  FFieldName := Value;
end;

end.
