unit ControllerProductionForeCast;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblProductionForeCast ,
         Generics.Collections, Un_MSg, ControllerProduto;

Type
  TListaItemProdForecast = TObjectList<TProductionForeCast>;

  TControllerProductionForeCast = Class(TControllerBase)


  private

  public
    Registro : TProductionForeCast;
    Produto : TControllerProduto;
    Lista : TListaItemProdForecast;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    procedure getlist;
    function getSaldoLoteInfo:Real;
    procedure clear;

  End;

implementation

procedure TControllerProductionForeCast.clear;
begin
  clearObj(registro);
end;

constructor TControllerProductionForeCast.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductionForeCast.Create;
  Lista := TListaItemProdForecast.create;
  Produto := TControllerProduto.create(Self);
end;

function TControllerProductionForeCast.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


destructor TControllerProductionForeCast.Destroy;
begin
  Lista.DisposeOf;
  Produto.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerProductionForeCast.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ORPPREV');
  InsertObj(Registro);
end;

function TControllerProductionForeCast.salva: boolean;
begin
  if Registro.codigo = 0 then
    Registro.Codigo := Generator('GN_ORPPREV');
  SaveObj(Registro);
end;


procedure TControllerProductionForeCast.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerProductionForeCast.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TProductionForeCast;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT opp.* ',
                      'FROM TB_ORPPREV opp ',
                      'WHERE opp.PRE_CODORP =:PRE_CODORP '
                     ));

      ParamByName('PRE_CODORP').AsInteger := Registro.Ordem;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TProductionForeCast.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerProductionForeCast.getSaldoLoteInfo: Real;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select sum(ml.mlt_qtde) total           ',
                'from TB_MOVIMENTO_LOTE ml               ',
                '  INNER JOIN tb_orpprev opp             ',
                '  ON ( opp.pre_codigo = ml.mlt_codvcl)  ',
                'WHERE ( opp.pre_codigo =:pre_codigo )   ' ,
                ' and ( MLT_TIPO = ''PRODUÇÃO M.P.'' )    '
             ));
      ParamByName('PRE_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := FieldByName('total').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


end.
