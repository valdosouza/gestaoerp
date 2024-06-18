unit ControllerNfeItemsFuel;

interface

uses STDatabase,Classes, Vcl.Grids,SysUtils,ControllerBase,
      tblNfeItemsFuel, Md5, STQuery;

Type
  TControllerNfeItemsFuel = Class(TControllerBase)

  private

  public
    Registro : TNfeItemsFuel;
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
{ ControllerBotao}

procedure TControllerNfeItemsFuel.clear;
begin

end;

constructor TControllerNfeItemsFuel.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNfeItemsFuel.Create;
end;

function TControllerNfeItemsFuel.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


destructor TControllerNfeItemsFuel.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerNfeItemsFuel.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerNfeItemsFuel.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerNfeItemsFuel.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerNfeItemsFuel.getByKey: Boolean;
begin
  _getByKey(Registro);
end;
end.

