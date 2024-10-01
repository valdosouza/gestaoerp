unit prm_TaxIcmsNr;

interface

uses
  prm_base, TblTaxIcmsNr, System.SysUtils;

Type
  TPrmTaxIcmsNr = class(TPrmBase)
  private
    FFieldName: TTaxIcmsNr;
    procedure setFFieldName(const Value: TTaxIcmsNr);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTaxIcmsNr read FFieldName write setFFieldName;
  end;

implementation

{ TPrmCoating }

procedure TPrmTaxIcmsNr.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxIcmsNr.Create;
begin
  FFieldName := TTaxIcmsNr.Create;
end;

destructor TPrmTaxIcmsNr.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxIcmsNr.setFFieldName(const Value: TTaxIcmsNr);
begin
  FFieldName := Value;
end;

end.
