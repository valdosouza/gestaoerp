unit ControllerAssistencia;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblAssistencia, Md5,  STQuery;

Type
  TControllerAssistencia = Class(TControllerBase)

  private

  public
    Registro : TAssistencia;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
  End;

  implementation
{ ControllerAssistencia }


procedure TControllerAssistencia.clear;
begin

end;

constructor TControllerAssistencia.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAssistencia.Create;
end;

function TControllerAssistencia.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAssistencia.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerAssistencia.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAssistencia.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerAssistencia.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerAssistencia.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
end.


