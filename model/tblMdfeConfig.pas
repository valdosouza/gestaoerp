unit tblMdfeConfig;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_CONFIG')]
  TMdfeConfig = Class(TGenericEntity)

    private
    FSENDEMAILTOYOURSELF: string;
    FREP_MDFE: string;
    FVERSION_NB: string;
    FORIENTATION_PASS: string;
    FCERTIFICATE_SERIE: string;
    FTYPE_EMISSION: string;
    FSENDEMAILTOACCOUNTING: string;
    FCERTIFICATE_PASS: string;
    FTB_INSTITUTION_ID: Integer;
    FSET_VIEW_MSG: string;
    FLAYER: string;
    FKIND: string;
    procedure setFCERTIFICATE_PASS(const Value: string);
    procedure setFCERTIFICATE_SERIE(const Value: string);
    procedure setFKIND(const Value: string);
    procedure setFLAYER(const Value: string);
    procedure setFORIENTATION(const Value: string);
    procedure setFREP_MDFE(const Value: string);
    procedure setFSENDEMAILTOACCOUNTING(const Value: string);
    procedure setFSENDEMAILTOYOURSELF(const Value: string);
    procedure setFSET_VIEW_MSG(const Value: string);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTYPE_EMISSION(const Value: string);
    procedure setFVERSION_NB(const Value: string);

    public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('LAYER')]
    property Camada: string read FLAYER write setFLAYER;

    [FieldName('TYPE_EMISSION')]
    property TipoEmissao: string read FTYPE_EMISSION write setFTYPE_EMISSION;

    [FieldName('CERTIFICATE_SERIE')]
    property Serie: string read FCERTIFICATE_SERIE write setFCERTIFICATE_SERIE;

    [FieldName('CERTIFICATE_PASS')]
    property Senha: string read FCERTIFICATE_PASS write setFCERTIFICATE_PASS;

    [FieldName('ORIENTATION')]
    property Orientacao: string read FORIENTATION_PASS write setFORIENTATION;

    [FieldName('SET_VIEW_MSG')]
    property Mensagem: string read FSET_VIEW_MSG write setFSET_VIEW_MSG;

    [FieldName('KIND')]
    property Tipo: string read FKIND write setFKIND;

    [FieldName('SENDEMAILTOACCOUNTING')]
    property EnviarParaContador: string read FSENDEMAILTOACCOUNTING write setFSENDEMAILTOACCOUNTING;

    [FieldName('SENDEMAILTOYOURSELF')]
    property EnviarParaSiMesmo: string read FSENDEMAILTOYOURSELF write setFSENDEMAILTOYOURSELF;

    [FieldName('VERSION_NB')]
    property Versao: string read FVERSION_NB write setFVERSION_NB;

    [FieldName('REP_MDFE')]
    property RepositorioMdfe: string read FREP_MDFE write setFREP_MDFE;

  End;

implementation

{ TMdfeConfig }

procedure TMdfeConfig.setFCERTIFICATE_PASS(const Value: string);
begin
  FCERTIFICATE_PASS := Value;
end;

procedure TMdfeConfig.setFCERTIFICATE_SERIE(const Value: string);
begin
  FCERTIFICATE_SERIE := Value;
end;

procedure TMdfeConfig.setFKIND(const Value: string);
begin
  FKIND := Value;
end;

procedure TMdfeConfig.setFLAYER(const Value: string);
begin
  FLAYER := Value;
end;

procedure TMdfeConfig.setFORIENTATION(const Value: string);
begin
  FORIENTATION_PASS := Value;
end;

procedure TMdfeConfig.setFREP_MDFE(const Value: string);
begin
  FREP_MDFE := Value;
end;

procedure TMdfeConfig.setFSENDEMAILTOACCOUNTING(const Value: string);
begin
  FSENDEMAILTOACCOUNTING := Value;
end;

procedure TMdfeConfig.setFSENDEMAILTOYOURSELF(const Value: string);
begin
  FSENDEMAILTOYOURSELF := Value;
end;

procedure TMdfeConfig.setFSET_VIEW_MSG(const Value: string);
begin
  FSET_VIEW_MSG := Value;
end;

procedure TMdfeConfig.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeConfig.setFTYPE_EMISSION(const Value: string);
begin
  FTYPE_EMISSION := Value;
end;

procedure TMdfeConfig.setFVERSION_NB(const Value: string);
begin
  FVERSION_NB := Value;
end;

end.
