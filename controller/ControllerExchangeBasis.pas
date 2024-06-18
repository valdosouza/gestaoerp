unit ControllerExchangeBasis;

interface

uses STDatabase,Classes, Vcl.Grids,SysUtils,ControllerBase,
      tblExchangeBasis, Md5, STQuery, Generics.Collections;

Type
  TListaExchangeItem = TObjectList<TExchangeBasis>;

  TControllerExchangeBasis = Class(TControllerBase)

  private
    function getNext:Integer;
  public
    Registro : TExchangeBasis;
    Lista : TListaExchangeItem;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:Boolean;
    function updateExtra:Boolean;
    function insert:boolean;
    Function delete:boolean;
    function deleteByOrdem:Boolean;
    function getByKey:Boolean;
    procedure clear;
    procedure getlistPendente;
  End;

  implementation
{ ControllerBotao}

procedure TControllerExchangeBasis.clear;
begin

end;

constructor TControllerExchangeBasis.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TExchangeBasis.Create;
  Lista := TListaExchangeItem.Create;
end;

function TControllerExchangeBasis.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerExchangeBasis.deleteByOrdem: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE FROM tb_exchange_basis ',
                      'WHERE TB_ORDER_ID =:TB_ORDER_ID '
                      ));
      ParamByName('TB_ORDER_ID').AsInteger := Registro.Ordem;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerExchangeBasis.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerExchangeBasis.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerExchangeBasis.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerExchangeBasis.update: Boolean;
begin
  try
    updateObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

function TControllerExchangeBasis.updateExtra: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Add(concat(
                'UPDATE TB_EXCHANGE_BASIS SET ',
                '    TB_USER_ID =:TB_USER_ID, ',
                '    TB_CUSTOMER_ID =:TB_CUSTOMER_ID, ',
                '    TB_SALESMAN_ID =:TB_SALESMAN_ID ',
                'WHERE (TB_INSTITUTION_ID =:TB_INSTITUTION_ID) AND ',
                '      (TB_ORDER_ID =:TB_ORDER_ID) AND ',
                '      (TB_ORDER_ITEM_ID =:TB_ORDER_ITEM_ID); '
      ));
      //Tabela 1 - normal
      ParamByName('TB_USER_ID').AsInteger         := Registro.Usuario;
      ParamByName('TB_CUSTOMER_ID').AsInteger     := Registro.Cliente;
      ParamByName('TB_SALESMAN_ID').AsInteger     := Registro.Vendedor;
      ParamByName('TB_INSTITUTION_ID').AsInteger  := Registro.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger        := Registro.Ordem;
      ParamByName('TB_ORDER_ITEM_ID').AsInteger   := Registro.Item;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerExchangeBasis.getByKey: Boolean;
begin
  _getByKey(Registro);
end;
procedure TControllerExchangeBasis.getlistPendente;
var
  Lc_Qry : TSTQuery;
  LITem : TExchangeBasis;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_exchange_basis ',
                      'WHERE tb_customer_id =:tb_customer_id ',
                      ' AND ((WEIGHT_OUT - WEIGHT_IN) <> 0) ',
                      ' order by TB_ORDER_ITEM_ID asc '
                      ));
      ParamByName('tb_customer_id').AsInteger := Registro.Cliente;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TExchangeBasis.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerExchangeBasis.getNext: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Add(concat(
                'select max(eb.tb_order_item_id) id ',
                'from tb_exchange_basis eb ',
                'where eb.tb_institution_id=:tb_institution_id ',
                'and eb.tb_order_id = 0 '
      ));
      //Tabela 1 - normal
      ParamByName('tb_institution_id').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      if (recordcount >0) then
        Result := FieldByName('id').AsInteger + 1
      else
        Result := 1;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

