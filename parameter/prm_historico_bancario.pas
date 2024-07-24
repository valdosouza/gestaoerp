unit prm_historico_bancario;

interface

uses
  prm_base, tblHistoricoBancario, System.SysUtils;

Type
  TPrmHistoricoBancario = class(TPrmBase)
  private
    FFieldName: THistoricoBancario;
    procedure setFFieldName(const Value: THistoricoBancario);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : THistoricoBancario read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmHistoricoBancario.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmHistoricoBancario.Create;
begin
  inherited;
  FFieldName := THistoricoBancario.Create;
end;

destructor TPrmHistoricoBancario.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmHistoricoBancario.setFFieldName(const Value: THistoricoBancario);
begin
  FFieldName := Value;
end;

end.
