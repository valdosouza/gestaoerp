unit ControllerEndereco;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,  tblEndereco ,
     Generics.Collections, ControllerUf, ControllerCidade, ControllerPais,
     FireDAC.Stan.Param;

Type
  TListEndereco = TObjectList<TEndereco>;

  TControllerEndereco = Class(TControllerBase)

  private
  protected

  public
    Registro : TEndereco;
    Uf : TcontrollerUf;
    Pais : TControllerPais;
    Cidade : TControllercidade;
    Lista : TListEndereco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getById;
    procedure getIdByFone;
    procedure getByEmpresa;
    procedure getByDocumento(Documento:String);
    function insert:Boolean;
    function Update:Boolean;
    function Delete:Boolean;
    function DeleteAllEmpresa:Boolean;
    function getAll:Boolean;
    function getByAllFones:Boolean;
    function getPrincipal:Integer;
    procedure setSequencia;
    Function getList:Boolean;
    Function AutoEndereco:Boolean;
    procedure clear;
    function ValidateFone:Boolean;
  End;

implementation

{ TControllerEndereco}

uses Un_Regra_Negocio,  UnFunctions;

procedure TControllerEndereco.clear;
begin
  clearObj(Registro);
end;

constructor TControllerEndereco.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEndereco.Create;
  Lista := TListEndereco.create;
  Uf := TcontrollerUf.Create(self);
  Cidade := TControllercidade.Create(self);
  Pais := TControllerPais.Create(self);
end;

destructor TControllerEndereco.Destroy;
begin
  Pais.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  Uf.DisposeOf;
  Cidade.DisposeOf;
  inherited;
end;

function TControllerEndereco.Delete: Boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerEndereco.DeleteAllEmpresa: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TEndereco;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('DELETE FROM TB_ENDERECO WHERE END_CODEMP=:EMP_CODIGO ');
      ParamByName('EMP_CODIGO').AsInteger := Registro.CodigoEmpresa;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEndereco.AutoEndereco: Boolean;
begin
  with Registro  do
  Begin
    Codigo            := 0;
    Tipo              := 'PRINCIPAL';
    Logradouro        := 'Não informado';
    Complemento       := '';
    Bairro            := 'Bairro';
    Cep               := '81000000';
    EnderecoPrincipal := 'S';
    Regiao            := '';
    NumeroPredial     := 'SN';
    CodigoPais        := 1058;
    CodigoCidade      := 4004;
    CodigoEstado      := 41;
  End;
  insert;
end;


function TControllerEndereco.salva: boolean;
begin
  if existObj(Registro) then
  Begin
    UpdateObj(Registro);
  End
  else
  Begin
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ENDERECO');
    InsertObj(Registro);
  End;
end;


procedure TControllerEndereco.setSequencia;
begin
  Registro.Codigo := getNextByField(Registro,'END_CODIGO',0) ;
  setGenerator('GN_ENDERECO',Registro.Codigo.ToString);
end;

function TControllerEndereco.Update: Boolean;
begin
  try
    UpdateObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerEndereco.ValidateFone: Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_aux:String;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      Sql.Clear;
      SQL.Add('select end_fone from tb_endereco where end_codigo =:end_codigo');
      ParamByName('end_codigo').AsInteger:= registro.Codigo;
      Active:=True;
      Lc_Aux := TRim(fieldbyname('END_FONE').AsString);
      Lc_Aux := RemoveCaracterInformado(Lc_Aux, ['.',',','/','-','(',')']);
      if(trim(Lc_Aux) <> '') and (Length(trim(Lc_Aux)) < 10) then
        Result:=false;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEndereco.getById;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add('SELECT e.* '+
              'FROM tb_endereco e '+
              'where e.END_CODIGO =:END_CODIGO ');
      parambyname('END_CODIGO').asInteger := Registro.Codigo;
      active := True;
      fetchall;
      if (RecordCount > 0) then
      Begin
        get(LC_Qry,Registro);
      End
      else
      Begin
        clearObj(Registro);
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEndereco.getByEmpresa;
Var
  lc_Aux : Integer;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  TRy
    //Guarda a informação da empresa caso o resultado seja zero
    lc_Aux := Registro.CodigoEmpresa;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT e.* '+
              'FROM tb_endereco e '+
              'where e.END_CODEMP =:END_CODEMP ');
      parambyname('END_CODEMP').asInteger := Registro.CodigoEmpresa;
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then
      Begin
        Locate('END_PRINCIPAL','S',[]);
        get(Lc_Qry,Registro);
      End
      else
      Begin
        clearObj(Registro);
        Registro.CodigoEmpresa := lc_Aux;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEndereco.getAll: Boolean;
begin
  if Registro.Codigo = 0 then
    getByEmpresa
  else
    _getByKey(Registro);
  uf.Registro.Codigo := Registro.CodigoEstado;
  uf.getbyId;
  Cidade.Registro.Codigo := Registro.CodigoCidade;
  Cidade.getbyId;

  Pais.Registro.Codigo := Registro.CodigoPais;
  Pais.getbyId;
end;

function TControllerEndereco.getByAllFones: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT e.* ',
              'FROM tb_endereco e ',
              'where (END_FONE like :END_FONE) ',
              ' OR  (END_CELULAR like :END_CELULAR) '
      ));
      parambyname('END_FONE').asString := '%' + Registro.Fone;
      parambyname('END_CELULAR').asString := '%' + Registro.Celular;
      active := True;
      fetchall;
      if (RecordCount > 0) then
      Begin
        get(Lc_Qry,Registro);
      End
      else
      Begin
        clearObj(Registro);
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEndereco.getByDocumento(Documento:String);
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add('SELECT e.* '+
              'FROM tb_endereco e '+
              '  inner join tb_empresa '+
              '  on (emp_codigo = end_codemp) '+
              'where EMP_CNPJ =:EMP_CNPJ ');
      parambyname('EMP_CNPJ').asString := Documento;
      active := True;
      fetchall;
      if (RecordCount > 0) then
      Begin
        get(Lc_Qry,Registro);
      End
      else
      Begin
        clearObj(Registro);
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

procedure TControllerEndereco.getIdByFone;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT e.* ',
              'FROM tb_endereco e ',
              'where e.END_FONE LIKE:END_FONE ',
              ' and  (e.END_FONE <> '''' ) '
      ));
      parambyname('END_FONE').asString := '%'+Registro.Fone;
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then
      Begin
        get( Lc_Qry,Registro);
      End
      else
      Begin
        clearObj(Registro);
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEndereco.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TEndereco;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_ENDERECO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEndereco.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEndereco.getPrincipal: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.add(' SELECT END_CODIGO '+
              ' FROM TB_ENDERECO  '+
              ' WHERE (END_CODEMP=:EMP_CODIGO)  '+
              ' AND END_PRINCIPAL = ''S'' ');
      ParamByName('EMP_CODIGO').AsInteger := Registro.CodigoEmpresa;;
      Active := True;
      FetchAll;
      Result := FieldByName('END_CODIGO').AsInteger;
    End;
  Finally
    Finalizaquery(Lc_Qry);
  End;
end;

function TControllerEndereco.insert: Boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ENDERECO')
    else
    if Registro.Codigo = -1 then
    Begin
      Registro.Codigo := getNextByField(Registro,'END_CODIGO',0) ;
      setGenerator('GN_ENDERECO',Registro.Codigo.ToString);
    End;

    InsertObj(Registro);
    Result := True;
  except
    Result := False;
  end;

end;

function TControllerEndereco.migra: boolean;
begin
  SaveObj(Registro);
end;

end.
