unit ControllerPermissaoPerfil;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblPermissaoPerfil, prm_permissao_perfil;

Type
  TListaPermissaoPerfil = TObjectList<TPermissaoPerfil>;
  TControllerPermissaoPerfil = Class(TControllerBase)
  private
    FParametros: TPrmPermissaoPerfil;
    procedure setFParametros(const Value: TPrmPermissaoPerfil);

  public
    Registro : TPermissaoPerfil;
    Lista : TListaPermissaoPerfil;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure getbyId;

    function Clear:Boolean;
    property Parametros : TPrmPermissaoPerfil read FParametros write setFParametros;
  End;

implementation

function TControllerPermissaoPerfil.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerPermissaoPerfil.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPermissaoPerfil.Create;
  FParametros := TPrmPermissaoPerfil.Create;
  Lista := TListaPermissaoPerfil.Create;
end;

function TControllerPermissaoPerfil.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPermissaoPerfil.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerPermissaoPerfil.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerPermissaoPerfil.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerPermissaoPerfil.setFParametros(const Value: TPrmPermissaoPerfil);
begin
  FParametros := Value;
end;

procedure TControllerPermissaoPerfil.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerPermissaoPerfil.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

