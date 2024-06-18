unit ControllerMdfeConfig;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeConfig ,Un_MSg,Generics.Collections,
  Registry, Winapi.Windows, Vcl.StdCtrls, blcksock, TypInfo, pcnConversaoNFe,
  ACBrMDFe, pcnConversao, ACBrDFeSSL, pmdfeConversaoMDFe,
  Vcl.ExtCtrls, Vcl.Graphics;

Type
  TControllerMdfeConfig = Class(TControllerBase)
  private
    FOperador: TACBrMDFe;
    procedure setFOperador(const Value: TACBrMDFe);


  public
    Registro : TMdfeConfig;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Configura;
    function CarregaCertificado:String;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    procedure Pc_SSL2_TLS1;
    procedure CarregaListaSSLType(Lista:Tcombobox);
    procedure PreparaComponente;
    procedure MostraValidade(pValidade, pCert_Validade,pCert_Expira: TPanel);
    function LabelTipo(Tipo:Integer):String;


    property Operador : TACBrMDFe read FOperador write setFOperador;
  End;

implementation

{ TControllerMdfeConfig }

uses UN_Sistema, Un_DM;

procedure TControllerMdfeConfig.Pc_SSL2_TLS1;
var
  Lc_Registro: TRegistry;
begin
  //TESTANDO O EMAIL VAMOS DESABILITAR A CONFIGUIRAÇÃO
  EXIT;

  try
    //acertando opções da internet (revogados / SSL / TSL)
    //verificar revogação de certificados do servidor
    Lc_Registro := TRegistry.Create(KEY_WRITE);
    Lc_Registro.RootKey := HKEY_CURRENT_USER;
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('CertificateRevocation', 0);
    end;
    Lc_registro.CloseKey;

    //verificar se há certificados revogados do fornecedor
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing', true) then
    begin
      Lc_Registro.WriteInteger('State', 146944);
    end;
    Lc_registro.CloseKey;

    if Fc_Aq_Geral('L', 'MDFE', 'MDFE_TIPO_SSL', '1') = '1' then
    Begin
     //Usar SSL 3.0 / Usar TSL 1.0
      if Lc_Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
          Lc_Registro.WriteInteger('SecureProtocols', 2728);
//        Lc_Registro.WriteInteger('SecureProtocols', 2088);
//        Lc_Registro.WriteInteger('SecureProtocols', 160);
      end;
      Lc_Registro.CloseKey;
    End
    else
    Begin
      //Usar SSL 2.0 / Usar TSL 1.0
      if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
        Lc_Registro.WriteInteger('SecureProtocols', 136);
      end;
      Lc_registro.CloseKey;
    End;

    //força para IE não ficar trabalhando off line
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('GlobalUserOffline', 0);
    end;
  finally
    Lc_registro.CloseKey;
    FReeAndNil(Lc_registro);
  end;
end;

procedure TControllerMdfeConfig.PreparaComponente;
begin
  Pc_SSL2_TLS1;
end;

function  TControllerMdfeConfig.CarregaCertificado:String;
Var
  LcNomeCert : String;
begin
  with FOperador do
  Begin
    if Registro.Tipo = 'A' then
    Begin
      if Configuracoes.Certificados.NumeroSerie = '' then
      Begin
        LcNomeCert := concat(
                        GbPathExe,
                        'cert_',
                        DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                        '.pfx'
                      );
        Configuracoes.Certificados.ArquivoPFX  :=  LcNomeCert;
        Configuracoes.Certificados.Senha       := Registro.Senha;
        Result :=  SSL.CertNumeroSerie;
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

procedure TControllerMdfeConfig.CarregaListaSSLType(Lista: Tcombobox);
Var
  I : TSSLType;
begin
  //Tipo de SSL
  Lista.Items.Clear;
  For I := Low(TSSLType) to High(TSSLType) do
    Lista.Items.Add( GetEnumName(TypeInfo(TSSLType), integer(I) ) );
  Lista.ItemIndex := 0;
end;

procedure TControllerMdfeConfig.Configura;
Var
  Lc_Ok : Boolean;
  LcIndSSL : Integer;
