unit tblPayBack;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PAY_BACK')]
  TPayBack = Class(TGenericEntity)

  private
    FHISTORY: String;
    FCREDIT_VALUE: Real;
    FDEBIT_VALUE: Real;
    FTB_CUSTOMER_ID: Integer;
    FId: Integer;
    Fupdated_at: TDAteTime;
    Ftb_institution_id: Integer;
    FTB_ORDER_ID: Integer;
    Fterminal: Integer;
    FDT_RECORD: TDate;
    Fcreated_at: TDAteTime;
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFCREDIT_VALUE(const Value: Real);
    procedure setFDEBIT_VALUE(const Value: Real);
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFHISTORY(const Value: String);
    procedure setFId(const Value: Integer);
    procedure setFTB_CUSTOMER_ID(const Value: Integer);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFterminal(const Value: Integer);
    procedure setFupdated_at(const Value: TDAteTime);

  public

    [FieldName('ID')]
    [KeyField('ID')]
    property Codigo: Integer read FId write setFId;

    [FieldName('TB_INSTITUTION_ID')]
    [KeyField('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('TERMINAL')]
    [KeyField('TERMINAL')]
    property Terminal: Integer read Fterminal write setFterminal;

    [FieldName('TB_CUSTOMER_ID')]
    property Cliente: Integer read FTB_CUSTOMER_ID write setFTB_CUSTOMER_ID;

    [FieldName('DT_RECORD')]
    property Data: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('CREDIT_VALUE')]
    property ValorCredito: Real read FCREDIT_VALUE write setFCREDIT_VALUE;

    [FieldName('DEBIT_VALUE')]
    property ValorDebito: Real read FDEBIT_VALUE write setFDEBIT_VALUE;

    [FieldName('HISTORY')]
    property Historico: String read FHISTORY write setFHISTORY;

    [FieldName('TB_ORDER_ID')]
    property Ordem: Integer read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('CREATED_AT')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('UPDATED_AT')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;

  End;

implementation

{ TPayBack }

procedure TPayBack.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TPayBack.setFCREDIT_VALUE(const Value: Real);
begin
  FCREDIT_VALUE := Value;
end;

procedure TPayBack.setFDEBIT_VALUE(const Value: Real);
begin
  FDEBIT_VALUE := Value;
end;

procedure TPayBack.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPayBack.setFHISTORY(const Value: String);
begin
  FHISTORY := Value;
end;

procedure TPayBack.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TPayBack.setFTB_CUSTOMER_ID(const Value: Integer);
begin
  FTB_CUSTOMER_ID := Value;
end;

procedure TPayBack.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TPayBack.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TPayBack.setFterminal(const Value: Integer);
begin
  Fterminal := Value;
end;

procedure TPayBack.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

end.
