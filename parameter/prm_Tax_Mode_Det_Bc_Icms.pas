unit prm_Tax_Mode_Det_Bc_Icms;

interface

uses
  prm_base, TblTaxModeDetBcIcms, System.SysUtils;

Type
  TPrmTaxModeDetBcIcms = class(TPrmBase)
  private
    FFieldName: TTaxModeDetBcIcms;
    procedure setFFieldName(const Value: TTaxModeDetBcIcms);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTaxModeDetBcIcms read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmTaxModeDetBcIcms.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxModeDetBcIcms.Create;
begin
  inherited;
  FFieldName := TTaxModeDetBcIcms.Create;
end;

destructor TPrmTaxModeDetBcIcms.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxModeDetBcIcms.setFFieldName(const Value: TTaxModeDetBcIcms);
begin
  FFieldName := Value;
end;

end.
