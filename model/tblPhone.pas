unit tblPhone;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_PHONE')]
  TPHONE = Class(TGenericEntity)
  private
    FID: Integer;
    FNUMBER: String;
    FCONTACT: String;
    FADDRESS_KIND: String;
    FKIND: String;

    procedure setFID(Value :   INTEGER);
    procedure setFKIND(Value :   String);
    procedure setFCONTACT(Value :   String);
    procedure setFNUMBER(Value :   String);
    procedure setFADDRESS_KIND(Value :   String);

  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('KIND')]
    [FieldName('KIND')]
    property Tipo: String read FKIND write setFKIND;

    [FieldName('CONTACT')]
    property Contato: String read FCONTACT write setFCONTACT;

    [KeyField('NUMBER')]
    [FieldName('NUMBER')]
    property Numero: String read FNUMBER write setFNUMBER;

    [FieldName('ADDRESS_KIND')]
    property TipoEndereco: String read FADDRESS_KIND write setFADDRESS_KIND;

  End;

implementation

{ TPHONE }

procedure TPHONE.setFADDRESS_KIND(Value: String);
begin
  FADDRESS_KIND := Value;
end;

procedure TPHONE.setFCONTACT(Value: String);
begin
  FCONTACT := Value;
end;

procedure TPHONE.setFID(Value: INTEGER);
begin
  FID := Value;
end;

procedure TPHONE.setFKIND(Value: String);
begin
  FKIND := Value;
end;

procedure TPHONE.setFNUMBER(Value: String);
begin
  FNUMBER := Value;
end;

end.
