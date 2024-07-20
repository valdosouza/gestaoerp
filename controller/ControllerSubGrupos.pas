unit ControllerSubGrupos;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblSubGrupos ,Un_MSg,Generics.Collections, tblRestSubGroup;

Type
  TListaSubGrupo  = TObjectList<TSubGrupos>;

  TControllerSubGrupos = Class(TControllerBase)

  private

  public
    Registro : TSubGrupos;
    Lista : TListaSubGrupo;
    ObjRestSubGroup: TRestSubGroup;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function getList:boolean;
    procedure Clear;
    function Replace:boolean;
    procedure AtivarDesativarProdutos(subgrupoId:Integer;oper:boolean);
    function getByDescricao(pGRupo:Integer;PSubgrupo:String) : Boolean;
    function autocreate(pGRupo:Integer;PSubgrupo:String):Integer;
    procedure FillDataRestSubGroup(subgrupo: TSubGrupos;DObjRestSubgroup:TRestSubGroup; institutioWebId:Integer);
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerSubGrupos.AtivarDesativarProdutos(subgrupoId:Integer;oper: boolean);
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
                'WHERE PRO_CODSBG=:PRO_CODSBG '
      ));
      if oper then
        ParamByName('PRO_ATIVO').AsString := 'S'
      else
        ParamByName('PRO_ATIVO').AsString := 'N';
      ParamByName('PRO_CODSBG').AsInteger := subgrupoId;
      ExecSql;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerSubGrupos.autocreate(pGRupo:Integer;PSubgrupo: String): Integer;
begin
  getByDescricao(pGrupo,PSubgrupo);
  if exist then
  Begin
    Result := Registro.Codigo;
  End
  else
  Begin
    Registro.Codigo             := Generator('GN_SUBGRUPO');
    Registro.Grupo              := pGRupo;
    Registro.Descricao          := PSubgrupo;
    Registro.Abas               := '';
    Registro.Impressora         := 0;
    Registro.Sequencia          := 0;
    InsertObj(Registro);
    Result := Registro.Codigo;
  End;
end;

procedure TControllerSubGrupos.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerSubGrupos.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSubGRupos.Create;
  Lista := TListaSubGrupo.create;
  ObjRestSubGroup :=  TRestSubGroup.create;
end;

function TControllerSubGrupos.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerSubGrupos.Destroy;
begin
  ObjRestSubGroup.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerSubGrupos.FillDataRestSubGroup(subgrupo: TSubGrupos;
  DObjRestSubgroup: TRestSubGroup; institutioWebId: Integer);
begin
  DObjRestSubgroup.Codigo           := subgrupo.Codigo;
  DObjRestSubgroup.Estabelecimento  := institutioWebId;
  DObjRestSubgroup.Grupo            := subgrupo.Grupo;
  DObjRestSubgroup.Descricao        := subgrupo.Descricao;
end;

function TControllerSubGrupos.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SUBGRUPO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSubGrupos.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerSubGrupos.Replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSubGrupos.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SUBGRUPO');
  SaveObj(Registro);
end;

function TControllerSubGrupos.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSubGrupos.getByDescricao(pGRupo:Integer;PSubgrupo: String): Boolean;
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
                  'FROM TB_SUBGRUPOS ',
                  '  INNER JOIN TB_GRUPOS ',
                  '  ON (GRP_CODIGO = SBG_CODGRP) ',
                  'WHERE ( UPPER( SBG_DESCRICAO ) =:SBG_DESCRICAO ) ',
                  ' AND (GRP_CODIGO =:GRP_CODIGO) '
      ));
      ParamByName('SBG_DESCRICAO').AsString := UpperCase( PSubgrupo );
      ParamByName('GRP_CODIGO').AsInteger := pGrupo;
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

procedure TControllerSubGrupos.getById;
var
  Lc_Qry : TSTQuery;
  LcLista : TSubGrupos;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'select * ',
                'from tb_subgrupos S ',
                'WHERE S.sbg_codigo =:SBG_CODIGO '
      ));
      if Registro.Abas <> '' then
        sql.add(' AND S.sbg_abas is not null ');
      ParamByName('SBG_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist  := ( RecordCount > 0 );
      if exist then get(Lc_Qry,Registro) ;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerSubGrupos.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TSubGrupos;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT * FROM TB_SUBGRUPOS ',
              'WHERE SBG_CODIGO IS NOT NULL '
      ));
      if Registro.Abas <> '' then
        sql.add(' AND (SBG_ABAS IS NOT NULL) ');

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TSubGrupos.Create;
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
