unit prm_ItensCtc;

interface

uses
  prm_base, tblItensCtc, System.SysUtils;

Type
  TPrmItensCtc = class(TPrmBase)
  private
    FFieldName: TItensCtc;
    procedure setFFieldName(const Value: TItensCtc);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TItensCtc read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmItensCtc.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmItensCtc.Create;
begin
  inherited;
  FFieldName := TItensCtc.Create;
end;

destructor TPrmItensCtc.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmItensCtc.setFFieldName(const Value: TItensCtc);
begin
  FFieldName := Value;
end;

end.
