unit tblNFSEletronica;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_NFS_ELETRONICA')]
  TNFSEletronica = Class(TGenericEntity)
  private
    FCODEMP: Integer;
    FCD_CNAE: String;
    FFRASE_WEB: String;
    FPROVEDOR: String;
    FCD_TRIB_MUN: String;
    FPWS_SENHA: String;
    FPWS_USER : String;
    FCERTIFICADO: String;
    FPATH_INI_PROVEDOR: String;
    FCD_SRV_LLC: String;
    FPATH_RPS: String;
    FUSER_WEB: String;
    FPREFEITURA_LOGO: String;
    FPWS_CERTIFICADO: String;
    FCD_CRET: Integer;
    FVISUA_MSG: String;
    FPREFEITURA: String;
    FAMBIENTE: String;
    FCOPIA_EMAIL: String;
    FPATH_SCH_PROVEDOR: String;
    FPATH_NFSE: String;
    FPATH_CERTIFICADO: String;
    FNFS_LAYOUT: String;
    FNFS_VERSAO: String;

    procedure setFCODEMP( Value : Integer);
    procedure setFAMBIENTE( Value : String);
    procedure setFCERTIFICADO( Value : String);
    procedure setFPATH_CERTIFICADO( Value : String);
    procedure setFPWS_CERTIFICADO( Value : String);
    procedure setFUSER_WEB( Value : String);
    procedure setFPWS_USER( Value : String);
    procedure setFPATH_NFSE( Value : String);
    procedure setFFRASE_WEB( Value : String);
    procedure setFPATH_RPS( Value : String);
    procedure setFPREFEITURA( Value : String);
    procedure setFPREFEITURA_LOGO( Value : String);
    procedure setFPATH_INI_PROVEDOR( Value : String);
    procedure setFPATH_SCH_PROVEDOR( Value : String);
    procedure setFCOPIA_EMAIL( Value : String);
    procedure setFVISUA_MSG( Value : String);
    procedure setFCD_SRV_LLC( Value : String);
    procedure setFCD_CRET( Value : Integer);
    procedure setFCD_TRIB_MUN( Value : String);
    procedure setFCD_CNAE( Value : String);
    procedure setFPROVEDOR( Value : String);
    procedure setFPWS_SENHA(Value: String);
    procedure setFNFS_LAYOUT(const Value: String);
    procedure setFNFS_VERSAO(const Value: String);

  public
    [KeyField('NFS_CODEMP')]
    [FieldName('NFS_CODEMP')]
    property CodigoEstabelecimento: Integer read FCODEMP write setFCODEMP;
    [FieldName('NFS_AMBIENTE')]
    property Ambiente: String read FAMBIENTE write setFAMBIENTE;
    [FieldName('NFS_CERTIFICADO')]
    property Certificado: String read FCERTIFICADO write setFCERTIFICADO;
    [FieldName('NFS_PATH_CERTIFICADO')]
    property CaminhoCertificado: String read FPATH_CERTIFICADO write setFPATH_CERTIFICADO;
    [FieldName('NFS_PWS_CERTIFICADO')]
    property SenhaCertificado: String read FPWS_CERTIFICADO write setFPWS_CERTIFICADO;
    [FieldName('NFS_USER_WEB')]
    property UsuarioWeb: String read FUSER_WEB write setFUSER_WEB;
    [FieldName('NFS_PWS_USER')]
    property SenhaWeb: String read FPWS_SENHA write setFPWS_SENHA;
    [FieldName('NFS_PATH_NFSE')]
    property CaminhoNFSE: String read FPATH_NFSE write setFPATH_NFSE;
    [FieldName('NFS_FRASE_WEB')]
    property FraseWeb: String read FFRASE_WEB write setFFRASE_WEB;
    [FieldName('NFS_PATH_RPS')]
    property CaminhoRPS: String read FPATH_RPS write setFPATH_RPS;
    [FieldName('NFS_PREFEITURA')]
     property Prefeitura: String read FPREFEITURA write setFPREFEITURA;
    [FieldName('NFS_PREFEITURA_LOGO')]
    property LogoPrefeitura: String read FPREFEITURA_LOGO write setFPREFEITURA_LOGO;
    [FieldName('NFS_PATH_INI_PROVEDOR')]
    property ArquivoIniProvedor: String read FPATH_INI_PROVEDOR write setFPATH_INI_PROVEDOR;
    [FieldName('NFS_PATH_SCH_PROVEDOR')]
    property SchemasProvedor: String read FPATH_SCH_PROVEDOR write setFPATH_SCH_PROVEDOR;
    [FieldName('NFS_COPIA_EMAIL')]
    property CopiaEmail: String read FCOPIA_EMAIL write setFCOPIA_EMAIL;
    [FieldName('NFS_VISUA_MSG')]
    property VisualizaMensagem: String read FVISUA_MSG write setFVISUA_MSG;
    [FieldName('NFS_CD_SRV_LLC')]
    property CodigoSrvLLC: String read FCD_SRV_LLC write setFCD_SRV_LLC;
    [FieldName('NFS_CD_CRET')]
    property CodigoRegimeEspecialTributacao: Integer read FCD_CRET write setFCD_CRET;
    [FieldName('NFS_CD_TRIB_MUN')]
    property CodigoTributarioMunicipal: String read FCD_TRIB_MUN write setFCD_TRIB_MUN;
    [FieldName('NFS_CD_CNAE')]
    property CNAE: String read FCD_CNAE write setFCD_CNAE;
    [FieldName('NFS_PROVEDOR')]
    property Provedor: String read FPROVEDOR write setFPROVEDOR;

    [FieldName('NFS_LAYOUT')]
    property LayoutNFse: String read FNFS_LAYOUT write setFNFS_LAYOUT;

    [FieldName('NFS_VERSAO')]
    property Versao: String read FNFS_VERSAO write setFNFS_VERSAO;

  End;

