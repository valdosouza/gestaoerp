unit ControllerUsuario;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      tblUsuario , Un_MSg,System.Generics.Collections,MD5, ControllerColaborador;

Type
  TListaUsuario = TObjectList<TUsuario>;

  TControllerUsuario = Class(TControllerBase)

  private
  public
    Registro : TUsuario;
    Lista : TListaUsuario;
    Colaborador : TControllerColaborador;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function Migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function getList:Boolean;
    function getVendedorID:Integer;
    function getByCard:Boolean;
    function getByLogin:boolean;
    function ResetaSenha:boolean;
    function Replace:boolean;
    function Autentica : Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerUsuario.Autentica: Boolean;
var
  Lc_Autentica: string;
  Lc_Senha: string;
  Lc_Qry : TSTQuery;
begin
  Try
    Result := False;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Autentica := 'SELECT * FROM TB_USUARIO tb_usuario '+
                      'WHERE (USU_LOGIN = ''' + Registro.Login + ''') '+
                      '  AND (USU_SENHA = ''' + MD5String(Registro.Senha) + ''') '+
                      '  AND (USU_ATIVO = ''S'') ';
      SQL.Clear;
      SQL.Add(Lc_Autentica);
      Active := True;
      FetchAll;
      exist := (RecordCount >0);
      if exist then
        get(Lc_Qry,Registro) ;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

constructor TControllerUsuario.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TUsuario.Create;
  Lista := TListaUsuario.Create;
  Colaborador := TControllerColaborador.create(Self);
end;

function TControllerUsuario.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerUsuario.Destroy;
begin
  Colaborador.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

function TControllerUsuario.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_USUARIO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerUsuario.Migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerUsuario.Replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerUsuario.ResetaSenha: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              ' update tb_usuario SET     ',
              ' USU_SENHA = :USU_SENHA     '+
              ' where                      '+
              ' USU_CODIGO = :USU_CODIGO   '
      ));
      ParamByName('USU_CODIGO').AsInteger:= Registro.Codigo;
      ParamByName('USU_SENHA').AsAnsiString:='827CCB0EEA8A706C4C34A16891F84E7B';//senha12345
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerUsuario.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_USUARIO');
  SaveObj(Registro);
end;

function TControllerUsuario.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerUsuario.getByCard: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_USUARIO ',
                      'WHERE USU_AUTH_CARD =:USU_AUTH_CARD '
      ));
      paramByName('USU_AUTH_CARD').AsString := Registro.CartaoAutorizacao;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry, Registro);

    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerUsuario.getById;
begin
    _getByKey(Registro);
end;


function TControllerUsuario.getByLogin: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_USUARIO ',
                      'WHERE USU_LOGIN =:USU_LOGIN '
      ));
      paramByName('USU_LOGIN').AsString := Registro.Login;
      Active := True;
      FetchAll;
      exist  := ( RecordCount > 0 );
      if exist then
      Begin
        clearObj(Registro);
        get(Lc_Qry,Registro) ;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerUsuario.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TUsuario;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_USUARIO ',
                      'WHERE USU_ATIVO = ''S'' ',
                      'ORDER BY USU_CODIGO ASC '
      ));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TUsuario.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerUsuario.getVendedorID: Integer;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Result := 0;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT USU_CODIGO, CLB_CODIGO ',
                'FROM TB_USUARIO tb_usuario ',
                '  LEFT OUTER JOIN TB_COLABORADOR tb_colaborador ',
                '  ON (tb_colaborador.CLB_CODUSU =  tb_usuario.USU_CODIGO) ',
                'WHERE (USU_CODIGO =:USU_CODIGO) ',
                '  AND (USU_ATIVO = ''S'') '
      ));
      ParambyName('USU_CODIGO').asinteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount >0;
      if exist then
        Result := StrToIntDef(FieldByName('CLB_CODIGO').AsString,0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
