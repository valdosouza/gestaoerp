unit prm_situation;

interface

uses
  prm_base, tblSituacao, System.SysUtils;

Type
  TPrmSituation = class(TPrmBase)
  private
    FFieldName: TSituacao;
    procedure setFFieldName(const Value: TSituacao);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TSituacao read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmSituation.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmSituation.Create;
begin
  FFieldName := TSituacao.Create;
end;

destructor TPrmSituation.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmSituation.setFFieldName(const Value: TSituacao);
begin
  FFieldName := Value;
end;

end.
