Unit ControllerCustoPedido;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,tblCartao,
      Un_sistema,Un_Regra_Negocio, tblCustoPedido,ControllerProduto ;

Type
  TControllerCustoPedido = Class(TControllerBase)
  private
  public
    Registro : TCustoPedido;
    Produto : TControllerProduto;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function getMaxCodigo:Integer;
    function salva:boolean;
    function insere:boolean;
    function deleteOrigensAutomatica:Boolean;
    function getCustoProduto(NumeroNota:String;CodigoProduto:Integer):Real;
    procedure clear;
    procedure AtualizarUltimoCusto(Data:TDatetime;Hora:TTime;ProdutoID:Integer;UltimoCusto:Real);
  End;

implementation

{ TControllerCustoPedido }

procedure TControllerCustoPedido.AtualizarUltimoCusto(Data:TDatetime;Hora:TTime;ProdutoID:Integer;UltimoCusto:Real);
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.add( concat(
                'select n.nfl_codigo ',
                'from tb_nota_fiscal n ',
                '  inner join tb_itens_nfl i ',
                '  on (i.itf_codnfl = n.nfl_codigo) ',
                'where  n.nfl_dt_emissao =:nfl_dt_emissao ',
                ' and n.nfl_hr_saida >:nfl_hr_saida ',
                ' and i.itf_codpro =:itf_codpro ',
                ' and (n.NFL_TIPO =:NFL_TIPO) '
      ));
      ParamByName('NFL_TIPO').AsString := 'EE';
      ParamByName('nfl_dt_emissao').AsDateTime := Data;
      ParamByName('nfl_hr_saida').Astime       := Hora;
      ParamByName('itf_codpro').AsInteger      := ProdutoID;
      Active := True;
      FetchAll;
      if (RecordCount = 0 ) then
      Begin
        Produto.Registro.Codigo := ProdutoID;
        Produto.Registro.UltimoCusto := UltimoCusto;
        Produto.AtualizaUltimoCusto;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerCustoPedido.clear;
begin
  clearObj(Registro);
end;

constructor TControllerCustoPedido.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCustoPedido.Create;
  Produto := TControllerProduto.create(Self);
end;

destructor TControllerCustoPedido.Destroy;
begin
  Produto.disposeOf;
  Registro.disposeOf;
  inherited;
end;


procedure TControllerCustoPedido.getById;
begin
  _getByKey(Registro);
end;

function TControllerCustoPedido.getCustoProduto(NumeroNota: String;
  CodigoProduto: Integer): Real;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry :=  GeraQuery;
    witH Lc_Qry do
    Begin
      sql.add('SELECT SUM(CTP_VL_REAL)  TOTAL '+
              'FROM tb_custo_pedido C '+
              '  INNER JOIN tb_nota_fiscal N '+
              '  ON (C.ctp_codped = N.nfl_codped) '+
              'WHERE ( N.nfl_numero LIKE :NFL_NUMERO ) '+
              '  AND ( C.ctp_codpro =:PRO_CODIGO)' );

      ParamByName('NFL_NUMERO').AsString := '%' + NumeroNota;
      ParamByName('PRO_CODIGO').AsInteger := CodigoProduto;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('TOTAL').Asfloat
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCustoPedido.getMaxCodigo: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry :=  GeraQuery;
    witH Lc_Qry do
    Begin
      sql.add('select max(CTP_CODIGO) id '+
              'from TB_CUSTO_PEDIDO '+
              'where CTP_CODPED=:PED_CODIGO' );
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('id').AsInteger + 1
      else
        Result := 1;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCustoPedido.insere: boolean;
begin
  Registro.Codigo := getMaxCodigo;
  InsertObj(Registro);
end;

function TControllerCustoPedido.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerCustoPedido.deleteOrigensAutomatica:Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  TRy
    Lc_Qry :=  GeraQuery;
    witH Lc_Qry do
    Begin
      sql.add('delete from tb_custo_pedido '+
              'where CTP_CODPED=:PED_CODIGO '+
              ' and (CTP_ORIGEM = ''A'') ' );
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      execSql;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
