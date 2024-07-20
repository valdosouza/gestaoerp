unit ControllerIfoodOrderPaymentMethods;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderPaymentMethods ,Un_MSg,Generics.Collections;

Type
  TListaIfoodOrderPaymentMethods = TObjectList<TIfoodOrderPaymentMethods>;

  TControllerIfoodOrderPaymentMethods = Class(TControllerBase)
  private

  public
    Registro : TIfoodOrderPaymentMethods;
    Lista : TListaIfoodOrderPaymentMethods;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerIfoodOrderPaymentMethods.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodOrderPaymentMethods.Create;
  Lista := TListaIfoodOrderPaymentMethods.Create;
end;

function TControllerIfoodOrderPaymentMethods.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderPaymentMethods.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderPaymentMethods.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderPaymentMethods.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderPaymentMethods.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderPaymentMethods.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderPaymentMethods;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER_PAYMENT_METHODS '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderPaymentMethods.Create;
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
