unit prm_ItensNFL;

interface

uses
  prm_base, tblItensnfl, System.SysUtils;

Type
  TPrmItensNFL = class(TPrmBase)
  private
    FFieldName: TItensNFL;
    procedure setFFieldName(const Value: TItensNFL);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TItensNFL read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmItensNFL.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmItensNFL.Create;
begin
  FFieldName := TItensNFL.Create;
end;

destructor TPrmItensNFL.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmItensNFL.setFFieldName(const Value: TItensNFL);
begin
  FFieldName := Value;
end;

end.
