unit ControllerCfopCfop;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCfopCfop, Md5, STQuery;
Type
  TControllerCfopCfop = Class(TControllerBase)
private

  public
    Registro : TCfopCfop;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
  End;

  implementation
{ ControllerCfopCfop}

constructor TControllerCfopCfop.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCfopCfop.Create;
end;

function TControllerCfopCfop.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCfopCfop.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCfopCfop.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCfopCfop.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCfopCfop.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCfopCfop.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.
