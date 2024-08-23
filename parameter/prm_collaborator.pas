unit prm_collaborator;

interface

uses
  prm_base, tblColaborador, System.SysUtils;

Type
  TPrmCollaborator = class(TPrmBase)
  private
    FFieldName: TColaborador;
    procedure setFFieldName(const Value: TColaborador);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TColaborador read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmCollaborator.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCollaborator.Create;
begin
  inherited;
  FFieldName := TColaborador.Create;
end;

destructor TPrmCollaborator.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCollaborator.setFFieldName(const Value: TColaborador);
begin
  FFieldName := Value;
end;

end.
