unit ControllerCfgEtiqueta;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCfgEtiqueta, Md5, STQuery;
Type
  TControllerCfgEtiqueta = Class(TControllerBase)
  private

  public
    Registro : TCfgEtiqueta;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
  End;

  implementation
{ ControllerCfgEtiqueta}

constructor TControllerCfgEtiqueta.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCfgEtiqueta.Create;
end;

function TControllerCfgEtiqueta.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCfgEtiqueta.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCfgEtiqueta.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCfgEtiqueta.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCfgEtiqueta.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCfgEtiqueta.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