begin
  with FOperador do
  BEgin
    Configuracoes.Arquivos.PathSchemas      := GbPathExe + 'Schemas\Mdfe\';
    Configuracoes.Geral.FormaEmissao        := StrToTpEmis(Lc_Ok,IntToStr(StrToIntDef(Self.Registro.TipoEmissao,0)+1));
    Configuracoes.Geral.Salvar              := true;

    if Trim(Self.Registro.RepositorioMdfe) <> '' then
    Begin
      if not DirectoryExists(Self.Registro.RepositorioMdfe) then
        ForceDirectories(Self.Registro.RepositorioMdfe);
    end
    else
    Begin
      if not DirectoryExists(GbPathExe + '\xml\mdfe\') then
        ForceDirectories(GbPathExe + '\xml\mdfe\');
      Self.Registro.RepositorioMdfe := GbPathExe + '\xml\mdfe\';
    End;
    DAMDFE.PathPDF := Self.Registro.RepositorioMdfe;
    DAMDFE.Sistema := 'Setes - Gestão Computacional';
    DAMDFE.Site := 'www.setes.com.br';

    if Registro.Orientacao = 'R' then
      DAMDFE.TipoDAMDFe := tiRetrato
    else
      DAMDFE.TipoDAMDFe := tiPaisagem;
    Configuracoes.WebServices.UF         := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
    if Self.Registro.Camada = 'P' then
      Configuracoes.WebServices.Ambiente   := taProducao
    else
      Configuracoes.WebServices.Ambiente   := taHomologacao;
    Configuracoes.WebServices.Visualizar := (Self.Registro.Mensagem = 'S');


    Configuracoes.Geral.SSLLib        := TSSLLib(StrToIntDef(Fc_Aq_Geral('L', 'MDFE', 'MDFE_SSLLib', '0'),0));
    Configuracoes.Geral.SSLCryptLib   := TSSLCryptLib(StrToIntDef(Fc_Aq_Geral('L', 'MDFE', 'MDFE_CryptLib', '0'),0));
    Configuracoes.Geral.SSLHttpLib    := TSSLHttpLib(StrToIntDef(Fc_Aq_Geral('L', 'MDFE', 'MDFE_HttpLib',  '0'),0));
    Configuracoes.Geral.SSLXmlSignLib := TSSLXmlSignLib(StrToIntDef(Fc_Aq_Geral('L', 'MDFE', 'MDFE_XmlSignLib',  '0'),0));
    Configuracoes.WebServices.SSLType := TSSLType(StrToIntDef(Fc_Aq_Geral('L', 'MDFE', 'MDFE_TIPO_SSL', '0'),0));
    //Versao
    Configuracoes.Geral.VersaoDF := ve300;
    Configuracoes.Certificados.NumeroSerie := Self.Registro.Serie;
    IF Registro.Tipo = 'A' THEN
    Begin
      Configuracoes.Certificados.ArquivoPFX     :=  concat(
                                                            GbPathExe,
                                                            'cert_',
                                                            DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                                                            '.pfx'
                                                          );
      Configuracoes.Certificados.Senha          := Self.Registro.Senha;
    End
    else
    Begin
      Configuracoes.Certificados.ArquivoPFX  :=  '';
      Configuracoes.Certificados.Senha       := '';
    End;


  end;
end;

constructor TControllerMdfeConfig.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeConfig.Create;
  FOperador := TACBrMDFe.Create(Self);
end;

function TControllerMdfeConfig.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeConfig.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerMdfeConfig.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeConfig.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeConfig.LabelTipo(Tipo: Integer): String;
begin
  if  Tipo = 0 then
  BEgin
    Result :=
          concat('O certificado deve estar na pasta do Sistema.',#13,
                 'O nome do certificado deve ser ',
                 'cert_',
                 DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                 '.pfx'
          );
  End
  else
  Begin
    Result :=
          concat('Verifique a instalação dos drives do dispositivo.',#13,
                 'Utilize o botão "Carregar o certificado".'
          );
  End;
end;

procedure TControllerMdfeConfig.MostraValidade(pValidade, pCert_Validade,
  pCert_Expira: TPanel);
Var
  Lc_Str_Date: String;
  Lc_Days_For: Integer;
  procedure errocertificado;
  BEgin
    // VAlidade
    pCert_Validade.Color := clBtnFace;
    pCert_Validade.Font.Color := clred;
    pCert_Validade.Caption := 'Não instalado/associado ao sistema';
    // Expira
    pCert_Expira.Color := clBtnFace;
    pCert_Expira.Font.Color := clGreen;
    pCert_Expira.Caption := 'Verifique!!!';
  End;

Begin
  IF (Trim(FOperador.Configuracoes.Certificados.NumeroSerie) <> '') or (FOperador.Configuracoes.Certificados.ArquivoPFX<> '') then
  Begin
    Try
      Lc_Str_Date := DateToStr(FOperador.SSL.CertDataVenc);
      Lc_Days_For := Round(FOperador.SSL.CertDataVenc - Date);
      if (Lc_Days_For <= 30) then
      Begin
        pCert_Validade.Color := clred;
        pCert_Validade.Font.Color := clBlack;
        pCert_Expira.Font.Color := clred;
      End
      else
      BEgin
        pCert_Validade.Color := clBtnFace;
        pCert_Expira.Font.Color := clGreen;
      End;
      pCert_Validade.Caption := ' Validade do Certificado: ' + Lc_Str_Date;
      pCert_Expira.Caption := 'O Certificado expira em ' +
        IntToStr(Lc_Days_For) + ' dia(s)';
    Except
      errocertificado;
    End;
  End
  else
  Begin
    errocertificado;
  End;
end;

function TControllerMdfeConfig.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerMdfeConfig.setFOperador(const Value: TACBrMDFe);
begin
  FOperador := Value;
end;

function TControllerMdfeConfig.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
