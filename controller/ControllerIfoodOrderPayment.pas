unit ControllerIfoodOrderPayment;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderPayment ,Un_MSg,Generics.Collections,
      ControllerIfoodOrderPaymentMethods;

Type
  TListaIfoodOrderPayment = TObjectList<TIfoodOrderPayment>;

  TControllerIfoodOrderPayment = Class(TControllerBase)
  private

  public
    Registro : TIfoodOrderPayment;
    Lista : TListaIfoodOrderPayment;
    Methods : TControllerIfoodOrderPaymentMethods;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
    procedure Clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerIfoodOrderPayment.Clear;
begin
  clearObj(Registro);
  Lista.Clear;
end;

constructor TControllerIfoodOrderPayment.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodOrderPayment.Create;
  Lista   := TListaIfoodOrderPayment.Create;
  Methods := TControllerIfoodOrderPaymentMethods.create(Self);
end;

function TControllerIfoodOrderPayment.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderPayment.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Methods.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderPayment.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderPayment.replace: boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerIfoodOrderPayment.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderPayment.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderPayment.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderPayment;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_IFOOD_ORDER_PAYMENT ',
                     'WHERE (TB_IFOOD_ORDER_ID =:TB_IFOOD_ORDER_ID) '
      ));
      ParamByName('TB_IFOOD_ORDER_ID').AsString := Registro.OrderId;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderPayment.Create;
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
