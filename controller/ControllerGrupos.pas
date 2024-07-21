unit ControllerGrupos;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblGrupos ,Un_MSg,Generics.Collections,ControllerSubGRupos, tblRestGroup;

Type
  TListaGrupo  = TObjectList<TGrupos>;

  TControllerGrupos = Class(TControllerBase)
    Lista:TListaGrupo;
  private
  protected
  public
    Registro : TGrupos;
    SubGRupo : TControllerSubGRupos;
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

constructor TControllerGrupos.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TGRupos.Create;
  Lista := TListaGrupo.create;
  SubGRupo := TControllerSubGRupos.Create(self);
  Obj := TRestGroup.create;
end;

function TControllerGrupos.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
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
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_GRUPO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerGrupos.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerGrupos.Replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerGrupos.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_GRUPO');
  SaveObj(Registro);
end;


function TControllerGrupos.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerGrupos.getByDescricao(pGrupo:String): Boolean;
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
  LcLista : TGrupos;
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


end.
