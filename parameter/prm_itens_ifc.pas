unit prm_itens_ifc;

interface

uses
  prm_base, tblItensIFc, System.SysUtils;

Type
  TPrmItensIfc = class(TPrmBase)
  private
    FFieldName: TItensIfc;
    procedure setFFieldName(const Value: TItensIfc);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TItensIfc read FFieldName write setFFieldName;
  end;

implementation

{ TPrmItensIfc }

procedure TPrmItensIfc.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmItensIfc.Create;
begin
  FFieldName :=TItensIFC.Create;
end;

destructor TPrmItensIfc.Destroy;
begin
  FReeAndNil(FFieldName);
  inherited;
end;

procedure TPrmItensIfc.setFFieldName(const Value: TItensIfc);
begin
  FFieldName := Value;
end;

end.
