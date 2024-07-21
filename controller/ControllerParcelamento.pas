unit ControllerParcelamento;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblParcelamento ,FireDAC.Stan.Param,  Generics.Collections;
Type
  TListParcelamento = TObjectList<TParcelamento>;

  TControllerParcelamento = Class(TControllerBase)

  private

  public
    Registro : TParcelamento;
    Lista : TListParcelamento;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    function getList:Boolean;
    procedure Clear;
    procedure deletebyPedido;
    function getValor:Real;
  End;

implementation

{ TControllerCashier }

uses Un_Regra_Negocio,Un_sistema;


procedure TControllerParcelamento.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerParcelamento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TParcelamento.Create;
  Lista := TListParcelamento.Create;
end;

procedure TControllerParcelamento.deletebyPedido;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('DELETE FROM TB_PARCELAMENTO WHERE PAR_CODPED=:PED_CODIGO');
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerParcelamento.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerParcelamento.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TParcelamento;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT * ',
              'FROM TB_PARCELAMENTO ',
              'WHERE PAR_CODPED =:PAR_CODPED '
              ));
      ParamByName('PAR_CODPED').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TParcelamento.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerParcelamento.getValor: Real;
var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT sum(p.par_valor) valor ',
              'FROM TB_PARCELAMENTO p ',
              'WHERE p.PAR_CODPED =:PAR_CODPED '
              ));
      ParamByName('PAR_CODPED').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      if ( recordCount > 0) then
      Begin
        Result := FieldByName('valor').AsFloat;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerParcelamento.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerParcelamento.salva: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

end.
