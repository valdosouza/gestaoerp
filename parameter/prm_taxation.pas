unit prm_taxation;

interface

uses
  prm_base, tblTributacao, System.SysUtils;

Type
  TPrmTaxation = class(TPrmBase)
  private
    FFieldName: TTributacao;
    procedure setFFieldName(const Value: TTributacao);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TTributacao read FFieldName write setFFieldName;
  end;

implementation

{ TPrmTaxation }

procedure TPrmTaxation.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmTaxation.Create;
begin
  FFieldName :=TTributacao.Create;
end;

destructor TPrmTaxation.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmTaxation.setFFieldName(const Value: TTributacao);
begin
  FFieldName := Value;
end;

end.
