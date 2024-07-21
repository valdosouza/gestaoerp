unit ControllerEmbalagem;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblEmbalagem ,Un_MSg,System.Generics.Collections,FireDAC.Stan.Param;

Type
  TListaEmbalagem  = TObjectList<TEmbalagem>;

  TControllerEmbalagem = Class(TControllerBase)

  private
  public
    Registro : TEmbalagem;
    Lista : TListaEmbalagem;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyDescricao;
    procedure getIdAutoByDesc;
    function salva:boolean;
    function migra:Boolean;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    Function getList:boolean;
    procedure clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerEmbalagem.clear;
begin
  clearObj(Registro);
end;

constructor TControllerEmbalagem.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEmbalagem.Create;
  Lista := TListaEmbalagem.create;
end;

function TControllerEmbalagem.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerEmbalagem.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

function TControllerEmbalagem.insert: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_EMBALAGEM');
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerEmbalagem.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerEmbalagem.replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerEmbalagem.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_EMBALAGEM');
  SaveObj(Registro);
end;

function TControllerEmbalagem.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerEmbalagem.getbyDescricao;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_EMBALAGEM '+
              'WHERE ( EMB_DESCRICAO =:EMB_DESCRICAO ) ');
      ParamByName('EMB_DESCRICAO').AsString := Registro.Descricao;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerEmbalagem.getById;
begin
    _getByKey(Registro);
end;


procedure TControllerEmbalagem.getIdAutoByDesc;
begin
  getbyDescricao;
  if not exist then
  Begin
    Registro.Codigo := 0;
    insert;
  End;
end;

function TControllerEmbalagem.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TEmbalagem;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_EMBALAGEM ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEmbalagem.Create;
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
