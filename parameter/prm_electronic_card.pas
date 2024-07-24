unit prm_electronic_card;

interface

uses
  prm_base, tblCartaoEletronico, System.SysUtils;

Type
  TPrmElectronicCard = class(TPrmBase)
  private
    FFieldName: TCartaoEletronico;
    procedure setFFieldName(const Value: TCartaoEletronico);

  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TCartaoEletronico read FFieldName write setFFieldName;
  end;


implementation

{ TPrmElectronicCard }

procedure TPrmElectronicCard.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmElectronicCard.Create;
begin
  inherited;
  FFieldName := TCartaoEletronico.Create;
end;

destructor TPrmElectronicCard.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmElectronicCard.setFFieldName(const Value: TCartaoEletronico);
begin
  FFieldName := Value;
end;

end.
