unit prm_city;

interface

uses
  prm_base, tblcidade, System.SysUtils;

Type
  TPrmCidade = class(TPrmBase)
  private
    FFieldName: TCidade;
    procedure setFFieldName(const Value: TCidade);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCidade read FFieldName write setFFieldName;
  end;

implementation

{ TPrmJobPosition }

procedure TPrmCidade.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCidade.Create;
begin
  FFieldName := TCidade.Create;
end;

destructor TPrmCidade.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCidade.setFFieldName(const Value: TCidade);
begin
  FFieldName := Value;
end;

end.
