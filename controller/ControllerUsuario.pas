unit ControllerUsuario;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblUsuario, prm_users, ControllerColaborador, MD5;

Type
  TListaUsuario = TObjectList<TUsuario>;

  TControllerUsuario = Class(TControllerBase)

  private
    FParametros: TPrmUsers;
    procedure setFParametros(const Value: TPrmUsers);
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
    function Clear:Boolean;
    function Search:Boolean;
    property Parametros : TPrmUsers read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerUsuario.Autentica: Boolean;
var
  Lc_Autentica: string;
  Lc_Qry : TSTQuery;
begin
  Result := False;
  Lc_Qry := GeraQuery;
  Try
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

function TControllerUsuario.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerUsuario.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TUsuario.Create;
  Lista := TListaUsuario.Create;
  Colaborador := TControllerColaborador.create(Self);
  Parametros := TPrmUsers.Create;
end;

function TControllerUsuario.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerUsuario.Destroy;
begin
  Colaborador.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;

  FreeAndNil(FParametros);
  inherited;
end;

function TControllerUsuario.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_USUARIO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerUsuario.Migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerUsuario.Replace: boolean;
begin
  Result := True;
  replaceObj(Registro);
end;

function TControllerUsuario.ResetaSenha: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_USUARIO');
  SaveObj(Registro);
end;

function TControllerUsuario.Search: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TUsuario;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_USUARIO where USU_ATIVO = ''S'' ';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND USU_CODIGO = :USU_CODIGO';
        ParamByName('USU_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.Nome <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND USU_NOME LIKE :USU_NOME';
        ParamByName('USU_NOME').AsString := Concat('%',Parametros.FieldName.Nome,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TUsuario.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerUsuario.setFParametros(const Value: TPrmUsers);
begin
  FParametros := Value;
end;

function TControllerUsuario.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerUsuario.getByCard: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
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
