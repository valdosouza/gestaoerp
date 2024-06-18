unit tblRegraTributacao;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_TRIBUTACAO')]
  TRegraTributacao = Class(TGenericEntity)

  private
    FTRB_CODPRO: Integer;
    FTRB_AQ_AFRMM: REal;
    FTRB_CODTBI_PIS: Integer;
    FTRB_AQ_SISCOMEX: Real;
    FTRB_CODTBI_CFS: Integer;
    FTRB_RD_BS_ICMS: Real;
    FTRB_MICRO: String;
    FTRB_AQ_IRPJ: REal;
    FTRB_CODOBS: Integer;
    FTRB_ST_ICMS: String;
    FTRB_CODMDB_ICMS_NR: Integer;
    FTRB_DESTAQUE: String;
    FTRB_CODIGO: Integer;
    FTRB_SUB_TRI: String;
    FTRB_AQ_II: REal;
    FTRB_CODNAT: Integer;
    FTRB_CODIGONCM: String;
    FTRB_AQ_IPI: REal;
    FTRB_CODTBI_ICMS_SN: Integer;
    FTRB_DIFERIDO: String;
    FTRB_PRODUTO: Integer;
    FTRB_CONSUMIDOR: String;
    FTRB_AQ_CSLL: REal;
    FTRB_CODMHA: Integer;
    FTRB_SENTIDO: String;
    FTRB_RD_AQ_ICMS: REal;
    FTRB_CODTBI_IPI: Integer;
    FTRB_CODTBI_ICMS_NR: Integer;
    FTRB_AQ_ICMS: Real;
    FTRB_CODMDB_ICMS_ST: Integer;
    FTRB_AQ_ISS: REal;
    FTRB_ORIGEM: String;
    FTRB_ESTADO: Integer;
    FTRB_AQ_PIS: REal;
    FTRB_RD_BS_ICMS_ST: String;
    FTRB_AQ_COFINS: REal;
    FTRB_CODDSI_ICMS: Integer;
    procedure setFTRB_AQ_AFRMM(const Value: REal);
    procedure setFTRB_AQ_COFINS(const Value: REal);
    procedure setFTRB_AQ_CSLL(const Value: REal);
    procedure setFTRB_AQ_ICMS(const Value: Real);
    procedure setFTRB_AQ_II(const Value: REal);
    procedure setFTRB_AQ_IPI(const Value: REal);
    procedure setFTRB_AQ_IRPJ(const Value: REal);
    procedure setFTRB_AQ_ISS(const Value: REal);
    procedure setFTRB_AQ_PIS(const Value: REal);
    procedure setFTRB_AQ_SISCOMEX(const Value: Real);
    procedure setFTRB_CODDSI_ICMS(const Value: Integer);
    procedure setFTRB_CODIGO(const Value: Integer);
    procedure setFTRB_CODIGONCM(const Value: String);
    procedure setFTRB_CODMDB_ICMS_NR(const Value: Integer);
    procedure setFTRB_CODMDB_ICMS_ST(const Value: Integer);
    procedure setFTRB_CODMHA(const Value: Integer);
    procedure setFTRB_CODNAT(const Value: Integer);
    procedure setFTRB_CODOBS(const Value: Integer);
    procedure setFTRB_CODPRO(const Value: Integer);
    procedure setFTRB_CODTBI_CFS(const Value: Integer);
    procedure setFTRB_CODTBI_ICMS_NR(const Value: Integer);
    procedure setFTRB_CODTBI_ICMS_SN(const Value: Integer);
    procedure setFTRB_CODTBI_IPI(const Value: Integer);
    procedure setFTRB_CODTBI_PIS(const Value: Integer);
    procedure setFTRB_CONSUMIDOR(const Value: String);
    procedure setFTRB_DESTAQUE(const Value: String);
    procedure setFTRB_DIFERIDO(const Value: String);
    procedure setFTRB_ESTADO(const Value: Integer);
    procedure setFTRB_MICRO(const Value: String);
    procedure setFTRB_ORIGEM(const Value: String);
    procedure setFTRB_PRODUTO(const Value: Integer);
    procedure setFTRB_RD_AQ_ICMS(const Value: REal);
    procedure setFTRB_RD_BS_ICMS(const Value: Real);
    procedure setFTRB_RD_BS_ICMS_ST(const Value: String);
    procedure setFTRB_SENTIDO(const Value: String);
    procedure setFTRB_ST_ICMS(const Value: String);
    procedure setFTRB_SUB_TRI(const Value: String);



   public
    [KeyField('TRB_CODIGO')]
    [FieldName('TRB_CODIGO')]
    property cODIGO: Integer read FTRB_CODIGO  write setFTRB_CODIGO;

    [KeyField('TRB_CODMHA')]
    [FieldName('TRB_CODMHA')]
    property Estabelecimento: Integer read FTRB_CODMHA  write setFTRB_CODMHA;


    [FieldName('TRB_CODPRO')]
    property Produto: Integer read FTRB_CODPRO  write setFTRB_CODPRO;

    [FieldName('TRB_ORIGEM')]
    property Origem: String read FTRB_ORIGEM  write setFTRB_ORIGEM;

    [FieldName('TRB_CODTBI_ICMS_NR')]
    property RegimeNormal: Integer read FTRB_CODTBI_ICMS_NR  write setFTRB_CODTBI_ICMS_NR;

    [FieldName('TRB_CODTBI_ICMS_SN')]
    property SimplesNacional: Integer read FTRB_CODTBI_ICMS_SN  write setFTRB_CODTBI_ICMS_SN;

    [FieldName('TRB_CODMDB_ICMS_NR')]
    property DeterminacaoBaseICMS: Integer read FTRB_CODMDB_ICMS_NR  write setFTRB_CODMDB_ICMS_NR;

    [FieldName('TRB_CODMDB_ICMS_ST')]
    property DeterminacaoBaseICMSST: Integer read FTRB_CODMDB_ICMS_ST  write setFTRB_CODMDB_ICMS_ST;

    [FieldName('TRB_CODDSI_ICMS')]
    property Desoneracao: Integer read FTRB_CODDSI_ICMS  write setFTRB_CODDSI_ICMS;

    [FieldName('TRB_AQ_ICMS')]
    property AliquotaICMS: Real read FTRB_AQ_ICMS  write setFTRB_AQ_ICMS;

    [FieldName('TRB_RD_AQ_ICMS')]
    property ReducaoAliqICMS: REal read FTRB_RD_AQ_ICMS  write setFTRB_RD_AQ_ICMS;

    [FieldName('TRB_RD_BS_ICMS')]
    property REducaoBaseICMS: Real read FTRB_RD_BS_ICMS  write setFTRB_RD_BS_ICMS;

    [FieldName('TRB_CODTBI_IPI')]
    property CSTIPI: Integer read FTRB_CODTBI_IPI  write setFTRB_CODTBI_IPI;

    [FieldName('TRB_AQ_IPI')]
    property AliquotaIPI: REal read FTRB_AQ_IPI  write setFTRB_AQ_IPI;

    [FieldName('TRB_CODTBI_PIS')]
    property CST_PIS: Integer read FTRB_CODTBI_PIS  write setFTRB_CODTBI_PIS;

    [FieldName('TRB_AQ_PIS')]
    property AliqPIS: REal read FTRB_AQ_PIS  write setFTRB_AQ_PIS;

    [FieldName('TRB_CODTBI_CFS')]
    property CST_Cofins: Integer read FTRB_CODTBI_CFS  write setFTRB_CODTBI_CFS;

    [FieldName('TRB_AQ_COFINS')]
    property AliqCofins: REal read FTRB_AQ_COFINS  write setFTRB_AQ_COFINS;

    [FieldName('TRB_AQ_IRPJ')]
    property AliqIRRF: REal read FTRB_AQ_IRPJ  write setFTRB_AQ_IRPJ;

    [FieldName('TRB_AQ_CSLL')]
    property ContribuicaoSocial: REal read FTRB_AQ_CSLL  write setFTRB_AQ_CSLL;

    [FieldName('TRB_AQ_II')]
    property AliqII: REal read FTRB_AQ_II  write setFTRB_AQ_II;

    [FieldName('TRB_ST_ICMS')]
    property ProdutoComST: String read FTRB_ST_ICMS  write setFTRB_ST_ICMS;

    [FieldName('TRB_CONSUMIDOR')]
    property Consumidor: String read FTRB_CONSUMIDOR  write setFTRB_CONSUMIDOR;

    [FieldName('TRB_MICRO')]
    property OptantePeloSimples: String read FTRB_MICRO  write setFTRB_MICRO;

    [FieldName('TRB_DIFERIDO')]
    property Diferido: String read FTRB_DIFERIDO  write setFTRB_DIFERIDO;

    [FieldName('TRB_DESTAQUE')]
    property DestacaImposto: String read FTRB_DESTAQUE  write setFTRB_DESTAQUE;

    [FieldName('TRB_CODOBS')]
    property Observaocao: Integer read FTRB_CODOBS  write setFTRB_CODOBS;

    [FieldName('TRB_CODNAT')]
    property CFOP: Integer read FTRB_CODNAT  write setFTRB_CODNAT;

    [FieldName('TRB_ESTADO')]
    property Estado: Integer read FTRB_ESTADO  write setFTRB_ESTADO;

    [FieldName('TRB_SUB_TRI')]
    property SubstitutoTRibutario: String read FTRB_SUB_TRI  write setFTRB_SUB_TRI;

    [FieldName('TRB_PRODUTO')]
    property Finalidade: Integer read FTRB_PRODUTO  write setFTRB_PRODUTO;

    [FieldName('TRB_AQ_ISS')]
    property AliqISS: REal read FTRB_AQ_ISS  write setFTRB_AQ_ISS;

    [FieldName('TRB_AQ_AFRMM')]
    property AliqAFRMM: REal read FTRB_AQ_AFRMM  write setFTRB_AQ_AFRMM;

    [FieldName('TRB_AQ_SISCOMEX')]
    property TaxaSiscomex: Real read FTRB_AQ_SISCOMEX  write setFTRB_AQ_SISCOMEX;

    [FieldName('TRB_CODIGONCM')]
    property NCM: String read FTRB_CODIGONCM  write setFTRB_CODIGONCM;

    [FieldName('TRB_RD_BS_ICMS_ST')]
    property PropagaREducaoBaseST: String read FTRB_RD_BS_ICMS_ST  write setFTRB_RD_BS_ICMS_ST;

    [FieldName('TRB_SENTIDO')]
    property Sentido: String read FTRB_SENTIDO  write setFTRB_SENTIDO;

  End;

