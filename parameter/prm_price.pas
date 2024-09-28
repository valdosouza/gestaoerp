unit prm_price;

interface

uses
  prm_base, tblPreco, System.SysUtils;

Type
  TPrmPrice = class(TPrmBase)
  private
    FFieldName: TPreco;
    procedure setFFieldName(const Value: TPreco);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TPreco read FFieldName write setFFieldName;
  end;

implementation

{ TPrmPrice }

procedure TPrmPrice.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPrice.Create;
begin
  FFieldName := TPreco.Create;
end;

destructor TPrmPrice.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPrice.setFFieldName(const Value: TPreco);
begin
  FFieldName := Value;
end;

end.
