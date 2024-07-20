unit ControllerDskRestMenu;

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

  TControllerDskRestMenu = Class(TControllerBase)

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
    function getListbyDescription:Boolean;
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
    procedure PausarHabilitarItemByName(Pausa:String;Produto:String;GRupo:Integer);
    procedure PausarHabilitarItemByCodigo(Pausa:String;Produto:Integer);
    function VerificaProdutoPausadoByName(Produto:String;GRupo:Integer):Boolean;
    function VerificaProdutoPausadoByCodigo(Produto:Integer):Boolean;

    procedure DesativarItemByName(Produto:String;GRupo:Integer);
    procedure DesativarItemByCodigo(Produto:Integer);
  End;

implementation

uses Un_Regra_Negocio;


procedure TControllerDskRestMenu.Ativa;
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

procedure TControllerDskRestMenu.AtualizaSeries(Operacao,Disponivel: String;ItemID:Integer);
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

procedure TControllerDskRestMenu.clear;
begin
  clearObj(registro);
end;

constructor TControllerDskRestMenu.Create(AOwner: TComponent);
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

function TControllerDskRestMenu.delete: boolean;
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

function TControllerDskRestMenu.deleteaLL: boolean;
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

procedure TControllerDskRestMenu.DesativarItemByCodigo(Produto: Integer);
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO PD SET ',
                'PD.PRO_ATIVO =:PRO_ATIVO ',
                'where PRO_CODIGO=:PRO_CODIGO '
      ));
      ParamByName('PRO_ATIVO').AsString := 'N';
      ParamByName('PRO_CODIGO').AsInteger := Produto;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDskRestMenu.DesativarItemByName(Produto: String;
  GRupo: Integer);
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO PD SET ',
                'PD.PRO_ATIVO =:PRO_ATIVO ',
                'where pro_descricao =:pro_descricao ',
                'AND PRO_CODGRP =:PRO_CODGRP '
      ));
      ParamByName('PRO_ATIVO').AsString := 'N';
      ParamByName('PRO_DESCRICAO').AsString := Produto;
      ParamByName('PRO_CODGRP').AsInteger := Grupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerDskRestMenu.DesativarTodos;
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

destructor TControllerDskRestMenu.Destroy;
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


procedure TControllerDskRestMenu.FillDataObjects(prod: TProduto;ObjMenu:TObjRestMenu; institutioWebId:Integer);
var
  I : Integer;
  Lc_HasProduto : TRestMenuHasProduct;
  Lc_Ativo : Boolean;
begin
  ObjMenu.Clear;
  Registro.CodigoGrupo  := prod.CodigoGrupo;
  Registro.Descricao    := prod.Descricao;
  getListByDescription;
  Lc_Ativo := False;
  for I := 0 to Lista.Count -1 do
  Begin
    if (Lista[I].Ativo = 'S') and (Lc_Ativo = False) then
    Begin
      Lc_Ativo := True;
      ObjMenu.RestMenu.Codigo           := 0;
      ObjMenu.RestMenu.Estabelecimento  := institutioWebId;
      ObjMenu.RestMenu.Description      := prod.Descricao;
      ObjMenu.RestMenu.Grupo            := prod.CodigoGrupo;
      ObjMenu.RestMenu.SubGrupo         := prod.CodigoSubgrupo;
      ObjMenu.RestMenu.Ativo            := Lista[I].Ativo;
    End;
    Lc_HasProduto := TRestMenuHasProduct.Create;
    Lc_HasProduto.Estabelecimento := institutioWebId;
    Lc_HasProduto.Menu            := 0;
    Lc_HasProduto.Produto         := Lista[I].Codigo;
    Lc_HasProduto.Ativo           := Lista[I].Ativo;
    ObjMenu.Produto.Add(Lc_HasProduto);
  End;
  if not Lc_Ativo then
  Begin
    ObjMenu.RestMenu.Codigo           := 0;
    ObjMenu.RestMenu.Estabelecimento  := institutioWebId;
    ObjMenu.RestMenu.Description      := prod.Descricao;
    ObjMenu.RestMenu.Grupo            := prod.CodigoGrupo;
    ObjMenu.RestMenu.SubGrupo         := prod.CodigoSubgrupo;
    ObjMenu.RestMenu.Ativo            := 'N';
  End;

end;

function TControllerDskRestMenu.insert: boolean;
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

