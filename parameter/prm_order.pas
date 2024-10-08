unit prm_order;

interface

uses
  prm_base, tblPedido, System.SysUtils;

Type
  TPrmOrder = class(TPrmBase)
  private
    FFieldName: TPedido;
    procedure setFFieldName(const Value: TPedido);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TPedido read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmOrder.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmOrder.Create;
begin
  FFieldName := TPedido.Create;
end;

destructor TPrmOrder.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmOrder.setFFieldName(const Value: TPedido);
begin
  FFieldName := Value;
end;

end.
