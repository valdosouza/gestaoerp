unit prm_configtag;

interface

uses
  prm_base, TblCfgEtiqueta, System.SysUtils;

Type
  TPrmConfigTag = class(TPrmBase)
  private
    FFieldName: TCfgEtiqueta;
    procedure setFFieldName(const Value: TCfgEtiqueta);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TCfgEtiqueta read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmConfigTag.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmConfigTag.Create;
begin
  inherited;
  FFieldName := TCfgEtiqueta.Create;
end;

destructor TPrmConfigTag.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmConfigTag.setFFieldName(const Value: TCfgEtiqueta);
begin
  FFieldName := Value;
end;

end.