procedure TControllerDskRestMenu.MarcaPromocao(Codigo: Integer;Ativa:Boolean);
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

procedure TControllerDskRestMenu.migraSelf(Lc_Qry: TSTQuery);
begin
  get(Lc_qry,Registro);
end;

procedure TControllerDskRestMenu.PausarHabilitarItemByCodigo(Pausa:String;Produto: Integer);
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO PD SET ',
                'PD.pro_fora_linha =:pro_fora_linha ',
                'where pro_CODIGO =:pro_CODIGO '
      ));
      ParamByName('PRO_FORA_LINHA').AsString := Pausa;
      ParamByName('pro_CODIGO').AsInteger := Produto;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerDskRestMenu.PausarHabilitarItemByName(Pausa:String;Produto: String;
  GRupo: Integer);
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PRODUTO PD SET ',
                'PD.pro_fora_linha =:pro_fora_linha ',
                'where pro_descricao =:pro_descricao ',
                'AND PRO_CODGRP =:PRO_CODGRP '
      ));
      ParamByName('PRO_FORA_LINHA').AsString := Pausa;
      ParamByName('PRO_DESCRICAO').AsString := Produto;
      ParamByName('PRO_CODGRP').AsInteger := Grupo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestMenu.migra: Boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerDskRestMenu.ReOrdenaSequenciaCodigo;
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
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
      Application.ProcessMessages;
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
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestMenu.replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskRestMenu.save: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_PRODUTO');

  if Length(Registro.CodigoFabrica) = 0 then
    Registro.CodigoFabrica := IntToStr(Registro.Codigo);

  SaveObj(Registro);
end;

function TControllerDskRestMenu.saveDatawebObjeto(DObj: TObjRestMenu): Boolean;
begin
end;


function TControllerDskRestMenu.temmovimento: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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

function TControllerDskRestMenu.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerDskRestMenu.VerificaProdutoPausadoByCodigo(
  Produto: Integer): Boolean;
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'select PRO_CODIGO ',
                'from tb_produto pd ',
                'where pd.PRO_CODIGO =:PRO_CODIGO ',
                ' AND pd.PRO_FORA_LINHA =:PRO_FORA_LINHA '
      ));
      ParamByName('PRO_FORA_LINHA').AsString := 'S';
      ParamByName('PRO_CODIGO').AsInteger := Produto;
      Active := True;
      FetchAll;
      Result := ( RecordCount > 0 );
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskRestMenu.VerificaProdutoPausadoByName(Produto: String;
  GRupo: Integer): Boolean;
Var
  I : Integer;
  Lc_Qry : TSTQuery;
  Lc_Contatdor : Integer;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'select PRO_CODIGO ',
                'from tb_produto pd ',
                'where pd.PRO_DESCRICAO =:PRO_DESCRICAO ',
                ' AND pd.PRO_CODGRP =:GRP_CODIGO ',
                ' AND pd.PRO_FORA_LINHA =:PRO_FORA_LINHA '
      ));
      ParamByName('PRO_FORA_LINHA').AsString := 'S';
      ParamByName('PRO_DESCRICAO').AsString := Produto;
      ParamByName('GRP_CODIGO').AsInteger := Grupo;
      Active := True;
      FetchAll;
      Result := ( RecordCount > 0 );
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerDskRestMenu.getbyBarCode: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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

Function TControllerDskRestMenu.getByDescricao(descricao: String):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
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

function TControllerDskRestMenu.getListbyDescription: Boolean;
Var
  Lc_Qry : TSTQuery;
  LcItem : TProduto;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
                'AND PRO_TIPO = ''A''  ',
                'AND PRO_CODGRP =:PRO_CODGRP '
      ));
      ParamByName('PRO_CODGRP').AsInteger   := Registro.CodigoGrupo;
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

function TControllerDskRestMenu.getbyFactoryProduct:Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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

procedure TControllerDskRestMenu.getById;
begin
  _getByKey(Registro);
end;

function TControllerDskRestMenu.getCusto: Real;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
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

function TControllerDskRestMenu.getField(codigo: Integer; Field: String): String;
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
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

procedure TControllerDskRestMenu.getList(limite:String);
var
  Lc_Qry : TSTQuery;
  LcLista : TProduto;
begin
  Lc_Qry := GeraQuery;
  Try
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


procedure TControllerDskRestMenu.getMenuToSincronia;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
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
