unit ControllerCorVeiculo;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCorVeiculo, Md5, STQuery;
Type
  TControllerCorVeiculo = Class(TControllerBase)
  private

  public
    Registro : TCorVeiculo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
  End;

  implementation
{ ControllerCorVeiculo }

constructor TControllerCorVeiculo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCorVeiculo.Create;
end;

function TControllerCorVeiculo.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCorVeiculo.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerCorVeiculo.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCorVeiculo.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCorVeiculo.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCorVeiculo.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