implementation

{ TRegraTributacao }

procedure TRegraTributacao.setFTRB_AQ_AFRMM(const Value: REal);
begin
  FTRB_AQ_AFRMM := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_COFINS(const Value: REal);
begin
  FTRB_AQ_COFINS := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_CSLL(const Value: REal);
begin
  FTRB_AQ_CSLL := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_ICMS(const Value: Real);
begin
  FTRB_AQ_ICMS := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_II(const Value: REal);
begin
  FTRB_AQ_II := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_IPI(const Value: REal);
begin
  FTRB_AQ_IPI := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_IRPJ(const Value: REal);
begin
  FTRB_AQ_IRPJ := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_ISS(const Value: REal);
begin
  FTRB_AQ_ISS := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_PIS(const Value: REal);
begin
  FTRB_AQ_PIS := Value;
end;

procedure TRegraTributacao.setFTRB_AQ_SISCOMEX(const Value: Real);
begin
  FTRB_AQ_SISCOMEX := Value;
end;

procedure TRegraTributacao.setFTRB_CODDSI_ICMS(const Value: Integer);
begin
  FTRB_CODDSI_ICMS := Value;
end;

procedure TRegraTributacao.setFTRB_CODIGO(const Value: Integer);
begin
  FTRB_CODIGO := Value;
