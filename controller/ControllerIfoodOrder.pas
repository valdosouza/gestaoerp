unit ControllerIfoodOrder;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrder ,Un_MSg,Generics.Collections,
      ControllerIfoodDelivery,
      ControllerIfoodCustomer,
      ControllerIfoodOrderItems,
      ControllerIfoodOrderPayment,
      ControllerIfoodOrderTotal,
      ControllerIfoodEvents,
      ControllerIfoodOrderBenefits,ControllerClienteFromExterior,
      ControllerPedidoFromExterior;

Type
  TListaIfoodOrder = TObjectList<TIfoodOrder>;

  TControllerIfoodOrder = Class(TControllerBase)

  private

  public
    Registro : TIfoodOrder;
    Lista : TListaIfoodOrder;
    Delivery :TControllerIfoodDelivery;
    Customer :TControllerIfoodCustomer;
    Items :TControllerIfoodOrderItems;
    Payment : TControllerIfoodOrderPayment;
    Total : TControllerIfoodOrderTotal;
    Events : TControllerIfoodEvents;
    Benefits : TControllerIfoodOrderBenefits;
    ClienteFromExterior : TControllerClienteFromExterior;
    PedidoFromExterior : TControllerPedidoFromExterior;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    procedure GetFullOrder;
    procedure getByIDSetes;
    function insert:boolean;
    function update:boolean;
    function replace:boolean;
    Function delete:boolean;
    function getList: Boolean;
    procedure AtualizarStatus;
    procedure AtualizarOrderAgendada;
    procedure Clear;
    function SetInitID_SETES:boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerIfoodOrder.AtualizarOrderAgendada;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
          'UPDATE tb_ifood_order ifd set ',
          'ifd.ordertiming = ''IMMEDIATE'' ',
          'where ifd.deliverydatetimestart is not null  ',
          'and ifd.ordertiming = ''SCHEDULED''  ',
          'and  ifd.deliverydatetimestart <= :TIMEWAIT '
      ));
      ParamByName('TIMEWAIT').AsDate   := Now + StrToTime('00:50:00');
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerIfoodOrder.AtualizarStatus;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE TB_IFOOD_ORDER SET ',
                     ' STATUS =:STATUS, ',
                     ' STATUS_TM =:STATUS_TM ',
                     'WHERE ID =:ID '
      ));
      if Registro.IDSETES > 0 then
        sql.add('AND (ID_SETES=:ID_SETES) ');

      ParamByName('STATUS_TM').AsDate   := Registro.StatusTempo;
      ParamByName('STATUS').AsString    := Registro.Status;
      ParamByName('ID').AsString := Registro.Codigo;
      if Registro.IDSETES > 0 then
        ParamByName('ID_SETES').AsInteger := Registro.IDSETES;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerIfoodOrder.Clear;
begin
  clearObj(Registro);
  Lista.Clear;
  Delivery.Clear;
  Customer.Clear;
  Items.clear;
  Payment.Clear;
  Total.Clear;
  Benefits.Clear;
  ClienteFromExterior.Clear;
  PedidoFromExterior.Clear;
end;

constructor TControllerIfoodOrder.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TIfoodOrder.Create;
  Lista     := TListaIfoodOrder.Create;
  Delivery  := TControllerIfoodDelivery.create(Self);
  Customer  := TControllerIfoodCustomer.create(Self);
  Items     := TControllerIfoodOrderItems.create(Self);
  Payment   := TControllerIfoodOrderPayment.create(Self);
  Total     := TControllerIfoodOrderTotal.create(Self);
  Events    := TControllerIfoodEvents.create(Self);
  Benefits  := TControllerIfoodOrderBenefits.create(Self);
  ClienteFromExterior := TControllerClienteFromExterior.create(Self);
  PedidoFromExterior := TControllerPedidoFromExterior.create(Self);
end;

function TControllerIfoodOrder.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrder.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Delivery.DisposeOf;
  Customer.DisposeOf;
  Items.DisposeOf;
  Payment.DisposeOf;
  Total.DisposeOf;
  Events.DisposeOf;
  Benefits.DisposeOf;
  ClienteFromExterior.DisposeOf;
  inherited;
end;

function TControllerIfoodOrder.insert: boolean;
begin
  Try
    Registro.IDSETES := getNextByField(Registro,'ID_SETES') ;
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrder.replace: boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerIfoodOrder.SetInitID_SETES: boolean;
var
  Lc_Qry : TSTQuery;
  Lc_Contador : Integer;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER ',
                      'WHERE ( id_setes is null)  or (id_setes = 0) '
      ));
      Active := True;
      FetchAll;
      First;
      Lc_Contador := 0;
      while not eof do
      Begin
        inc(Lc_Contador);
        Get(Lc_Qry,Registro) ;
        Registro.IdSetes := Lc_Contador;
        updateObj(Registro);
        Next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerIfoodOrder.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrder.getByIDSetes;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER ',
                      'WHERE id_setes =:id_setes '
      ));
      ParamByName('id_setes').AsInteger:= Registro.IDSETES;
      Active := True;
      FetchAll;
      exist := RecordCount >0;
      if exist then
        Get(Lc_Qry,Registro) ;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerIfoodOrder.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerIfoodOrder.GetFullOrder;
begin
  if Registro.Codigo <> '' then
  Begin
    Delivery.Registro.OrderId := Registro.Codigo;
    Delivery.getbyId;
    Customer.Registro.OrderId := Registro.Codigo;
    Customer.getbyId;
    Items.Registro.OrderId := Registro.Codigo;
    Items.getList;
    Payment.Registro.OrderId := Registro.Codigo;
    Payment.getbyId;
    Total.Registro.OrderId := Registro.Codigo;
    Total.getbyId;
  End;
end;

function TControllerIfoodOrder.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrder;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrder.Create;
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
