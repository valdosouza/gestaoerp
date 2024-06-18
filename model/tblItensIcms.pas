unit tblItensIcms;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_ICMS')]
  TItensIcms = Class(TGenericEntity)
  private
    FICM_VL_FRETE: Real;
    FICM_CODOBS: Integer;
    FICM_CODITF: Integer;
    FICM_VL_RET: Real;
    FICM_DESTAQUE: String;
    FICM_AQ_CALC_CRED: Real;
    FICM_VL_NR: Real;
    FICM_REPASSE: String;
    FICM_VL_BC_ST_RET: Real;
    FICM_MD_BC_NR: String;
    FICM_PARTILHA: String;
    FICM_AQ_ST: Real;
    FICM_AQ_RD_BC_ST: Real;
    FICM_VL_SEGURO: Real;
    FICM_MG_VA_ST: Real;
    FICM_CODIGO: Integer;
    FICM_VL_OUTRAS: Real;
    FICM_VL_CRED_APRO: Real;
    FICM_AQ_RD_NR: Real;
    FICM_CODNFL: Integer;
    FICM_VL_ST_RET: Real;
    FICM_CODNAT: Integer;
    FICM_VL_BC_ST: Real;
    FICM_AQ_RD_ST: Real;
    FICM_VL_BC_RET: Real;
    FICM_MD_BC_ST: String;
    FICM_AQ_NR: Real;
    FICM_AQ_RD_BC_NR: Real;
    FICM_VL_ST: Real;
    FICM_VL_BC_NR: Real;
    FICM_ORIGEM: String;
    FICM_CODTBI_NR: Integer;
    FICM_CODDSI: Integer;
    FICM_CODTBI_SN: Integer;
    procedure setFICM_AQ_CALC_CRED(const Value: Real);
    procedure setFICM_AQ_NR(const Value: Real);
    procedure setFICM_AQ_RD_BC_NR(const Value: Real);
    procedure setFICM_AQ_RD_BC_ST(const Value: Real);
    procedure setFICM_AQ_RD_NR(const Value: Real);
    procedure setFICM_AQ_RD_ST(const Value: Real);
    procedure setFICM_AQ_ST(const Value: Real);
    procedure setFICM_CODDSI(const Value: Integer);
    procedure setFICM_CODIGO(const Value: Integer);
    procedure setFICM_CODITF(const Value: Integer);
    procedure setFICM_CODNAT(const Value: Integer);
    procedure setFICM_CODNFL(const Value: Integer);
    procedure setFICM_CODOBS(const Value: Integer);
    procedure setFICM_CODTBI_NR(const Value: Integer);
    procedure setFICM_CODTBI_SN(const Value: Integer);
    procedure setFICM_DESTAQUE(const Value: String);
    procedure setFICM_MD_BC_NR(const Value: String);
    procedure setFICM_MD_BC_ST(const Value: String);
    procedure setFICM_MG_VA_ST(const Value: Real);
    procedure setFICM_ORIGEM(const Value: String);
    procedure setFICM_PARTILHA(const Value: String);
    procedure setFICM_REPASSE(const Value: String);
    procedure setFICM_VL_BC_NR(const Value: Real);
    procedure setFICM_VL_BC_RET(const Value: Real);
    procedure setFICM_VL_BC_ST(const Value: Real);
    procedure setFICM_VL_BC_ST_RET(const Value: Real);
    procedure setFICM_VL_CRED_APRO(const Value: Real);
    procedure setFICM_VL_FRETE(const Value: Real);
    procedure setFICM_VL_NR(const Value: Real);
    procedure setFICM_VL_OUTRAS(const Value: Real);
    procedure setFICM_VL_RET(const Value: Real);
    procedure setFICM_VL_SEGURO(const Value: Real);
    procedure setFICM_VL_ST(const Value: Real);
    procedure setFICM_VL_ST_RET(const Value: Real);

  public
    [KeyField('ICM_CODIGO')]
    [FieldName('ICM_CODIGO')]
    property codigo: Integer read FICM_CODIGO write setFICM_CODIGO;

    [FieldName('ICM_CODNFL')]
    property Nota: Integer read FICM_CODNFL write setFICM_CODNFL;

    [FieldName('ICM_CODITF')]
    property ItemNota :Integer read FICM_CODITF write setFICM_CODITF;

    [FieldName('ICM_CODTBI_NR')]
    property CST: Integer read FICM_CODTBI_NR write setFICM_CODTBI_NR;

    [FieldName('ICM_CODTBI_SN')]
    property CSOSN: Integer read FICM_CODTBI_SN write setFICM_CODTBI_SN;

    [FieldName('ICM_ORIGEM')]
    property Origem: String read FICM_ORIGEM write setFICM_ORIGEM;

    [FieldName('ICM_MD_BC_NR')]
    property Determinacao: String read FICM_MD_BC_NR write setFICM_MD_BC_NR;

    [FieldName('ICM_AQ_RD_BC_NR')]
    property AliqRedBase: Real read FICM_AQ_RD_BC_NR write setFICM_AQ_RD_BC_NR;

    [FieldName('ICM_VL_BC_NR')]
    property ValorBase: Real read FICM_VL_BC_NR write setFICM_VL_BC_NR;

    [FieldName('ICM_AQ_NR')]
    property Aliquota: Real read FICM_AQ_NR write setFICM_AQ_NR;

    [FieldName('ICM_AQ_RD_NR')]
    property AliquotaReduzida: Real read FICM_AQ_RD_NR write setFICM_AQ_RD_NR;

    [FieldName('ICM_VL_NR')]
    property Valor: Real read FICM_VL_NR write setFICM_VL_NR;

    [FieldName('ICM_MD_BC_ST')]
    property DeterminacaoBaseST: String read FICM_MD_BC_ST write setFICM_MD_BC_ST;

    [FieldName('ICM_AQ_RD_BC_ST')]
    property AliqRedBaseST : Real read FICM_AQ_RD_BC_ST write setFICM_AQ_RD_BC_ST;

    [FieldName('ICM_MG_VA_ST')]
    property MVA: Real read FICM_MG_VA_ST write setFICM_MG_VA_ST;

    [FieldName('ICM_VL_BC_ST')]
    property ValorBaseST: Real read FICM_VL_BC_ST write setFICM_VL_BC_ST;

    [FieldName('ICM_AQ_ST')]
    property AliquotaST: Real read FICM_AQ_ST write setFICM_AQ_ST;

    [FieldName('ICM_AQ_RD_ST')]
    property AliqRedST: Real read FICM_AQ_RD_ST write setFICM_AQ_RD_ST;

    [FieldName('ICM_VL_ST')]
    property ValorST: Real read FICM_VL_ST write setFICM_VL_ST;

    [FieldName('ICM_CODDSI')]
    property Desoneracao: Integer read FICM_CODDSI write setFICM_CODDSI;

    [FieldName('ICM_VL_BC_ST_RET')]
    property VAlorBaseSTRetido: Real read FICM_VL_BC_ST_RET write setFICM_VL_BC_ST_RET;

    [FieldName('ICM_VL_ST_RET')]
    property ValorSTRetido: Real read FICM_VL_ST_RET write setFICM_VL_ST_RET;

    [FieldName('ICM_PARTILHA')]
    property Partilha: String read FICM_PARTILHA write setFICM_PARTILHA;

    [FieldName('ICM_REPASSE')]
    property Repasse: String read FICM_REPASSE write setFICM_REPASSE;

    [FieldName('ICM_VL_BC_RET')]
    property BaseICMSRetido: Real read FICM_VL_BC_RET write setFICM_VL_BC_RET;

    [FieldName('ICM_VL_RET')]
    property ValorICMSRetido: Real read FICM_VL_RET write setFICM_VL_RET;

    [FieldName('ICM_AQ_CALC_CRED')]
    property AliqCalcCred: Real read FICM_AQ_CALC_CRED write setFICM_AQ_CALC_CRED;

    [FieldName('ICM_VL_CRED_APRO')]
    property CreditoAprox: Real read FICM_VL_CRED_APRO write setFICM_VL_CRED_APRO ;

    [FieldName('ICM_VL_FRETE')]
    property ValorFrete: Real read FICM_VL_FRETE write setFICM_VL_FRETE;

    [FieldName('ICM_VL_SEGURO')]
    property Seguro: Real read FICM_VL_SEGURO write setFICM_VL_SEGURO;

    [FieldName('ICM_VL_OUTRAS')]
    property OutrasDespesas: Real read FICM_VL_OUTRAS write setFICM_VL_OUTRAS;

    [FieldName('ICM_CODNAT')]
    property CFOP: Integer read FICM_CODNAT write setFICM_CODNAT;

    [FieldName('ICM_DESTAQUE')]
    property Destacar: String read FICM_DESTAQUE write setFICM_DESTAQUE;

    [FieldName('ICM_CODOBS')]
    property Observacao: Integer read FICM_CODOBS write setFICM_CODOBS;


	End;

