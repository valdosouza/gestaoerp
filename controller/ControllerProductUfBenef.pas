unit ControllerProductUfBenef;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Data.DB,
      tblProductUfBenef,Generics.Collections;


Type
  TListaProductUfBenef = TObjectList<TProductUfBenef>;

  TControllerProductUfBenef = Class(TControllerBase)
    Lista : TListaProductUfBenef;
  private

  public
    Registro : TProductUfBenef;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function salva:boolean;
    function insere:boolean;
    function getlist:boolean;
    function deleteAllProduct:boolean;
  End;

implementation

{ TControllerCashier }

uses Un_Regra_Negocio;

constructor TControllerProductUfBenef.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductUfBenef.Create;
  Lista := TListaProductUfBenef.Create;
end;

function TControllerProductUfBenef.deleteAllProduct: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'delete from tb_product_uf_benef pb ',
              'where pb.tb_produtct_id=:produtct_id '
      ));
      ParamByName('produtct_id').AsInteger := Registro.Produto;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerProductUfBenef.Destroy;
begin
  FreeAndNil( Lista );
  Registro.DisposeOf;
  inherited;
end;



procedure TControllerProductUfBenef.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerProductUfBenef.getlist: boolean;
Var
  LcItem : TProductUfBenef;
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'select * ',
              'from tb_product_uf_benef pb ',
              'where pb.tb_produtct_id=:produtct_id '
      ));
      ParamByName('produtct_id').AsInteger := Registro.Produto;
      Active := True;
      First;
      while not eof do
      Begin
        LcItem := TProductUfBenef.Create;
        get(Lc_Qry,LcItem);
        lista.Add(LcItem);
        next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProductUfBenef.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerProductUfBenef.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
