unit tblPedido;

interface

Uses TEntity,CAtribEntity, Variants, SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_pedido')]
  TPedido = Class(TGenericEntity)
  private
    FPED_VL_FRETE: Real;
    FPED_VL_CREDITO: Real;
    FPED_CODMHA: Integer;
    FPED_FATURADO: String;
    FPED_VL_IPI: Real;
    FPED_GARANTIA: String;
    FPED_OBS: String;
    FPED_CTA_FRETE: Integer;
    FPED_CODCOB: Integer;
    FPED_CODFAT: Integer;
    FPED_CODENT: Integer;
    FPED_CODTRP: Integer;
    FPED_CODFPG: Integer;
    FPED_DT_ENTREGA: TDate;
    FPED_TP_CUSTOMER: String;
    FPED_VL_DESCONTO: Real;
    FPED_ENTREGA: String;
    FPED_QT_PRODUTO: Real;
    FPED_VL_SERVICO: Real;
    FPED_CODIGO: Integer;
    FPED_VL_PEDIDO: Real;
    FPED_PRAZO: String;
    FPED_EMUSO: String;
    FPED_ALIQ_DESCONTO: Real;
    FPED_CODVDO: Integer;
    FPED_NUMERO: Integer;
    FPED_VL_ODESPESA: Real;
    FPED_CODNAT: Integer;
    FPED_NUM_ANT: Integer;
    FPED_TP_CONTATO: String;
    FPED_APROVADO: String;
    FPED_CODEMP: Integer;
    FPED_NUM_ORCA: Integer;
    FPED_CODNEG: Integer;
    FPED_CODUSU: Integer;
    FPED_CODWEB: Integer;
    FPED_TIPO: Integer;
    FPED_VL_PRODUTO: Real;
    FPED_CODEND: Integer;
    FPED_VALIDADE: TDate;
    FPED_DATA: TDate;
    FPED_INDPRES: Integer;
    FPED_VL_ST : REal;
    FPED_DT_ALTERA: TDateTime;
    FPED_NUMWEB: Integer;
    FPED_TERMINAL: Integer;
    FPED_HORA: TTime;
    FUSU_NOME: String;
    FEMP_NOME: String;
    FFPT_DESCRICAO: String;
    FEMP_FANTASIA: String;
    FDataIni: TDate;
    FDataFim: TDate;


    procedure setFPED_CODIGO( Value : INTEGER);
    procedure setFPED_NUMERO( Value : INTEGER);
    procedure setFPED_TIPO( Value : INTEGER);
    procedure setFPED_CODUSU( Value : INTEGER);
    procedure setFPED_DATA( Value : TDATE);
    procedure setFPED_CODEMP( Value : INTEGER);
    procedure setFPED_CODVDO( Value : INTEGER);
    procedure setFPED_CODFPG( Value : INTEGER);
    procedure setFPED_PRAZO( Value : String);
    procedure setFPED_CODEND( Value : INTEGER);
    procedure setFPED_QT_PRODUTO( Value : Real);
    procedure setFPED_VL_PRODUTO( Value : Real);
    procedure setFPED_VL_IPI( Value : Real);
    procedure setFPED_VL_FRETE( Value : Real);
    procedure setFPED_ALIQ_DESCONTO( Value : Real);
    procedure setFPED_VL_DESCONTO( Value : Real);
    procedure setFPED_VL_PEDIDO( Value : Real);
    procedure setFPED_FATURADO( Value : String);
    procedure setFPED_TP_CONTATO( Value : String);
    procedure setFPED_DT_ENTREGA( Value : TDATE);
    procedure setFPED_VL_SERVICO( Value : Real);
    procedure setFPED_CODTRP( Value : INTEGER);
    procedure setFPED_CTA_FRETE( Value : INTEGER);
    procedure setFPED_EMUSO( Value : String);
    procedure setFPED_CODNAT( Value : INTEGER);
    procedure setFPED_CODENT( Value : INTEGER);
    procedure setFPED_CODFAT( Value : INTEGER);
    procedure setFPED_CODCOB( Value : INTEGER);
    procedure setFPED_CODMHA( Value : INTEGER);
    procedure setFPED_APROVADO( Value : String);
    procedure setFPED_VL_ODESPESA( Value : Real);
    procedure setFPED_OBS( Value : String);
    procedure setFPED_NUM_ORCA( Value : INTEGER);
    procedure setFPED_VALIDADE( Value : TDATE);
    procedure setFPED_CODWEB( Value : INTEGER);
    procedure setFPED_VL_CREDITO( Value : Real);
    procedure setFPED_CODNEG( Value : INTEGER);
    procedure setFPED_ENTREGA( Value : String);
    procedure setFPED_GARANTIA( Value : String);
    procedure setFPED_TP_CUSTOMER( Value : String);
    procedure setFPED_INDPRES( Value : INTEGER);
    procedure setFPED_NUM_ANT(Value: Integer);
    procedure setFPED_VL_ST(Value : Real);
    procedure setFPED_DT_ALTERA(const Value: TDateTime);
    procedure setFPED_NUMWEB(const Value: Integer);
    procedure setFPED_TERMINAL(const Value: Integer);
    procedure setFPED_HORA(const Value: TTime);
    procedure setFEMP_NOME(const Value: String);
    procedure setFFPT_DESCRICAO(const Value: String);
    procedure setFUSU_NOME(const Value: String);
    procedure setFEMP_FANTASIA(const Value: String);
    procedure setFDataFim(const Value: TDate);
    procedure setFDataIni(const Value: TDate);
  public

    [FieldName('PED_CODIGO')]
    [KeyField('PED_CODIGO')]
    property Codigo: Integer read FPED_CODIGO write setFPED_CODIGO;

    [FieldName('PED_NUMERO')]
    property Numero: Integer read FPED_NUMERO write setFPED_NUMERO;

    [FieldName('PED_TIPO')]
    property Tipo: Integer read FPED_TIPO write setFPED_TIPO;

    [FieldName('PED_CODUSU')]
    property Usuario: Integer read FPED_CODUSU write setFPED_CODUSU;

    [FieldName('PED_DATA')]
    property Data: TDate read FPED_DATA write setFPED_DATA;

    [FieldName('PED_CODEMP')]
    property Empresa: Integer read FPED_CODEMP write setFPED_CODEMP;

    [FieldName('PED_CODVDO')]
    property Vendedor: Integer read FPED_CODVDO write setFPED_CODVDO;

    [FieldName('PED_CODFPG')]
    property FormaPagto: Integer read FPED_CODFPG write setFPED_CODFPG;

    [FieldName('PED_PRAZO')]
    property Prazo: String read FPED_PRAZO write setFPED_PRAZO;

    [FieldName('PED_CODEND')]
    property Endereco: Integer read FPED_CODEND write setFPED_CODEND;

    [FieldName('PED_QT_PRODUTO')]
    property QtdeProdutos: Real read FPED_QT_PRODUTO write setFPED_QT_PRODUTO;

    [FieldName('PED_VL_PRODUTO')]
    property ValorProdutos: Real read FPED_VL_PRODUTO write setFPED_VL_PRODUTO;

    [FieldName('PED_VL_IPI')]
    property ValorIPI: Real read FPED_VL_IPI write setFPED_VL_IPI;

    [FieldName('PED_VL_FRETE')]
    property ValorFrete: Real read FPED_VL_FRETE write setFPED_VL_FRETE;

    [FieldName('PED_ALIQ_DESCONTO')]
    property AliqDesconto: Real read FPED_ALIQ_DESCONTO write setFPED_ALIQ_DESCONTO;

    [FieldName('PED_VL_DESCONTO')]
    property ValorDesconto: Real read FPED_VL_DESCONTO write setFPED_VL_DESCONTO;

    [FieldName('PED_VL_PEDIDO')]
    property ValorPedido: Real read FPED_VL_PEDIDO write setFPED_VL_PEDIDO;

    [FieldName('PED_FATURADO')]
    property Faturado: String read FPED_FATURADO write setFPED_FATURADO;

    [FieldName('PED_TP_CONTATO')]
    property TipoContato: String read FPED_TP_CONTATO write setFPED_TP_CONTATO;

    [FieldName('PED_DT_ENTREGA')]
    property DataEntrega: TDate read FPED_DT_ENTREGA write setFPED_DT_ENTREGA;

    [FieldName('PED_NUM_ANT')]
    property PedidoAnterior: Integer read FPED_NUM_ANT write setFPED_NUM_ANT;

    [FieldName('PED_DT_ALTERA')]
    property DataAlteracao: TDateTime read FPED_DT_ALTERA write setFPED_DT_ALTERA;

    [FieldName('PED_VL_SERVICO')]
    property ValorServico: Real read FPED_VL_SERVICO write setFPED_VL_SERVICO;

    [FieldName('PED_CODTRP')]
    property Transportadora: Integer read FPED_CODTRP write setFPED_CODTRP;

    [FieldName('PED_CTA_FRETE')]
    property FretePorConta: Integer read FPED_CTA_FRETE write setFPED_CTA_FRETE;

    [FieldName('PED_EMUSO')]
    property EmUso: String read FPED_EMUSO write setFPED_EMUSO;

    [FieldName('PED_CODNAT')]
    property CodigoNatureza: Integer read FPED_CODNAT write setFPED_CODNAT;

    [FieldName('PED_CODENT')]
    property EnderecoEntrega: Integer read FPED_CODENT write setFPED_CODENT;

    [FieldName('PED_CODFAT')]
    property EnderecoFaturamento: Integer read FPED_CODFAT write setFPED_CODFAT;

    [FieldName('PED_CODCOB')]
    property EnderecoCobranca: Integer read FPED_CODCOB write setFPED_CODCOB;

    [FieldName('PED_CODMHA')]
    property CodigoEstabelecimento: Integer read FPED_CODMHA write setFPED_CODMHA;

    [FieldName('PED_APROVADO')]
    property Aprovado: String read FPED_APROVADO write setFPED_APROVADO;

    [FieldName('PED_VL_ODESPESA')]
    property ValorOutrasDEspesas: Real read FPED_VL_ODESPESA write setFPED_VL_ODESPESA;

    [FieldName('PED_OBS')]
    property Observacao: String read FPED_OBS write setFPED_OBS;

    [FieldName('PED_NUM_ORCA')]
    property NumeroOrcamento: Integer read FPED_NUM_ORCA write setFPED_NUM_ORCA;

    [FieldName('PED_VALIDADE')]
    property Validade: TDate read FPED_VALIDADE write setFPED_VALIDADE;

    [FieldName('PED_CODWEB')]
    property CodigoWeb: Integer read FPED_CODWEB write setFPED_CODWEB;

    [FieldName('PED_NUMWEB')]
    property NumeroWeb: Integer read FPED_NUMWEB write setFPED_NUMWEB;

    [FieldName('PED_VL_CREDITO')]
    property ValorCredito: Real read FPED_VL_CREDITO write setFPED_VL_CREDITO;

    [FieldName('PED_CODNEG')]
    property CodigoNegocio: Integer read FPED_CODNEG write setFPED_CODNEG;

    [FieldName('PED_ENTREGA')]
    property Entrega: String read FPED_ENTREGA write setFPED_ENTREGA;

    [FieldName('PED_GARANTIA')]
    property Garantia: String read FPED_GARANTIA write setFPED_GARANTIA;

    [FieldName('PED_TP_CUSTOMER')]
    property OrigemCliente: String read FPED_TP_CUSTOMER write setFPED_TP_CUSTOMER;

    [FieldName('PED_INDPRES')]
    property IndicaPresenca: Integer read FPED_INDPRES write setFPED_INDPRES;

    [FieldName('PED_VL_ST')]
    property ValorSubstTributaria: Real read FPED_VL_ST write setFPED_VL_ST;

    [FieldName('PED_TERMINAL')]
    property Terminal: Integer read FPED_TERMINAL write setFPED_TERMINAL;

    [FieldName('PED_HORA')]
    property Hora: TTime read FPED_HORA write setFPED_HORA;

    property FPT_DESCRICAO: String read FFPT_DESCRICAO write setFFPT_DESCRICAO;
    property EMP_NOME: String read FEMP_NOME write setFEMP_NOME;
    property USU_NOME: String read FUSU_NOME write setFUSU_NOME;
    property EMP_FANTASIA: String read FEMP_FANTASIA write setFEMP_FANTASIA;

    property DataIni: TDate read FDataIni write setFDataIni;
    property DataFim: TDate read FDataFim write setFDataFim;
  End;

