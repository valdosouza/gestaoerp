unit ControllerItensCotacao;

interface

uses STDatabase,STQuery, Classes, Vcl.Grids,SysUtils,ControllerBase,prm_ItensCotacao,
      tblItensCotacao,  Generics.Collections, ControllerProduto,ControllerItensObs,
      FireDAC.Stan.Param;
Type
  TListItensCotacao = TObjectList<TItensCotacao>;

  TControllerItensCotacao = Class(TControllerBase)
    Lista :TListItensCotacao;

  private
    FParametros: TPrmItensCotacao;
    function nextCodigo:Integer;
    procedure setFParametros(const Value: TPrmItensCotacao);
  public
    Registro : TItensCotacao;
    Produto : TControllerProduto;
    Detalhe : TControllerItensObs;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function migra:Boolean;
    function insert:boolean;
    Function delete:boolean;
    procedure getList;
    procedure getById;
    procedure clear;
    function atualiza:boolean;
    function ExisteItemNoCotacao: Boolean;
    property Parametros : TPrmItensCotacao read FParametros write setFParametros;
    procedure search;
  End;


implementation

{ TControllerItensCotacao }

function TControllerItensCotacao.atualiza: boolean;
begin
  UpdateObj(Registro);
end;


procedure TControllerItensCotacao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerItensCotacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensCotacao.Create;
  Lista := TListItensCotacao.create;
  Produto := TControllerProduto.Create(self);
  Detalhe := TControllerItensObs.Create(self);
  FParametros := TPrmItensCotacao.Create;
end;

function TControllerItensCotacao.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

destructor TControllerItensCotacao.Destroy;
begin
  Detalhe.DisposeOf;
  Produto.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;


function TControllerItensCotacao.ExisteItemNoCotacao: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                 'SELECT it.* ' ,
                 ' FROM TB_ITENS_CTC it ' ,
                 ' WHERE ICT_CODVCL=:PRO_CODIGO AND (ICT_CODCTC=:ICT_CODCTC) '
      ));
      ParamByName('ICT_CODCTC').AsInteger := registro.Cotacao;
      ParamByName('PRO_CODIGO').AsInteger := registro.Vinculo;
      Active := True;
      FetchAll;
      First;
      exist := (recordCount > 0);
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(LC_Qry)
  End;
end;

procedure TControllerItensCotacao.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerItensCotacao.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TItensCotacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_ITENS_CTC ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TItensCotacao.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerItensCotacao.insert: boolean;
begin
  try
    Registro.Codigo := nextCodigo;
    insertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerItensCotacao.migra: Boolean;
begin
  Result := True;
  InsertObj(Registro);
end;

function TControllerItensCotacao.nextCodigo: Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(ICT_CODIGO) FROM TB_ITENS_CTC ' );
      Active := True;
      fetchall;
      if recordcount > 0 then
        Result := FieldByName('MAX').AsInteger + 1
      else
        Result := 1;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerItensCotacao.save: boolean;
begin
  try
    if registro.Codigo = 0 then
      Registro.Codigo := nextCodigo;
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerItensCotacao.search;
var
  Lc_Qry : TSTQuery;
  LITem : TItensCotacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        '   SELECT tb_itens_ctc.*, ' +
        '          tb_produto.PRO_CODIGOFAB, tb_produto.PRO_VL_CUSTO, tb_produto.PRO_DIVISOR, tb_produto.PRO_CODIGO, tb_tabela_preco.TPR_MODALIDADE' +
        '     FROM TB_ITENS_CTC tb_itens_ctc ' +
        '     left JOIN TB_PRODUTO tb_produto on (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL) ' +
        '    INNER JOIN TB_TABELA_PRECO tb_tabela_preco on (tb_tabela_preco.TPR_CODIGO = tb_itens_ctc.ICT_CODTPR) ' +
        '    WHERE (tb_itens_ctc.ICT_CODCTC = :ICT_CODCTC) AND (tb_itens_ctc.ICT_TIPO <> ''S'') ' +
        ' ORDER BY tb_itens_ctc.ICT_CODIGO ';

      ParamByName('ICT_CODCTC').AsInteger := Parametros.FieldName.Cotacao;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensCotacao.Create;
        get(Lc_Qry,LITem);

        LITem. CodigoFabrica := FieldByName('PRO_CODIGOFAB').AsString;

        if FieldByName('ICT_QTDE').AsFloat > 0 then
          LITem.SubTotal := FieldByName('ICT_QTDE').AsFloat * FieldByName('ICT_VL_UNIT').AsFloat;

        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerItensCotacao.setFParametros(const Value: TPrmItensCotacao);
begin
  FParametros := Value;
end;

end.
