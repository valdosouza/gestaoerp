unit prm_product_brand;

interface

uses
  prm_base, tblmarcaproduto, System.SysUtils;

Type
  TPrmProductBrand = class(TPrmBase)
  private
    FFieldName: TMarcaProduto;
    procedure setFFieldName(const Value: TMarcaProduto);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TMarcaProduto read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmProductBrand.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmProductBrand.Create;
begin
  inherited;
  FFieldName := TMarcaProduto.Create;
end;

destructor TPrmProductBrand.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmProductBrand.setFFieldName(const Value: TMarcaProduto);
begin
  FFieldName := Value;
end;

end.
