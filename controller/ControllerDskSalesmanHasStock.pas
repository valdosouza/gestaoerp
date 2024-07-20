unit ControllerDskSalesmanHasStock;

interface
 uses
  System.Classes, System.SysUtils, System.Variants,
  STDatabase,STQuery,  ControllerBase,tblDskSalesmanHasStock ;
 Type

  TControllerDskSalesmanHasStock = Class(TControllerBase)
  private

  public
    Registro : TDskSalesmanHasStock;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    procedure getList;
    procedure getListObjCashier;
    function delete: boolean;
    function deleteBySalesman: boolean;
    function insert:boolean;
    procedure clear;
    function getByKey:boolean;
    function getBySalesman:Boolean;
  End;

implementation

{ TControllerDskSalesmanHasStock }

procedure TControllerDskSalesmanHasStock.clear;
begin
  clearObj(Registro);
end;

constructor TControllerDskSalesmanHasStock.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDSkSalesmanHasStock.Create;
end;

function TControllerDskSalesmanHasStock.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerDskSalesmanHasStock.deleteBySalesman: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
              'delete ',
              'from tb_salesman_has_stock shs ',
              'where (shs.tb_salesman_id=:tb_salesman_id )'
      ));
      ParamByName('tb_salesman_id').AsInteger := Registro.Vendedor;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

destructor TControllerDskSalesmanHasStock.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerDskSalesmanHasStock.getByKey: boolean;
begin
  _getByKey(Registro);
end;

function TControllerDskSalesmanHasStock.getBySalesman: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
              'select * ',
              'from tb_salesman_has_stock shs ',
              'where (shs.tb_salesman_id=:tb_salesman_id )'
      ));
      ParamByName('tb_salesman_id').AsInteger := Registro.Vendedor;
      Active := True;
      FetchAll;
      exist := ( recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskSalesmanHasStock.getList;
begin

end;

procedure TControllerDskSalesmanHasStock.getListObjCashier;
begin

end;

function TControllerDskSalesmanHasStock.insert: boolean;
begin
  try
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  end;

end;

function TControllerDskSalesmanHasStock.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  end;

end;

function TControllerDskSalesmanHasStock.update: boolean;
begin
  try
    UpdateObj(Registro);
    Result := True;
  except
    Result := False;
  end;

end;

end.
