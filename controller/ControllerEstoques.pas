unit ControllerEstoques;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblEstoques,tblEstoque,Un_MSg,System.Generics.Collections,
  ControllerEstoque;

Type
  TListaEstoques  = TObjectList<TEstoques>;

  TControllerEstoques = Class(TControllerBase)

  private
  public
    Registro : TEstoques;
    Lista : TListaEstoques;
    SaldoEstoque : TControllerEstoque;
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
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;


constructor TControllerEstoques.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEstoques.Create;
  Lista := TListaEstoques.Create;
  SaldoEstoque := TControllerEstoque.Create(nil);
end;

function TControllerEstoques.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerEstoques.Destroy;
begin
  SaldoEstoque.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

function TControllerEstoques.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ESTOQUES');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerEstoques.IsPrincipal: Boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
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
  SaveObj(Registro);
end;

function TControllerEstoques.Replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerEstoques.save: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ESTOQUES');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerEstoques.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
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
  LcLista : TEstoques;
begin
  Try
    Lc_Qry := GeraQuery;
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
  Try
    Lc_Qry := GeraQuery;
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


end.