implementation

{ TPedido }

procedure TPedido.setFDataFim(const Value: TDate);
begin
  FDataFim := Value;
end;

procedure TPedido.setFDataIni(const Value: TDate);
begin
  FDataIni := Value;
end;

procedure TPedido.setFEMP_FANTASIA(const Value: String);
begin
  FEMP_FANTASIA := Value;
end;

procedure TPedido.setFEMP_NOME(const Value: String);
begin
  FEMP_NOME := Value;
end;

procedure TPedido.setFFPT_DESCRICAO(const Value: String);
begin
  FFPT_DESCRICAO := Value;
end;

procedure TPedido.setFPED_ALIQ_DESCONTO(Value: Real);
begin
  FPED_ALIQ_DESCONTO := Value;
end;

procedure TPedido.setFPED_APROVADO(Value: String);
begin
  FPED_APROVADO := Value;
end;

procedure TPedido.setFPED_CODCOB(Value: INTEGER);
begin
  FPED_CODCOB := Value;
end;

procedure TPedido.setFPED_CODEMP(Value: INTEGER);
begin
  FPED_CODEMP := Value;
end;

procedure TPedido.setFPED_CODEND(Value: INTEGER);
begin
  FPED_CODEND := Value;
end;

procedure TPedido.setFPED_CODENT(Value: INTEGER);
begin
  FPED_CODENT := Value;
