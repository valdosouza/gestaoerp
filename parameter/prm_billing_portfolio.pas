unit prm_billing_portfolio;

interface

uses
  prm_base, tblCarteiraCobranca, System.SysUtils;

Type
  TPrmCarteiraCobranca = class(TPrmBase)
  private
    FFieldName: TCarteiraCobranca;
    procedure setFFieldName(const Value: TCarteiraCobranca);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCarteiraCobranca read FFieldName write setFFieldName;
  end;

implementation

{ TPrmJobPosition }

procedure TPrmCarteiraCobranca.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCarteiraCobranca.Create;
begin
  FFieldName := TCarteiraCobranca.Create;
end;

destructor TPrmCarteiraCobranca.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCarteiraCobranca.setFFieldName(const Value: TCarteiraCobranca);
begin
  FFieldName := Value;
end;

end.
