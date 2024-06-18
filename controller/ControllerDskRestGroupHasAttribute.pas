unit ControllerDskRestGroupHasAttribute;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblProduto ,Un_MSg,ControllerMedida,
      Generics.Collections,controllerPreco,ObjRestMenu,ControllerEmbalagem,
      controllerEstoques,ControllerMarcaProduto,ControllerGRupos,ControllerCtrlEstoque,
      ControllerTabelaPreco, tblRestMenuHasProduct,
      tblStockBalance, tblPrice,ObjStockList,ObjPriceList, System.StrUtils,
  Vcl.Forms;





Type
  TListaProdutos = TObjectList<TProduto>;

  TControllerDskRestGroupHasAttribute = Class(TControllerBase)

  private

  protected

  public
    Registro : TProduto;
    Lista : TListaProdutos;
    Marca : TControllerMarcaProduto;
    Medida : TControllerMedida;
    Embalagem : TControllerEmbalagem;
    Preco : TcontrollerPreco;
    TabelaPreco :  TControllerTabelaPreco;
    Estoque : TcontrollerEstoques;
    Grupo : TControllerGRupos;
    MovimentoEStoque :TControllerCtrlEstoque;
    Obj  : TObjRestMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    Function migra:Boolean;
    procedure getbyId;
    procedure getMenuToSincronia;
    function getbyFactoryProduct:Boolean;
    function getbyDescription:Boolean;
    function getbyBarCode:Boolean;
    function getCusto:Real;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteaLL:boolean;
    procedure ReOrdenaSequenciaCodigo;
    procedure getList(limite:String);
    function getField(codigo:Integer;Field:String):String;
    Function getByDescricao(descricao:String):Integer;
    procedure MarcaPromocao(Codigo:Integer;Ativa:Boolean);
    procedure clear;
    function saveDatawebObjeto(DObj : TObjRestMenu):Boolean;
    function temmovimento:Boolean;
    procedure FillDataObjects(prod: TProduto;ObjMenu:TObjRestMenu; institutioWebId:Integer);
    procedure MigraSelf(Lc_Qry: TSTQuery);
    PROCEDURE AtualizaSeries(Operacao,Disponivel:String;ItemID:Integer);
    procedure Ativa;
    procedure DesativarTodos;
  End;

implementation

uses Un_Regra_Negocio;


procedure TControllerDskRestGroupHasAttribute.Ativa;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                'PRO_ATIVO = :PRO_ATIVO ',
                'WHERE ( PRO_CODIGO=:PRO_CODIGO) '
      ));
      ParamByName('PRO_ATIVO').AsString := Registro.Ativo;
    ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestGroupHasAttribute.AtualizaSeries(Operacao,Disponivel: String;ItemID:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      Active := False;
      if Operacao = 'S' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        SQL.Clear;
        sql.Add(concat('UPDATE TB_SERIE_PRODUTO SET SRP_DISPON =:SRP_DISPON WHERE SRP_CODSAI=:SRP_CODSAI '));
        Active := False;
        ParamByName('SRP_DISPON').AsString := Disponivel;
        ParamByName('SRP_CODSAI').AsInteger := ItemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      end
      else
      if Operacao = 'E' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        Active := False;
        SQL.Clear;
        sql.Add(concat('UPDATE TB_SERIE_PRODUTO SET SRP_DISPON =:SRP_DISPON WHERE SRP_CODENT =:SRP_CODENT '));
        ParamByName('SRP_DISPON').AsString := Disponivel;
        ParamByName('SRP_CODENT').AsInteger := ItemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      end
      else
      if Operacao = 'A' then
      Begin
        IF not Transaction.InTransaction THEN Transaction.StartTransaction;
        //exclui as series de entrada
        Active := False;
        SQL.Clear;
        sql.Add(concat('DELETE FROM TB_SERIE_PRODUTO SET WHERE SRP_CODENT:SRP_CODENT '));
        ParamByName('SRP_CODENT').AsInteger := ItemId;
        ExecSQL;
        //exclui as series de Saida
        Active := False;
        SQL.Clear;
        sql.Add(concat('DELETE FROM TB_SERIE_PRODUTO SET WHERE SRP_CODSAI:SRP_CODSAI '));
        ParamByName('SRP_CODSAI').AsInteger := itemId;
        ExecSQL;
        IF Transaction.InTransaction THEN Transaction.Commit;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
  //Executa a Ação

end;

procedure TControllerDskRestGroupHasAttribute.clear;
begin
  clearObj(registro);
end;

constructor TControllerDskRestGroupHasAttribute.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TProduto.Create;
  Marca     := TControllerMarcaProduto.Create(Self);
  Medida    := TControllerMedida.Create(Self);
  Embalagem := TControllerEmbalagem.Create(Self);
  Lista     := TListaProdutos.Create;
  Preco     := TcontrollerPreco.Create(Self);
  Estoque   := TcontrollerEstoques.Create(Self);
  Grupo     := TControllerGRupos.Create(Self);
  MovimentoEStoque := TControllerCtrlEstoque.Create(Self);
  Obj     := TObjRestMenu.create;
  TabelaPreco :=  TControllerTabelaPreco.Create(Self);
end;

function TControllerDskRestGroupHasAttribute.delete: boolean;
begin
  Try
    MovimentoEStoque.Registro.Produto := Registro.Codigo;
    MovimentoEStoque.deleteByProduto;
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskRestGroupHasAttribute.deleteaLL: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add('DELETE FROM TB_PRODUTO ');
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestGroupHasAttribute.DesativarTodos;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                'PRO_ATIVO = ''N'' '
              ));
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

