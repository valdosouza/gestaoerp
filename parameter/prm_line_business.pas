unit prm_line_business;

interface

uses
  prm_base, tblRamoAtividade, System.SysUtils;

Type
  TPrmLineBusiness = class(TPrmBase)
  private
    FFieldName: TRamoAtividade;
    procedure setFFieldName(const Value: TRamoAtividade);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TRamoAtividade read FFieldName write setFFieldName;
  end;

implementation

{ TPrmLineBusiness }

procedure TPrmLineBusiness.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmLineBusiness.Create;
begin
  FFieldName := TRamoAtividade.Create;
end;

destructor TPrmLineBusiness.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmLineBusiness.setFFieldName(const Value: TRamoAtividade);
begin
  FFieldName := Value;
end;

end.
