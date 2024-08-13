unit ControllerGrupos;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblGrupos, prm_group_menu, ControllerSubGRupos, tblRestGroup;

Type
  TListaGrupo  = TObjectList<TGrupos>;

  TControllerGrupos = Class(TControllerBase)
  private
    FParametros: TPrmGroupMenu;
    procedure setFParametros(const Value: TPrmGroupMenu);
  public
    Lista:TListaGrupo;
    Registro : TGrupos;
    SubGrupo : TControllerSubGRupos;
    Obj:TRestGroup;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function getList:boolean;
    function Replace:boolean;
    function getByDescricao(pGrupo:String) : Boolean;
    function autocreate(pGrupo:String):Integer;
    procedure AtivarDesativarProdutos(grupoId:Integer;oper:boolean);
    procedure FillDataRestGRoup(grupo: TGrupos;ObjRestGroup:TRestGroup; institutioWebId:Integer);
    function Fc_GrupoExiste(pCodigo: integer; pDescricao: String): Integer;

    procedure clear;
    procedure Search;
    property Parametros : TPrmGroupMenu read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerGrupos.AtivarDesativarProdutos(grupoId: Integer;
  oper: boolean);
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
                'update tb_produto set ',
                'PRO_ATIVO=:PRO_ATIVO ',
                'WHERE PRO_CODGRP=:PRO_CODGRP '
      ));
      if oper then
        ParamByName('PRO_ATIVO').AsString := 'S'
      else
        ParamByName('PRO_ATIVO').AsString := 'N';
      ParamByName('PRO_CODGRP').AsInteger := GrupoId;
      ExecSql;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerGrupos.autocreate(pGrupo: String): Integer;
begin
  getByDescricao(pGrupo);
  if exist then
  Begin
    Result := Registro.Codigo;
  End
  else
  Begin
    Registro.Codigo             := Generator('GN_GRUPO');
    Registro.Descricao          := pGrupo;
    Registro.ValorDesconto      := 0;
    Registro.Composicao         := '';
    Registro.ControleInterface  := '';
    Registro.Tamanhos           := '';
    Registro.Tamanhos           := '';
    Registro.Agrupar            := '';
    InsertObj(Registro);
    Result := Registro.Codigo;
  End;
end;

procedure TControllerGrupos.clear;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerGrupos.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TGRupos.Create;
  Lista := TListaGrupo.create;
  SubGRupo := TControllerSubGRupos.Create(self);
  Obj := TRestGroup.create;
  FParametros := TPrmGroupMenu.Create;
end;

function TControllerGrupos.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerGrupos.Destroy;
begin
  Obj.disposeOF;
  SubGRupo.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

procedure TControllerGrupos.FillDataRestGroup(grupo: TGrupos;
  ObjRestGroup: TRestGRoup; institutioWebId: Integer);
begin
  ObjRestGroup.Codigo          := grupo.Codigo;
  ObjRestGroup.Estabelecimento := institutioWebId;
  ObjRestGroup.Sequencia       := grupo.Sequencia;
  ObjRestGroup.Descricao       := grupo.Descricao;
  ObjRestGroup.Ativo           := 'S';
end;

function TControllerGrupos.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_GRUPO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerGrupos.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerGrupos.Replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerGrupos.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_GRUPO');
  SaveObj(Registro);
end;

procedure TControllerGrupos.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TGrupos;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        'SELECT tb_grupos.*, tb_subgrupos.SBG_DESCRICAO '+
        'FROM TB_GRUPOS tb_grupos '+
        '   LEFT OUTER JOIN TB_SUBGRUPOS tb_subgrupos '+
        '   ON (tb_subgrupos.SBG_CODGRP= tb_grupos.GRP_CODIGO) '+
        'WHERE (GRP_COMPOSICAO IS NOT NULL) ';

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND tb_grupos.GRP_DESCRICAO LIKE :GRP_DESCRICAO';
        ParamByName('GRP_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.SubGrupo <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND tb_grupos.SBG_DESCRICAO LIKE :SBG_DESCRICAO';
        ParamByName('SBG_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.GruposVazios then
        SQL.Text := SQL.Text + ' AND (tb_subgrupos.SBG_DESCRICAO IS NULL) '
      else
        SQL.Text := SQL.Text + ' AND (tb_subgrupos.SBG_DESCRICAO IS NOT NULL) ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TGrupos.Create;
        get(Lc_Qry, LITem);

        LItem.SubGrupo := FieldByName('SBG_DESCRICAO').AsString;

        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerGrupos.setFParametros(const Value: TPrmGroupMenu);
begin
  FParametros := Value;
end;

function TControllerGrupos.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerGrupos.getByDescricao(pGrupo:String): Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_GRUPOS ',
                  'WHERE ( UPPER( GRP_DESCRICAO ) =:GRP_DESCRICAO ) '
      ));
      ParamByName('GRP_DESCRICAO').AsString := UpperCase( pGrupo );
      Active := True;
      FetchAll;
      exist := recordCount > 0;
      if exist then
        get(Lc_qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerGrupos.getById;
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
                'SELECT * FROM TB_GRUPOS ',
                'WHERE GRP_CODIGO =:GRP_CODIGO '
      ));
      if Registro.Composicao <> '' then
        sql.add(' AND (GRP_COMPOSICAO IS NOT NULL) ');
      ParamByName('GRP_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist  := ( RecordCount > 0 );
      if exist then get(Lc_Qry,Registro) ;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerGrupos.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TGrupos;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * FROM TB_GRUPOS ',
                'WHERE GRP_CODIGO IS NOT NULL '
      ));
      if Registro.Composicao <> '' then
        sql.add(' AND (GRP_COMPOSICAO IS NOT NULL) ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TGrupos.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerGrupos.Fc_GrupoExiste(pCodigo: integer; pDescricao: String): Integer;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Result := 0;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := 'SELECT GRP_CODIGO '+
                  'FROM TB_GRUPOS '+
                  'WHERE GRP_DESCRICAO=:GRP_DESCRICAO '+
                  'and GRP_CODIGO <>:GRP_CODIGO ';
      ParamByName('GRP_CODIGO').AsInteger := pCodigo;
      ParamByName('GRP_DESCRICAO').AsString := pDescricao;
      Active := True;
      FetchAll;
      First;
      if ( RecordCount > 0) then
        Result := FieldByName('GRP_CODIGO').AsInteger;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
