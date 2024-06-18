unit ControllerOrderItemPacking;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblOrderItemPacking, tblEntity, FireDAC.Comp.Client,Md5, FireDAC.Stan.Param;

Type
  TControllerOrderItemPacking = Class(TBaseController)
    procedure clear;
  private

  public
    Registro : TOrderItemPacking;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;

  End;

implementation

{ ControllerOrderItemPacking}

procedure TControllerOrderItemPacking.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerOrderItemPacking.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOrderItemPacking.Create;
end;

destructor TControllerOrderItemPacking.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerOrderItemPacking.save: boolean;
begin
  try
    saveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


end.
