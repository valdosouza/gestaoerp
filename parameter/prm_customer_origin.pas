unit prm_customer_origin;

interface

uses
  prm_base, tblCustomerOrigin, System.SysUtils;

Type
  TPrmCustomerOrigin = class(TPrmBase)
  private
    FFieldName: TCustomerOrigin;
    procedure setFFieldName(const Value: TCustomerOrigin);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TCustomerOrigin read FFieldName write setFFieldName;
  end;

implementation

{ TPrmCustomerOrigin }

procedure TPrmCustomerOrigin.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCustomerOrigin.Create;
begin
  FFieldName := TCustomerOrigin.Create;
end;

destructor TPrmCustomerOrigin.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCustomerOrigin.setFFieldName(const Value: TCustomerOrigin);
begin
  FFieldName := Value;
end;

end.
