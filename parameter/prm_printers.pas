unit prm_printers;

interface

uses
  prm_base, tblImpressora, System.SysUtils;

Type
  TPrmPrinters = class(TPrmBase)
  private
    FFieldName: TImpressora;
    procedure setFFieldName(const Value: TImpressora);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TImpressora read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrmPrinters.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmPrinters.Create;
begin
  inherited;
  FFieldName := TImpressora.Create;
end;

destructor TPrmPrinters.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmPrinters.setFFieldName(const Value: TImpressora);
begin
  FFieldName := Value;
end;

end.