end;

procedure TPedido.setFPED_CODFAT(Value: INTEGER);
begin
  FPED_CODFAT := Value;
end;

procedure TPedido.setFPED_CODFPG(Value: INTEGER);
begin
  FPED_CODFPG := Value;
end;

procedure TPedido.setFPED_CODIGO(Value: INTEGER);
begin
  FPED_CODIGO := Value;
end;

procedure TPedido.setFPED_CODMHA(Value: INTEGER);
begin
  FPED_CODMHA := Value;
end;

procedure TPedido.setFPED_CODNAT(Value: INTEGER);
begin
  FPED_CODNAT := Value;
end;

procedure TPedido.setFPED_CODNEG(Value: INTEGER);
begin
  FPED_CODNEG := Value;
end;

procedure TPedido.setFPED_CODTRP(Value: INTEGER);
begin
  FPED_CODTRP := Value;
end;

procedure TPedido.setFPED_CODUSU(Value: INTEGER);
begin
  FPED_CODUSU := Value;
end;

procedure TPedido.setFPED_CODVDO(Value: INTEGER);
begin
  FPED_CODVDO := Value;
end;

procedure TPedido.setFPED_CODWEB(Value: INTEGER);
begin
  FPED_CODWEB := Value;
end;

procedure TPedido.setFPED_CTA_FRETE(Value: INTEGER);
begin
  FPED_CTA_FRETE := Value;
