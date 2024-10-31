unit ControllerEstoques;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblEstoques, prm_stocks, Vcl.Forms;

Type
  TListaEstoques  = TObjectList<TEstoques>;

  TControllerEstoques = Class(TControllerBase)

  private
    FParametros: TPrmStocks;
    procedure setFParametros(const Value: TPrmStocks);

  public
    Registro : TEstoques;
    Lista : TListaEstoques;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    procedure getbyMain;
    function save:boolean;
    function migra:Boolean;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function Replace:boolean;
    procedure GetList;
    function IsPrincipal:Boolean;
    procedure Pc_CriaRegistroEstoque(Pc_Cd_Estoque: Integer);

    procedure clear;
    function salva:boolean;
    procedure Search;
    property Parametros : TPrmStocks read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;


procedure TControllerEstoques.clear;
begin
  clearObj(Registro);
end;

constructor TControllerEstoques.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEstoques.Create;
  Lista := TListaEstoques.Create;
  FParametros := TPrmStocks.Create;
end;

function TControllerEstoques.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerEstoques.Destroy;
begin
 FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerEstoques.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ESTOQUES');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerEstoques.IsPrincipal: Boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add(concat(
              'SELECT * ',
              'FROM TB_ESTOQUES ',
              'WHERE ( ETS_PRINCIPAL = ''S'' )' +
              ' and ( ETS_CODMHA=:ETS_CODMHA ) ',
              ' and ( ETS_CODIGO >0 ) ',
              ' AND ( ETS_CODIGO <>:ETS_CODIGO ) '
      ));
      ParamByName('ETS_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('ETS_CODMHA').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      First;
      REsult := (RecordCount > 0);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerEstoques.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerEstoques.Replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerEstoques.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'ETS_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerEstoques.save: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ESTOQUES');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerEstoques.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TEstoques;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM tb_estoques where ETS_CODMHA =:ETS_CODMHA ';
      ParamByName('ETS_CODMHA').AsInteger := FParametros.FieldName.Estabelecimento;

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ETS_CODIGO = :ETS_CODIGO';
        ParamByName('ETS_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND ETS_DESCRICAO LIKE :ETS_DESCRICAO';
        ParamByName('ETS_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY ETS_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TEstoques.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerEstoques.setFParametros(const Value: TPrmStocks);
begin
  FParametros := Value;
end;

function TControllerEstoques.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerEstoques.getById;
begin
    _getByKey(Registro);
end;


procedure TControllerEstoques.getbyMain;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * FROM tb_estoques ',
                'where ETS_CODMHA=:ETS_CODMHA ',
                ' and (ETS_PRINCIPAL = ''S'' ) ',
                'ORDER BY ETS_CODIGO '
      ));
      ParamByName('ETS_CODMHA').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      exist  := ( RecordCount > 0 );
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerEstoques.GetList;
var
  Lc_Qry : TSTQuery;
  LcLista : TEstoques;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * FROM tb_estoques ',
                'where ETS_CODMHA=:ETS_CODMHA ',
                'ORDER BY ETS_CODIGO '
      ));
      ParamByName('ETS_CODMHA').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEstoques.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEstoques.Pc_CriaRegistroEstoque(Pc_Cd_Estoque : Integer);
Var
  Lc_Qry_Produtos : TSTQuery;
  Lc_Qry_Insere : TSTQuery;
  Lc_SqlTxt : String;
begin
  Lc_Qry_Produtos := GeraQuery;
  Lc_Qry_Insere := GeraQuery;

    try
    //Cria a Consulta de Estoques Disponiveis
    Lc_Qry_Produtos.Active := False;
    Lc_Qry_Produtos.SQL.Clear;
    Lc_SqlTxt := ' SELECT PRO_CODIGO FROM TB_PRODUTO tb_produto '+
                 ' where '+
                 ' not exists (select est_codpro from tb_estoque '+
                 '             where  '+
                 '             tb_estoque.est_codpro = tb_produto.pro_codigo AND '+
                 '             tb_estoque.est_codets = :est_codets ) ';
    Lc_Qry_Produtos.SQL.Add(Lc_SqlTxt);
    Lc_Qry_Produtos.ParamByName('est_codets').AsInteger:= Pc_Cd_Estoque;
    Lc_Qry_Produtos.Active := True;
    Lc_Qry_Produtos.FetchAll;
    Lc_Qry_Produtos.First;

    //Cria a Sql que insere a registro de estoque
    Lc_Qry_Insere.Active := False;
    Lc_Qry_Insere.SQL.Clear;
    Lc_SqlTxt := 'INSERT INTO TB_ESTOQUE( '+
                 '  EST_CODIGO, '+
                 '  EST_CODETS, '+
                 '  EST_CODPRO, '+
                 '  EST_QTDE, '+
                 '  EST_QTDE_MIN) '+
                 'VALUES( '+
                 '  :EST_CODIGO, '+
                 '  :EST_CODETS, '+
                 '  :EST_CODPRO, '+
                 '  :EST_QTDE, '+
                 '  :EST_QTDE_MIN) ';
    Lc_Qry_Insere.SQL.Add(Lc_SqlTxt);
    while not Lc_Qry_Produtos.Eof do
    Begin

      Lc_Qry_Insere.Active := False;
      Lc_Qry_Insere.ParamByName('EST_CODIGO').AsInteger := Fc_Generator('GN_ESTOQUE','TB_ESTOQUE','EST_CODIGO');
      Lc_Qry_Insere.ParamByName('EST_CODETS').AsInteger := Pc_Cd_Estoque;
      Lc_Qry_Insere.ParamByName('EST_CODPRO').AsInteger := Lc_Qry_Produtos.FieldByName('PRO_CODIGO').AsInteger;
      Lc_Qry_Insere.ParamByName('EST_QTDE').AsFloat := 0;
      Lc_Qry_Insere.ParamByName('EST_QTDE_MIN').AsInteger := 0;
      Lc_Qry_Insere.ExecSQL;

      Application.ProcessMessages;
      Lc_Qry_Produtos.Next;
    end;
  finally
    FreeAndNil(Lc_Qry_Produtos);
    FreeAndNil(Lc_Qry_Insere);
  end;
end;

end.
