unit tblProductUfBenef;

interface

Uses TEntity,CAtribEntity, Data.DB;

Type

  [TableName('TB_PRODUCT_UF_BENEF')]
  TProductUfBenef = Class(TGenericEntity)
  private
    FTB_PRODUTCT_ID: Integer;
    FCOD_BENEFITS: String;
    FUF: String;
    FCST: String;
    procedure setFCOD_BENEFITS(const Value: String);
    procedure setFTB_PRODUTCT_ID(const Value: Integer);
    procedure setFUF(const Value: String);
    procedure setFCST(const Value: String);

  public
    [KeyField('TB_PRODUTCT_ID')]
    [FieldName('TB_PRODUTCT_ID')]
    property Produto: Integer read FTB_PRODUTCT_ID write setFTB_PRODUTCT_ID;

    [KeyField('UF')]
    [FieldName('UF')]
    property Estado: String read FUF write setFUF;

    [KeyField('CST')]
    [FieldName('CST')]
    property CST: String read FCST write setFCST;

    [FieldName('COD_BENEFITS')]
    property Beneficio: String read FCOD_BENEFITS write setFCOD_BENEFITS;

  End;


implementation

{ TProductUfBenef }

procedure TProductUfBenef.setFCOD_BENEFITS(const Value: String);
begin
  FCOD_BENEFITS := Value;
end;

procedure TProductUfBenef.setFCST(const Value: String);
begin
  FCST := Value;
end;

procedure TProductUfBenef.setFTB_PRODUTCT_ID(const Value: Integer);
begin
  FTB_PRODUTCT_ID := Value;
end;

procedure TProductUfBenef.setFUF(const Value: String);
begin
  FUF := Value;
end;

end.
