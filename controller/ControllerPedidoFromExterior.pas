unit ControllerPedidoFromExterior;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
       tblPedidoFromExterior, Generics.Collections;
Type

  TControllerPedidoFromExterior = Class(TControllerBase)
  private

  public
    Registro : TPedidoFromExterior;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function delete:boolean;
    procedure Clear;
  End;

implementation

uses ControllerIfoodCustomer;

{ TControllerPedidoFromExterior }

procedure TControllerPedidoFromExterior.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerPedidoFromExterior.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPedidoFromExterior.create;
end;

function TControllerPedidoFromExterior.delete: boolean;
begin
  try
    deleteObj(Registro);
    result := true;
  except
    result := false;
  end;
end;

destructor TControllerPedidoFromExterior.Destroy;
begin
  Registro.disposeOf;
  inherited;
end;

procedure TControllerPedidoFromExterior.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerPedidoFromExterior.insert: boolean;
begin
  try
    insertObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

end.
