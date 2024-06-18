unit ControllerAgenda;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblAgenda, Md5, STQuery;
Type
  TControllerAgenda = Class(TControllerBase)

  private

  public
    Registro : TAgenda;
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
{ ControllerAgenda }


procedure TControllerAgenda.clear;
begin
ClearObj(Registro);
end;

constructor TControllerAgenda.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAgenda.Create;
end;

function TControllerAgenda.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAgenda.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerAgenda.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAgenda.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerAgenda.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerAgenda.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
end.

