unit ControllerEmpresa;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
       tblEmpresa ,ControllerEndereco,
      Generics.Collections, objcustomer, ControllerColaborador,objEntityFiscal,
      tblphone,tblAddress;


Type
  TListEmpresa = TObjectList<TEmpresa>;

  TControllerEmpresa = Class(TControllerBase)

  private
  protected

  public
    Registro : TEmpresa;
    Endereco : TControllerEndereco;
    Obj : TObjEntityFiscal;
    Lista : TListEmpresa;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    function insert:Boolean;
    function Update:Boolean;
    function Detele:Boolean;
    procedure getById;
    procedure getByDocumento;
    Function delete:boolean;
    procedure SetSequencia;
    procedure getAllBykey;
    function getList: Boolean;
    function getListMovimento: Boolean;
    procedure clear;
    function Replace:boolean;
    procedure criarEmpresaSemCPFCNPJ;
    procedure saveObjWeb(Fiscal:TObjEntityFiscal);
    procedure fillDataObjeto(pEmpresa:TEmpresa;pObj:TObjEntityFiscal);
    procedure AtualizaBanco;
  End;

implementation

{ TControllerEmpresa }

uses Un_Regra_Negocio;

procedure TControllerEmpresa.AtualizaBanco;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'UPDATE TB_EMPRESA SET '+
              'EMP_NUMBCO =:EMP_NUMBCO '+
              'where ( EMP_CODIGO =:EMP_CODIGO) '
      ));
      parambyname('EMP_NUMBCO').asString := Registro.NumeroBanco;
      parambyname('EMP_CODIGO').asInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerEmpresa.clear;
begin
  clearObj(Registro);
  endereco.clear;
end;

constructor TControllerEmpresa.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEmpresa.Create;
  Endereco := TControllerEndereco.Create(Self);
  Lista := TListEmpresa.create;
  Obj := TObjEntityFiscal.Create;
end;

procedure TControllerEmpresa.criarEmpresaSemCPFCNPJ;
begin
  clear;
  Registro.Codigo                     := 0;
  Registro.Tipo                       := 1;
  Registro.NomeRazaoSocial            := 'CLIENTE SEM CPF/CNPJ';
  Registro.ApelidoFantasia            := 'CLIENTE SEM CPF/CNPJ';
  Registro.CpfCNPJ                    := '12345677654321';
  Registro.TipoPessoa                 := 'J';
  Registro.ConsumidorFinal            := 'N';
  Registro.Multiplicador              := 1;
  Registro.OptantePeloSimples         := 'N';
  Registro.IndicadorInscricaoEstadual := '1';
  Registro.CodigoVendedor             := 0;
  Registro.Ativa                      := 'S';
  salva;
  Endereco.Registro.Codigo := 0;
  Endereco.Registro.CodigoEmpresa :=  Registro.Codigo;
  Endereco.Registro.Cnpj          :=  Registro.CpfCNPJ;
  Endereco.Registro.Tipo          := 'COMERCIAL';
  Endereco.Registro.Tipo          := 'PRINCIPAL';
  Endereco.Registro.Logradouro    := 'RUA';
  Endereco.Registro.Bairro        := 'BAIRRO';
  Endereco.Registro.Cep           := '80000000';
  Endereco.Registro.NumeroPredial := '1';
  Endereco.Registro.CodigoPais    := 1058;
  Endereco.Registro.CodigoEstado  := 41;
  Endereco.Registro.CodigoCidade  := 4004;
  Endereco.salva;


end;

function TControllerEmpresa.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerEmpresa.Destroy;
begin
  Obj.Destroy;
  Registro.DisposeOf;
  Endereco.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;



function TControllerEmpresa.Detele: Boolean;
begin
  try
    DeleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

procedure TControllerEmpresa.fillDataObjeto(pEmpresa: TEmpresa;pObj:TObjEntityFiscal);
Var
  LcPhone : TPhone;
  LcAddress : TAddress;