implementation

{ TItensIcms }

procedure TItensIcms.setFICM_AQ_CALC_CRED(const Value: Real);
begin
  FICM_AQ_CALC_CRED := Value;
end;

procedure TItensIcms.setFICM_AQ_NR(const Value: Real);
begin
  FICM_AQ_NR := Value;
end;

procedure TItensIcms.setFICM_AQ_RD_BC_NR(const Value: Real);
begin
  FICM_AQ_RD_BC_NR := Value;
end;

procedure TItensIcms.setFICM_AQ_RD_BC_ST(const Value: Real);
begin
  FICM_AQ_RD_BC_ST := Value;
end;

procedure TItensIcms.setFICM_AQ_RD_NR(const Value: Real);
begin
  FICM_AQ_RD_NR := Value;
end;

procedure TItensIcms.setFICM_AQ_RD_ST(const Value: Real);
begin
  FICM_AQ_RD_ST := Value;
end;

procedure TItensIcms.setFICM_AQ_ST(const Value: Real);
begin
  FICM_AQ_ST := Value;
end;

procedure TItensIcms.setFICM_CODDSI(const Value: Integer);
begin
  FICM_CODDSI := Value;
end;

procedure TItensIcms.setFICM_CODIGO(const Value: Integer);
begin
  FICM_CODIGO := Value;
