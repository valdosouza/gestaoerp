unit ControllerProductVariant;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblProductVariant ,Un_MSg,Generics.Collections,
  ControllerProductVariantSKU,Data.DB, Datasnap.DBClient, Vcl.StdCtrls;

Type
  TListaProductVAriant = TObjectList<TProductVariant>;

  TControllerProductVariant = Class(TControllerBase)

  private

  public
    Registro : TProductVariant;
    SKU : TControllerProductVariantSKU;
    Lista : TListaProductVAriant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyProduct;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;overload;
    procedure getList(Cds:TClientDataSet);overload;
    procedure ListarTamanho(Combo:TComboBox);
    procedure ListarCor(Combo:TComboBox);
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerProductVariant.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductVariant.Create;
  Lista := TListaProductVAriant.Create;
  SKU := TControllerProductVariantSKU.Create(Self);
end;

function TControllerProductVariant.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerProductVariant.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  SKU.DisposeOf;
  inherited;
end;

function TControllerProductVariant.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUCT_VARIANT');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerProductVariant.ListarCor(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct  sk.cor ',
                'from TB_PRODUCT_VARIANT_SKU sk ',
                'where sk.cor <> '''' '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('COR').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerProductVariant.ListarTamanho(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct  sk.tamanho ',
                'from TB_PRODUCT_VARIANT_SKU sk ',
                'where sk.tamanho <> '''' '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('TAMANHO').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProductVariant.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerProductVariant.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRODUCT_VARIANT');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerProductVariant.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerProductVariant.getById;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRODUCT_VARIANT ',
                'where ID =:ID '
      ));
      ParamByName('ID').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerProductVariant.getbyProduct;
var
  Lc_Qry : TSTQuery;
  LITem : TProductVariant;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRODUCT_VARIANT ',
                'where TB_PRODUCT_ID =:TB_PRODUCT_ID '
      ));
      ParamByName('TB_PRODUCT_ID').AsInteger := Registro.ProdutoVariante;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerProductVariant.getList(Cds: TClientDataSet);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT PV.id, PV.tb_product_id,PVS.id sku_id, PVS.tamanho, ',
                ' PVS.cor, PVS.quantity, PVS.price_tag, lt.web_id ',
                'FROM tb_product_variant pv ',
                '   inner join tb_product_variant_sku pvs ',
                '   on (pv.id = pvs.tb_product_variant_id) ',
                '   left outer join tb_loja_tray lt ',
                '   on (lt.id = pvs.id) and (lt.tabela = ''TB_PRODUCT_VARIANT_SKU'') ',
                'WHERE (PV.tb_product_id =:tb_product_id ) '
      ));
      ParamByName('tb_product_id').AsInteger := Registro.ProdutoVariante;
      Active := True;
      FetchAll;
      First;
      if not Cds.Active then cds.CreateDataSet;
      cds.EmptyDataSet;
      while not eof do
      Begin
        cds.Append;
        cds.FieldByName('ID').AsInteger := FieldByName('ID').AsInteger;
        cds.FieldByName('TB_PRODUCT_ID').AsInteger := FieldByName('TB_PRODUCT_ID').AsInteger;
        cds.FieldByName('SKU_ID').AsInteger := FieldByName('SKU_ID').AsInteger;
        cds.FieldByName('TAMANHO').AsString := FieldByName('TAMANHO').AsString;
        cds.FieldByName('COR').AsString := FieldByName('COR').AsString;
        cds.FieldByName('QUANTITY').AsFloat := FieldByName('QUANTITY').AsFloat;
        cds.FieldByName('PRICE_TAG').AsFloat := FieldByName('PRICE_TAG').AsFloat;
        cds.FieldByName('WEB_ID').AsInteger := FieldByName('WEB_ID').AsInteger;
        cds.Post;
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerProductVariant.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TProductVariant;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PRODUCT_VARIANT '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TProductVariant.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
