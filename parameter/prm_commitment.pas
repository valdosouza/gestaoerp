unit prm_commitment;

interface

uses
  prm_base, tblagenda, System.SysUtils;

Type
  TPrmCommitMent = class(TPrmBase)
  private
    FFieldName: TAgenda;
    procedure setFFieldName(const Value: TAgenda);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TAgenda read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmCommitMent.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmCommitMent.Create;
begin
  inherited;
  FFieldName := TAgenda.Create;
end;

destructor TPrmCommitMent.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmCommitMent.setFFieldName(const Value: TAgenda);
begin
  FFieldName := Value;
end;

end.
