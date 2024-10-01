unit prm_TaxIcmsSn;

interface

uses
  prm_base, TblTaxIcmsSn, System.SysUtils;

Type
  TPrmTaxIcmsSn = class(TPrmBase)
  private
    FFieldName: TTaxIcmsSn;
    procedure setFFieldName(const Value: TTaxIcmsSn);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTaxIcmsSn read FFieldName write setFFieldName;
  end;

implementation

{ TPrmTaxIcmsSn }

procedure TPrmTaxIcmsSn.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxIcmsSn.Create;
begin
  FFieldName := TTaxIcmsSn.Create;
end;

destructor TPrmTaxIcmsSn.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxIcmsSn.setFFieldName(const Value: TTaxIcmsSn);
begin
  FFieldName := Value;
end;

end.
