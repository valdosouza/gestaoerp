unit prm_contacts;

interface

uses
  prm_base, tblContato, System.SysUtils;

Type
  TPrmContacts = class(TPrmBase)
  private
    FFieldName: Tcontato;
    procedure setFFieldName(const Value: Tcontato);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : Tcontato read FFieldName write setFFieldName;
  end;

implementation

{ TPrmcontacts }

procedure TPrmcontacts.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmcontacts.Create;
begin
  FFieldName := Tcontato.Create;
end;

destructor TPrmcontacts.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmcontacts.setFFieldName(const Value: Tcontato);
begin
  FFieldName := Value;
end;

end.
