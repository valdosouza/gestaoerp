unit ControllerProductionRealized;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblProductionrealized ,
      Generics.Collections, Un_MSg, ControllerProduto;

Type
  TListaItemProdRealized = TObjectList<TProductionRealized>;

  TControllerProductionRealized = Class(TControllerBase)


  private

  public
    Registro : TProductionRealized;
    Produto : TControllerProduto;
    Lista : TListaItemProdRealized;
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

procedure TControllerProductionRealized.clear;
begin
  clearObj(Registro);
end;

constructor TControllerProductionRealized.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductionRealized.Create;
  Lista := TListaItemProdRealized.create;
  Produto := TControllerProduto.create(Self);
end;

function TControllerProductionRealized.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


destructor TControllerProductionRealized.Destroy;
begin
  Lista.DisposeOf;
  Produto.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerProductionRealized.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ORPREAL');
  InsertObj(Registro);
end;

function TControllerProductionRealized.salva: boolean;
begin
  if Registro.codigo = 0 then
    Registro.Codigo := Generator('GN_ORPREAL');
  SaveObj(Registro);
end;


procedure TControllerProductionRealized.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerProductionRealized.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TProductionRealized;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT opr.* ',
                      'FROM TB_ORPREAL opr ',
                      'WHERE opr.ORL_CODORP =:ORL_CODORP '
                     ));

      ParamByName('ORL_CODORP').AsInteger := Registro.Ordem;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TProductionRealized.Create;
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

function TControllerProductionRealized.getSaldoLoteInfo: Real;
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
                '  INNER JOIN tb_orpreal opr             ',
                '  ON ( opr.orl_codigo = ml.mlt_codvcl)  ',
                'WHERE ( opr.orl_codigo =:orl_codigo )   ',
                ' and ( MLT_TIPO = ''PRODUÇÃO P.A.'' )    '
             ));
      ParamByName('ORL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := FieldByName('total').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
