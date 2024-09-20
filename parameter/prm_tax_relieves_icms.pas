unit prm_tax_relieves_icms;

interface

uses
  prm_base, tblTaxRelievesIcms, System.SysUtils;

Type
  TPrmTaxRelievesIcms = class(TPrmBase)
  private
    FFieldName: TTaxRelievesIcms;
    procedure setFFieldName(const Value: TTaxRelievesIcms);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTaxRelievesIcms read FFieldName write setFFieldName;
  end;

implementation

{ TPrmTaxRelievesIcms }

procedure TPrmTaxRelievesIcms.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxRelievesIcms.Create;
begin
  FFieldName := TTaxRelievesIcms.Create;
end;

destructor TPrmTaxRelievesIcms.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxRelievesIcms.setFFieldName(const Value: TTaxRelievesIcms);
begin
  FFieldName := Value;
end;

end.
