unit ControllerColaborador;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblColaborador ,Un_MSg,Generics.Collections,
      ControllerCargo, ObjSalesMan, tblphone, tblAddress,ControllerUF, controllerCidade,
      prm_collaborator, controllerUsuario;

Type
  TListColaborador = TObjectList<TColaborador>;

  TControllerColaborador = Class(TControllerBase)

  private
    FParametros: TPrmCollaborator;
    procedure setFParametros(const Value: TPrmCollaborator);
  public
    Registro : TColaborador;
    Cargo : TControllerCargo;
    Lista : TListColaborador;
    Cidade : TControllerCidade;
    Usuario : TControllerUsuario;
    Obj  : TObjSalesMan;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function getDocByID:String;
    function getByDoc:Boolean;
    function getByUser:Boolean;
    function getIDByDoc:Integer;
    function getVendedorTray:Integer;
    function getVendedorIfood:Integer;
    function getVendedorAppDelivery:Integer;
    function temPedido:Boolean;
    function getByUsuario:Boolean;
    function Replace:boolean;
    procedure FillDataObjeto(Colab: TColaborador;Obj:TObjSalesMan);
    function VerificaExistenciaUsuario(UsuarioId:Integer):Boolean;
    procedure Clear;
    procedure Search;
    property Parametros : TPrmCollaborator read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio, ENV;

procedure TControllerColaborador.Clear;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerColaborador.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TColaborador.Create;
  Lista     := TListColaborador.Create;
  Cargo := TControllerCargo.create(Self);
  Obj  := TObjSalesMan.Create;
  FParametros := TPrmCollaborator.Create;
  Cidade := TControllerCidade.create(Self);
  Usuario := TControllerUsuario.create(Self);
end;

function TControllerColaborador.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerColaborador.Destroy;
begin
  Obj.Destroy;
  FreeAndNil(Lista);
  Registro.DisposeOf;
  Cargo.DisposeOf;
  FParametros.DisposeOf;
  Cidade.DisposeOf;
  Usuario.DisposeOf;
  inherited;
end;

procedure TControllerColaborador.FillDataObjeto(Colab: TColaborador; Obj: TObjSalesMan);
Var
  LcPhone : TPhone;
  LcAddress : TAddress;
  LcUF : TControllerUf;
  LcCidade : TControllerCidade;
begin
  with Obj do
  BEgin
    Colaborador.Estabelecimento := Estabelecimento;
    Fiscal.Entidade.Entidade.Codigo := 0;
    Fiscal.Entidade.Entidade.NomeRazao           := Colab.Nome;
    Fiscal.Entidade.Entidade.ApelidoFantasia     := Colab.Nome;
    Fiscal.Entidade.Entidade.AniversarioFundacao := Colab.NAscimento;
    Fiscal.Entidade.Entidade.RamoAtividade       := 0;
    Fiscal.Entidade.Entidade.Observacao          := Colab.Observacao;

    if ( Length( Trim(Colab.CPFCNPJ)) = 11 ) then
    Begin
      Fiscal.Fisica.CPF := Colab.CPFCNPJ;
      Fiscal.Fisica.RG := Colab.Identidade;
      Fiscal.Fisica.Aniversario := Colab.NAscimento;
    End
    else
    Begin
      Fiscal.Juridica.CNPJ := Colab.CPFCNPJ;
      Fiscal.Juridica.InscricaoEstadual := Colab.Identidade;
      Fiscal.Juridica.CRT := '1';
      Fiscal.Juridica.DataFundacao := Colab.NAscimento;
      Fiscal.Juridica.IndicacaoIEDestinatario := '1';
      Fiscal.Juridica.EnviarSomenteXMLNFe := 'N';
    End;

    LcAddress := TAddress.Create;
    LcAddress.Logradouro := Colab.Endereco;
    LcAddress.NumeroPredial := '';
    LcAddress.Complemento := '';
    LcAddress.Bairro := Colab.Bairro;
    LcAddress.Regiao := '';
    LcAddress.Tipo := 'RESIDENCIAL';
    LcAddress.Cep := Colab.Cep;
    LcAddress.CodigoPais := 1058;
    Try
      LcUF := TControllerUf.Create(self);
      LcCidade := TControllerCidade.Create(self);

      LcAddress.CodigoEstado := LcUF.BuscaCodigo( Colab.Estado );
      LcAddress.CodigoCidade := LcCidade.Buscacodigo(0,Colab.Cidade,Colab.Estado);
    Finally
      FreeAndNil( LcUF );
      FreeAndNil( LcCidade );
    End;
    LcAddress.Principal := 'S';
    Fiscal.Entidade.ListaEndereco.Add(LcAddress);

    Fiscal.Entidade.Email.Email := Colab.email;

    if Colab.Fone <> '' then
    Begin
      LcPhone := TPhone.Create;
      LcPhone.Codigo := 0;
      LcPhone.Tipo := 'Fone';
      LcPhone.Numero := Colab.Fone;
      LcPhone.TipoEndereco := 'Fone';
      Fiscal.Entidade.ListaFones.Add(LcPhone);
    End;

    if Colab.Celular <> '' then
    Begin
      LcPhone := TPhone.Create;
      LcPhone.Codigo := 0;
      LcPhone.Tipo := 'Celular';
      LcPhone.Numero := Colab.Fone;
      LcPhone.TipoEndereco := 'Celular';
      Fiscal.Entidade.ListaFones.Add(LcPhone);
    End;

    Colaborador.Codigo          := 0;
    Colaborador.Estabelecimento := Estabelecimento;
    Colaborador.DataAdmissao    := Colab.Admissao;
    Colaborador.DataDemissao    := Colab.Demissao;
    Colaborador.Salario         := Colab.Salario;
    Colaborador.Pai             := Colab.NomePai;
    Colaborador.Mamae           := Colab.NomeMae;
    Colaborador.Titulo          := Colab.TituloEleitor;
    Colaborador.Zona            := Colab.TituloZona;
    Colaborador.Sessão          := Colab.SecaoZona;
    Colaborador.Certificado     := Colab.CertificadoMilitar;
    Colaborador.Ativo           := 'S';
    Colaborador.Pis             := Colab.PIS;


    Vendedor.Codigo           := 0;
    Vendedor.Estabelecimento  := Estabelecimento;
    Vendedor.Ativo            := 'S';
    Vendedor.AliquotaComissao := Colab.ComissaoAliqVenda;
    Vendedor.ComissaoProduto  := Colab.ComissaoPorProduto;
  End;