end;

procedure TPedido.setFPED_DATA(Value: TDATE);
begin
  if not (Value = null) then
    FPED_DATA := Value
  else
    FPED_DATA := Date;
end;

procedure TPedido.setFPED_DT_ALTERA(const Value: TDateTime);
begin
  FPED_DT_ALTERA := Value;
end;

procedure TPedido.setFPED_DT_ENTREGA(Value: TDATE);
begin
  FPED_DT_ENTREGA := Value;
end;

procedure TPedido.setFPED_EMUSO(Value: String);
begin
  FPED_EMUSO := Value;
end;

procedure TPedido.setFPED_ENTREGA(Value: String);
begin
  FPED_ENTREGA := Value;
end;

procedure TPedido.setFPED_FATURADO(Value: String);
begin
  FPED_FATURADO := Value;
end;

procedure TPedido.setFPED_GARANTIA(Value: String);
begin
  FPED_GARANTIA := Value;
end;

procedure TPedido.setFPED_HORA(const Value: TTime);
begin
  FPED_HORA := Value;
end;

procedure TPedido.setFPED_INDPRES(Value: INTEGER);
begin
  FPED_INDPRES := Value;
end;

procedure TPedido.setFPED_NUMERO(Value: INTEGER);
begin
  FPED_NUMERO := Value;
