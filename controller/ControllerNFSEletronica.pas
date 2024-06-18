unit ControllerNFSEletronica;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblNFSEletronica ,
      pcnConversao,Vcl.ExtCtrls,ACBrDFeSSL,blcksock, Vcl.Forms,
      ControllerEstabelecimento,synacode, ACBrNFSeX, ACBrNFSeXConversao,
  System.AnsiStrings;

Type
  TControllerNFSEletronica = Class(TControllerBase)
  private
    PathExe : String;

  public
    Registro : TNFSEletronica;
    Estabelecimento : TControllerEstabelecimento;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure get;
    procedure ConfiguraComponente(nfse:TACBrNFSeX;CNPJ:String);
    function salva:boolean;
    procedure CarregaDadosEmitente(nfse: TACBrNFSeX;CNPJ:String);
    function ConfigSSLCertificado(comp: TACBrNFSeX):String;
    function CarregaCertificado(comp: TACBrNFSeX;cnpj,senha:String):String;
  End;

implementation

//uses RN_NotaFiscalServico;

constructor TControllerNFSEletronica.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNFSEletronica.Create;
  Estabelecimento := TControllerEstabelecimento.Create(self);
end;

destructor TControllerNFSEletronica.Destroy;
begin
  Estabelecimento.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerNFSEletronica.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerNFSEletronica.get;
begin
  _getByKey(Registro);
end;



function TControllerNFSEletronica.CarregaCertificado(comp: TACBrNFSeX;cnpj,senha: String): String;
Var
  LcNomeCert : String;
  LcPathExe : String;