end;

procedure TRegraTributacao.setFTRB_CODIGONCM(const Value: String);
begin
  FTRB_CODIGONCM := Value;
end;

procedure TRegraTributacao.setFTRB_CODMDB_ICMS_NR(const Value: Integer);
begin
  FTRB_CODMDB_ICMS_NR := Value;
end;

procedure TRegraTributacao.setFTRB_CODMDB_ICMS_ST(const Value: Integer);
begin
  FTRB_CODMDB_ICMS_ST := Value;
end;

procedure TRegraTributacao.setFTRB_CODMHA(const Value: Integer);
begin
  FTRB_CODMHA := Value;
end;

procedure TRegraTributacao.setFTRB_CODNAT(const Value: Integer);
begin
  FTRB_CODNAT := Value;
end;

procedure TRegraTributacao.setFTRB_CODOBS(const Value: Integer);
begin
  FTRB_CODOBS := Value;
end;

procedure TRegraTributacao.setFTRB_CODPRO(const Value: Integer);
begin
  FTRB_CODPRO := Value;
end;

procedure TRegraTributacao.setFTRB_CODTBI_CFS(const Value: Integer);
begin
  FTRB_CODTBI_CFS := Value;
end;

procedure TRegraTributacao.setFTRB_CODTBI_ICMS_NR(const Value: Integer);
begin
  FTRB_CODTBI_ICMS_NR := Value;