end;

procedure TItensIcms.setFICM_CODITF(const Value: Integer);
begin
  FICM_CODITF := Value;
end;

procedure TItensIcms.setFICM_CODNAT(const Value: Integer);
begin
  FICM_CODNAT := Value;
end;

procedure TItensIcms.setFICM_CODNFL(const Value: Integer);
begin
  FICM_CODNFL := Value;
end;

procedure TItensIcms.setFICM_CODOBS(const Value: Integer);
begin
  FICM_CODOBS := Value;
end;

procedure TItensIcms.setFICM_CODTBI_NR(const Value: Integer);
begin
  FICM_CODTBI_NR := Value;
end;

procedure TItensIcms.setFICM_CODTBI_SN(const Value: Integer);
begin
  FICM_CODTBI_SN := Value;
end;

procedure TItensIcms.setFICM_DESTAQUE(const Value: String);
begin
  FICM_DESTAQUE := Value;
end;

procedure TItensIcms.setFICM_MD_BC_NR(const Value: String);
begin
  FICM_MD_BC_NR := Value;
end;

procedure TItensIcms.setFICM_MD_BC_ST(const Value: String);
begin
  FICM_MD_BC_ST := Value;
end;

procedure TItensIcms.setFICM_MG_VA_ST(const Value: Real);
begin
  FICM_MG_VA_ST := Value;
end;

procedure TItensIcms.setFICM_ORIGEM(const Value: String);
begin
  FICM_ORIGEM := Value;
end;

procedure TItensIcms.setFICM_PARTILHA(const Value: String);
begin
  FICM_PARTILHA := Value;
end;

procedure TItensIcms.setFICM_REPASSE(const Value: String);
begin
  FICM_REPASSE := Value;
end;

procedure TItensIcms.setFICM_VL_BC_NR(const Value: Real);
begin
  FICM_VL_BC_NR := Value;
end;

procedure TItensIcms.setFICM_VL_BC_RET(const Value: Real);
begin
  FICM_VL_BC_RET := Value;
end;

procedure TItensIcms.setFICM_VL_BC_ST(const Value: Real);
begin
  FICM_VL_BC_ST := Value;
end;

procedure TItensIcms.setFICM_VL_BC_ST_RET(const Value: Real);
begin
  FICM_VL_BC_ST_RET := Value;
end;

procedure TItensIcms.setFICM_VL_CRED_APRO(const Value: Real);
begin
  FICM_VL_CRED_APRO := Value;
end;

procedure TItensIcms.setFICM_VL_FRETE(const Value: Real);
begin
  FICM_VL_FRETE := Value;
end;

procedure TItensIcms.setFICM_VL_NR(const Value: Real);
begin
  FICM_VL_NR := Value;
end;

procedure TItensIcms.setFICM_VL_OUTRAS(const Value: Real);
begin
  FICM_VL_OUTRAS := Value;
end;

procedure TItensIcms.setFICM_VL_RET(const Value: Real);
begin
  FICM_VL_RET := Value;
end;

procedure TItensIcms.setFICM_VL_SEGURO(const Value: Real);
begin
  FICM_VL_SEGURO := Value;
end;

procedure TItensIcms.setFICM_VL_ST(const Value: Real);
begin
  FICM_VL_ST := Value;
end;

procedure TItensIcms.setFICM_VL_ST_RET(const Value: Real);
begin
  FICM_VL_ST_RET := Value;
end;

end.

