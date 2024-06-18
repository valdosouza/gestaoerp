unit ControllerFechaFinanceiro;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblFechaFinanceiro ;


Type
  TControllerFechaFinanceiro = Class(TControllerBase)
  private

  public
    Registro : TFechaFinanceiro;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function getSaldoAnterior(Codigo:Integer;Data:TDate):Real;
  End;

implementation

{ TControllerFechaFinanceiro }

constructor TControllerFechaFinanceiro.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFechaFinanceiro.Create;

end;

destructor TControllerFechaFinanceiro.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerFechaFinanceiro.getSaldoAnterior(Codigo: Integer;
  Data: TDate): Real;
Var
  Lc_Qry: TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Sql.Add('SELECT FIRST 1 SET_VALUE '+
              'FROM tb_fecha_financeiro FF '+
              'WHERE FF.tb_planocontas_id = :codigo '+
              'AND (FF.dt_record < :data ) '+
              'ORDER by FF.dt_record DESC');
      ParamByName('codigo').AsInteger := Codigo;
      ParamByName('data').AsDate := DAta;
      Active := True;
      FetchAll;
      Result := FieldByName('SET_VALUE').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerFechaFinanceiro.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
