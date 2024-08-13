unit prm_mva_uf_ncm;

interface

uses
  prm_base, tblMvaUfNcm, System.SysUtils;

Type
  TPrmMvaUFNcm = class(TPrmBase)
  private
    FFieldName: TMvaUfNcm;
    procedure setFFieldName(const Value: TMvaUfNcm);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TMvaUfNcm read FFieldName write setFFieldName;
  end;

implementation

{ TPrmMvaUFNcm }

procedure TPrmMvaUFNcm.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmMvaUFNcm.Create;
begin
  FFieldName := TMvaUfNcm.Create;
end;

destructor TPrmMvaUFNcm.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmMvaUFNcm.setFFieldName(const Value: TMvaUfNcm);
begin
  FFieldName := Value;
end;

end.
