unit ControllerIfoodOrderItems;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderItems ,Un_MSg,Generics.Collections,
      ControllerIfoodOrderItemsOptions;

Type
  TListaIfoodOrderItems = TObjectList<TIfoodOrderItems>;

  TControllerIfoodOrderItems = Class(TControllerBase)

  private

  public
    Registro : TIfoodOrderItems;
    Lista : TListaIfoodOrderItems;
    Option :TControllerIfoodOrderItemsOptions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:Boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
    function getTotalItems:Real;
    procedure Clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerIfoodOrderItems.Clear;
begin
  clearObj(Registro);
  Lista.Clear;
end;

constructor TControllerIfoodOrderItems.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodOrderItems.Create;
  Lista := TListaIfoodOrderItems.Create;
  Option := TControllerIfoodOrderItemsOptions.create(Self);
end;

function TControllerIfoodOrderItems.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderItems.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Option.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderItems.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderItems.replace: Boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerIfoodOrderItems.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderItems.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderItems.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderItems;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER_ITEMS ',
                     'Where TB_IFOOD_ORDER_ID =:TB_IFOOD_ORDER_ID '
      ));
      ParamByName('TB_IFOOD_ORDER_ID').AsString := Registro.OrderId;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderItems.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerIfoodOrderItems.getTotalItems: Real;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT sum(quantity) qtty ',
                'FROM TB_IFOOD_ORDER_ITEMS ',
                'Where TB_IFOOD_ORDER_ID =:TB_IFOOD_ORDER_ID '
      ));
      ParamByName('TB_IFOOD_ORDER_ID').AsString := Registro.OrderId;
      Active := True;
      FetchAll;
      Result := FieldByName('qtty').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

