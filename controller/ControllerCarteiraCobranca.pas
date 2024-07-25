unit ControllerCarteiraCobranca;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCarteiraCobranca, prm_billing_portfolio;

Type
  TControllerCarteiraCobranca = Class(TControllerBase)
  private
    FParametros: TPrmCarteiraCobranca;
    procedure setFParametros(const Value: TPrmCarteiraCobranca);
  public
    Registro : TCarteiraCobranca;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function salva:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure getbyId;
    function Clear:Boolean;
    property Parametros : TPrmCarteiraCobranca read FParametros write setFParametros;
  End;

implementation

{ ControllerCarteiraCobranca}

function TControllerCarteiraCobranca.clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerCarteiraCobranca.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCarteiraCobranca.Create;
  Parametros := TPrmCarteiraCobranca.Create;
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
  FreeAndNil(FParametros);
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

function TControllerCarteiraCobranca.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CARTEIRACOBRANCA');
    SaveObj(Registro);
  Except
    Result := False;
  End;
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

procedure TControllerCarteiraCobranca.setFParametros(
  const Value: TPrmCarteiraCobranca);
begin
  FParametros := Value;
end;

function TControllerCarteiraCobranca.getAllByKey: boolean;
begin
  getByKey;
end;

procedure TControllerCarteiraCobranca.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCarteiraCobranca.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.
