unit prm_receipt;

interface

uses
  prm_base, tblRecibo, System.SysUtils;

Type
  TPrmReceipt = class(TPrmBase)
  private
    FFieldName: TRecibo;
    procedure setFFieldName(const Value: TRecibo);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TRecibo read FFieldName write setFFieldName;
  end;



implementation

{ TPrmReceipt }

procedure TPrmReceipt.Clear;
begin
  inherited;

end;

constructor TPrmReceipt.Create;
begin
  FFieldName := TRecibo.Create;
end;

destructor TPrmReceipt.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmReceipt.setFFieldName(const Value: TRecibo);
begin
  FFieldName := Value;
end;

end.
