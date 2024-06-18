unit tblFinanceiro;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_financeiro')]
  TFinanceiro = Class(TGenericEntity)
  private
    FCODIGO: INTEGER ;
    FCODEMP: INTEGER ;
    FDATA: TDATE ;
    FCODPED : INTEGER ;
    FCODNFL : INTEGER ;
    FCODFPG :INTEGER ;
    FPRAZO : String ;
    FDT_VENCIMENTO : TDATE ;
    FNUMERO : String ;
    FVL_PARCELA : Real ;
    FNR_PARCELA : INTEGER ;
    FVL_JUROS : Real ;
    FVL_MORA : REal ;
    FVL_DESCONTO : Real ;
    FVL_PAGO : REal ;
    FDT_PAGTO : TDATE ;
    FDT_BAIXA : TDATE ;
    FBAIXA : String ;
    FPLC_CREDITO : INTEGER ;
    FPLC_DEBITO :      INTEGER ;
    FTIPO : String ;
    FSITUACAO : String ;
    FCODQTC : INTEGER ;
    FOPERACAO : String;
    FETAPA : String;
    FCODMHA : INTEGER;
    FCODCHQ : INTEGER;
    FFIN_DT_LIMIT_DESC:  TDATE;
    FFIN_ALIQ_DESC : Real;
    FFIN_COND_ESPECIAIS : String;
    FFIN_DT_REPROGRAMADA:  TDATE;
    FFIN_AUTORIZADO: String;

    procedure setFCODIGO( Value : INTEGER );
    procedure setFCODEMP( Value : INTEGER );
    procedure setFDATA( Value : TDATE );
    procedure setFCODPED( Value : INTEGER );
    procedure setFCODNFL( Value : INTEGER );
    procedure setFCODFPG( Value :INTEGER );
    procedure setFPRAZO( Value : String );
    procedure setFDT_VENCIMENTO( Value : TDATE );
    procedure setFNUMERO( Value : String );
    procedure setFVL_PARCELA( Value : Real );
    procedure setFNR_PARCELA( Value : INTEGER );
    procedure setFVL_JUROS( Value : Real );
    procedure setFVL_MORA( Value : REal );
    procedure setFVL_DESCONTO( Value : Real );
    procedure setFVL_PAGO( Value : REal );
    procedure setFDT_PAGTO( Value : TDATE );
    procedure setFDT_BAIXA( Value : TDATE );
    procedure setFBAIXA( Value : String );
    procedure setFPLC_CREDITO( Value : INTEGER );
    procedure setFPLC_DEBITO( Value :      INTEGER );
    procedure setFTIPO( Value : String );
    procedure setFSITUACAO( Value : String );
    procedure setFCODQTC( Value : INTEGER );
    procedure setFOPERACAO( Value : String);
    procedure setFETAPA( Value : String);
    procedure setFCODMHA( Value : INTEGER);
    procedure setFCODCHQ( Value : INTEGER);
    procedure setFFIN_DT_LIMIT_DESC( Value :  TDATE);
    procedure setFFIN_ALIQ_DESC( Value : Real);
    procedure setFFIN_COND_ESPECIAIS( Value : String);
    procedure setFFIN_DT_REPROGRAMADA(Value :  TDATE);
    procedure setFFIN_AUTORIZADO(const Value: String);


  public
    [KeyField('FIN_CODIGO')]
    [FieldName('FIN_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [FieldName('FIN_CODEMP')]
    property CodigoEmpresa: Integer read FCODEMP write setFCODEMP;

    [FieldName('FIN_DATA')]
    property DataFinanceiro: TDate read FDATA write setFDATA;

    [FieldName('FIN_CODPED')]
    property CodigoPedido: Integer read FCODPED write setFCODPED;

    [FieldName('FIN_CODNFL')]
    property CodigoNota: Integer read FCODNFL write setFCODNFL;

    [FieldName('FIN_CODFPG')]
    property FormaPagamento: Integer read FCODFPG write setFCODFPG;

    [FieldName('FIN_PRAZO')]
    property PrazoPagamento: String read FPRAZO write setFPRAZO;

    [FieldName('FIN_DT_VENCIMENTO')]
    property DataVencimento: TDate read FDT_VENCIMENTO write setFDT_VENCIMENTO;

    [FieldName('FIN_NUMERO')]
    property NumeroDuplicata: String read FNUMERO write setFNUMERO;

    [FieldName('FIN_VL_PARCELA')]
    property ValorParcela: Real read FVL_PARCELA write setFVL_PARCELA;

    [FieldName('FIN_NR_PARCELA')]
    property NumeroParcela: Integer read FNR_PARCELA write setFNR_PARCELA;

    [FieldName('FIN_VL_JUROS')]
    property ValorJuros: Real read FVL_JUROS write setFVL_JUROS;

    [FieldName('FIN_VL_MORA')]
    property ValorMora: Real read FVL_MORA write setFVL_MORA;
    [FieldName('FIN_VL_DESCONTO')]
    property ValorDesconto: Real read FVL_DESCONTO write setFVL_DESCONTO;

    [FieldName('FIN_VL_PAGO')]
    property ValorPago: Real read FVL_PAGO write setFVL_PAGO;

    [FieldName('FIN_DT_PAGTO')]
    property DataPagamento: TDate read FDT_PAGTO write setFDT_PAGTO;

    [FieldName('FIN_DT_BAIXA')]
    property DataBaixa: TDate read FDT_BAIXA write setFDT_BAIXA;

    [FieldName('FIN_BAIXA')]
    property DocumentoBaixado: String read FBAIXA write setFBAIXA;

    [FieldName('FIN_PLC_CREDITO')]
    property ContaResultado: Integer read FPLC_CREDITO write setFPLC_CREDITO;

    [FieldName('FIN_PLC_DEBITO')]
    property CentroCusto: Integer read FPLC_DEBITO write setFPLC_DEBITO;

    [FieldName('FIN_TIPO')]
    property TipoFinanceiro: String read FTIPO write setFTIPO;

    [FieldName('FIN_SITUACAO')]
    property SituacaoFinanceiro: String read FSITUACAO write setFSITUACAO;

    [FieldName('FIN_CODQTC')]
    property CodigoQuitacao: Integer read FCODQTC write setFCODQTC;

    [FieldName('FIN_OPERACAO')]
    property OperacaoFinanceiro: String read FOPERACAO write setFOPERACAO;

    [FieldName('FIN_ETAPA')]
    property EtapaFinaceiro: String read FETAPA write setFETAPA;

    [FieldName('FIN_CODMHA')]
    property Estabelecimento: Integer read FCODMHA write setFCODMHA;

    [FieldName('FIN_CODCHQ')]
    property CodigoCheque: Integer read FCODCHQ write setFCODCHQ;
    [FieldName('FIN_DT_LIMIT_DESC')]
    property DataLimite: TDate read FFIN_DT_LIMIT_DESC write setFFIN_DT_LIMIT_DESC;
    [FieldName('FIN_ALIQ_DESC')]
    property AliquotaDesconto: Real read FFIN_ALIQ_DESC write setFFIN_ALIQ_DESC;
    [FieldName('FIN_COND_ESPECIAIS')]
    property CondicoesEspeciais: String read FFIN_COND_ESPECIAIS write setFFIN_COND_ESPECIAIS;
    [FieldName('FIN_DT_REPROGRAMADA')]
    property Reprogramacao: TDate read FFIN_DT_REPROGRAMADA write setFFIN_DT_REPROGRAMADA;

    [FieldName('FIN_AUTORIZADO')]
    property Autorizado: String read FFIN_AUTORIZADO write setFFIN_AUTORIZADO;

  End;

implementation

{ TFinanceiro }

procedure TFinanceiro.setFBAIXA(Value: String);
begin
  FBAIXA := Value;
end;

procedure TFinanceiro.setFCODCHQ(Value: INTEGER);
begin
  FCODCHQ := Value;
end;

procedure TFinanceiro.setFCODEMP(Value: INTEGER);
begin
  FCODEMP := Value;
end;

procedure TFinanceiro.setFCODFPG(Value: INTEGER);
begin
  FCODFPG := Value;
end;

procedure TFinanceiro.setFCODIGO(Value: INTEGER);
begin
  FCODIGO := Value;
end;

procedure TFinanceiro.setFCODMHA(Value: INTEGER);
begin
  FCODMHA := Value;
end;

procedure TFinanceiro.setFCODNFL(Value: INTEGER);
begin
  FCODNFL := Value;
end;

procedure TFinanceiro.setFCODPED(Value: INTEGER);
begin
  FCODPED := Value;
end;

procedure TFinanceiro.setFCODQTC(Value: INTEGER);
begin
  FCODQTC := Value;
end;

procedure TFinanceiro.setFDATA(Value: TDATE);
begin
  FDATA := Value;
end;

procedure TFinanceiro.setFDT_BAIXA(Value: TDATE);
begin
  FDT_BAIXA := Value;
end;

procedure TFinanceiro.setFDT_PAGTO(Value: TDATE);
begin
  FDT_PAGTO := Value;
end;

procedure TFinanceiro.setFDT_VENCIMENTO(Value: TDATE);
begin
  FDT_VENCIMENTO := Value;
end;

procedure TFinanceiro.setFETAPA(Value: String);
begin
  FETAPA := Value;
end;

procedure TFinanceiro.setFFIN_ALIQ_DESC(Value: Real);
begin
  FFIN_ALIQ_DESC := Value;
end;

procedure TFinanceiro.setFFIN_AUTORIZADO(const Value: String);
begin
  FFIN_AUTORIZADO := Value;
end;

procedure TFinanceiro.setFFIN_COND_ESPECIAIS(Value: String);
begin
  FFIN_COND_ESPECIAIS := Value;
end;

procedure TFinanceiro.setFFIN_DT_LIMIT_DESC(Value: TDATE);
begin
  FFIN_DT_LIMIT_DESC := Value;
end;

procedure TFinanceiro.setFFIN_DT_REPROGRAMADA(Value: TDATE);
begin
  FFIN_DT_REPROGRAMADA := Value;
end;

procedure TFinanceiro.setFNR_PARCELA(Value: INTEGER);
begin
  FNR_PARCELA := Value;
end;

procedure TFinanceiro.setFNUMERO(Value: String);
begin
  FNUMERO := Value;
end;

procedure TFinanceiro.setFOPERACAO(Value: String);
begin
  FOPERACAO := Value;
end;

procedure TFinanceiro.setFPLC_CREDITO(Value: INTEGER);
begin
  FPLC_CREDITO := Value;
end;

procedure TFinanceiro.setFPLC_DEBITO(Value: INTEGER);
begin
  FPLC_DEBITO := Value;
end;

procedure TFinanceiro.setFPRAZO(Value: String);
begin
  FPRAZO := Value;
end;

procedure TFinanceiro.setFSITUACAO(Value: String);
begin
  FSITUACAO := Value;
end;

procedure TFinanceiro.setFTIPO(Value: String);
begin
  FTIPO := Value;
end;


procedure TFinanceiro.setFVL_DESCONTO(Value: Real);
begin
  FVL_DESCONTO := Value;
end;

procedure TFinanceiro.setFVL_JUROS(Value: Real);
begin
  FVL_JUROS := Value;
end;

procedure TFinanceiro.setFVL_MORA(Value: REal);
begin
  FVL_MORA := Value;
end;

procedure TFinanceiro.setFVL_PAGO(Value: REal);
begin
  FVL_PAGO := Value;
end;

procedure TFinanceiro.setFVL_PARCELA(Value: Real);
begin
  FVL_PARCELA := Value;
end;

end.

