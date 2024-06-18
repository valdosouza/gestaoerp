unit ControllerCarteiraCobranca;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCarteiraCobranca, Md5, STQuery;
Type
  TControllerCarteiraCobranca = Class(TControllerBase)

  private

  public
    Registro : TCarteiraCobranca;
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
{ ControllerCarteiraCobranca}


procedure TControllerCarteiraCobranca.clear;
begin

end;

constructor TControllerCarteiraCobranca.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCarteiraCobranca.Create;
end;

function TControllerCarteiraCobranca.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCarteiraCobranca.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCarteiraCobranca.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCarteiraCobranca.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCarteiraCobranca.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCarteiraCobranca.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.
