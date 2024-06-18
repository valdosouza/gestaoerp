unit objOrderBonus;

interface

uses System.SysUtils, objEntityFiscal, tblCustomer,  ObjSalesMan, tblOrder,
  System.Generics.Collections, tblOrderItem, tblOrderBonus,objBase;

Type
  TListItems = TObjectList<TOrderItem>;
  TObjOrderBonus = Class(TObjBase)
  private
    FDocFiscalVendedor: String;
    FItems: TListItems;
    FCliente: TCustomer;
    FOrder: TOrder;
    FVendedor: Integer;
    FOrderBonus: TOrderBonus;
    FFiscal: TObjEntityFiscal;
    procedure setFCliente(const Value: TCustomer);
    procedure setFDocFiscalVendedor(const Value: String);
    procedure setFFiscal(const Value: TObjEntityFiscal);
    procedure setFItems(const Value: TListItems);
    procedure setFOrder(const Value: TOrder);
    procedure setFOrderBonus(const Value: TOrderBonus);
    procedure setFVendedor(const Value: Integer);


  public
      constructor Create;override;
      destructor Destroy;override;
      procedure clear;
      property Fiscal : TObjEntityFiscal read FFiscal write setFFiscal;
      property Cliente : TCustomer read FCliente write setFCliente;
      property Vendedor : Integer read FVendedor write setFVendedor;
      property DocFiscalVendedor : String read FDocFiscalVendedor write setFDocFiscalVendedor;
      property Order : TOrder read FOrder write setFOrder;
      property OrderBonus : TOrderBonus read FOrderBonus write setFOrderBonus;
      property Items  : TListItems  read FItems write setFItems;

  End;

implementation

uses GenericDao;
{ TObjOrderBonus }

procedure TObjOrderBonus.clear;
begin
  FItems.Clear;
  TGenericDAO._Clear(FCliente);
  FFiscal.clear;
  TGenericDAO._Clear(FOrderBonus);
  TGenericDAO._Clear(FOrder);
end;

constructor TObjOrderBonus.Create;
begin
  inherited;
  FItems      := TListItems.Create;
  FFiscal     := TObjEntityFiscal.Create;
  FCliente    := TCustomer.Create;
  FOrderBonus := TOrderBonus.Create;
  FOrder      := TOrder.Create;;
end;

destructor TObjOrderBonus.Destroy;
begin
  FItems.DisposeOf;
  Fiscal.Destroy;
  FCliente.DisposeOf;
  FOrderBonus.DisposeOf;
  FOrder.DisposeOf;
end;

procedure TObjOrderBonus.setFCliente(const Value: TCustomer);
begin
  FCliente := Value;
end;

procedure TObjOrderBonus.setFDocFiscalVendedor(const Value: String);
begin
  FDocFiscalVendedor := Value;
end;

procedure TObjOrderBonus.setFFiscal(const Value: TObjEntityFiscal);
begin
  FFiscal := Value;
end;

procedure TObjOrderBonus.setFItems(const Value: TListItems);
begin
  FItems := Value;
end;

procedure TObjOrderBonus.setFOrder(const Value: TOrder);
begin
  FOrder := Value;
end;

procedure TObjOrderBonus.setFOrderBonus(const Value: TOrderBonus);
begin
  FOrderBonus := Value;
end;

procedure TObjOrderBonus.setFVendedor(const Value: Integer);
begin
  FVendedor := Value;
end;

end.


