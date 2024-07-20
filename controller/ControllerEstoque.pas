unit ControllerEstoque;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblEstoque ,Un_MSg,tblestoques, Generics.Collections,ControllerCtrlEstoque;

Type
  TListaEstoque = TObjectList<TEstoque>;
  TListaEstoques  = TObjectList<TEstoques>;

  TControllerEstoque = Class(TControllerBase)

  private
    FTerminal: Integer;
    function Auditoria(Fc_Cd_Produto, Fc_Cd_Estoque: Integer;
      Fc_DataFinal: TDate): Boolean;
    procedure setFTerminal(const Value: Integer);

  public
    Registro : TEstoque;
    ListaEstoques : TListaEstoques;
    Lista : TListaEstoque;
    CtrlEstoque : TControllerCtrlEstoque;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    function Insert:boolean;
    function replace:boolean;
    function update:boolean;
    function updateBalance:boolean;
    Function delete:boolean;
    procedure getbyId;
    procedure getList;
    procedure getListaEstoques;
    Function getIdByEstoqueProduto:Integer;
    function getByCodigo:Boolean;
    function CriaRegistroAutomatico(produtoID:Integer):boolean;
    procedure Clear;
    function ZerarEstoque: boolean;
    property Terminal: Integer read FTerminal write setFTerminal;
  End;

implementation

uses UN_Sistema, Un_Regra_Negocio;

function TControllerEstoque.Auditoria(Fc_Cd_Produto, Fc_Cd_Estoque: Integer;
  Fc_DataFinal: TDate): Boolean;
begin

end;

procedure TControllerEstoque.Clear;
begin
  ClearObj(registro);
end;

constructor TControllerEstoque.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEstoque.Create;
  Lista := TListaEstoque.Create;
  ListaEstoques := TListaEstoques.Create;
  CtrlEstoque := TControllerCtrlEstoque.create(Self);
end;

destructor TControllerEstoque.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  ListaEstoques.DisposeOf;
  CtrlEstoque.DisposeOf;
  inherited;
end;


function TControllerEstoque.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_Estoque');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False
  End;
end;

procedure TControllerEstoque.setFTerminal(const Value: Integer);
begin
  FTerminal := Value;
end;

function TControllerEstoque.update: boolean;
begin
  Try
    Result := True;
    UpdateObj(Registro);
  Except
    Result := False
  End;

end;

function TControllerEstoque.updateBalance: boolean;
var
  Lc_Qry : TSTQuery;
  item : TEstoques;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'UPDATE TB_ESTOQUE SET ' ,
              'EST_QTDE =:EST_QTDE ',
              'where EST_CODETS =:EST_CODETS ',
              ' AND EST_CODPRO =:EST_CODPRO '
      ));
      ParamByName('EST_QTDE').AsFloat := Registro.QtdeDisp;
      ParamByName('EST_CODETS').AsInteger := Registro.codigoEstoque;
      ParamByName('EST_CODPRO').AsInteger := Registro.CodigoProduto;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEstoque.ZerarEstoque: boolean;
Var
  Lc_QtdeZerar : Real;
  Lc_Sentido : String;
begin

  if ( Self.registro.QtdeDisp <> 0) then
  Begin
    if ( Self.registro.QtdeDisp > 0) then
    Begin
      Lc_QtdeZerar := Self.registro.QtdeDisp;
      Lc_Sentido := 'S';
    End
    else
    Begin
      Lc_QtdeZerar := Self.registro.QtdeDisp * -1;
      Lc_Sentido := 'E';
    End;
    with CtrlEstoque.Registro do
    Begin
      Codigo      := 0;
      Terminal    := FTerminal;
      Vinculo     := 'A';
      Ordem       := 0;
      Item        := 0;
      Estoque     := Self.Registro.CodigoEstoque;
      Produto     := Self.Registro.CodigoProduto;
      operacao    := Lc_Sentido;
      Quantidade  := Lc_QtdeZerar;
      Data        := Date;
      Tipo        := 'Avulso';
      UpdateAt    := Now;
    End;
    CtrlEstoque.insert;
    //Retorna o resultado zera para atualizar o tb_estoque
  End;
end;

function TControllerEstoque.CriaRegistroAutomatico(produtoID:Integer): boolean;
VAr
  I:Integer;
begin
  Result := False;
  getListaEstoques;
  for I := 0 to ListaEstoques.Count-1 do
  Begin
    REgistro.CodigoProduto := produtoId;
    REgistro.CodigoEstoque := ListaEstoques[I].Codigo;
    getbyId;
    if not exist then
    Begin
      REgistro.Codigo := 0;
      REgistro.CodigoEstoque := ListaEstoques[I].Codigo;
      REgistro.CodigoProduto := produtoId;;
      Registro.QtdeDisp := 0;
      Insert;
    End;
  End;
end;

function TControllerEstoque.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerEstoque.getById;
begin
  _getByKey(Registro);
end;

Function TControllerEstoque.getIdByEstoqueProduto:Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT EST_CODIGO '+
              'FROM TB_Estoque '+
              'WHERE ( EST_CODETS=:ETS_CODIGO ) AND ( EST_CODPRO =:PRO_CODIGO ) ');
      ParamByName('ETS_CODIGO').AsInteger := Registro.codigoEstoque;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
        Result := FieldByName('EST_CODIGO').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEstoque.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TEstoque;
begin

  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_ESTOQUE where (EST_CODIGO > 0 ) ');
      if Registro.CodigoProduto > 0 then
        sql.add(' AND (EST_CODPRO=:PRO_CODIGO) ');
      if Registro.CodigoEstoque > 0 then
        sql.add(' AND (EST_CODETS=:ETS_CODIGO) ');

      sql.add(' ORDER BY EST_CODIGO ');

      //Passagem de Parametro
      if Registro.CodigoProduto > 0 then
        ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      if Registro.CodigoEstoque > 0 then
        ParamByName('ETS_CODIGO').AsInteger := Registro.CodigoEstoque;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEstoque.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerEstoque.getListaEstoques;
var
  Lc_Qry : TSTQuery;
  item : TEstoques;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat('SELECT * ',
                     'FROM TB_ESTOQUES '
      ));
      sql.add(' ORDER BY ETS_CODIGO ');
      //Passagem de Parametro
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        item := TEstoques.Create;
        get(Lc_qry,item);
        ListaEstoques.add(item);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEstoque.Insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ESTOQUE');
    insertObj(Registro);
    Result := True;
  Except
    Result := False
  End;

end;

function TControllerEstoque.migra: Boolean;
begin
  SaveObj(Registro);
end;


function TControllerEstoque.replace: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ESTOQUE');
    replaceObj(Registro);
    Result := True;
  Except
    Result := False
  End;
end;

function TControllerEstoque.getByCodigo: Boolean;
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
      SQL.Add('SELECT * '+
              'FROM TB_ESTOQUE '+
              'WHERE ( EST_CODIGO=:EST_CODIGO )');
      ParamByName('EST_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.