end;

function TControllerColaborador.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_COLABORADOR');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerColaborador.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerColaborador.Replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerColaborador.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_COLABORADOR');
  SaveObj(Registro);
end;

procedure TControllerColaborador.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TColaborador;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := //' SELECT * FROM TB_COLABORADOR WHERE 1=1';
        ' SELECT CLB.*, CRG.CRG_DESCRICAO ' + //CLB_CODIGO, CLB_CPF, CLB_NOME, CRG_DESCRICAO, CLB_CODMHA ' +
        '   FROM TB_COLABORADOR CLB' +
        '   LEFT OUTER JOIN TB_CARGO CRG ON (CRG.CRG_CODIGO = CLB.CLB_CODCRG) ' +
        '  WHERE (CLB.CLB_CODIGO IS NOT NULL) ';

      if not (Fc_Tb_Geral('L','PES_G_COMPARTILHA','S') = 'S') then
      begin
        SQL.Text := SQL.Text + ' AND (CLB.CLB_CODMHA =:CLB_CODMHA) ';
        ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
      end;

      if FParametros.FieldName.CPFCNPJ <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND CLB.CLB_CPF = :CLB_CPF ';
        ParamByName('CLB_CPF').AsString := FParametros.FieldName.CPFCNPJ;
      end;

      if FParametros.FieldName.Nome <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND CLB.CLB_NOME LIKE :CLB_NOME ';
        ParamByName('CLB_NOME').AsString := Concat('%',FParametros.FieldName.nome,'%');
      end;

      if FParametros.FieldName.CargoDescricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND CRG.CRG_DESCRICAO LIKE :CRG.CRG_DESCRICAO ';
        ParamByName('CRG.CRG_DESCRICAO').AsString := Concat('%',FParametros.FieldName.CargoDescricao,'%');
      end;

      if FParametros.FieldName.Demitidos then
        SQL.Text := SQL.Text +'AND (CLB.CLB_DEMISSAO IS NOT NULL) '
      else
        SQL.Text := SQL.Text +'AND (CLB.CLB_DEMISSAO IS NULL) ';

      SQL.Text := SQL.Text + ' ORDER BY CLB.CLB_NOME';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TColaborador.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        LITem.CargoDescricao := FieldByName('CRG_DESCRICAO').AsString;

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerColaborador.setFParametros(const Value: TPrmCollaborator);
begin
  FParametros := Value;
end;

function TControllerColaborador.temPedido: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select PED_CODVDO ',
                     'from TB_PEDIDO ',
                     'where PED_CODVDO =:PED_CODVDO '
                     ));
      ParamByName('PED_CODVDO').AsInteger := Registro.codigo;
      Active := True;
      FetchAll;
      REsult := (recordCount > 0)
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerColaborador.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerColaborador.VerificaExistenciaUsuario(
  UsuarioId: Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select * ',
                     'from TB_COLABORADOR ',
                     'where CLB_CODUSU =:CLB_CODUSU ',
                     ' AND CLB_CODIGO <>:CLB_CODIGO '
                     ));
      ParamByName('CLB_CODUSU').AsInteger := UsuarioId;
      ParamByName('CLB_CODIGO').AsInteger := Registro.codigo;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerColaborador.getById;
