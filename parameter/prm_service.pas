unit prm_service;

interface

uses
  prm_base, tblProduto, System.SysUtils;

Type
  TPrmService = class(TPrmBase)
  private
    FFieldName: TProduto;
    procedure setFFieldName(const Value: TProduto);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TProduto read FFieldName write setFFieldName;
  end;

implementation

{ TPrmService }

procedure TPrmService.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmService.Create;
begin
  FFieldName := TProduto.Create;
end;

destructor TPrmService.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmService.setFFieldName(const Value: TProduto);
begin
  FFieldName := Value;
end;

end.
