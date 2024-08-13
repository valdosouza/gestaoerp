unit prm_fcp_uf_ncm;

interface

uses
  prm_base, tblFcpUfNcm, System.SysUtils;

Type
  TPrmFcpUFNcm = class(TPrmBase)
  private
    FFieldName: TFcpUfNcm;
    procedure setFFieldName(const Value: TFcpUfNcm);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TFcpUfNcm read FFieldName write setFFieldName;
  end;

implementation

{ TPrmFcpUFNcm }

procedure TPrmFcpUFNcm.Clear;
begin
  inherited;
  clearObj(FFieldName);
end;

constructor TPrmFcpUFNcm.Create;
begin
  FFieldName := TFcpUfNcm.Create;
end;

destructor TPrmFcpUFNcm.Destroy;
begin
  FreeAndnil(FFieldName);
  inherited;
end;

procedure TPrmFcpUFNcm.setFFieldName(const Value: TFcpUfNcm);
begin
  FFieldName := Value;
end;

end.