begin
  ConfigSSLCertificado(comp);
  with comp do
  Begin


    if StrToIntDef( Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_CERT','0'),0) = 0 then
    Begin
      if Configuracoes.Certificados.NumeroSerie = '' then
      Begin
        LcPathExe := ExtractFilePath(Application.ExeName);
        LcNomeCert := concat(LcPathExe,'cert_',cnpj,'.pfx');
        Configuracoes.Certificados.ArquivoPFX  :=  LcNomeCert;
        Configuracoes.Certificados.Senha       := Senha;
        Result := SSL.CertNumeroSerie;
      End
      else
      BEgin
        REsult := Configuracoes.Certificados.NumeroSerie;
      End;
    End
    else
    BEgin
      Configuracoes.Certificados.ArquivoPFX  :=  '';
      Configuracoes.Certificados.Senha       := '';
      Configuracoes.Certificados.NumeroSerie := ssl.SelecionarCertificado;
      Result  := Configuracoes.Certificados.NumeroSerie;
    End;
  End;
end;

procedure TControllerNFSEletronica.CarregaDadosEmitente(nfse: TACBrNFSeX;CNPJ:String);
Var
  Lc_Ok : Boolean;
  Ex_Logo: TImage;
  Lc_Arq_Logo : String;
  LcIndSSL : Integer;
Begin
  get;
  Estabelecimento.Registro.CpfCNPJ := CNPJ;
  Estabelecimento.getAll;
  Nfse.LerCidades;
  with nfse do
  Begin
    NotasFiscais.Clear;
    DANFSE.Logo := '';
    Try
      //Verificar se há arquivo para a logomarca da Empresa

      Lc_Arq_Logo := 'logo_' + Estabelecimento.Registro.Codigo.ToString() + '.jpg';
      ex_logo:= TImage.create(nil);
      Fc_BuscaImagemEmpresa(Ex_Logo.Picture,'LOGO');
      DeleteFile(Pchar( GbPathExe  + Lc_Arq_Logo));
      //sALVA LOGO NO DISCO PASTA BIN
      if (Ex_Logo.Picture.Graphic <> nil) then
        ex_logo.Picture.SaveToFile(GbPathExe + Lc_Arq_Logo);
      if FileExists(GbPathExe + Lc_Arq_Logo) then
        DANFSE.Logo       := GbPathExe + Lc_Arq_Logo;

      //Verificar se há arquivo para a Marca D'agua da Empresa
      if FileExists(GbPathExe+'marcadagua.jpg') then DeleteFile(Pchar( GbPathExe+'marcadagua.jpg'));
      Ex_Logo.Picture.Graphic := nil;
      //sALVA MARCA D´GUA NO DISCO PASTA BIN
      Fc_BuscaImagemEmpresa(Ex_Logo.Picture,'MARCADAGUA');

      if (Ex_Logo.Picture.Graphic <> nil) then
        ex_logo.Picture.SaveToFile(GbPathExe+'marcadagua.jpg');
    Finally
      FreeAndNil(ex_logo);
    End;



    Configuracoes.Geral.Emitente.CNPJ      := Estabelecimento.Registro.CpfCNPJ;
    Configuracoes.Geral.Emitente.InscMun   := Estabelecimento.Registro.InscricaoMunicipal;
    Configuracoes.Geral.Emitente.RazSocial := Estabelecimento.Registro.NomeRazaoSocial;

    Configuracoes.Geral.Emitente.WSUser      := Registro.UsuarioWeb;
    Configuracoes.Geral.Emitente.WSSenha     := Registro.SenhaWeb;
    Configuracoes.Geral.Emitente.WSFraseSecr := Registro.FraseWeb;


    if ( Registro.Provedor = 'IPMSistemas' ) then
    Begin
      Configuracoes.Geral.Emitente.WSChaveAcesso := string( EncodeBase64(Registro.UsuarioWeb + ':' + Registro.SenhaWeb));

    End;


    ConfigSSLCertificado(nfse);
    IF StrToIntDef( Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_CERT','0'),0) = 0 THEN
    Begin
      Configuracoes.Certificados.ArquivoPFX     :=  concat(
                                                            GbPathExe,
                                                            'cert_',
                                                            Estabelecimento.Registro.CpfCNPJ,
                                                            '.pfx'
                                                          );
      Configuracoes.Certificados.Senha          := Fc_Tb_Geral('L','NFS_SENHA_CERT','');
    End
    else
    Begin
      Configuracoes.Certificados.ArquivoPFX  :=  '';
      Configuracoes.Certificados.Senha       := '';
      Configuracoes.Certificados.NumeroSerie := Registro.Certificado;
    End;


    //DANFSE.Fax    := Estabelecimento.Endereco.Registro.Fax;
    DANFSE.Email  := Estabelecimento.Registro.Email;
    DANFSE.Site   := Estabelecimento.Registro.WebSite;
    //Versao
    Lc_Ok := True;
    Configuracoes.Geral.Versao := StrToVersaoNFSe(Lc_Ok,Registro.Versao);
  End;

end;

function TControllerNFSEletronica.ConfigSSLCertificado(
  comp: TACBrNFSeX): String;
begin
  with comp do
  Begin
    SSL.DescarregarCertificado;
    SSL.SSLType := TSSLType(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_SSL','-1'),-1 ));
    with Configuracoes do
    Begin
      WebServices.SSLType :=  TSSLType(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_TIPO_SSL','-1'),-1 ));
      Geral.SSLLib        := TSSLLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_SSLLib','-1'),-1 ));
      Geral.SSLCryptLib   := TSSLCryptLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_CryptLib','-1'),-1 ));
      Geral.SSLHttpLib    := TSSLHttpLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_HttpLib','-1'),-1 ));
      Geral.SSLXmlSignLib := TSSLXmlSignLib(StrtoIntDef(Fc_Aq_Geral('L', 'NFS', 'NFS_XmlSignLib','-1'),-1 ));
    End;
  End;
end;

procedure TControllerNFSEletronica.ConfiguraComponente(nfse:TACBrNFSeX;CNPJ:String);
var
  Lc_Ok : Boolean;
  Ex_Logo: TImage;
  LcIndSSL  :Integer;
  LcPathExe :String;
  LcNomeCert : String;
Begin

  PathExe := ExtractFilePath(Application.ExeName);
  CarregaDadosEmitente(nfse,cnpj);


  with Nfse do
  Begin

    Configuracoes.WebServices.UF            := Estabelecimento.Endereco.Uf.Registro.Sigla;
    Configuracoes.WebServices.Visualizar    := (Registro.VisualizaMensagem = 'S');
    Configuracoes.WebServices.Salvar     := True;
    if Registro.Ambiente ='0' then
      Configuracoes.WebServices.Ambiente   := taProducao
    else
      Configuracoes.WebServices.Ambiente   := taHomologacao;
    Configuracoes.WebServices.Visualizar := (Registro.VisualizaMensagem = 'S');
    Configuracoes.WebServices.TimeOut := 5000;


    Configuracoes.Arquivos.SepararPorIE     := False;
    Configuracoes.Arquivos.SepararPorModelo := False;
    Configuracoes.Arquivos.SepararPorAno    := False;
    Configuracoes.Arquivos.SepararPorMes    := False;
    Configuracoes.Arquivos.SepararPorDia    := False;

    Configuracoes.Arquivos.AdicionarLiteral := True;
    Configuracoes.Arquivos.EmissaoPathNFSe  := True;
    Configuracoes.Arquivos.PathGer          := Registro.CaminhoNFSE;
    Configuracoes.Arquivos.PathSchemas      := Registro.SchemasProvedor;
    Configuracoes.Arquivos.NomeLongoNFSe    := True;
    Configuracoes.Arquivos.PathCan          := Registro.CaminhoNFSE;
    Configuracoes.Arquivos.PathSalvar       := Registro.CaminhoNFSE;
    Configuracoes.Arquivos.Salvar           := True;

    Configuracoes.Geral.MontarPathSchema := True;

    if Registro.LayoutNFse = 'Nacional' then
      Configuracoes.Geral.LayoutNFSe := TLayoutNFSe(1)
    else
      Configuracoes.Geral.LayoutNFSe := TLayoutNFSe(0);

    Configuracoes.Geral.FormaEmissao := teNormal;
    Configuracoes.Geral.Salvar       := true;
    Configuracoes.Geral.ExibirErroSchema := True;
    Configuracoes.Geral.ValidarDigest := False;
    Configuracoes.Geral.ConsultaLoteAposEnvio := True;

    case AnsiIndexStr(Registro.provedor, ['ISSCuritiba','ISSNet','IPMSistemas']) of
      0: Begin
          Configuracoes.Geral.provedor := proIssCuritiba;
      End;
      1: Begin
          Configuracoes.Geral.provedor := proIssNet;
      End;
      2: Begin
          Configuracoes.Geral.provedor := proIPM;
      End;
    end;

    Nfse.Configuracoes.Geral.retirarAcentos := True;
    if Nfse.DANFSe <> nil then
    begin
      Nfse.DANFSe.Provedor := Configuracoes.Geral.Provedor;
      Nfse.DANFSe.MargemEsquerda := StrToIntDef(Fc_Tb_Geral('L','NFE_MARGEM_ESQUERDA','5'),5);
      Nfse.DANFSe.MargemSuperior := StrToIntDef(Fc_Tb_Geral('L','NFE_MARGEM_SUPERIOR','5'),5);
      Nfse.DANFSe.Logo       := Registro.LogoPrefeitura;
      if FileExists(PathExe+'logo.jpg') then DeleteFile(PathExe+'logo.jpg');
      //sALVA LOGO NO DISCO PASTA BIN
      ex_logo:= TImage.create(nil);
      Self.Estabelecimento.Imagem(Ex_Logo.Picture,'LOGO');

      if (Ex_Logo.Picture.Graphic <> nil) then
        ex_logo.Picture.SaveToFile(PathExe+'logo.jpg');
      if FileExists(PathExe+'logo.jpg') then
        Nfse.DANFSe.Prestador.Logo  := PathExe+'logo.jpg';
      if FileExists(Registro.Prefeitura) then
        Nfse.DANFSe.Prefeitura := Registro.Prefeitura;
      Nfse.DANFSe.PathPDF    := Registro.CaminhoNFSE;
      //TTipoDANFSE = ( tpPadrao, tpIssDSF, tpFiorilli );
      Nfse.DANFSe.TipoDANFSE := tpPadrao;
    end;
    //Estas confurações precisam estar nesta ultima posição de preenchimento por que interferem no Layout e no Layout NFSE
    Configuracoes.Geral.CodigoMunicipio := Estabelecimento.Endereco.Cidade.Registro.ibge;
    Configuracoes.Geral.LerParamsMunicipio;

  End;
end;

end.
