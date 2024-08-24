unit tblCotacao;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_cotacao')]
  TCotacao = Class(TGenericEntity)

  private
    Fctc_vl_produto: Real;
    Fctc_solicitante: String;
    Fctc_obs: String;
    Fctc_equipamento: String;
    Fctc_garantia: String;
    Fctc_vl_desconto: Real;
    Fctc_fantasia: String;
    Fctc_codvdo: Integer;
    Fctc_codtrp: String;
    Fctc_vl_servico: Real;
    Fctc_codemp: Integer;
    Fctc_prz_entrega: String;
    Fctc_vl_cotacao: Real;
    Fctc_codfpg: Integer;
    Fctc_codigo: Integer;
    Fctc_tp_contato: String;
    Fctc_frota: String;
    Fctc_prazo: String;
    Fctc_codusu: Integer;
    Fctc_codped: Integer;
    Fctc_aliq_desconto: Real;
    Fctc_codsit: Integer;
    Fctc_numero: String;
    Fctc_obs_corte: String;
    Fctc_tp_frete: String;
    FCTC_STATUS: String;
    Fctc_email_e: String;
    Fctc_aprovado: String;
    Fctc_contato: String;
    Fctc_qt_produto: Real;
    Fctc_codmha: Integer;
    Fctc_vl_adicional: Real;
    Fctc_dt_env_email: TDateTime;
    Fctc_contatoempresa: String;
    Fctc_vl_frete: Real;
    Fctc_tipo: String;
    Fctc_validade: String;
    Fctc_data: TDate;
    Fctc_vl_custo: Real;
    FCTC_CODVDO_AUX: Integer;
    FCTC_EMUSO: String;
    FFPT_DESCRICAO: String;
    FBloqueados: boolean;
    FPeriodo: boolean;
    FDataFinal: TDate;
    FDataInicial: TDate;
    procedure setFctc_aliq_desconto(const Value: Real);
    procedure setFctc_aprovado(const Value: String);
    procedure setFctc_codemp(const Value: Integer);
    procedure setFctc_codfpg(const Value: Integer);
    procedure setFctc_codigo(const Value: Integer);
    procedure setFctc_codmha(const Value: Integer);
    procedure setFctc_codped(const Value: Integer);
    procedure setFctc_codsit(const Value: Integer);
    procedure setFctc_codtrp(const Value: String);
    procedure setFctc_codusu(const Value: Integer);
    procedure setFctc_codvdo(const Value: Integer);
    procedure setFctc_contato(const Value: String);
    procedure setFctc_contatoempresa(const Value: String);
    procedure setFctc_data(const Value: TDate);
    procedure setFctc_dt_env_email(const Value: TDateTime);
    procedure setFctc_email_e(const Value: String);
    procedure setFctc_equipamento(const Value: String);
    procedure setFctc_fantasia(const Value: String);
    procedure setFctc_frota(const Value: String);
    procedure setFctc_garantia(const Value: String);
    procedure setFctc_numero(const Value: String);
    procedure setFctc_obs(const Value: String);
    procedure setFctc_obs_corte(const Value: String);
    procedure setFctc_prazo(const Value: String);
    procedure setFctc_prz_entrega(const Value: String);
    procedure setFctc_qt_produto(const Value: Real);
    procedure setFctc_solicitante(const Value: String);
    procedure setFCTC_STATUS(const Value: String);
    procedure setFctc_tipo(const Value: String);
    procedure setFctc_tp_contato(const Value: String);
    procedure setFctc_tp_frete(const Value: String);
    procedure setFctc_validade(const Value: String);
    procedure setFctc_vl_adicional(const Value: Real);
    procedure setFctc_vl_cotacao(const Value: Real);
    procedure setFctc_vl_custo(const Value: Real);
    procedure setFctc_vl_desconto(const Value: Real);
    procedure setFctc_vl_frete(const Value: Real);
    procedure setFctc_vl_produto(const Value: Real);
    procedure setFctc_vl_servico(const Value: Real);
    procedure setFCTC_CODVDO_AUX(const Value: Integer);
    procedure setFCTC_EMUSO(const Value: String);
    procedure setFFPT_DESCRICAO(const Value: String);
    procedure setFBloqueados(const Value: boolean);
    procedure setFPeriodo(const Value: boolean);
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
  public

    [FieldName('ctc_codigo')]
    [KeyField('ctc_codigo')]
    property Codigo: Integer read Fctc_codigo write setFctc_codigo;

    [FieldName('ctc_codmha')]
    property Estabelecimento: Integer read Fctc_codmha write setFctc_codmha;

    [FieldName('ctc_codped')]
    property Codped: Integer read Fctc_codped write setFctc_codped;

    [FieldName('ctc_numero')]
    property Numero: String read Fctc_numero write setFctc_numero;

    [FieldName('ctc_tipo')]
    property Tipo: String read Fctc_tipo write setFctc_tipo;

    [FieldName('ctc_codusu')]
    property Codusu: Integer read Fctc_codusu write setFctc_codusu;

    [FieldName('ctc_data')]
    property Data: TDate read Fctc_data write setFctc_data;

    [FieldName('ctc_codemp')]
    property Codemp: Integer read Fctc_codemp write setFctc_codemp;

    [FieldName('ctc_fantasia')]
    property Fantasia: String read Fctc_fantasia write setFctc_fantasia;

    [FieldName('ctc_codfpg')]
    property Codfpg: Integer read Fctc_codfpg write setFctc_codfpg;

    [FieldName('ctc_prazo')]
    property Prazo: String read Fctc_prazo write setFctc_prazo;

    [FieldName('ctc_aprovado')]
    property Aprovado: String read Fctc_aprovado write setFctc_aprovado;

    [FieldName('ctc_qt_produto')]
    property QtProduto: Real read Fctc_qt_produto write setFctc_qt_produto;

    [FieldName('ctc_vl_produto')]
    property VlProduto: Real read Fctc_vl_produto write setFctc_vl_produto;

    [FieldName('ctc_vl_servico')]
    property VlServico: Real read Fctc_vl_servico write setFctc_vl_servico;

    [FieldName('ctc_vl_frete')]
    property VlFrete: Real read Fctc_vl_frete write setFctc_vl_frete;

    [FieldName('ctc_aliq_desconto')]
    property AliqDesconto: Real read Fctc_aliq_desconto write setFctc_aliq_desconto;

    [FieldName('ctc_vl_desconto')]
    property VlDesconto: Real read Fctc_vl_desconto write setFctc_vl_desconto;

    [FieldName('ctc_vl_cotacao')]
    property VlCotacao: Real read Fctc_vl_cotacao write setFctc_vl_cotacao;

    [FieldName('ctc_contato')]
    property Contato: String read Fctc_contato write setFctc_contato;

    [FieldName('ctc_validade')]
    property Validade: String read Fctc_validade write setFctc_validade;

    [FieldName('ctc_prz_entrega')]
    property PrzEntrega: String read Fctc_prz_entrega write setFctc_prz_entrega;

    [FieldName('ctc_garantia')]
    property Garantia: String read Fctc_garantia write setFctc_garantia;

    [FieldName('ctc_frota')]
    property Frota: String read Fctc_frota write setFctc_frota;

    [FieldName('ctc_equipamento')]
    property Equipamento: String read Fctc_equipamento write setFctc_equipamento;

    [FieldName('ctc_tp_frete')]
    property TpFrete: String read Fctc_tp_frete write setFctc_tp_frete;

    [FieldName('ctc_email_e')]
    property EmailE: String read Fctc_email_e write setFctc_email_e;

    [FieldName('ctc_codvdo')]
    property Codvdo: Integer read Fctc_codvdo write setFctc_codvdo;

    [FieldName('ctc_tp_contato')]
    property TpContato: String read Fctc_tp_contato write setFctc_tp_contato;

    [FieldName('ctc_contatoempresa')]
    property ContatoEmpr: String read Fctc_contatoempresa write setFctc_contatoempresa;

    [FieldName('ctc_codtrp')]
    property Codtrp: String read Fctc_codtrp write setFctc_codtrp;

    [FieldName('ctc_vl_custo')]
    property VlCusto: Real read Fctc_vl_custo write setFctc_vl_custo;

    [FieldName('ctc_obs_corte')]
    property ObsCorte: String read Fctc_obs_corte write setFctc_obs_corte;

    [FieldName('ctc_obs')]
    property Obs: String read Fctc_obs write setFctc_obs;

    [FieldName('ctc_dt_env_email')]
    property DtEnvEmail: TDateTime read Fctc_dt_env_email write setFctc_dt_env_email;

    [FieldName('ctc_codsit')]
    property Codsit: Integer read Fctc_codsit write setFctc_codsit;

    [FieldName('ctc_solicitante')]
    property Solicitante: String read Fctc_solicitante write setFctc_solicitante;

    [FieldName('ctc_vl_adicional')]
    property VlAdicional: Real read Fctc_vl_adicional write setFctc_vl_adicional;

    [FieldName('CTC_STATUS')]
    property Status: String read FCTC_STATUS write setFCTC_STATUS;

    [FieldName('CTC_CODVDO_AUX')]
    property AuxiliarVenda: Integer read FCTC_CODVDO_AUX write setFCTC_CODVDO_AUX;

    [FieldName('CTC_EMUSO')]
    property EmUso: String read FCTC_EMUSO write setFCTC_EMUSO;

    property FPT_DESCRICAO: String read FFPT_DESCRICAO write setFFPT_DESCRICAO;
    property Bloqueados: boolean read FBloqueados write setFBloqueados;
    property Periodo: boolean read FPeriodo write setFPeriodo;

    property DataInicial: TDate read FDataInicial write setFDataInicial;
    property DataFinal: TDate read FDataFinal write setFDataFinal;
  End;


