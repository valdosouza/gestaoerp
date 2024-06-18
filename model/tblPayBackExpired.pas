unit tblPayBackExpired;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PAY_BACK_EXPIRED')]
  TPayBackExpired = Class(TGenericEntity)

  private
    FTB_PAYBACK_ID: Integer;
    Fupdated_at: TDAteTime;
    FVALUE_EXPIRED: Real;
    Ftb_institution_id: Integer;
    Fterminal: Integer;
    FDT_RECORD: TDate;
    Fcreated_at: TDAteTime;
    FCodigoCliente: Integer;
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFTB_PAYBACK_ID(const Value: Integer);
    procedure setFterminal(const Value: Integer);
    procedure setFupdated_at(const Value: TDAteTime);
    procedure setFVALUE_EXPIRED(const Value: Real);
    procedure setFCodigoCliente(const Value: Integer);

  public

    [FieldName('TB_PAY_BACK_ID')]
    [KeyField('TB_PAY_BACK_ID')]
    property Codigo: Integer read FTB_PAYBACK_ID write setFTB_PAYBACK_ID;

    [FieldName('TB_INSTITUTION_ID')]
    [KeyField('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('TERMINAL')]
    [KeyField('TERMINAL')]
    property Terminal: Integer read Fterminal write setFterminal;

    [FieldName('TB_CUSTOMER_ID')]
    property CodigoCliente: Integer read FCodigoCliente write setFCodigoCliente;

    [FieldName('DT_RECORD')]
    property Data: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('VALUE_EXPIRED')]
    property ValorExpirado: Real read FVALUE_EXPIRED write setFVALUE_EXPIRED;

    [FieldName('CREATED_AT')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('UPDATED_AT')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;

  End;

implementation


{ TPayBackExpired }

procedure TPayBackExpired.setFCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

procedure TPayBackExpired.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TPayBackExpired.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPayBackExpired.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TPayBackExpired.setFTB_PAYBACK_ID(const Value: Integer);
begin
  FTB_PAYBACK_ID := Value;
end;

procedure TPayBackExpired.setFterminal(const Value: Integer);
begin
  Fterminal := Value;
end;

procedure TPayBackExpired.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

procedure TPayBackExpired.setFVALUE_EXPIRED(const Value: Real);
begin
  FVALUE_EXPIRED := Value;
end;

end.
