unit ControllerContador;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      ControllerEmpresa, tblContador,
      Un_Msg;


Type
  TControllerContador = Class(TControllerBase)
  private

  public
    Registro : TContador;
    Empresa : TControllerEmpresa;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getRegistroEmpresa;
    procedure getById;
    function getEmail:String;
    function getCNPJ:String;
    function VerificaSeExste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;
    function salva:boolean;
    function update:boolean;
  End;

implementation

{ TControllerContador }

uses UN_Sistema, Un_Regra_Negocio;

constructor TControllerContador.Create(AOwner: TComponent);
begin
  inherited;
  Empresa := TControllerEmpresa.Create(Self);
  Registro := TContador.create;
end;

destructor TControllerContador.Destroy;
begin
  Registro.DisposeOf;
  Empresa.DisposeOf;
  inherited;
end;

procedure TControllerContador.getById;
begin
  _getByKey(Registro);
end;

function TControllerContador.getCNPJ: String;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT EMP_CNPJ ',
              'FROM tb_empresa c ',
              ' INNER JOIN TB_CONTADOR ',
              '  ON (CON_CODEMP = EMP_CODIGO) ',
              'where (c.EMP_ATIVA = ''S'') '
      ));
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then
      Begin
        Result := FieldByname('EMP_CNPJ').AsString;
      End
      else
      Begin
        Result := '';
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerContador.getEmail:String;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT EMP_EMAIL ',
              'FROM tb_empresa e ',
              ' INNER JOIN TB_CONTADOR c ',
              '  ON (CON_CODEMP = EMP_CODIGO) ',
              'where (c.con_ativo = ''S'') '
      ));
      active := True;
      fetchall;
      if (RecordCount > 0) then
      Begin
        Result := FieldByname('EMP_EMAIL').AsString;
      End
      else
      Begin
        Result := '';
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerContador.getRegistroEmpresa;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select * ',
                'from tb_empresa e ',
                'where e.emp_tipo = 9 and e.emp_ativa = ''S'' '
      ));
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then get(Lc_Qry,Empresa.Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerContador.salva: boolean;
begin
  try
    SaveObj(Registro);
    REsult := true;
  Except
    REsult := false;
  end;
end;

function TControllerContador.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContador.VerificaSeExste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean): Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select EMP_CODIGO,EMP_NOME '+
                 'from tb_empresa    '+
                 '  inner join tb_contador '+
                 '  on (CON_CODEMP = EMP_CODIGO )'+
                 'WHERE (EMP_CNPJ = :EMP_CNPJ) ';
      IF (Trim(Fc_Cd_Codigo) <> '') then
        Lc_SqlTxt:= Lc_SqlTxt + ' and (EMP_CODIGO<>:EMP_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      IF (Trim(Fc_Cd_Codigo) <> '') then
        ParamByName('EMP_CODIGO').AsString:= Fc_Cd_Codigo;
      fc_documento := Fc_RemoveCaracterInformado(fc_documento, ['.',',','/','-']);
      ParamByName('EMP_CNPJ').AsString:= fc_documento;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        if Msg then
        Begin
          MensagemPararExecucao('Um Fornecedor com este CPF/CNPJ já existe.'+EOLN+
                                FieldByName('EMP_CODIGO').AsString + ' - ' + FieldByName('EMP_NOME').AsString);
        End;
        Result:= FieldByName('EMP_CODIGO').AsInteger
      end
      else
      Begin
        Result:= 0;
      end;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
