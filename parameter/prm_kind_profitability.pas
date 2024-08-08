unit prm_kind_profitability;

interface

uses
  prm_base, tblKindLucratividade, System.SysUtils;

Type
  TPrmkindProfitability = class(TPrmBase)
  private
    FFieldName: TKindLucratividade;
    procedure setFFieldName(const Value: TKindLucratividade);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TKindLucratividade read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmkindProfitability.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmkindProfitability.Create;
begin
  inherited;
  FFieldName := TKindLucratividade.Create;
end;

destructor TPrmkindProfitability.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmkindProfitability.setFFieldName(const Value: TKindLucratividade);
begin
  FFieldName := Value;
end;

end.
