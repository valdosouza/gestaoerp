unit ControllerIfoodEvents;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodEvents ,Un_MSg,Generics.Collections;

Type
  TControllerIfoodEvents = Class(TControllerBase)

  private

  public
    Registro : TIfoodEvents;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
  End;

implementation

{ TControllerIfoodEvents }

constructor TControllerIfoodEvents.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodEvents.create;
end;

destructor TControllerIfoodEvents.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerIfoodEvents.getbyId;
begin
  _getByKey(registro);
end;

function TControllerIfoodEvents.insert: boolean;
begin
  try
    insertObj(Registro);
    Result := True;
  finally
    Result := False;
  end;
end;

end.