end;

procedure TRegraTributacao.setFTRB_CODTBI_ICMS_SN(const Value: Integer);
begin
  FTRB_CODTBI_ICMS_SN := Value;
end;

procedure TRegraTributacao.setFTRB_CODTBI_IPI(const Value: Integer);
begin
  FTRB_CODTBI_IPI := Value;
end;

procedure TRegraTributacao.setFTRB_CODTBI_PIS(const Value: Integer);
begin
  FTRB_CODTBI_PIS := Value;
end;

procedure TRegraTributacao.setFTRB_CONSUMIDOR(const Value: String);
begin
  FTRB_CONSUMIDOR := Value;
end;

procedure TRegraTributacao.setFTRB_DESTAQUE(const Value: String);
begin
  FTRB_DESTAQUE := Value;
end;

procedure TRegraTributacao.setFTRB_DIFERIDO(const Value: String);
begin
  FTRB_DIFERIDO := Value;
end;

procedure TRegraTributacao.setFTRB_ESTADO(const Value: Integer);
begin
  FTRB_ESTADO := Value;
end;

procedure TRegraTributacao.setFTRB_MICRO(const Value: String);
begin
  FTRB_MICRO := Value;
end;

procedure TRegraTributacao.setFTRB_ORIGEM(const Value: String);
begin
  FTRB_ORIGEM := Value;
end;

procedure TRegraTributacao.setFTRB_PRODUTO(const Value: Integer);
begin
  FTRB_PRODUTO := Value;
end;

procedure TRegraTributacao.setFTRB_RD_AQ_ICMS(const Value: REal);
begin
  FTRB_RD_AQ_ICMS := Value;
end;

procedure TRegraTributacao.setFTRB_RD_BS_ICMS(const Value: Real);
begin
  FTRB_RD_BS_ICMS := Value;
end;

procedure TRegraTributacao.setFTRB_RD_BS_ICMS_ST(const Value: String);
begin
  FTRB_RD_BS_ICMS_ST := Value;
end;

procedure TRegraTributacao.setFTRB_SENTIDO(const Value: String);
begin
  FTRB_SENTIDO := Value;
end;

procedure TRegraTributacao.setFTRB_ST_ICMS(const Value: String);
begin
  FTRB_ST_ICMS := Value;
end;

procedure TRegraTributacao.setFTRB_SUB_TRI(const Value: String);
begin
  FTRB_SUB_TRI := Value;
end;

end.
