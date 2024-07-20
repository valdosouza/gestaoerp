unit ControllerIfoodOrderItemsOptions;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderItemsOptions ,Un_MSg,Generics.Collections;

Type
  TListaIfoodOrderItemsOptions = TObjectList<TIfoodOrderItemsOptions>;

  TControllerIfoodOrderItemsOptions = Class(TControllerBase)

  private

  public
    Registro : TIfoodOrderItemsOptions;
    Lista : TListaIfoodOrderItemsOptions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:Boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerIfoodOrderItemsOptions.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodOrderItemsOptions.Create;
  Lista := TListaIfoodOrderItemsOptions.Create;
end;

function TControllerIfoodOrderItemsOptions.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderItemsOptions.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderItemsOptions.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderItemsOptions.replace: Boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerIfoodOrderItemsOptions.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderItemsOptions.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderItemsOptions.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderItemsOptions;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_IFOOD_ORDER_ITEMS_OPTIONS ',
                     'WHERE (TB_IFOOD_ORDER_ID =:TB_IFOOD_ORDER_ID) ',
                     ' AND (TB_IFOOD_ORDER_ITEMS_ID =:TB_IFOOD_ORDER_ITEMS_ID) ',
                     ' order by unitprice '
      ));
      ParamByName('TB_IFOOD_ORDER_ID').AsString := Registro.OrderId;
      ParamByName('TB_IFOOD_ORDER_ITEMS_ID').AsInteger := Registro.OrderItemsId;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderItemsOptions.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

