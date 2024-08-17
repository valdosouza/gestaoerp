unit ControllerImpostos;

interface

uses STDatabase, System.Classes, System.SysUtils, ControllerBase,
      tblImpostos, prm_taxes;

Type
  TControllerImpostos = Class(TControllerBase)
  private
    FParametros: TPrmTaxes;
    procedure setFParametros(const Value: TPrmTaxes);
  public
    Registro : TImpostos;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;
    function Clear:Boolean;
    property Parametros : TPrmTaxes read FParametros write setFParametros;
  End;

  implementation
{ ControllerAgenda }

function TControllerImpostos.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerImpostos.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TImpostos.Create;
  FParametros := TPrmTaxes.Create;
end;

function TControllerImpostos.delete: boolean;
begin
  Result := True;
  Try
    deleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerImpostos.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerImpostos.insert: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerImpostos.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'agd_codigo',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerImpostos.save: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerImpostos.setFParametros(const Value: TPrmTaxes);
begin
  FParametros := Value;
end;

procedure TControllerImpostos.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerImpostos.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
end.

