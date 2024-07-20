unit ControllerProductVariantSKU;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblProductVariantSKU ,Un_MSg,Generics.Collections;

Type
  TListaProductVAriantSKU = TObjectList<TProductVariantSKU>;

  TControllerProductVariantSKU = Class(TControllerBase)

  private

  public
    Registro : TProductVariantSKU;
    Lista : TListaProductVAriantSKU;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;

  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerProductVariantSKU.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductVariantSKU.Create;
  Lista := TListaProductVAriantSKU.Create;
end;

function TControllerProductVariantSKU.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerProductVariantSKU.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerProductVariantSKU.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUCT_VARIANT_SKU');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerProductVariantSKU.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerProductVariantSKU.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRODUCT_VARIANT_SKU');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerProductVariantSKU.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerProductVariantSKU.getById;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRODUCT_VARIANT_SKU ',
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


function TControllerProductVariantSKU.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TProductVariantSKU;
begin
  Result := True;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PRODUCT_VARIANT_SKU ',
                'where TB_PRODUCT_VARIANT_ID = :TB_PRODUCT_VARIANT_ID '
      ));
      ParamByName('TB_PRODUCT_VARIANT_ID').AsInteger := Registro.VarianteID;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TProductVariantSKU.Create;
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
