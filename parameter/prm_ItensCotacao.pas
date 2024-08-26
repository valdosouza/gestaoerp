unit prm_ItensCotacao;

interface

uses
  prm_base, tblItensCotacao, System.SysUtils;

Type
  TPrmItensCotacao = class(TPrmBase)
  private
    FFieldName: TItensCotacao;
    procedure setFFieldName(const Value: TItensCotacao);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TItensCotacao read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmItensCotacao.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmItensCotacao.Create;
begin
  inherited;
  FFieldName := TItensCotacao.Create;
end;

destructor TPrmItensCotacao.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmItensCotacao.setFFieldName(const Value: TItensCotacao);
begin
  FFieldName := Value;
end;

end.