begin

  pObj.Entidade.Entidade.Codigo              := pEmpresa.Codigo;
  pObj.Entidade.Entidade.NomeRazao           := pEmpresa.NomeRazaoSocial;
  pObj.Entidade.Entidade.ApelidoFantasia     := pEmpresa.ApelidoFantasia;
  pObj.Entidade.Entidade.AniversarioFundacao := pEmpresa.DataFundacao;
  pObj.Entidade.Entidade.RamoAtividade       := pEmpresa.CodigoRamoAtividade;
  pObj.Entidade.Entidade.Observacao          := pEmpresa.Observacao;

  //PEga o Objeto Endereco
  Endereco.Registro.CodigoEmpresa := pEmpresa.Codigo;
  Endereco.getByEmpresa;

  if pEmpresa.TipoPessoa = 'F' then
  Begin
    pObj.Fisica.Codigo              := pEmpresa.Codigo;
    pObj.Fisica.CPF                 := pEmpresa.CpfCNPJ;
    pObj.Fisica.RG                  := pEmpresa.InscricaoEstadual;
    pObj.Fisica.DataEmissao         := pEmpresa.DataCadastro;
    pObj.Fisica.OrgaoEmissor        := 'SSP';
    pObj.Fisica.CodigoEstadoEmissor := Endereco.Registro.CodigoEstado;
    pObj.Fisica.Aniversario         := pEmpresa.DataFundacao;
    pObj.Fisica.CodigoCargo         := 0;
  End
  else
  Begin
    pObj.Juridica.Codigo                  := pEmpresa.Codigo;
    pObj.Juridica.CNPJ                    := pEmpresa.CpfCNPJ;
    pObj.Juridica.InscricaoEstadual       := pEmpresa.InscricaoEstadual;
    pObj.Juridica.InscricaoMunicipal      := pEmpresa.InscricaoMunicipal;
    if pEmpresa.OptantePeloSimples = 'S' then
    BEgin
      pObj.Juridica.CRT                   := '1';
      pObj.Juridica.CRTmodal              := '1';
    End
    else
    Begin
      pObj.Juridica.CRT                   := '3';
      pObj.Juridica.CRTmodal              := '3';
    End;
    pObj.Juridica.IndicacaoIEDestinatario := pEmpresa.IndicadorInscricaoEstadual;
    pObj.Juridica.DataFundacao            := pEmpresa.DataFundacao;
  End;

  if Endereco.Registro.Codigo > 0 then
  Begin
    LcAddress := TAddress.Create;
    LcAddress.Codigo        := Endereco.Registro.Codigo;
    LcAddress.Logradouro    := Endereco.Registro.Logradouro;
    LcAddress.NumeroPredial := Endereco.Registro.NumeroPredial;
    LcAddress.Complemento   := Endereco.Registro.Complemento;
    LcAddress.Bairro        := Endereco.Registro.Bairro;
    LcAddress.Regiao        := Endereco.Registro.Regiao;
    LcAddress.Tipo          := 'COMERCIAL';
    LcAddress.Cep           := Endereco.Registro.Cep;
    LcAddress.CodigoPais    := Endereco.Registro.CodigoPais;
    LcAddress.CodigoEstado  := Endereco.Registro.CodigoEstado;
    LcAddress.CodigoCidade  := Endereco.Registro.CodigoCidade;
    LcAddress.Principal     := Endereco.Registro.EnderecoPrincipal;
    pObj.Entidade.ListaEndereco.Add(LcAddress);

    if Endereco.Registro.Fone <> '' then
    BEgin
      LcPhone := TPhone.Create;
      LcPhone.Codigo       := Endereco.Registro.Codigo;
      LcPhone.Tipo         := 'Fone';
      LcPhone.Contato      := Endereco.Registro.Contato;
      LcPhone.Numero       := Endereco.Registro.Fone;
      LcPhone.TipoEndereco := 'COMERCIAL';
      pObj.Entidade.ListaFones.Add(LcPhone);
    End;

    if Endereco.Registro.Fax <> '' then
    BEgin
      LcPhone := TPhone.Create;
      LcPhone.Codigo       := Endereco.Registro.Codigo;
      LcPhone.Tipo         := 'Fax';
      LcPhone.Contato      := Endereco.Registro.Contato;
      LcPhone.Numero       := Endereco.Registro.Fax;
      LcPhone.TipoEndereco := 'COMERCIAL';
      pObj.Entidade.ListaFones.Add(LcPhone);
    End;

    if Endereco.Registro.Celular <> '' then
    BEgin
      LcPhone := TPhone.Create;
      LcPhone.Codigo       := Endereco.Registro.Codigo;
      LcPhone.Tipo         := 'Celular';
      LcPhone.Contato      := Endereco.Registro.Contato;
      LcPhone.Numero       := Endereco.Registro.Celular;
      LcPhone.TipoEndereco := 'COMERCIAL';
      pObj.Entidade.ListaFones.Add(LcPhone);
    End;
  End;

  if Registro.Email <> '' then
  Begin
    pObj.Entidade.Email.Codigo := pEmpresa.Codigo;
    pObj.Entidade.Email.Email := pEmpresa.Email;
  End;

  //Social Midia
  if pEmpresa.WebSite <> '' then
  Begin
    pObj.Entidade.MidiaSocial.Codigo := pEmpresa.Codigo;
    pObj.Entidade.MidiaSocial.Tipo   := 'www';
    pObj.Entidade.MidiaSocial.Link   := pEmpresa.WebSite;
  End;
