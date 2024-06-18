unit tblClienteFromExterior;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CLIENTE_FROM_EXTERIOR')]
  TClienteFromExterior = Class(TGenericEntity)
  private
    FID_EXTERIOR: String;
    FKIND: String;
    FTB_CLIENTE_ID: Integer;
    procedure setFID_EXTERIOR(const Value: String);
    procedure setFKIND(const Value: String);
    procedure setFTB_CLIENTE_ID(const Value: Integer);

  public
    [KeyField('KIND')]
    [FieldName('KIND')]
    property Kind: String read FKIND write setFKIND;

    [KeyField('ID_EXTERIOR')]
    [FieldName('ID_EXTERIOR')]
    property CodigoExterior: String read FID_EXTERIOR write setFID_EXTERIOR;

    [FieldName('TB_CLIENTE_ID')]
    property ClienteCodigo: Integer read FTB_CLIENTE_ID write setFTB_CLIENTE_ID;
  End;


implementation


{ TClienteFromExterior }

procedure TClienteFromExterior.setFID_EXTERIOR(const Value: String);
begin
  FID_EXTERIOR := Value;
end;

procedure TClienteFromExterior.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TClienteFromExterior.setFTB_CLIENTE_ID(const Value: Integer);
begin
  FTB_CLIENTE_ID := Value;
end;

end.
