unit ControllerFornecedor;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,FireDAC.Stan.Param,
      Un_sistema,Un_Regra_Negocio, tblFornecedor, ControllerEmpresa ,
      ControllerEndereco,ObjProvider,tblPhone,tblAddress, Un_Msg,
      Generics.Collections;
Type
  TListFornecedor = TObjectList<TFornecedor>;
  TControllerFornecedor = Class(TControllerBase)
  private

  public
    Registro : TFornecedor;
    Empresa : TControllerEmpresa;
    Endereco : TControllerEndereco;
    Lista : TListFornecedor;
    Obj : TObjProvider;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function update:Boolean;
    procedure getById;
    procedure clear;
    procedure getList;
    procedure fillDataObjeto(pFornecedor:TFornecedor;pObj:TObjProvider);
    function VerificaSeExste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;

    procedure search;
    function getCodigoLista(Descricao: String): Integer;
    function getDescLista(Codigo: Integer): String;
  End;

implementation

uses UnFunctions;


procedure TControllerFornecedor.clear;
begin
  ClearObj(registro);
end;

constructor TControllerFornecedor.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TFornecedor.Create;
  Empresa   := TControllerEmpresa.create(Self);
  Endereco  := TControllerEndereco.create(Self);
  Obj       := TObjProvider.Create;
  Lista     := TListFornecedor.Create;
end;

destructor TControllerFornecedor.Destroy;
begin
  Lista.DisposeOf;
  Obj.Destroy;
  Endereco.DisposeOf;
  Empresa.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerFornecedor.fillDataObjeto(pFornecedor: TFornecedor;pObj:TObjProvider);
Var
  LcPhone : TPhone;
  LcAddress : TAddress;
begin
  Empresa.Registro.Codigo := pFornecedor.Codigo;
  Empresa.getAllBykey;
  Empresa.fillDataObjeto(Empresa.Registro,pObj.Fiscal);
  pObj.Estabelecimento := pObj.Estabelecimento;
  pObj.EstabelecimentoCNPJ := pObj.EstabelecimentoCNPJ;

  pObj.Fornecedor.Codigo          := pFornecedor.Codigo;
  pObj.Fornecedor.Estabelecimento := pObj.Estabelecimento;
  pObj.Fornecedor.Ativo           := pFornecedor.Ativo;
end;

procedure TControllerFornecedor.getById;
begin
  _getByKey(Registro);
end;

function TControllerFornecedor.getCodigoLista(Descricao: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(Lista.Count) do
  begin
    if Lista[i].Descricao = Descricao then
    Begin
      Result := Lista[i].Codigo;
      Break;
    End;
  end;
end;

function TControllerFornecedor.getDescLista(Codigo: Integer): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to Pred(Lista.Count) do
  begin
    if Lista[i].Codigo = Codigo then
    Begin
      Result := Lista[i].Descricao;
      Break;
    End;
  end;
end;

procedure TControllerFornecedor.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TFornecedor;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_FORNECEDOR ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TFornecedor.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerFornecedor.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerFornecedor.search;
var
  Lc_Qry : TSTQuery;
  LcItem : TFornecedor;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      SQL.Text := 'SELECT F.*, E.EMP_NOME ' +
                  '  FROM TB_EMPRESA E ' +
                  ' INNER JOIN TB_FORNECEDOR F ON (F.FOR_CODEMP = E.EMP_CODIGO) ' +
                  ' WHERE F.FOR_ATIVO = ''S'' ' +
                  ' ORDER BY E.EMP_NOME ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcItem := TFornecedor.Create;
        get(Lc_qry,LcItem);

        LcItem.Descricao := FieldByName('EMP_NOME').AsString;

        Lista.add(LcItem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerFornecedor.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerFornecedor.VerificaSeExste(Fc_Cd_Codigo,
  fc_documento: string; Msg: Boolean): Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select EMP_CODIGO,EMP_NOME '+
                 'from tb_empresa    '+
                 '  inner join tb_fornecedor '+
                 '  on (FOR_CODEMP = EMP_CODIGO )'+
                 'WHERE (EMP_CNPJ = :EMP_CNPJ) ';
      IF (Trim(Fc_Cd_Codigo) <> '') then
        Lc_SqlTxt:= Lc_SqlTxt + ' and (EMP_CODIGO<>:EMP_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      IF (Trim(Fc_Cd_Codigo) <> '') then
        ParamByName('EMP_CODIGO').AsString:= Fc_Cd_Codigo;
      fc_documento := RemoveCaracterInformado(fc_documento, ['.',',','/','-']);
      ParamByName('EMP_CNPJ').AsString:= fc_documento;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        if Msg then
        Begin
          MensagemPararExecucao('Um Fornecedor com este CPF/CNPJ j� existe.'+EOLN+
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
