unit prm_oper_interface;

interface

uses
  prm_base, tblOperInterface, System.SysUtils;

Type
  TPrm_Oper_Interface = class(TPrmBase)
  private
    FFieldName: TOperInterface;
    procedure setFFieldName(const Value: TOperInterface);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TOperInterface read FFieldName write setFFieldName;
  end;

implementation

{ TPrmHistoricoBancario }

procedure TPrm_Oper_Interface.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrm_Oper_Interface.Create;
begin
  inherited;
  FFieldName := TOperInterface.Create;
end;

destructor TPrm_Oper_Interface.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrm_Oper_Interface.setFFieldName(const Value: TOperInterface);
begin
  FFieldName := Value;
end;

end.
