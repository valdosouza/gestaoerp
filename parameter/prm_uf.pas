unit prm_uf;

interface

uses
  prm_base, tblUf, System.SysUtils;

Type
  TPrmUF = class(TPrmBase)
  private
    FFieldName: TUF;
    procedure setFFieldName(const Value: TUF);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TUF read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmUF.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmUF.Create;
begin
  inherited;
  FFieldName := TUF.Create;
end;

destructor TPrmUF.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmUF.setFFieldName(const Value: Tuf);
begin
  FFieldName := Value;
end;

end.
