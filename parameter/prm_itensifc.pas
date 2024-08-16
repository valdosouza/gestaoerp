unit prm_itensifc;

interface

uses
  prm_base, tblItensIFC, System.SysUtils;

Type
  TPrmItensIFC = class(TPrmBase)
  private
    FFieldName: TItensIFC;
    procedure setFFieldName(const Value: TItensIFC);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TItensIFC read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmItensIFC.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmItensIFC.Create;
begin
  inherited;
  FFieldName := TItensIFC.Create;
end;

destructor TPrmItensIFC.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmItensIFC.setFFieldName(const Value: TItensifc);
begin
  FFieldName := Value;
end;

end.
