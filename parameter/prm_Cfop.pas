unit prm_Cfop;

interface

uses
  prm_base, tblNatureza, System.SysUtils;

Type
  TPrmCfop = class(TPrmBase)
  private
    FFieldName: TNatureza;
    procedure setFFieldName(const Value: TNatureza);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TNatureza read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmCfop.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCfop.Create;
begin
  inherited;
  FFieldName := TNatureza.Create;
end;

destructor TPrmCfop.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCfop.setFFieldName(const Value: TNatureza);
begin
  FFieldName := Value;
end;

end.
