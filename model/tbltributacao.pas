unit tbltributacao;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_TRIBUTACAO')]
  TTributacao = Class(TGenericEntity)
  private
    FTRB_CODPRO: Integer;
    FTRB_RD_BS_ICMS_ST: String;
    FTRB_AQ_AFRMM: Real;
    FTRB_CODOBS: Integer;
    FTRB_DESTAQUE: String;
    FTRB_RD_AQ_ICMS: Real;
    FTRB_ST_ICMS: String;
    FTRB_AQ_IPI: Real;
    FTRB_RD_BS_ICMS: Real;
    FTRB_CODIGO: Integer;
    FTRB_AQ_SISCOMEX: Real;
    FTRB_SUB_TRI: String;
    FTRB_AQ_II: Real;
    FTRB_CODNAT: Integer;
    FTRB_CODTBI_PIS: Integer;
    FTRB_CODIGONCM: String;
    FTRB_CODTBI_CFS: Integer;
    FTRB_CODMDB_ICMS_ST: Integer;
    FTRB_DIFERIDO: String;
    FTRB_AQ_ICMS: Real;
    FTRB_CODTBI_ICMS_NR: Integer;
    FTRB_CODTBI_ICMS_SN: Integer;
    FTRB_PRODUTO: String;
    FTRB_CONSUMIDOR: String;
    FTRB_AQ_CSLL: Real;
    FTRB_CODMDB_ICMS_NR: Integer;
    FTRB_CODMHA: Integer;
    FTRB_SENTIDO: String;
    FTRB_CODTBI_IPI: Integer;
    FTRB_AQ_IRPJ: REal;
    FTRB_AQ_ISS: REal;
    FTRB_ORIGEM: String;
    FTRB_ESTADO: Integer;
    FTRB_AQ_PIS: Real;
    FTRB_MICRO: String;
    FTRB_AQ_COFINS: Real;
    FTRB_CODDSI_ICMS: Integer;
    procedure setFTRB_AQ_AFRMM(const Value: Real);
    procedure setFTRB_AQ_COFINS(const Value: Real);
    procedure setFTRB_AQ_CSLL(const Value: Real);
    procedure setFTRB_AQ_ICMS(const Value: Real);
    procedure setFTRB_AQ_II(const Value: Real);
    procedure setFTRB_AQ_IPI(const Value: Real);
    procedure setFTRB_AQ_IRPJ(const Value: REal);
    procedure setFTRB_AQ_ISS(const Value: REal);
    procedure setFTRB_AQ_PIS(const Value: Real);
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
    procedure setFTRB_PRODUTO(const Value: String);
    procedure setFTRB_RD_AQ_ICMS(const Value: Real);
    procedure setFTRB_RD_BS_ICMS(const Value: Real);
    procedure setFTRB_RD_BS_ICMS_ST(const Value: String);
    procedure setFTRB_SENTIDO(const Value: String);
    procedure setFTRB_ST_ICMS(const Value: String);
    procedure setFTRB_SUB_TRI(const Value: String);

  public
    [KeyField('TRB_CODIGO')]
    [FieldName('TRB_CODIGO')]
    property Codigo: Integer  read FTRB_CODIGO write setFTRB_CODIGO;

    [FieldName('TRB_CODPRO')]
    property Produto: Integer  read FTRB_CODPRO write setFTRB_CODPRO;

    [FieldName('TRB_ORIGEM')]
    property Origem: String  read FTRB_ORIGEM write setFTRB_ORIGEM;

    [FieldName('TRB_CODTBI_ICMS_NR')]
    property TribICMS_NR: Integer  read FTRB_CODTBI_ICMS_NR write setFTRB_CODTBI_ICMS_NR;

    [FieldName('TRB_CODTBI_ICMS_SN')]
    property TribICMS_SN: Integer read FTRB_CODTBI_ICMS_SN write setFTRB_CODTBI_ICMS_SN;

    [FieldName('TRB_CODMDB_ICMS_NR')]
    property DeterBC_ICMS_NR: Integer read FTRB_CODMDB_ICMS_NR write setFTRB_CODMDB_ICMS_NR;

    [FieldName('TRB_CODMDB_ICMS_ST')]
    property DeterBC_ICMS_ST:Integer  read FTRB_CODMDB_ICMS_ST write setFTRB_CODMDB_ICMS_ST;

    [FieldName('TRB_CODDSI_ICMS')]
    property Desoneracao: Integer  read FTRB_CODDSI_ICMS write setFTRB_CODDSI_ICMS;

    [FieldName('TRB_AQ_ICMS')]
    property AliqICMS: Real  read FTRB_AQ_ICMS write setFTRB_AQ_ICMS;

    [FieldName('TRB_RD_AQ_ICMS')]
    property RedAliqICMS:Real  read FTRB_RD_AQ_ICMS write setFTRB_RD_AQ_ICMS;

    [FieldName('TRB_RD_BS_ICMS')]
    property RedBCICMS:Real  read FTRB_RD_BS_ICMS write setFTRB_RD_BS_ICMS;

    [FieldName('TRB_CODTBI_IPI')]
    property TribIPI: Integer  read FTRB_CODTBI_IPI write setFTRB_CODTBI_IPI;

    [FieldName('TRB_AQ_IPI')]
    property AliqIPI: Real  read FTRB_AQ_IPI write setFTRB_AQ_IPI;

    [FieldName('TRB_CODTBI_PIS')]
    property TribPIS: Integer  read FTRB_CODTBI_PIS write setFTRB_CODTBI_PIS;

    [FieldName('TRB_AQ_PIS')]
    property AliqPIS: Real read FTRB_AQ_PIS write setFTRB_AQ_PIS;

    [FieldName('TRB_CODTBI_CFS')]
    property TribCofins: Integer  read FTRB_CODTBI_CFS write setFTRB_CODTBI_CFS;

    [FieldName('TRB_AQ_COFINS')]
    property AliqCofins: Real  read FTRB_AQ_COFINS write setFTRB_AQ_COFINS;

    [FieldName('TRB_AQ_IRPJ')]
    property AliqIRPJ: REal  read FTRB_AQ_IRPJ write setFTRB_AQ_IRPJ;

    [FieldName('TRB_AQ_CSLL')]
    property AliqCSLL: Real  read FTRB_AQ_CSLL write setFTRB_AQ_CSLL;

    [FieldName('TRB_AQ_II')]
    property AliqII: Real  read FTRB_AQ_II write setFTRB_AQ_II;

    [FieldName('TRB_ST_ICMS')]
    property TemST: String  read FTRB_ST_ICMS write setFTRB_ST_ICMS;

    [FieldName('TRB_CONSUMIDOR')]
    property Consumidor:String  read FTRB_CONSUMIDOR write setFTRB_CONSUMIDOR;

    [FieldName('TRB_MICRO')]
    property MicroEmpresa:String  read FTRB_MICRO write setFTRB_MICRO;

    [FieldName('TRB_DIFERIDO')]
    property Diferido:String  read FTRB_DIFERIDO write setFTRB_DIFERIDO;

    [FieldName('TRB_DESTAQUE')]
    property Destacar:String  read FTRB_DESTAQUE write setFTRB_DESTAQUE;

    [FieldName('TRB_CODOBS')]
    property Observacao: Integer  read FTRB_CODOBS write setFTRB_CODOBS;

    [FieldName('TRB_CODNAT')]
    property CFOP: Integer read FTRB_CODNAT write setFTRB_CODNAT;

    [FieldName('TRB_ESTADO')]
    property Estado: Integer read FTRB_ESTADO write setFTRB_ESTADO;

    [FieldName('TRB_CODMHA')]
    property Estabelecimento: Integer  read FTRB_CODMHA write setFTRB_CODMHA;

    [FieldName('TRB_SUB_TRI')]
    property SubstitutoTributario:String  read FTRB_SUB_TRI write setFTRB_SUB_TRI;

    [FieldName('TRB_PRODUTO')]
    property TipoTransacaoProduto: String read FTRB_PRODUTO write setFTRB_PRODUTO;

    [FieldName('TRB_AQ_ISS')]
    property AliqISS: REal  read FTRB_AQ_ISS write setFTRB_AQ_ISS;

    [FieldName('TRB_AQ_AFRMM')]
    property AliqAFRMM: Real  read FTRB_AQ_AFRMM write setFTRB_AQ_AFRMM;

    [FieldName('TRB_AQ_SISCOMEX')]
    property AliqSisComex: Real  read FTRB_AQ_SISCOMEX write setFTRB_AQ_SISCOMEX;

    [FieldName('TRB_CODIGONCM')]
    property NCM:String  read FTRB_CODIGONCM write setFTRB_CODIGONCM;

    [FieldName('TRB_RD_BS_ICMS_ST')]
    property PropRedBCST: String  read FTRB_RD_BS_ICMS_ST write setFTRB_RD_BS_ICMS_ST;

    [FieldName('TRB_SENTIDO')]
    property Sentido: String  read FTRB_SENTIDO write setFTRB_SENTIDO;

  End;

