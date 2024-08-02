unit tblEmpresa;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_empresa')]
  TEmpresa = Class(TGenericEntity)
  private
    FCODIGO : Integer;
    FTIPO : Integer;
    FNOME : String;
    FFANTASIA : String;
    FCNPJ : String;
    FINSC_EST : String;
    FSTCRED : String;
    FOBSERV : String;
    FDT_CADASTRO : TDate;
    FPESSOA : String;
    FVL_CRED : Real;
    FCODVDOR : Integer;
    FML_DRT : String;
    FCODBCO : String;
    FAGENCIA : String;
    FCONTABCO : String;
    FEMAIL : String;
    FSITE : String;
    FDT_FUNDA : TDate;
    FCODTRANSP : Integer;
    FNUMBCO : String;
    FCODANT : Integer;
    FDT_ULT_MOV : TDate;
    FCONSUMIDOR : String;
    FMICRO : String;
    FRED_CONTRATO : Real;
    FMULTIPLICADOR : Real;
    FCLASSE : String;
    FATIVA : String;
    FSTATUS : String;
    FPOLIT_DESC : String;
    FVDOEXCLUSIVO : String;
    FFABRICA : String;
    FNUMINSC_SUBS : String;
    FMOV_FIDELIDADE : Integer;
    FCODFPG : Integer;
    FTIP_FAT : Integer;
    FRESPONSAVEL : String;
    FCREA : String;
    FRESP_TEC : String;
    FFORMDATA : String;
    FCONTATO_ADM : String;
    FINSC_MUN : String;
    FCRT : Integer;
    FSUB_TRIB : String;
    FLOJISTA : String;
    FIGNORAR_ST : String;
    FFORMDATA_E : String;
    FFORMDATA_C : String;
    FOBS_FISCAL : String;
    FRAMO_ATIVIDADE_ID : Integer;
    FIND_IE_DEST : String;
    FNumeroNome: String;

    procedure setFCODIGO( Value : Integer);
    procedure setFTIPO( Value : Integer);
    procedure setFNOME( Value : String);
    procedure setFFANTASIA( Value : String);
    procedure setFCNPJ( Value : String);
    procedure setFINSC_EST( Value : String);
    procedure setFSTCRED( Value : String);
    procedure setFOBSERV( Value : String);
    procedure setFDT_CADASTRO( Value : TDate);
    procedure setFPESSOA( Value : String);
    procedure setFVL_CRED( Value : Real);
    procedure setFCODVDOR( Value : Integer);
    procedure setFML_DRT( Value : String);
    procedure setFCODBCO( Value : String);
    procedure setFAGENCIA( Value : String);
    procedure setFCONTABCO( Value : String);
    procedure setFEMAIL( Value : String);
    procedure setFSITE( Value : String);
    procedure setFDT_FUNDA( Value : TDate);
    procedure setFCODTRANSP( Value : Integer);
    procedure setFNUMBCO( Value : String);
    procedure setFCODANT( Value : Integer);
    procedure setFDT_ULT_MOV( Value : TDate);
    procedure setFCONSUMIDOR( Value : String);
    procedure setFMICRO( Value : String);
    procedure setFRED_CONTRATO( Value : Real);
    procedure setFMULTIPLICADOR( Value : Real);
    procedure setFCLASSE( Value : String);
    procedure setFATIVA( Value : String);
    procedure setFSTATUS( Value : String);
    procedure setFPOLIT_DESC( Value : String);
    procedure setFVDOEXCLUSIVO( Value : String);
    procedure setFFABRICA( Value : String);
    procedure setFNUMINSC_SUBS( Value : String);
    procedure setFMOV_FIDELIDADE( Value : Integer);
    procedure setFCODFPG( Value : Integer);
    procedure setFTIP_FAT( Value : Integer);
    procedure setFRESPONSAVEL( Value : String);
    procedure setFCREA( Value : String);
    procedure setFRESP_TEC( Value : String);
    procedure setFFORMDATA( Value : String);
    procedure setFCONTATO_ADM( Value : String);
    procedure setFINSC_MUN( Value : String);
    procedure setFCRT( Value : Integer);
    procedure setFSUB_TRIB( Value : String);
    procedure setFLOJISTA( Value : String);
    procedure setFIGNORAR_ST( Value : String);
    procedure setFFORMDATA_E( Value : String);
    procedure setFFORMDATA_C( Value : String);
    procedure setFOBS_FISCAL( Value : String);
    procedure setFRAMO_ATIVIDADE_ID( Value : Integer);
    procedure setFIND_IE_DEST( Value : String);
    procedure setfNumeroNome(const Value: String);

  public

    [KeyField('EMP_CODIGO')]
    [FieldName('EMP_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;
    [FieldName('EMP_TIPO')]
    property Tipo: Integer read FTIPO write setFTIPO;

    [FieldName('EMP_NOME')]
    property NomeRazaoSocial: String read FNOME write setFNOME;

    [FieldName('EMP_FANTASIA')]
    property ApelidoFantasia: String read FFANTASIA write setFFANTASIA;
    [FieldName('EMP_CNPJ')]
    property CpfCNPJ: String read FCNPJ write setFCNPJ;
    [FieldName('EMP_INSC_EST')]
    property InscricaoEstadual: String read FINSC_EST write setFINSC_EST;
    [FieldName('EMP_STCRED')]
    property SituacaoCredito: String read FSTCRED write setFSTCRED;
    [FieldName('EMP_OBSERV')]
    property Observacao: String read FOBSERV write setFOBSERV;
    [FieldName('EMP_DT_CADASTRO')]
    property DataCadastro: TDate read FDT_CADASTRO write setFDT_CADASTRO;
    [FieldName('EMP_PESSOA')]
    property TipoPessoa: String read FPESSOA write setFPESSOA;
    [FieldName('EMP_VL_CRED')]
    property ValorCredito: Real read FVL_CRED write setFVL_CRED;
    [FieldName('EMP_CODVDOR')]
    property CodigoVendedor: Integer read FCODVDOR write setFCODVDOR;
    [FieldName('EMP_ML_DRT')]
    property UtilizarMalaDireta: String read FML_DRT write setFML_DRT;
    [FieldName('EMP_CODBCO')]
    property CodigoBancoUtilizadoPeloCliente: String read FCODBCO write setFCODBCO;
    [FieldName('EMP_AGENCIA')]
    property AgenciaUtilizadaPeloCliente: String read FAGENCIA write setFAGENCIA;
    [FieldName('EMP_CONTABCO')]
    property ContaCorrenteUtilizadaPeloCliente: String read FCONTABCO write setFCONTABCO;
    [FieldName('EMP_EMAIL')]
    property Email: String read FEMAIL write setFEMAIL;
    [FieldName('EMP_SITE')]
    property WebSite: String read FSITE write setFSITE;
    [FieldName('EMP_DT_FUNDA')]
    property DataFundacao: TDate read FDT_FUNDA write setFDT_FUNDA;
    [FieldName('EMP_CODTRANSP')]
    property CodigoTransportadora: Integer read FCODTRANSP write setFCODTRANSP;
    [FieldName('EMP_NUMBCO')]
    property NumeroBanco: String read FNUMBCO write setFNUMBCO;
    [FieldName('EMP_CODANT')]
    property CodigoAnterior: Integer read FCODANT write setFCODANT;
    [FieldName('EMP_DT_ULT_MOV')]
    property DataUltimoMovimento: TDate read FDT_ULT_MOV write setFDT_ULT_MOV;
    [FieldName('EMP_CONSUMIDOR')]
    property ConsumidorFinal: String read FCONSUMIDOR write setFCONSUMIDOR;
    [FieldName('EMP_MICRO')]
    property OptantePeloSimples: String read FMICRO write setFMICRO;
    [FieldName('EMP_RED_CONTRATO')]
    property ReducaoContrato: Real read FRED_CONTRATO write setFRED_CONTRATO;    
    [FieldName('EMP_MULTIPLICADOR')]
    property Multiplicador: Real read FMULTIPLICADOR write setFMULTIPLICADOR;
    [FieldName('EMP_CLASSE')]
    property Classificacao: String read FCLASSE write setFCLASSE;
    [FieldName('EMP_ATIVA')]
    property Ativa: String read FATIVA write setFATIVA;
    [FieldName('EMP_STATUS')]
    property Status: String read FSTATUS write setFSTATUS;    
    [FieldName('EMP_POLIT_DESC')]
    property PoliticaDesconto: String read FPOLIT_DESC write setFPOLIT_DESC;
    [FieldName('EMP_VDOEXCLUSIVO')]
    property VendedorExclusivo: String read FVDOEXCLUSIVO write setFVDOEXCLUSIVO;
    [FieldName('EMP_FABRICA')]
    property Fabrica: String read FFABRICA write setFFABRICA;
    [FieldName('EMP_NUMINSC_SUBS')]
    property InscricaoSubsTributario: String read FNUMINSC_SUBS write setFNUMINSC_SUBS;
    [FieldName('EMP_MOV_FIDELIDADE')]
    property MovimentoFidelidade: Integer read FMOV_FIDELIDADE write setFMOV_FIDELIDADE;    
    [FieldName('EMP_CODFPG')]
    property VendaEmCarteira: Integer read FCODFPG write setFCODFPG;
    [FieldName('EMP_TIP_FAT')]
    property TipoFaturamento: Integer read FTIP_FAT write setFTIP_FAT;
    [FieldName('EMP_RESPONSAVEL')]
    property ResponsavelCREA: String read FRESPONSAVEL write setFRESPONSAVEL;
    [FieldName('EMP_CREA')]
    property NumeroCREA: String read FCREA write setFCREA;
    [FieldName('EMP_RESP_TEC')]
    property TecnicoResponsavel: String read FRESP_TEC write setFRESP_TEC;
    [FieldName('EMP_FORMDATA')]
    property FormatoDataInspecaoExintor: String read FFORMDATA write setFFORMDATA;
    [FieldName('EMP_CONTATO_ADM')]
    property ContatoAdministrativo: String read FCONTATO_ADM write setFCONTATO_ADM;
    [FieldName('EMP_INSC_MUN')]
    property InscricaoMunicipal: String read FINSC_MUN write setFINSC_MUN;
    [FieldName('EMP_CRT')]
    property CodigoRegimeTributario: Integer read FCRT write setFCRT;
    [FieldName('EMP_SUB_TRIB')]
    property SubstitutoTributario: String read FSUB_TRIB write setFSUB_TRIB;
    [FieldName('EMP_LOJISTA')]
    property Lojista: String read FLOJISTA write setFLOJISTA;
    [FieldName('EMP_IGNORAR_ST')]
    property IgnorarCalculoST: String read FIGNORAR_ST write setFIGNORAR_ST;
    [FieldName('EMP_FORMDATA_E')]
    property FormatoDataEnsaioExintor: String read FFORMDATA_E write setFFORMDATA_E;
    [FieldName('EMP_FORMDATA_C')]
    property FormatoDataCargaExintor: String read FFORMDATA_C write setFFORMDATA_C;
    [FieldName('EMP_OBS_FISCAL')]
    property ObservacaoFiscal: String read FOBS_FISCAL write setFOBS_FISCAL;    
    [FieldName('TB_RAMO_ATIVIDADE_ID')]
    property CodigoRamoAtividade: Integer read FRAMO_ATIVIDADE_ID write setFRAMO_ATIVIDADE_ID;
    [FieldName('EMP_IND_IE_DEST')]
    property IndicadorInscricaoEstadual: String read FIND_IE_DEST write setFIND_IE_DEST;

    property NumeroNome : String read FNumeroNome write setfNumeroNome;
  End;

implementation

{ TEmpresa }

procedure TEmpresa.setFDT_FUNDA(Value: TDate);
begin
  FDT_FUNDA := Value;
end;

procedure TEmpresa.setFAGENCIA(Value: String);
begin
  FAGENCIA := Value;
end;

procedure TEmpresa.setFRAMO_ATIVIDADE_ID(Value: Integer);
begin
  FRAMO_ATIVIDADE_ID := Value;
end;

procedure TEmpresa.setFATIVA(Value: String);
begin
  FATIVA := Value;
end;

procedure TEmpresa.setFCLASSE(Value: String);
begin
  FCLASSE := Value;
end;

procedure TEmpresa.setFCNPJ(Value: String);
begin
  FCNPJ := Value;
end;

procedure TEmpresa.setFCODANT(Value: Integer);
begin
  FCODANT := Value;
end;

procedure TEmpresa.setFCODBCO(Value: String);
begin
  FCODBCO := Value;
end;

procedure TEmpresa.setFCODFPG(Value: Integer);
begin
  FCODFPG := Value;
end;

procedure TEmpresa.setFCODIGO(Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TEmpresa.setFCODTRANSP(Value: Integer);
begin
  FCODTRANSP := Value;
end;

procedure TEmpresa.setFCODVDOR(Value: Integer);
begin
  FCODVDOR := Value;
end;

procedure TEmpresa.setFCONSUMIDOR(Value: String);
begin
  FCONSUMIDOR := Value;
end;

procedure TEmpresa.setFCONTABCO(Value: String);
begin
  FCONTABCO := Value;
end;

procedure TEmpresa.setFCONTATO_ADM(Value: String);
begin
  FCONTATO_ADM := Value;
end;

procedure TEmpresa.setFCREA(Value: String);
begin
  FCREA := Value;
end;

procedure TEmpresa.setFCRT(Value: Integer);
begin
  FCRT := Value;
end;

procedure TEmpresa.setFDT_CADASTRO(Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TEmpresa.setFDT_ULT_MOV(Value: TDate);
begin
  FDT_ULT_MOV := Value;
end;

procedure TEmpresa.setFEMAIL(Value: String);
begin
  FEMAIL := Value;
end;

procedure TEmpresa.setFFABRICA(Value: String);
begin
  FFABRICA := Value;
end;

procedure TEmpresa.setFFANTASIA(Value: String);
begin
  FFANTASIA := Value;
end;

procedure TEmpresa.setFFORMDATA(Value: String);
begin
  FFORMDATA := Value;
end;

procedure TEmpresa.setFFORMDATA_C(Value: String);
begin
  FFORMDATA_C := Value;
end;

procedure TEmpresa.setFFORMDATA_E(Value: String);
begin
  FFORMDATA_E := Value;
end;

procedure TEmpresa.setFIGNORAR_ST(Value: String);
begin
  FIGNORAR_ST := Value;
end;

procedure TEmpresa.setFIND_IE_DEST(Value: String);
begin
  FIND_IE_DEST := Value;
end;

procedure TEmpresa.setFINSC_EST(Value: String);
begin
  FINSC_EST := Value;
end;

procedure TEmpresa.setFINSC_MUN(Value: String);
begin
  FINSC_MUN := Value;
end;

procedure TEmpresa.setFLOJISTA(Value: String);
begin
  FLOJISTA := Value;
end;

procedure TEmpresa.setFMICRO(Value: String);
begin
  FMICRO := Value;
end;

procedure TEmpresa.setFML_DRT(Value: String);
begin
  FML_DRT := Value;
end;

procedure TEmpresa.setFMOV_FIDELIDADE(Value: Integer);
begin
  FMOV_FIDELIDADE := Value;
end;

procedure TEmpresa.setFMULTIPLICADOR(Value: Real);
begin
  FMULTIPLICADOR := Value;
end;

procedure TEmpresa.setFNOME(Value: String);
begin
  FNOME := Value;
end;

procedure TEmpresa.setFNUMBCO(Value: String);
begin
  FNUMBCO := Value;
end;

procedure TEmpresa.setfNumeroNome(const Value: String);
begin
  FNumeroNome := Value;
end;

procedure TEmpresa.setFNUMINSC_SUBS(Value: String);
begin
  FNUMINSC_SUBS := Value;
end;

procedure TEmpresa.setFOBSERV(Value: String);
begin
  FOBSERV := Value;
end;

procedure TEmpresa.setFOBS_FISCAL(Value: String);
begin
  FOBS_FISCAL := Value;
end;

procedure TEmpresa.setFPESSOA(Value: String);
begin
  FPESSOA := Value;
end;

procedure TEmpresa.setFPOLIT_DESC(Value: String);
begin
  FPOLIT_DESC := Value;
end;


procedure TEmpresa.setFRED_CONTRATO(Value: Real);
begin
  FRED_CONTRATO := Value;
end;

procedure TEmpresa.setFRESPONSAVEL(Value: String);
begin
  FRESPONSAVEL := Value;
end;

procedure TEmpresa.setFRESP_TEC(Value: String);
begin
  FRESP_TEC := Value;
end;

procedure TEmpresa.setFSITE(Value: String);
begin
  FSITE := Value;
end;

procedure TEmpresa.setFSTATUS(Value: String);
begin
  FSTATUS := Value;
end;

procedure TEmpresa.setFSTCRED(Value: String);
begin
  FSTCRED := Value;
end;

procedure TEmpresa.setFSUB_TRIB(Value: String);
begin
  FSUB_TRIB := Value;
end;

procedure TEmpresa.setFTIPO(Value: Integer);
begin
  FTIPO := Value;
end;

procedure TEmpresa.setFTIP_FAT(Value: Integer);
begin
  FTIP_FAT := Value;
end;

procedure TEmpresa.setFVDOEXCLUSIVO(Value: String);
begin
  FVDOEXCLUSIVO := Value;
end;

procedure TEmpresa.setFVL_CRED(Value: Real);
begin
  FVL_CRED := Value;
end;

end.
