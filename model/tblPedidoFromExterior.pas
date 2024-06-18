unit tblPedidoFromExterior;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PEDIDO_FROM_EXTERIOR')]
  TPedidoFromExterior = Class(TGenericEntity)
  private
    FID_EXTERIOR: String;
    FTB_PEDIDO_ID: Integer;
    FKIND: String;
    procedure setFID_EXTERIOR(const Value: String);
    procedure setFKIND(const Value: String);
    procedure setFTB_PEDIDO_ID(const Value: Integer);

  public
    [KeyField('KIND')]
    [FieldName('KIND')]
    property Kind: String read FKIND write setFKIND;

    [KeyField('ID_EXTERIOR')]
    [FieldName('ID_EXTERIOR')]
    property CodigoExterior: String read FID_EXTERIOR write setFID_EXTERIOR;

    [FieldName('TB_PEDIDO_ID')]
    property PedidoCodigo: Integer read FTB_PEDIDO_ID write setFTB_PEDIDO_ID;
  End;


implementation

{ TPedidoFromExterior }

procedure TPedidoFromExterior.setFID_EXTERIOR(const Value: String);
begin
  FID_EXTERIOR := Value;
end;

procedure TPedidoFromExterior.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TPedidoFromExterior.setFTB_PEDIDO_ID(const Value: Integer);
begin
  FTB_PEDIDO_ID := Value;
end;

end.
