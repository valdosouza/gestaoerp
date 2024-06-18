unit tblProductSimilar;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_PRODUCT_SIMILAR')]
  TProductSimilar = Class(TGenericEntity)
  private
    FTB_PRODUCT_ID_SIMILAR: Integer;
    FTB_PRODUCT_ID_MASTER: Integer;
    procedure setFTB_PRODUCT_ID_MASTER(const Value: Integer);
    procedure setFTB_PRODUCT_ID_SIMILAR(const Value: Integer);

  public
    [KeyField('TB_PRODUCT_ID_MASTER')]
    [FieldName('TB_PRODUCT_ID_MASTER')]
    property Master: Integer read FTB_PRODUCT_ID_MASTER write setFTB_PRODUCT_ID_MASTER;

    [KeyField('TB_PRODUCT_ID_SIMILAR')]
    [FieldName('TB_PRODUCT_ID_SIMILAR')]
    property Similar: Integer read FTB_PRODUCT_ID_SIMILAR write setFTB_PRODUCT_ID_SIMILAR;

  End;

implementation

{ TProductSimilar }

procedure TProductSimilar.setFTB_PRODUCT_ID_MASTER(const Value: Integer);
begin
  FTB_PRODUCT_ID_MASTER := Value;
end;

procedure TProductSimilar.setFTB_PRODUCT_ID_SIMILAR(const Value: Integer);
begin
  FTB_PRODUCT_ID_SIMILAR := Value;
end;

end.
