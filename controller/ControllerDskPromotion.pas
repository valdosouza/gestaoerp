unit ControllerDskPromotion;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDskpromotion ,Un_MSg,
      System.Generics.Collections, ControllerDskPromotionItems,
      ObjPromotion,tblDskPromotionItems,tblPromotionItems;

Type
  TListPromotion  =  TObjectList<TDskPromotion>;
  TControllerDskPromotion = Class(TControllerBase)

  private
  protected

  public
    Registro : TDskPromotion;
    Lista : TListPromotion;
    Items  : TControllerDskPromotionItems;
    Obj : TObjPromotion;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function Insert:boolean;
    function replace:boolean;
    procedure getList;
    function update:boolean;
    Function delete:boolean;
    function tempromocao:Boolean;
    procedure getbyId;
    procedure getbyProduct(product,institutionID:Integer);
    procedure FillDataObjeto(Promo: TDskPromotion; Obj: TObjPromotion);
  End;
implementation

{ TControllerDskPromotion }

constructor TControllerDskPromotion.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskPromotion.Create;
  Items  := TControllerDskPromotionItems.Create(Self);
  Lista := TListPromotion.Create;
    Obj       := TObjPromotion.create;
end;


destructor TControllerDskPromotion.Destroy;
begin
  Obj.Destroy;
  Registro.DisposeOf;
  Items.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerDskPromotion.FillDataObjetO(Promo: TDskPromotion; Obj: TObjPromotion);
var
  I,J : Integer;
  LcItem : TPromotionItems;
begin
  With Obj do
  Begin
    Promocao.Codigo          := Promo.Codigo;
    Promocao.Estabelecimento := Promo.Estabelecimento;
    Promocao.Descricao       := Promo.Descricao;
    Promocao.Preco           := Promo.Preco;
    Promocao.Quantidade      := Promo.Quantidade;
    Promocao.Ativo           := Promo.Ativo;
    Promocao.Estabelecimento := Estabelecimento;
    //Itens
    Self.Items.Registro.Promocao := promo.Codigo;
    Self.Items.getList;
    for I := 0 to Self.Items.Lista.Count -1 do
    Begin
      LcItem := TPromotionItems.Create;
      LcItem.Promocao        := Self.Items.Lista[I].Promocao;
      LcItem.Estabelecimento := Estabelecimento;
      LcItem.Produto         := Self.Items.Lista[I].Produto;
      Obj.Items.Add(LcItem);
    End;
  End;
end;

function TControllerDskPromotion.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PROMOTION');
  SaveObj(Registro);
end;


function TControllerDskPromotion.tempromocao: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'select first 1 1 ',
                  'from tb_promotion ',
                  'where  (REG_ACTIVE = ''S'') '
      ));
      Active := True;
      First;
      result := (RecordCount > 0 );
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerDskPromotion.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;


function TControllerDskPromotion.Insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PROMOTION');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;


function TControllerDskPromotion.replace: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PROMOTION');
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskPromotion.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerDskPromotion.getById;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'select * ',
                  'from tb_promotion  ',
                  'where id =:id '
      ));
      ParamByName('id').AsInteger := Registro.Codigo;
      Active := True;
      First;
      exist := (RecordCount > 0 );
      if exist then
        get(Lc_Qry,Registro);

    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;



procedure TControllerDskPromotion.getbyProduct(product,institutionID:Integer);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'select pm.* ',
                  'from tb_promotion pm ',
                  '  inner join tb_promotion_items pmi ',
                  '  on (pmi.tb_institution_id = pm.tb_institution_id) and ',
                  '     (pmi.tb_promotion_id = pm.id) ',
                  'where pmi.tb_product_id =:product_id ',
                  '  and (pm.tb_institution_id =:tb_institution_id) ',
                  '  and (REG_ACTIVE = ''S'') '
      //                  '  and (DT_EXPIRATION >= :DT_EXPIRATION)' retirado para mostrar a data de a promoção expirou
      ));
      ParamByName('tb_institution_id').AsInteger := institutionID;
      ParamByName('product_id').AsInteger := product;
      //ParamByName('DT_EXPIRATION').Asdate := Date;
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

procedure TControllerDskPromotion.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TDskPromotion;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_promotion ',
                      ' ORDER BY description '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TDskPromotion.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;


end;


end.
