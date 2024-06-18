unit tblOrderImport;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ORDER_IMPORT')]
  TOrderImport = Class(TGenericEntity)
  private
    FQUOTATION_STATE: Real;
    FTRADE_SYSTEM: String;
    FINVOICE_NUMBER: String;
    FNUMBER: Integer;
    FTB_INSTITUTION_ID: Integer;
    FTB_ORDER_ID: Integer;
    FDATA: TDate;
    FQUOTATION_PURCHASE: Real;
    procedure setFDATA(const Value: TDate);
    procedure setFINVOICE_NUMBER(const Value: String);
    procedure setFNUMBER(const Value: Integer);
    procedure setFQUOTATION_STATE(const Value: Real);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTRADE_SYSTEM(const Value: String);
    procedure setFQUOTATION_PURCHASE(const Value: Real);

  public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_ORDER_ID')]
    [FieldName('TB_ORDER_ID')]
    property Ordem: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('NUMBER')]
    property Numero: Integer read FNUMBER write setFNUMBER;

    [FieldName('DATA')]
    property Data: TDate read FDATA write setFDATA;

    [FieldName('INVOICE_NUMBER')]
    property NumeroInvoice: String read FINVOICE_NUMBER write setFINVOICE_NUMBER;

    [FieldName('QUOTATION_STATE')]
    property CotacaoGoverno: Real read FQUOTATION_STATE write setFQUOTATION_STATE;

    [FieldName('QUOTATION_PURCHASE')]
    property CotacaoCompra: Real read FQUOTATION_PURCHASE write setFQUOTATION_PURCHASE;

    [FieldName('TRADE_SYSTEM')]
    property TradeSystem: String read FTRADE_SYSTEM write setFTRADE_SYSTEM;


  End;

implementation


{ TOrderImport }

procedure TOrderImport.setFDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TOrderImport.setFINVOICE_NUMBER(const Value: String);
begin
  FINVOICE_NUMBER := Value;
end;

procedure TOrderImport.setFNUMBER(const Value: Integer);
begin
  FNUMBER := Value;
end;

procedure TOrderImport.setFQUOTATION_PURCHASE(const Value: Real);
begin
  FQUOTATION_PURCHASE := Value;
end;

procedure TOrderImport.setFQUOTATION_STATE(const Value: Real);
begin
  FQUOTATION_STATE := Value;
end;

procedure TOrderImport.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TOrderImport.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TOrderImport.setFTRADE_SYSTEM(const Value: String);
begin
  FTRADE_SYSTEM := Value;
end;

end.
