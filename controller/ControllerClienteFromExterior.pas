unit ControllerClienteFromExterior;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
       tblClienteFromExterior, Generics.Collections;
Type

  TControllerClienteFromExterior = Class(TControllerBase)
  private

  public
    Registro : TClienteFromExterior;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    procedure Clear;
  End;

implementation

uses ControllerIfoodCustomer;

{ TControllerClienteFromExterior }

procedure TControllerClienteFromExterior.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerClienteFromExterior.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TClienteFromExterior.create;
end;

destructor TControllerClienteFromExterior.Destroy;
begin
  Registro.disposeOf;
  inherited;
end;

procedure TControllerClienteFromExterior.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerClienteFromExterior.insert: boolean;
begin
  try
    insertObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

end.
