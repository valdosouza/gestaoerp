unit ControllerItensNflTributacao;

interface

uses STDatabase,Classes, Vcl.Grids,SysUtils,ControllerBase,
      tblItensNflTributacao, Md5, STQuery;

Type
  TControllerItensNflTributacao = Class(TControllerBase)

  private

  public
    Registro : TItensNflTributacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure clear;
  End;

  implementation
{ ControllerBotao}

procedure TControllerItensNflTributacao.clear;
begin

end;

constructor TControllerItensNflTributacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensNflTributacao.Create;
end;

function TControllerItensNflTributacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerItensNflTributacao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerItensNflTributacao.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerItensNflTributacao.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerItensNflTributacao.getByKey: Boolean;
begin
  _getByKey(Registro);
end;


end.

