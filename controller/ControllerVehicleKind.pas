unit ControllerVehicleKind;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tbltpveiculo, prm_vehicle_kind;

Type
  TListaTpVeiculo = TObjectList<TTpVeiculo>;
  TControllerVehicleKind = Class(TControllerBase)
  private
    FParametros: TPrmVehicleKind;
    procedure setFParametros(const Value: TPrmVehicleKind);

  public
    Registro : TTpVeiculo;
    Lista : TListaTpVeiculo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmVehicleKind read FParametros write setFParametros;
  End;

implementation

function TControllerVehicleKind.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerVehicleKind.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTpVeiculo.Create;
  FParametros := TPrmVehicleKind.Create;
  Lista := TListaTpVeiculo.Create;
end;

function TControllerVehicleKind.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleKind.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerVehicleKind.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerVehicleKind.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'tpv_codigo',0);
  SaveObj(Registro);
end;

function TControllerVehicleKind.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerVehicleKind.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTpVeiculo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_TP_VEICULO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TPV_CODIGO = :TPV_CODIGO';
        ParamByName('TPV_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND TPV_DESCRICAO LIKE :TPV_DESCRICAO';
        ParamByName('TPV_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTpVeiculo.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerVehicleKind.setFParametros(const Value: TPrmVehicleKind);
begin
  FParametros := Value;
end;

procedure TControllerVehicleKind.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerVehicleKind.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

