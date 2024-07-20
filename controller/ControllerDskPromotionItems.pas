unit ControllerDskPromotionItems;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDskpromotionItems ,Un_MSg,
      System.Generics.Collections, ControllerProduto,tblDskPromotion,ObjPromotion;

Type
  TListaItensPromocao =  TObjectList<TDskPromotionItems>;

  TControllerDskPromotionItems = Class(TControllerBase)

  private
  public
    Registro : TDskPromotionItems;
    Lista : TListaItensPromocao;
    Produto : TControllerProduto;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function Insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteByPromotion:boolean;
    procedure getbyId;
    procedure getList;
    procedure getbyProduct;
    procedure getProductDuplicated;

  End;

implementation

{ TControllerDskPromotionItems }

constructor TControllerDskPromotionItems.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TDskPromotionItems.create;
  Produto   := TControllerProduto.create(Self);
  Lista     := TListaItensPromocao.create;

end;

function TControllerDskPromotionItems.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskPromotionItems.deleteByPromotion: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('delete ',
                     'from tb_promotion_items ',
                     'where (tb_institution_id =:institution_id ) ',
                     'and (tb_promotion_id=:promotion_id) '
                     ));
      ParamByName('institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('promotion_id').AsInteger := Registro.Promocao;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

destructor TControllerDskPromotionItems.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Produto.DisposeOf;
  inherited;
end;




procedure TControllerDskPromotionItems.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerDskPromotionItems.getbyProduct;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'select * ',
                  'from tb_promotion_items pmi ',
                  'where pmi.tb_product_id =:product_id ',
                  ' pmi.TB_INSTITUTION_ID=:INSTITUTION_ID '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('product_id').AsInteger := Registro.Produto;
      Active := True;
      First;
      exist := (RecordCount > 0 );
      if exist then
        get(Lc_Qry,Registro);
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerDskPromotionItems.getList;
Var
  Lc_Qry : TSTQuery;
  LITem : TDskPromotionItems;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
                'Select * ',
                'from  TB_PROMOTION_ITEMS ',
                ' where tb_promotion_id =:promotion_id '
          ));
      ParamByName('promotion_id').AsInteger := Registro.Promocao;
      Active := True;
      FetchAll;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TDskPromotionItems.Create;
        get(Lc_Qry,LITem);
        Lista.Add(LITem);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskPromotionItems.getProductDuplicated;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'select * ',
                  'from tb_promotion_items pmi ',
                  'where ( pmi.tb_product_id =:product_id  )',
                  ' AND  ( pmi.TB_INSTITUTION_ID=:INSTITUTION_ID ) ',
                  ' AND  ( pmi.TB_PROMOTION_ID <>:PROMOTION_ID)',
                  ' AND  ( pmi.TB_PROMOTION_ID > 0 )'
      ));
      ParamByName('INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('PROMOTION_ID').AsInteger := Registro.Promocao;
      ParamByName('product_id').AsInteger := Registro.Produto;
      Active := True;
      First;
      exist := (RecordCount > 0 );
      if exist then
        get(Lc_Qry,Registro);
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerDskPromotionItems.Insert: boolean;
begin
  Try
    InsertObj(Registro);
    REsult := True;
  Finally
    REsult := False;
  End;
end;

function TControllerDskPromotionItems.replace: boolean;
begin
  Try
    replaceObj(Registro);
    REsult := True;
  Finally
    REsult := False;
  End;

end;

function TControllerDskPromotionItems.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerDskPromotionItems.update: boolean;
begin
  UpdateObj(Registro);
end;

end.
