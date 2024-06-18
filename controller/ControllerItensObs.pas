unit ControllerItensObs;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      Un_MSg,System.Generics.Collections, tblItensObs;

Type
  TControllerItensObs = Class(TControllerBase)

  private

  public
    Registro : TItensObs;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    procedure getbyId;
    Function delete:boolean;
    procedure clear;
  End;


implementation

{ TControllerItensObs }

procedure TControllerItensObs.clear;
begin
  exist := False;
  clearObj(Registro);
end;

constructor TControllerItensObs.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensObs.Create;
end;

function TControllerItensObs.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

destructor TControllerItensObs.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerItensObs.getbyId;
begin
  _getByKey(Registro)
end;


function TControllerItensObs.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

end.
