unit prm_electronic_slip;

interface

uses
  prm_base, tblBoletoEletronico, System.SysUtils;

Type
  TPrmElectronicSlip = class(TPrmBase)
  private
    FFieldName: TBoletoEletronico;
    procedure setFFieldName(const Value: TBoletoEletronico);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TBoletoEletronico read FFieldName write setFFieldName;
  end;

implementation

{ TPrmElectronicSlip }

procedure TPrmElectronicSlip.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmElectronicSlip.Create;
begin
  inherited;
  FFieldName := TBoletoEletronico.Create;
end;

destructor TPrmElectronicSlip.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmElectronicSlip.setFFieldName(const Value: TBoletoEletronico);
begin
  FFieldName := Value;
end;

end.