destructor TControllerDskRestGroupHasAttribute.Destroy;
begin
  TabelaPreco.DisposeOf;
  Obj.Destroy;
  MovimentoEstoque.DisposeOf;
  Estoque.DisposeOf;
  Marca.DisposeOf;
  Preco.DisposeOf;
  Embalagem.DisposeOf;
  Registro.DisposeOf;
  Medida.DisposeOf;
  Lista.DisposeOf;
  Grupo.DisposeOf;
  inherited;
end;


procedure TControllerDskRestGroupHasAttribute.FillDataObjects(prod: TProduto;ObjMenu:TObjRestMenu; institutioWebId:Integer);
var
  I : Integer;
  Lc_HasProduto : TRestMenuHasProduct;
begin
  ObjMenu.Clear;
  Registro.Descricao := prod.Descricao;
  getbyDescription;
  for I := 0 to Lista.Count -1 do
  Begin
    if (I = 0) then
    Begin
      ObjMenu.RestMenu.Codigo           := Registro.Codigo;
      ObjMenu.RestMenu.Estabelecimento  := institutioWebId;
      ObjMenu.RestMenu.Description      := Registro.Descricao;
      ObjMenu.RestMenu.Grupo            := Registro.CodigoGrupo;
      ObjMenu.RestMenu.SubGrupo         := Registro.CodigoSubgrupo;
      ObjMenu.RestMenu.Ativo            := Registro.Ativo;
    End;
    Lc_HasProduto := TRestMenuHasProduct.Create;
    Lc_HasProduto.Estabelecimento := institutioWebId;
    Lc_HasProduto.Menu            := 0;
    Lc_HasProduto.Produto         := Lista[I].Codigo;
    Lc_HasProduto.Ativo           := Lista[I].Ativo;
    ObjMenu.Produto.Add(Lc_HasProduto);
  End;
end;

function TControllerDskRestGroupHasAttribute.insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRODUTO');

    if Length(Registro.CodigoFabrica) = 0 then
      Registro.CodigoFabrica := IntToStr(Registro.Codigo);

    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerDskRestGroupHasAttribute.MarcaPromocao(Codigo: Integer;Ativa:Boolean);
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add('UPDATE TB_PRODUTO SET '+
              'PRO_CAMPANHA=:PRO_CAMPANHA '+
              'WHERE ( PRO_CODIGO=:PRO_CODIGO )');
      if Ativa then
        ParamByName('PRO_CAMPANHA').AsString := 'S'
      else
        ParamByName('PRO_CAMPANHA').AsString := 'N';
      ParamByName('PRO_CODIGO').AsInteger := Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestGroupHasAttribute.migraSelf(Lc_Qry: TSTQuery);
begin
  get(Lc_qry,Registro);
end;

function TControllerDskRestGroupHasAttribute.migra: Boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerDskRestGroupHasAttribute.ReOrdenaSequenciaCodigo;
Var
  I : Integer;
  Lc_Upt : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Try
    Lc_Upt := GeraQuery;
    with Lc_Upt do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO SET ',
                ' PRO_CODIGO=:PRO_CODIGO ',
                ' PRO_CODIGOFAB=:PRO_CODIGO ',
                'WHERE PRO_CODIGO=:OLD_CODIGO '
      ));
      //rEGISTRA O NUMERO ALTO PARA INICIAR DO ZERO DEPOIS
      getList('');
      FProgresso.Progress := 0;
      FProgresso.MinValue := 0;
      FProgresso.MaxValue := Lista.Count;
      FProgresso.Update;
      Lc_Contatdor := 900000;
      for I := 0 to Lista.Count - 1 do
      Begin
        Active := False;
        ParamByName('PRO_CODIGO').AsInteger := Lc_Contatdor;
        ParamByName('OLD_CODIGO').AsInteger := Lista[I].Codigo;
        ExecSQL;
        Lc_Contatdor := Lc_Contatdor + 1;
      End;
      //Agora inicia do 1 para ajustar a ordeñação
      getList('');
      FProgresso.Progress := 0;
      FProgresso.MinValue := 0;
      FProgresso.MaxValue := Lista.Count;
      Lc_Contatdor := 1;
      for I := 0 to Lista.Count - 1 do
      Begin
        Active := False;
        ParamByName('PRO_CODIGO').AsInteger := Lc_Contatdor;
        ParamByName('OLD_CODIGO').AsInteger := Lista[I].Codigo;
        ExecSQL;
        Lc_Contatdor := Lc_Contatdor + 1;
      End;

    End;
  Finally
    FinalizaQuery(Lc_Upt);
  End;
end;

