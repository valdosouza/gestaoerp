unit tblPayTypeHasInterm;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('TB_PAY_TYPE_HAS_INTERM')]
  TPayTypeHasInterm = Class(TGenericEntity)
  private
    FTB_PAYMENT_TYPE_ID: Integer;
    FUSER_IDENTIFIER: String;
    FFISCAL_DOC: String;
    procedure setFFISCAL_DOC(const Value: String);
    procedure setFTB_PAYMENT_TYPE_ID(const Value: Integer);
    procedure setFUSER_IDENTIFIER(const Value: String);

  public
    [FieldName('TB_PAYMENT_TYPE_ID')]
    [KeyField('TB_PAYMENT_TYPE_ID')]
    property FormaPagamento: Integer read FTB_PAYMENT_TYPE_ID write setFTB_PAYMENT_TYPE_ID;

    [FieldName('FISCAL_DOC')]
    property DocFiscal: String read FFISCAL_DOC write setFFISCAL_DOC;

    [FieldName('USER_IDENTIFIER')]
    property UsuarioNaPlataforma: String read FUSER_IDENTIFIER write setFUSER_IDENTIFIER;

  End;
implementation


{ TPayTypeHasInterm }

procedure TPayTypeHasInterm.setFFISCAL_DOC(const Value: String);
begin
  FFISCAL_DOC := Value;
end;

procedure TPayTypeHasInterm.setFTB_PAYMENT_TYPE_ID(const Value: Integer);
begin
  FTB_PAYMENT_TYPE_ID := Value;
end;

procedure TPayTypeHasInterm.setFUSER_IDENTIFIER(const Value: String);
begin
  FUSER_IDENTIFIER := Value;
end;

end.
