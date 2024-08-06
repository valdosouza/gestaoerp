unit prm_package;

interface

uses
  prm_base, tblEmbalagem, System.SysUtils;

Type
  TPrmPackage = class(TPrmBase)
  private
    FFieldName: TEmbalagem;
    procedure setFFieldName(const Value: TEmbalagem);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TEmbalagem read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmPackage.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPackage.Create;
begin
  inherited;
  FFieldName := TEmbalagem.Create;
end;

destructor TPrmPackage.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPackage.setFFieldName(const Value: TEmbalagem);
begin
  FFieldName := Value;
end;

end.