implementation


{ TNFSEletronica }

procedure TNFSEletronica.setFAMBIENTE(Value: String);
begin
  FAMBIENTE := Value;
end;

procedure TNFSEletronica.setFCD_CNAE(Value: String);
begin
  FCD_CNAE := Value;
end;

procedure TNFSEletronica.setFCD_CRET(Value: Integer);
begin
  FCD_CRET := Value;
end;

procedure TNFSEletronica.setFCD_SRV_LLC(Value: String);
begin
  FCD_SRV_LLC := Value;
end;

procedure TNFSEletronica.setFCD_TRIB_MUN(Value: String);
begin
  FCD_TRIB_MUN := Value;
end;

procedure TNFSEletronica.setFCERTIFICADO(Value: String);
begin
  FCERTIFICADO := Value;
end;

procedure TNFSEletronica.setFCODEMP(Value: Integer);
begin
  FCODEMP := Value;
end;

procedure TNFSEletronica.setFCOPIA_EMAIL(Value: String);
begin
  FCOPIA_EMAIL := Value;
end;

procedure TNFSEletronica.setFFRASE_WEB(Value: String);
begin
  FFRASE_WEB := Value;
end;

procedure TNFSEletronica.setFNFS_LAYOUT(const Value: String);
begin
  FNFS_LAYOUT := Value;
end;

procedure TNFSEletronica.setFNFS_VERSAO(const Value: String);
begin
  FNFS_VERSAO := Value;
end;

procedure TNFSEletronica.setFPATH_CERTIFICADO(Value: String);
begin
  FPATH_CERTIFICADO := Value;
end;

procedure TNFSEletronica.setFPATH_INI_PROVEDOR(Value: String);
begin
  FPATH_INI_PROVEDOR := Value;
end;

procedure TNFSEletronica.setFPATH_NFSE(Value: String);
begin
  FPATH_NFSE := Value;
end;

procedure TNFSEletronica.setFPATH_RPS(Value: String);
begin
  FPATH_RPS := Value;
end;

procedure TNFSEletronica.setFPATH_SCH_PROVEDOR(Value: String);
begin
  FPATH_SCH_PROVEDOR := Value;
end;

procedure TNFSEletronica.setFPREFEITURA(Value: String);
begin
  FPREFEITURA := Value;
end;

procedure TNFSEletronica.setFPREFEITURA_LOGO(Value: String);
begin
  FPREFEITURA_LOGO := Value;
end;

procedure TNFSEletronica.setFPROVEDOR(Value: String);
begin
  FPROVEDOR := Value;
end;

procedure TNFSEletronica.setFPWS_CERTIFICADO(Value: String);
begin
  FPWS_CERTIFICADO := Value;
end;

procedure TNFSEletronica.setFPWS_SENHA(Value: String);
begin
  FPWS_SENHA := Value;
end;

procedure TNFSEletronica.setFPWS_USER(Value: String);
begin
  FPWS_USER := Value;
end;

procedure TNFSEletronica.setFUSER_WEB(Value: String);
begin
  FUSER_WEB := Value;
end;

procedure TNFSEletronica.setFVISUA_MSG(Value: String);
begin
  FVISUA_MSG := Value;
end;

end.
