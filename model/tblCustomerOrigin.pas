unit tblCustomerOrigin;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_CUSTOMER_ORIGEN')]
  TCustomerOrigin = Class(TGenericEntity)

  private
    FDESCRIPTION: String;
    FID: Integer;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFID(const Value: Integer);

  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('DESCRIPTION')]
    property Descricao: String read FDESCRIPTION write setFDESCRIPTION;
  End;

implementation

{ TCustomerOrigin }

procedure TCustomerOrigin.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TCustomerOrigin.setFID(const Value: Integer);
begin
  FID := Value;
end;

end.