end;

function TControllerEmpresa.salva: boolean;
begin
  if (Registro.Codigo = 0 ) then
    Registro.Codigo := Generator('GN_EMPRESA');
  SaveObj(Registro);
end;


procedure TControllerEmpresa.saveObjWeb(Fiscal: TObjEntityFiscal);
Var
  I : Integer;
begin
  with Registro do
  Begin
    Codigo                            := 0;
    Tipo                              := 1;
    NomeRazaoSocial                   := Fiscal.Entidade.Entidade.NomeRazao;
    ApelidoFantasia                   := Fiscal.Entidade.Entidade.ApelidoFantasia;
    if Fiscal.Fisica.CPF<> '' then
    Begin
      CpfCNPJ                           := Fiscal.Fisica.CPF;
      InscricaoEstadual                 := Fiscal.Fisica.RG;
      TipoPessoa                        := 'F';
      IndicadorInscricaoEstadual        := '9';
    End
    else
    Begin
      CpfCNPJ                           := Fiscal.Juridica.CNPJ;
      InscricaoEstadual                 := Fiscal.Juridica.InscricaoEstadual;
      InscricaoMunicipal                := Fiscal.Juridica.InscricaoMunicipal;
      TipoPessoa                        := 'J';
      IndicadorInscricaoEstadual        := '1';
    End;
    SituacaoCredito                   := 'L';
    Observacao                        := Fiscal.Entidade.Entidade.Observacao;
    DataCadastro                      := Fiscal.Entidade.Entidade.RegistroCriado;
    ValorCredito                      := 0;
    CodigoVendedor                    := 0;
    UtilizarMalaDireta                := 'S';
    CodigoBancoUtilizadoPeloCliente   := '';
    AgenciaUtilizadaPeloCliente       := '';
    ContaCorrenteUtilizadaPeloCliente := '';
    Email                             := Fiscal.Entidade.Email.Email;
    WebSite                           := Fiscal.Entidade.MidiaSocial.Link ;
    DataFundacao                      := Fiscal.Entidade.Entidade.AniversarioFundacao ;
    CodigoTransportadora              := 0;
    NumeroBanco                       := '0';
    CodigoAnterior                    := 0;
    DataUltimoMovimento               := 0;
    ConsumidorFinal                   := 'N';
    OptantePeloSimples                := 'N';
    ReducaoContrato                   := 0;
    Multiplicador                     := 1;
    Classificacao                     := '';
    Ativa                             := 'S';
    Status                            := 'L';
    PoliticaDesconto                  := '';
    VendedorExclusivo                 := '';
    Fabrica                           := 'N';
    InscricaoSubsTributario           := '';
    MovimentoFidelidade               := 0;
    VendaEmCarteira                   := 0;
    TipoFaturamento                   := 0;
    ResponsavelCREA                   := '';
    NumeroCREA                        := '';
    TecnicoResponsavel                := '';
    FormatoDataInspecaoExintor        := '';
    ContatoAdministrativo             := '';
    CodigoRegimeTributario            := 0;
    SubstitutoTributario              := 'N';
    Lojista                           := 'N';
    IgnorarCalculoST                  := 'N';
    FormatoDataEnsaioExintor          := '';
    FormatoDataCargaExintor           := '';
    ObservacaoFiscal                  := '';
    CodigoRamoAtividade               := 0;
  End;
  salva;

  if Fiscal.Entidade.ListaEndereco.Count > 0 then
  BEgin
    with Endereco.Registro  do
    Begin
      Codigo            := 0;
      CodigoEmpresa     := Registro.Codigo;
      Cnpj              := Registro.CpfCNPJ;
      Tipo              := Fiscal.Entidade.ListaEndereco[0].Tipo;
      Logradouro        := Fiscal.Entidade.ListaEndereco[0].Logradouro;
      Complemento       := Fiscal.Entidade.ListaEndereco[0].Complemento;
      Bairro            := Fiscal.Entidade.ListaEndereco[0].Bairro;
      Cep               := Fiscal.Entidade.ListaEndereco[0].Cep;
      EnderecoPrincipal := 'S';
      Regiao            := Fiscal.Entidade.ListaEndereco[0].Regiao;
      NumeroPredial     := Fiscal.Entidade.ListaEndereco[0].NumeroPredial;
      CodigoPais        := Fiscal.Entidade.ListaEndereco[0].CodigoPais;
      CodigoCidade      := Fiscal.Entidade.ListaEndereco[0].CodigoCidade;
      CodigoEstado      := Fiscal.Entidade.ListaEndereco[0].CodigoEstado;

      //Telefone
      for I := 0 to Fiscal.Entidade.ListaFones.Count -1 do
      Begin
        if Fiscal.Entidade.ListaFones[I].Tipo ='Fone' then
        Begin
          Endereco.Registro.Contato := Fiscal.Entidade.ListaFones[I].Contato;
          Endereco.Registro.Fone    := Fiscal.Entidade.ListaFones[I].Numero;
        end;
      end;
      //Fax
      for I := 0 to Fiscal.Entidade.ListaFones.Count -1 do
      Begin
        if Fiscal.Entidade.ListaFones[I].Tipo ='Fax' then
        Begin
          Endereco.Registro.Fax    := Fiscal.Entidade.ListaFones[I].Numero;
        end;
      end;
      //Celular
      for I := 0 to Fiscal.Entidade.ListaFones.Count -1 do
      Begin
        if Fiscal.Entidade.ListaFones[I].Tipo ='Celular' then
        Begin
          if Endereco.Registro.Contato = '' then
            Endereco.Registro.Contato := Fiscal.Entidade.ListaFones[I].Contato;
          Endereco.Registro.Fax    := Fiscal.Entidade.ListaFones[I].Numero;
        end;
      end;
    End;
    Endereco.salva;
  end
  else
  Begin
    Endereco.Registro.Codigo        := 0;
    Endereco.Registro.CodigoEmpresa := Registro.Codigo;
    Endereco.AutoEndereco;
  End;
  Fiscal.Entidade.Entidade.Codigo :=  Registro.Codigo;
