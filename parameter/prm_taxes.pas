unit prm_taxes;

interface

uses
  prm_base, tblImpostos, System.SysUtils;

Type
  TPrmTaxes = class(TPrmBase)
  private
    FFieldName: TImpostos;
    procedure setFFieldName(const Value: TImpostos);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TImpostos read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmTaxes.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxes.Create;
begin
  inherited;
  FFieldName := TImpostos.Create;
end;

destructor TPrmTaxes.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxes.setFFieldName(const Value: TImpostos);
begin
  FFieldName := Value;
end;

end.