implementation


{ TTributacao }

procedure TTributacao.setFTRB_AQ_AFRMM(const Value: Real);
begin
  FTRB_AQ_AFRMM := Value;
end;

procedure TTributacao.setFTRB_AQ_COFINS(const Value: Real);
begin
  FTRB_AQ_COFINS := Value;
end;

procedure TTributacao.setFTRB_AQ_CSLL(const Value: Real);
begin
  FTRB_AQ_CSLL := Value;
end;

procedure TTributacao.setFTRB_AQ_ICMS(const Value: Real);
begin
  FTRB_AQ_ICMS := Value;
end;

procedure TTributacao.setFTRB_AQ_II(const Value: Real);
begin
  FTRB_AQ_II := Value;
end;

procedure TTributacao.setFTRB_AQ_IPI(const Value: Real);
begin
  FTRB_AQ_IPI := Value;
end;

procedure TTributacao.setFTRB_AQ_IRPJ(const Value: REal);
begin
  FTRB_AQ_IRPJ := Value;
end;

procedure TTributacao.setFTRB_AQ_ISS(const Value: REal);
begin
  FTRB_AQ_ISS := Value;
end;

procedure TTributacao.setFTRB_AQ_PIS(const Value: Real);
begin
  FTRB_AQ_PIS := Value;
