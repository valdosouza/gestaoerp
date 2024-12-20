unit ControllerCarteiraCobranca;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCarteiraCobranca, prm_billing_portfolio,ControllerBanco;

Type
  TControllerCarteiraCobranca = Class(TControllerBase)
  private
    FParametros: TPrmCarteiraCobranca;
    procedure setFParametros(const Value: TPrmCarteiraCobranca);
  public
    Registro : TCarteiraCobranca;
    Banco : TControllerBanco;
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
  FParametros.Clear;
end;

constructor TControllerCarteiraCobranca.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCarteiraCobranca.Create;
  FParametros := TPrmCarteiraCobranca.Create;
  Banco := TControllerBanco.Create(self);
end;

function TControllerCarteiraCobranca.delete: boolean;
begin
  Result := True;
  Try
    deleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerCarteiraCobranca.Destroy;
begin
  FreeAndNil(Banco);
  FreeAndNil(Registro);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerCarteiraCobranca.insert: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerCarteiraCobranca.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ctr_codigo',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerCarteiraCobranca.save: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
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
  Result := True;
  try
    getByKey;
  except
    Result := False;
  end;
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
