unit prm_Sales_Origin;

interface

uses
  prm_base, tblSalesOrigin, System.SysUtils;

Type
  TPrmSalesOrigin = class(TPrmBase)
  private
    FFieldName: TSalesOrigin;
    procedure setFFieldName(const Value: TSalesOrigin);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TSalesOrigin read FFieldName write setFFieldName;
  end;

implementation

{ TPrmSalesOrigin }

procedure TPrmSalesOrigin.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmSalesOrigin.Create;
begin
  FFieldName := TSalesOrigin.Create;
end;

destructor TPrmSalesOrigin.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmSalesOrigin.setFFieldName(const Value: TSalesOrigin);
begin
  FFieldName := Value;
end;

end.