end;

procedure TPedido.setFPED_NUMWEB(const Value: Integer);
begin
  FPED_NUMWEB := Value;
end;

procedure TPedido.setFPED_NUM_ANT(Value: Integer);
begin
  FPED_NUM_ANT := Value;
end;

procedure TPedido.setFPED_NUM_ORCA(Value: INTEGER);
begin
  FPED_NUM_ORCA := Value;
end;

procedure TPedido.setFPED_OBS(Value: String);
begin
  FPED_OBS := Value;
end;

procedure TPedido.setFPED_PRAZO(Value: String);
begin
  FPED_PRAZO := Value;
end;

procedure TPedido.setFPED_QT_PRODUTO(Value: Real);
begin
  FPED_QT_PRODUTO := Value;
end;

procedure TPedido.setFPED_TERMINAL(const Value: Integer);
begin
  FPED_TERMINAL := Value;
end;

procedure TPedido.setFPED_TIPO(Value: INTEGER);
begin
  FPED_TIPO := Value;
end;

procedure TPedido.setFPED_TP_CONTATO(Value: String);
begin
  FPED_TP_CONTATO := Value;
end;

procedure TPedido.setFPED_TP_CUSTOMER(Value: String);
begin
  FPED_TP_CUSTOMER := Value;
end;

procedure TPedido.setFPED_VALIDADE(Value: TDATE);
begin
  FPED_VALIDADE := Value;
end;

procedure TPedido.setFPED_VL_CREDITO(Value: Real);
begin
  FPED_VL_CREDITO := Value;
end;

procedure TPedido.setFPED_VL_DESCONTO(Value: Real);
begin
  FPED_VL_DESCONTO := Value;
end;

procedure TPedido.setFPED_VL_FRETE(Value: Real);
begin
  FPED_VL_FRETE := Value;
end;

procedure TPedido.setFPED_VL_IPI(Value: Real);
begin
  FPED_VL_IPI := Value;
end;

procedure TPedido.setFPED_VL_ODESPESA(Value: Real);
begin
  FPED_VL_ODESPESA := Value;
end;

procedure TPedido.setFPED_VL_PEDIDO(Value: Real);
begin
  FPED_VL_PEDIDO := Value;
end;

procedure TPedido.setFPED_VL_PRODUTO(Value: Real);
begin
  FPED_VL_PRODUTO := Value;
end;

procedure TPedido.setFPED_VL_SERVICO(Value: Real);
begin
  FPED_VL_SERVICO := Value;
end;

procedure TPedido.setFPED_VL_ST(Value: Real);
begin
  FPED_VL_ST := Value;
end;

procedure TPedido.setFUSU_NOME(const Value: String);
begin
  FUSU_NOME := Value;
end;

end.
