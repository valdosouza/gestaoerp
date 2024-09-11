unit prm_measure;

interface

uses
  prm_base, tblMedida, System.SysUtils;

Type
  TPrmMeasure = class(TPrmBase)
  private
    FFieldName: TMedida;
    procedure setFFieldName(const Value: TMedida);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TMedida read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmMeasure.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmMeasure.Create;
begin
  FFieldName := TMedida.Create;
end;

destructor TPrmMeasure.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmMeasure.setFFieldName(const Value: TMedida);
begin
  FFieldName := Value;
end;

end.
