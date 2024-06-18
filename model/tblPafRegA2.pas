unit tblPafRegA2;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils,System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_PAF_REG_A2')]
  TPafRegA2 = Class(TGenericEntity)
  private
    FTOTAL_VALUE: Real;
    FID_KIND_DOC: String;
    FPAYMENT_DESC: String;
    FCUSTOMER_DOC: String;
    FDT_RECORD: TDate;
    FDOC_NUMBER: String;
    procedure setFCUSTOMER_DOC(const Value: String);
    procedure setFDOC_NUMBER(const Value: String);
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFID_KIND_DOC(const Value: String);
    procedure setFPAYMENT_DESC(const Value: String);
    procedure setFTOTAL_VALUE(const Value: Real);

  public

    [KeyField('DT_RECORD')]
    [FieldName('DT_RECORD')]
    property DataMovimento: TDate read FDT_RECORD write setFDT_RECORD;

    [KeyField('PAYMENT_DESC')]
    [FieldName('PAYMENT_DESC')]
    property MeioPagamento: String read FPAYMENT_DESC write setFPAYMENT_DESC;

    [KeyField('ID_KIND_DOC')]
    [FieldName('ID_KIND_DOC')]
    property TipoDocumento: String read FID_KIND_DOC write setFID_KIND_DOC;

    [FieldName('TOTAL_VALUE')]
    property Valor: Real read FTOTAL_VALUE write setFTOTAL_VALUE;

    [FieldName('CUSTOMER_DOC')]
    property CnpjCpfCliente: String read FCUSTOMER_DOC write setFCUSTOMER_DOC;

    [FieldName('DOC_NUMBER')]
    property NumeroDocumento: String read FDOC_NUMBER write setFDOC_NUMBER;

  End;

implementation



{ TPafRegA2 }

procedure TPafRegA2.setFCUSTOMER_DOC(const Value: String);
begin
  FCUSTOMER_DOC := Value;
end;

procedure TPafRegA2.setFDOC_NUMBER(const Value: String);
begin
  FDOC_NUMBER := Value;
end;

procedure TPafRegA2.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPafRegA2.setFID_KIND_DOC(const Value: String);
begin
  FID_KIND_DOC := Value;
end;

procedure TPafRegA2.setFPAYMENT_DESC(const Value: String);
begin
  FPAYMENT_DESC := Value;
end;

procedure TPafRegA2.setFTOTAL_VALUE(const Value: Real);
begin
  FTOTAL_VALUE := Value;
end;

end.
