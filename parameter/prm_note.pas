unit prm_note;

interface

uses
  prm_base, tblObservacao, System.SysUtils;

Type
  TPrmNote = class(TPrmBase)
  private
    FFieldName: TObservacao;
    procedure setFFieldName(const Value: TObservacao);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TObservacao read FFieldName write setFFieldName;
  end;

implementation

procedure TPrmNote.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmNote.Create;
begin
  FFieldName := TObservacao.Create;
end;

destructor TPrmNote.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmNote.setFFieldName(const Value: TObservacao);
begin
  FFieldName := Value;
end;

end.
