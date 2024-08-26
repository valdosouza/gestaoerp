unit prm_quotation_log;

interface

uses
  prm_base, tblCotacao, System.SysUtils;

Type
  TPrmQuotation_log = class(TPrmBase)
  private
    FFieldName: TCotacao;
    procedure setFFieldName(const Value: TCotacao);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TCotacao read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmQuotation_log.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmQuotation_log.Create;
begin
  inherited;
  FFieldName := TCotacao.Create;
end;

destructor TPrmQuotation_log.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmQuotation_log.setFFieldName(const Value: TCotacao);
begin
  FFieldName := Value;
end;

end.