implementation

{ TCotacao }

procedure TCotacao.setFBloqueados(const Value: boolean);
begin
  FBloqueados := Value;
end;

procedure TCotacao.setFctc_aliq_desconto(const Value: Real);
begin
  Fctc_aliq_desconto := Value;
end;

procedure TCotacao.setFctc_aprovado(const Value: String);
begin
  Fctc_aprovado := Value;
end;

procedure TCotacao.setFctc_codemp(const Value: Integer);
begin
  Fctc_codemp := Value;
end;

procedure TCotacao.setFctc_codfpg(const Value: Integer);
begin
  Fctc_codfpg := Value;
end;

procedure TCotacao.setFctc_codigo(const Value: Integer);
begin
  Fctc_codigo := Value;
end;

procedure TCotacao.setFctc_codmha(const Value: Integer);
begin
  Fctc_codmha := Value;
end;

procedure TCotacao.setFctc_codped(const Value: Integer);
begin
  Fctc_codped := Value;
end;

procedure TCotacao.setFctc_codsit(const Value: Integer);
begin
  Fctc_codsit := Value;
end;

procedure TCotacao.setFctc_codtrp(const Value: String);
begin
  Fctc_codtrp := Value;
end;

procedure TCotacao.setFctc_codusu(const Value: Integer);
begin
  Fctc_codusu := Value;