end;

procedure TTributacao.setFTRB_AQ_SISCOMEX(const Value: Real);
begin
  FTRB_AQ_SISCOMEX := Value;
end;

procedure TTributacao.setFTRB_CODDSI_ICMS(const Value: Integer);
begin
  FTRB_CODDSI_ICMS := Value;
end;

procedure TTributacao.setFTRB_CODIGO(const Value: Integer);
begin
  FTRB_CODIGO := Value;
end;

procedure TTributacao.setFTRB_CODIGONCM(const Value: String);
begin
  FTRB_CODIGONCM := Value;
end;

procedure TTributacao.setFTRB_CODMDB_ICMS_NR(const Value: Integer);
begin
  FTRB_CODMDB_ICMS_NR := Value;
end;

procedure TTributacao.setFTRB_CODMDB_ICMS_ST(const Value: Integer);
begin
  FTRB_CODMDB_ICMS_ST := Value;
end;

procedure TTributacao.setFTRB_CODMHA(const Value: Integer);
begin
  FTRB_CODMHA := Value;
end;

procedure TTributacao.setFTRB_CODNAT(const Value: Integer);
begin
  FTRB_CODNAT := Value;
end;

procedure TTributacao.setFTRB_CODOBS(const Value: Integer);
begin
  FTRB_CODOBS := Value;
end;

procedure TTributacao.setFTRB_CODPRO(const Value: Integer);
begin
  FTRB_CODPRO := Value;
end;

procedure TTributacao.setFTRB_CODTBI_CFS(const Value: Integer);
begin
  FTRB_CODTBI_CFS := Value;
end;

procedure TTributacao.setFTRB_CODTBI_ICMS_NR(const Value: Integer);
begin
  FTRB_CODTBI_ICMS_NR := Value;
end;

procedure TTributacao.setFTRB_CODTBI_ICMS_SN(const Value: Integer);
begin
  FTRB_CODTBI_ICMS_SN := Value;
end;

procedure TTributacao.setFTRB_CODTBI_IPI(const Value: Integer);
begin
  FTRB_CODTBI_IPI := Value;
end;

procedure TTributacao.setFTRB_CODTBI_PIS(const Value: Integer);
begin
  FTRB_CODTBI_PIS := Value;
end;

procedure TTributacao.setFTRB_CONSUMIDOR(const Value: String);
begin
  FTRB_CONSUMIDOR := Value;
end;

procedure TTributacao.setFTRB_DESTAQUE(const Value: String);
begin
  FTRB_DESTAQUE := Value;
end;

procedure TTributacao.setFTRB_DIFERIDO(const Value: String);
begin
  FTRB_DIFERIDO := Value;
end;

procedure TTributacao.setFTRB_ESTADO(const Value: Integer);
begin
  FTRB_ESTADO := Value;
end;

procedure TTributacao.setFTRB_MICRO(const Value: String);
begin
  FTRB_MICRO := Value;
end;

procedure TTributacao.setFTRB_ORIGEM(const Value: String);
begin
  FTRB_ORIGEM := Value;
end;

procedure TTributacao.setFTRB_PRODUTO(const Value: String);
begin
  FTRB_PRODUTO := Value;
end;

procedure TTributacao.setFTRB_RD_AQ_ICMS(const Value: Real);
begin
  FTRB_RD_AQ_ICMS := Value;
end;

procedure TTributacao.setFTRB_RD_BS_ICMS(const Value: Real);
begin
  FTRB_RD_BS_ICMS := Value;
end;

procedure TTributacao.setFTRB_RD_BS_ICMS_ST(const Value: String);
begin
  FTRB_RD_BS_ICMS_ST := Value;
end;

procedure TTributacao.setFTRB_SENTIDO(const Value: String);
begin
  FTRB_SENTIDO := Value;
end;

procedure TTributacao.setFTRB_ST_ICMS(const Value: String);
begin
  FTRB_ST_ICMS := Value;
end;

procedure TTributacao.setFTRB_SUB_TRI(const Value: String);
begin
  FTRB_SUB_TRI := Value;
end;

end.
