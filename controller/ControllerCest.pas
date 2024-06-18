unit ControllerCest;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCest, Md5, STQuery;
Type
  TControllerCest = Class(TControllerBase)
  private

  public
    Registro : TCest;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
  End;

  implementation
{ ControllerCest}

constructor TControllerCest.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCest.Create;
end;

function TControllerCest.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCest.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCest.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCest.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCest.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCest.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

