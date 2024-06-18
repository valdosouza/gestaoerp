unit tblLojaTrayOrder;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_LOJA_TRAY_ORDER')]
  TLojaTrayOrder = Class(TGenericEntity)

  private
    FSHIPMENT_VALUE: Real;
    FDISCOUNT: REal;
    FPAYMENT_FORM: String;
    FDT_SHIPMENT: TDate;
    FPARTIAL_TOTAL: REal;
    FId: Integer;
    FMODIFIED: TDatetime;
    FDT_PAYMENT: TDAte;
    FTOTAL_VALUE: Real;
    FSTATUS: String;
    FCUSTOMER_ID: Integer;
    FSHIPMENT: String;
    FTAXES: REal;
    FDT_RECORD: TDATE;
    procedure setFCUSTOMER_ID(const Value: Integer);
    procedure setFDISCOUNT(const Value: REal);
    procedure setFDT_PAYMENT(const Value: TDAte);
    procedure setFDT_RECORD(const Value: TDATE);
    procedure setFDT_SHIPMENT(const Value: TDate);
    procedure setFId(const Value: Integer);
    procedure setFMODIFIED(const Value: TDatetime);
    procedure setFPARTIAL_TOTAL(const Value: REal);
    procedure setFPAYMENT_FORM(const Value: String);
    procedure setFSHIPMENT(const Value: String);
    procedure setFSHIPMENT_VALUE(const Value: Real);
    procedure setFSTATUS(const Value: String);
    procedure setFTAXES(const Value: REal);
    procedure setFTOTAL_VALUE(const Value: Real);


  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: Integer read FId write setFId;

    [FieldName('STATUS')]
    property Situacao: String read FSTATUS write setFSTATUS;

    [FieldName('DT_RECORD')]
    property Data: TDATE read FDT_RECORD write setFDT_RECORD;

    [FieldName('CUSTOMER_ID')]
    property CodigoCliente: Integer read FCUSTOMER_ID write setFCUSTOMER_ID;

    [FieldName('PARTIAL_TOTAL')]
    property SubTotal: REal read FPARTIAL_TOTAL write setFPARTIAL_TOTAL;

    [FieldName('TAXES')]
    property Taxas: REal read FTAXES write setFTAXES;

    [FieldName('DISCOUNT')]
    property Desconto: REal read FDISCOUNT write setFDISCOUNT;

    [FieldName('SHIPMENT')]
    property TipoFrete: String read FSHIPMENT write setFSHIPMENT;

    [FieldName('SHIPMENT_VALUE')]
    property ValorFrete: Real read FSHIPMENT_VALUE write setFSHIPMENT_VALUE;

    [FieldName('DT_SHIPMENT')]
    property DataEntrega: TDate read FDT_SHIPMENT write setFDT_SHIPMENT;

    [FieldName('PAYMENT_FORM')]
    property FormaPagamento: String read FPAYMENT_FORM write setFPAYMENT_FORM;

    [FieldName('TOTAL_VALUE')]
    property ValorTotal: Real read FTOTAL_VALUE write setFTOTAL_VALUE;

    [FieldName('DT_PAYMENT')]
    property DataPagamento: TDAte read FDT_PAYMENT write setFDT_PAYMENT;

    [FieldName('MODIFIED')]
    property RegistroAlterado: TDatetime read FMODIFIED write setFMODIFIED;

  End;

implementation

{ TLojaTrayOrder }

procedure TLojaTrayOrder.setFCUSTOMER_ID(const Value: Integer);
begin
  FCUSTOMER_ID := Value;
end;

procedure TLojaTrayOrder.setFDISCOUNT(const Value: REal);
begin
  FDISCOUNT := Value;
end;

procedure TLojaTrayOrder.setFDT_PAYMENT(const Value: TDAte);
begin
  FDT_PAYMENT := Value;
end;

procedure TLojaTrayOrder.setFDT_RECORD(const Value: TDATE);
begin
  FDT_RECORD := Value;
end;

procedure TLojaTrayOrder.setFDT_SHIPMENT(const Value: TDate);
begin
  FDT_SHIPMENT := Value;
end;

procedure TLojaTrayOrder.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TLojaTrayOrder.setFMODIFIED(const Value: TDatetime);
begin
  FMODIFIED := Value;
end;

procedure TLojaTrayOrder.setFPARTIAL_TOTAL(const Value: REal);
begin
  FPARTIAL_TOTAL := Value;
end;

procedure TLojaTrayOrder.setFPAYMENT_FORM(const Value: String);
begin
  FPAYMENT_FORM := Value;
end;

procedure TLojaTrayOrder.setFSHIPMENT(const Value: String);
begin
  FSHIPMENT := Value;
end;

procedure TLojaTrayOrder.setFSHIPMENT_VALUE(const Value: Real);
begin
  FSHIPMENT_VALUE := Value;
end;

procedure TLojaTrayOrder.setFSTATUS(const Value: String);
begin
  FSTATUS := Value;
end;

procedure TLojaTrayOrder.setFTAXES(const Value: REal);
begin
  FTAXES := Value;
end;

procedure TLojaTrayOrder.setFTOTAL_VALUE(const Value: Real);
begin
  FTOTAL_VALUE := Value;
end;

end.
