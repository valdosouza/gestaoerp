unit prm_business;

interface

uses
  prm_base, tblnegocio, System.SysUtils;

Type
  TPrmBusiness = class(TPrmBase)
  private
    FFieldName: TNegocio;
    procedure setFFieldName(const Value: TNegocio);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TNegocio read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmBusiness.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmBusiness.Create;
begin
  inherited;
  FFieldName := TNegocio.Create;
end;

destructor TPrmBusiness.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmBusiness.setFFieldName(const Value: TNegocio);
begin
  FFieldName := Value;
end;

end.