end;

procedure TCotacao.setFctc_codvdo(const Value: Integer);
begin
  Fctc_codvdo := Value;
end;

procedure TCotacao.setFCTC_CODVDO_AUX(const Value: Integer);
begin
  FCTC_CODVDO_AUX := Value;
end;

procedure TCotacao.setFctc_contato(const Value: String);
begin
  Fctc_contato := Value;
end;

procedure TCotacao.setFctc_contatoempresa(const Value: String);
begin
  Fctc_contatoempresa := Value;
end;

procedure TCotacao.setFctc_data(const Value: TDate);
begin
  Fctc_data := Value;
end;

procedure TCotacao.setFctc_dt_env_email(const Value: TDateTime);
begin
  Fctc_dt_env_email := Value;
end;

procedure TCotacao.setFctc_email_e(const Value: String);
begin
  Fctc_email_e := Value;
end;

procedure TCotacao.setFCTC_EMUSO(const Value: String);
begin
  FCTC_EMUSO := Value;
end;

procedure TCotacao.setFctc_equipamento(const Value: String);
begin
  Fctc_equipamento := Value;
end;

procedure TCotacao.setFctc_fantasia(const Value: String);
begin
  Fctc_fantasia := Value;
end;

procedure TCotacao.setFctc_frota(const Value: String);
begin
  Fctc_frota := Value;
end;

procedure TCotacao.setFctc_garantia(const Value: String);
begin
  Fctc_garantia := Value;
end;

procedure TCotacao.setFctc_numero(const Value: String);
begin
  Fctc_numero := Value;
end;

procedure TCotacao.setFctc_obs(const Value: String);
begin
  Fctc_obs := Value;
end;

procedure TCotacao.setFctc_obs_corte(const Value: String);
begin
  Fctc_obs_corte := Value;
end;

procedure TCotacao.setFctc_prazo(const Value: String);
begin
  Fctc_prazo := Value;
end;

procedure TCotacao.setFctc_prz_entrega(const Value: String);
begin
  Fctc_prz_entrega := Value;
end;

procedure TCotacao.setFctc_qt_produto(const Value: Real);
begin
  Fctc_qt_produto := Value;
end;

procedure TCotacao.setFctc_solicitante(const Value: String);
begin
  Fctc_solicitante := Value;
end;

procedure TCotacao.setFCTC_STATUS(const Value: String);
begin
  FCTC_STATUS := Value;
end;

procedure TCotacao.setFctc_tipo(const Value: String);
begin
  Fctc_tipo := Value;
end;

procedure TCotacao.setFctc_tp_contato(const Value: String);
begin
  Fctc_tp_contato := Value;
end;

procedure TCotacao.setFctc_tp_frete(const Value: String);
begin
  Fctc_tp_frete := Value;
end;

procedure TCotacao.setFctc_validade(const Value: String);
begin
  Fctc_validade := Value;
end;

procedure TCotacao.setFctc_vl_adicional(const Value: Real);
begin
  Fctc_vl_adicional := Value;
end;

procedure TCotacao.setFctc_vl_cotacao(const Value: Real);
begin
  Fctc_vl_cotacao := Value;
end;

procedure TCotacao.setFctc_vl_custo(const Value: Real);
begin
  Fctc_vl_custo := Value;
end;

procedure TCotacao.setFctc_vl_desconto(const Value: Real);
begin
  Fctc_vl_desconto := Value;
end;

procedure TCotacao.setFctc_vl_frete(const Value: Real);
begin
  Fctc_vl_frete := Value;
end;

procedure TCotacao.setFctc_vl_produto(const Value: Real);
begin
  Fctc_vl_produto := Value;
end;

procedure TCotacao.setFctc_vl_servico(const Value: Real);
begin
  Fctc_vl_servico := Value;
end;

procedure TCotacao.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TCotacao.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TCotacao.setFFPT_DESCRICAO(const Value: String);
begin
  FFPT_DESCRICAO := Value;
end;

procedure TCotacao.setFPeriodo(const Value: boolean);
begin
  FPeriodo := Value;
end;

end.
