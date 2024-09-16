unit prm_Tax_Mode_Det_Bc_Icms_St;

interface

uses
  prm_base, TblTaxModeDetBcIcmsSt, System.SysUtils;

Type
  TPrmTaxModeDetBcIcmsSt = class(TPrmBase)
  private
    FFieldName: TTaxModeDetBcIcmsSt;
    procedure setFFieldName(const Value: TTaxModeDetBcIcmsSt);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TTaxModeDetBcIcmsSt read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmTaxModeDetBcIcmsSt.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxModeDetBcIcmsSt.Create;
begin
  inherited;
  FFieldName := TTaxModeDetBcIcmsSt.Create;
end;

destructor TPrmTaxModeDetBcIcmsSt.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxModeDetBcIcmsSt.setFFieldName(const Value: TTaxModeDetBcIcmsSt);
begin
  FFieldName := Value;
end;

end.
