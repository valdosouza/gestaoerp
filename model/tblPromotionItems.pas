unit tblPromotionItems;
interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_promotion_items')]
  TPromotionItems = Class(TGenericEntity)
  private
    FProduto: Integer;
    FPromocao: Integer;
    FEstabelecimento: Integer;
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFProduto(const Value: Integer);
    procedure setFPromocao(const Value: Integer);

  public
    [KeyField('tb_promotion_id')]
    [FieldName('tb_promotion_id')]
    property Promocao: Integer read FPromocao write setFPromocao;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read FEstabelecimento write setFEstabelecimento;

    [KeyField('tb_product_id')]
    [FieldName('tb_product_id')]
    property Produto: Integer read FProduto write setFProduto;


  End;

implementation


{ TPromotionItems }

procedure TPromotionItems.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TPromotionItems.setFProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TPromotionItems.setFPromocao(const Value: Integer);
begin
  FPromocao := Value;
end;

end.
