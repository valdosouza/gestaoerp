unit prm_category;

interface

uses
  prm_base, tblCategory, System.SysUtils;

Type
  TPrmCategory = class(TPrmBase)
  private
    FFieldName: TCategory;
    procedure setFFieldName(const Value: TCategory);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCategory read FFieldName write setFFieldName;
  end;

implementation

{ TPrmCategory }

procedure TPrmCategory.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCategory.Create;
begin
  FFieldName := TCategory.Create;
end;

destructor TPrmCategory.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCategory.setFFieldName(const Value: TCategory);
begin
  FFieldName := Value;
end;

end.
