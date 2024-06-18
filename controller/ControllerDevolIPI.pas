unit ControllerDevolIPI;

interface
uses STDatabase,Classes, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDevolIpi ,Un_MSg,
      Datasnap.DBClient, STQuery;

Type
  TControllerDevolIPI = Class(TControllerBase)
  private

  public
    Registro : TDevolIpi;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    Function deleteByItem:boolean;
    function GetValorTotal:Real;
  End;

implementation

constructor TControllerDevolIPI.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDevolIpi.Create;
end;

function TControllerDevolIPI.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDevolIPI.deleteByItem: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      SQL.Add('delete from TB_DEVOL_IPI where TB_ORDER_ITEM_ID=:ORDER_ITEM_ID');
      ParamByName('ORDER_ITEM_ID').AsInteger := Registro.Item;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

destructor TControllerDevolIPI.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerDevolIPI.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerDevolIPI.salva: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerDevolIPI.getById;
begin
  _getByKey(Registro);
end;

function TControllerDevolIPI.GetValorTotal: Real;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      SQL.Add(concat(
                'select sum(di.v_ipi) total ',
                'from tb_devol_ipi di ',
                'where di.tb_order_id =:order_id '
      ));
      ParamByName('order_id').AsInteger := Registro.Ordem;
      Active := true;
      REsult := FieldByName('total').AsFloat;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


end.