function TControllerDskRestGroupHasAttribute.replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskRestGroupHasAttribute.save: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUTO');

  if Length(Registro.CodigoFabrica) = 0 then
    Registro.CodigoFabrica := IntToStr(Registro.Codigo);

  SaveObj(Registro);
end;

function TControllerDskRestGroupHasAttribute.saveDatawebObjeto(DObj: TObjRestMenu): Boolean;
begin
end;


function TControllerDskRestGroupHasAttribute.temmovimento: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'select * ',
                'from TB_ITENS_NFL ',
                'where (ITF_CODPRO =:PRO_CODIGO )'
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := (recordCount > 0);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestGroupHasAttribute.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerDskRestGroupHasAttribute.getbyBarCode: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT * ',
                'FROM TB_PRODUTO ',
                'WHERE (PRO_CODIGOBAR =:PRO_CODIGOBAR) ',
                '  and (PRO_CODIGOBAR <> ''SEM GTIN'') '
      ));
      if (REgistro.Codigo > 0) then
        SQL.Add(' AND (PRO_CODIGO <>:PRO_CODIGO)');

      if (REgistro.Codigo > 0) then
        ParamByName('PRO_CODIGO').AsInteger := REgistro.Codigo;

      ParamByName('PRO_CODIGOBAR').AsString := Registro.CodigoBarras;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

Function TControllerDskRestGroupHasAttribute.getByDescricao(descricao: String):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_DESCRICAO LIKE :PRO_DESCRICAO )'
      ));
      ParamByName('PRO_DESCRICAO').AsString := concat('%',Descricao,'%');
      Active := True;
      FetchAll;
      if (RecordCount = 1) then
      Begin
        exist := True;
        get(Lc_Qry,Registro);
        Result := 1;
      End
      else
      Begin
        exist := False;
        Result := RecordCount;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestGroupHasAttribute.getbyDescription: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcItem : TProduto;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT p.* ',
                'FROM TB_PRODUTO p ',
                '  inner join tb_grupos g ',
                '  on (g.grp_codigo =p.pro_codgrp) ',
                '  inner join tb_subgrupos s ',
                '  on ( s.sbg_codigo =p.pro_codsbg) ',
                'WHERE PRO_DESCRICAO =:PRO_DESCRICAO ',
                'AND PRO_TIPO = ''A''  '
//                'AND G.grp_composicao IS NOT NULL ',
//                'AND S.sbg_abas IS NOT NULL '
      ));
      ParamByName('PRO_DESCRICAO').AsString := Registro.Descricao;
      Active := True;
      FetchAll;
      Lista.Clear;
      while not eof  do
      Begin
        LcItem := TProduto.Create;
        get(Lc_qry,LcItem);
        Lista.add(LcItem);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestGroupHasAttribute.getbyFactoryProduct:Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_CODIGOFAB =:PRO_CODIGOFAB )'
      ));
      ParamByName('PRO_CODIGOFAB').AsString := Registro.CodigoFabrica;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestGroupHasAttribute.getById;
begin
  _getByKey(Registro);
end;

function TControllerDskRestGroupHasAttribute.getCusto: Real;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select PRO_VL_CUSTO ',
                'from tb_produto ',
                'where (pro_codigo=:pro_codigo )'
      ));
      ParamByName('pro_codigo').AsInteger := Registro.Codigo;
      Active := True;
      Result := FieldByName('PRO_VL_CUSTO').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestGroupHasAttribute.getField(codigo: Integer; Field: String): String;
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT ', Field ,' FROM TB_PRODUTO ',
                'where PRO_CODIGO=:PRO_CODIGO '
               ));
      ParamByName('PRO_CODIGO').AsInteger := Codigo;
      Active := True;
      FetchAll;
      Result := FieldByName(Field).asString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestGroupHasAttribute.getList(limite:String);
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      if StrToIntDef(limite,0)>0 then
        sql.add(concat('SELECT FIRST ',limite,' * '))
      else
        sql.add('SELECT p.* ');

      sql.add(concat(
                'FROM TB_PRODUTO p '
                ));
      //Criei objeto contorller para produto e para menu cardapio  Aqui é igual a Automatico
     sql.add(' and (PRO_TIPO = ''A'') ');

      if ( pos('GRP_DESCRICAO',FOrderBy) > 0 ) then
      Begin
        sql.add(concat(
                     '  INNER JOIN tb_grupos g ',
                     '  ON (grp_CODIGO = pro_codGRP) ',
                     '  INNER JOIN tb_subgrupos s ',
                     '  ON (sbg_CODIGO = pro_codSBG) '
                  ));
      End;

      sql.add(concat(
                'WHERE (PRO_CODIGO IS NOT NULL) '
                ));

      if Registro.Internet = 'S' then
        sql.add(' AND (PRO_INTERNET = ''S'') ');

      if FORderby = '' then
        sql.add(' ORDER BY PRO_CODIGO ')
      else
        sql.add( FORderby );
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TProduto.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerDskRestGroupHasAttribute.getMenuToSincronia;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_produto ',
                'where (PRO_TIPO = ''A'' )',
                ' AND PRO_CODIGO=:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;


end.