end;


procedure TControllerEmpresa.SetSequencia;
begin
  Registro.Codigo := getNextByField(Registro,'EMP_CODIGO',0) ;
  setGenerator('GN_EMPRESA',Registro.Codigo.ToString);
end;

function TControllerEmpresa.Update: Boolean;
begin
  try
    UpdateObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;


procedure TControllerEmpresa.getAllBykey;
begin
  _getByKey(Registro);
  Endereco.clear;
  if (exist) then
  Begin
    Endereco.Registro.CodigoEmpresa := Registro.Codigo;
    Endereco.getAll;
  End;

end;

procedure TControllerEmpresa.getByDocumento;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT c.* '+
              'FROM tb_empresa c '+
              'where ( c.EMP_CNPJ =:EMP_CNPJ) and (c.EMP_CNPJ <> '''') ');
      parambyname('EMP_CNPJ').asString := Registro.CpfCNPJ;
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerEmpresa.getById;
begin
  _getByKey(Registro);
end;

function TControllerEmpresa.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TEmpresa;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_EMPRESA ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEmpresa.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerEmpresa.getListMovimento: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TEmpresa;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat('select distinct e.* ',
                     'from tb_empresa e ',
                     '  inner join tb_pedido p ',
                     '  on (p.ped_codemp = e.emp_codigo) '
      ));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TEmpresa.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerEmpresa.insert: Boolean;
begin
  try
    if (Registro.Codigo = 0 ) then
      Registro.Codigo := Generator('GN_EMPRESA')
    else
    if Registro.Codigo = -1 then
    Begin
      Registro.Codigo := getNextByField(Registro,'EMP_CODIGO',0) ;
      setGenerator('GN_EMPRESA',Registro.Codigo.ToString);
    End;
    InsertObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerEmpresa.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerEmpresa.Replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