begin
  _getByKey(Registro);
end;


function TControllerColaborador.getByUser: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select *  ',
                     'from tb_colaborador ',
                     'where CLB_CODUSU =:CLB_CODUSU'
                     ));
      ParamByName('CLB_CODUSU').AsInteger := Registro.Usuario;
      Active := True;
      First;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerColaborador.getByUsuario: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                  'select * ',
                  'from tb_colaborador ',
                  'where (CLB_CODUSU =:CLB_CODUSU) '
      ));
      ParamByName('CLB_CODUSU').AsInteger := Registro.Usuario;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if not exist then
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                  'SELECT FIRST 1 C.* ',
                  'from tb_colaborador C ',
                  '  INNER JOIN TB_CARGO G ',
                  '  ON (G.crg_codigo  = C.clb_codcrg) ',
                  'where (G.crg_descricao LIKE ''VENDEDOR%'') '
        ));
        Active := True;
        FetchAll;
        exist := (RecordCount > 0);
      End;
      if exist then
      Begin
        get(Lc_Qry,Registro);
      End
      else
      BEgin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                  'SELECT FIRST 1 C.* ',
                  'from tb_colaborador C '
        ));
        Active := True;
        FetchAll;
        exist := (RecordCount > 0);
        if exist then
          get(Lc_Qry,Registro);
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerColaborador.getDocByID: String;
Var
  Lc_Qry : TSTQuery;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CLB_CPF ',
                     'from tb_colaborador ',
                     'where clb_codigo =:clb_codigo'
                     ));
      ParamByName('clb_codigo').AsInteger := Registro.Codigo;
      Active := True;
      First;
      if RecordCount > 0 then
        REsult := FieldByName('CLB_CPF').AsString;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerColaborador.getIDByDoc: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CLB_CODIGO ',
                     'from tb_colaborador ',
                     'where CLB_CPF =:CLB_CPF '
                     ));
      ParamByName('CLB_CPF').AsString := Registro.CPFCNPJ;
      Active := True;
      First;
      if RecordCount > 0 then
        REsult := FieldByName('CLB_CODIGO').AsInteger;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerColaborador.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TColaborador;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_COLABORADOR ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TColaborador.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerColaborador.getVendedorAppDelivery: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CLB_CODIGO ',
                     'from tb_colaborador ',
                     'where CLB_NOME =:CLB_NOME'
                     ));
      ParamByName('CLB_NOME').AsString := 'APP DELIVERY';
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CLB_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.Codigo := 0;
        Registro.Nome := 'APP DELIVERY';
        Registro.Sexo := 'M';
        Registro.Cargo := Cargo.GetcargoVendedor;
        Registro.Pais := 1058;
        Registro.Admissao := Date;
        Registro.NAscimento := Date;
        //Registro.Estabelecimento := InstitutitionID;não colocar o codigo para que o usuario não possa alterar no sistema
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerColaborador.getVendedorIfood: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CLB_CODIGO ',
                     'from tb_colaborador ',
                     'where CLB_NOME =:CLB_NOME'
                     ));
      ParamByName('CLB_NOME').AsString := 'VENDEDOR IFOOD';
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CLB_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.Codigo := 0;
        Registro.Nome := 'VENDEDOR IFOOD';
        Registro.Sexo := 'M';
        Registro.Cargo := Cargo.GetcargoVendedor;
        Registro.Pais := 1058;
        Registro.Admissao := Date;
        Registro.NAscimento := Date;
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerColaborador.getVendedorTray: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CLB_CODIGO ',
                     'from tb_colaborador ',
                     'where CLB_NOME =:CLB_NOME'
                     ));
      ParamByName('CLB_NOME').AsString := 'VENDEDOR LOJA TRAY';
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CLB_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.Codigo := 0;
        Registro.Nome := 'VENDEDOR LOJA TRAY';
        Registro.Sexo := 'M';
        Registro.Cargo := Cargo.GetcargoVendedor;
        Registro.Pais := 1058;
        Registro.Admissao := Date;
        Registro.NAscimento := Date;
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerColaborador.getByDoc: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select *  ',
                     'from tb_colaborador ',
                     'where CLB_CPF =:CLB_CPF'
                     ));
      ParamByName('CLB_CPF').AsString := Registro.CPFCNPJ;
      Active := True;
      First;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
