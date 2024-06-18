unit tblMovimentoFinanceiro;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MOVIM_FINANCEIRO')]
  TMovimentoFinanceiro = Class(TGenericEntity)
  private
    FMVF_HISTORISCO: String;
    FMVF_VL_CREDITO: Real;
    FMVF_VL_FUTURO: Real;
    FMVF_CODHTB: Integer;
    FMVF_ESPECIE: String;
    FMVF_CODFPT: Integer;
    FMVF_NR_DOC: String;
    FMVF_VL_DEBITO: Real;
    FMVF_CODIGO: Integer;
    FMVF_CODCTB: Integer;
    FMVF_CODPLC_C: Integer;
    FMVF_CONFERIDO: String;
    FMVF_CODMHA: Integer;
    FMVF_CODQTC: Integer;
    FMVF_CODPLC_D: Integer;
    FMVF_DT_ORIG: TDate;
    FMVF_CODUSU: Integer;
    FMVF_TIPO: String;
    FMVF_DATA: TDate;


    procedure setFMVF_CODCTB(const Value: Integer);
    procedure setFMVF_CODFPT(const Value: Integer);
    procedure setFMVF_CODHTB(const Value: Integer);
    procedure setFMVF_CODIGO(const Value: Integer);
    procedure setFMVF_CODMHA(const Value: Integer);
    procedure setFMVF_CODPLC_C(const Value: Integer);
    procedure setFMVF_CODPLC_D(const Value: Integer);
    procedure setFMVF_CODQTC(const Value: Integer);
    procedure setFMVF_CODUSU(const Value: Integer);
    procedure setFMVF_CONFERIDO(const Value: String);
    procedure setFMVF_DATA(const Value: TDate);
    procedure setFMVF_DT_ORIG(const Value: TDate);
    procedure setFMVF_ESPECIE(const Value: String);
    procedure setFMVF_HISTORISCO(const Value: String);
    procedure setFMVF_NR_DOC(const Value: String);
    procedure setFMVF_TIPO(const Value: String);
    procedure setFMVF_VL_CREDITO(const Value: Real);
    procedure setFMVF_VL_DEBITO(const Value: Real);
    procedure setFMVF_VL_FUTURO(const Value: Real);


  public
    [KeyField('MVF_CODIGO')]
    [FieldName('MVF_CODIGO')]
    property Codigo: Integer read FMVF_CODIGO write setFMVF_CODIGO;

    [FieldName('MVF_CODCTB')]
    property ContaCorrente: Integer read FMVF_CODCTB write setFMVF_CODCTB;

    [FieldName('MVF_DATA')]
    property Data: TDate read FMVF_DATA write setFMVF_DATA;

    [FieldName('MVF_CODHTB')]
    property HistoricoBancario: Integer read FMVF_CODHTB write setFMVF_CODHTB;

    [FieldName('MVF_CODPLC_C')]
    property PL_Credito: Integer read FMVF_CODPLC_C write setFMVF_CODPLC_C;

    [FieldName('MVF_CODPLC_D')]
    property PL_Debito: Integer read FMVF_CODPLC_D write setFMVF_CODPLC_D;

    [FieldName('MVF_VL_CREDITO')]
    property ValorCredito: Real read FMVF_VL_CREDITO write setFMVF_VL_CREDITO;

    [FieldName('MVF_VL_DEBITO')]
    property ValorDebito: Real read FMVF_VL_DEBITO write setFMVF_VL_DEBITO;

    [FieldName('MVF_HISTORISCO')]
    property Historico: String read FMVF_HISTORISCO write setFMVF_HISTORISCO;

    [FieldName('MVF_TIPO')]
    property Tipo: String read FMVF_TIPO write setFMVF_TIPO;

    [FieldName('MVF_CODQTC')]
    property Quitacao: Integer read FMVF_CODQTC write setFMVF_CODQTC;

    [FieldName('MVF_CODUSU')]
    property Usuario: Integer read FMVF_CODUSU write setFMVF_CODUSU;

    [FieldName('MVF_ESPECIE')]
    property Especie: String read FMVF_ESPECIE write setFMVF_ESPECIE;

    [FieldName('MVF_VL_FUTURO')]
    property ValorFuturo: Real read FMVF_VL_FUTURO write setFMVF_VL_FUTURO;

    [FieldName('MVF_DT_ORIG')]
    property DataOriginal: TDate read FMVF_DT_ORIG write setFMVF_DT_ORIG;

    [FieldName('MVF_NR_DOC')]
    property NrDocumento: String read FMVF_NR_DOC write setFMVF_NR_DOC;

    [FieldName('MVF_CONFERIDO')]
    property Conferido: String read FMVF_CONFERIDO write setFMVF_CONFERIDO;

    [FieldName('MVF_CODFPT')]
    property FormaPagto: Integer read FMVF_CODFPT write setFMVF_CODFPT;

    [FieldName('MVF_CODMHA')]
    property Estabelecimento: Integer read FMVF_CODMHA write setFMVF_CODMHA;

	End;

implementation

{ TMovimentoFinanceiro }

procedure TMovimentoFinanceiro.setFMVF_CODCTB(const Value: Integer);
begin
  FMVF_CODCTB := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODFPT(const Value: Integer);
begin
  FMVF_CODFPT := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODHTB(const Value: Integer);
begin
  FMVF_CODHTB := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODIGO(const Value: Integer);
begin
  FMVF_CODIGO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODMHA(const Value: Integer);
begin
  FMVF_CODMHA := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODPLC_C(const Value: Integer);
begin
  FMVF_CODPLC_C := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODPLC_D(const Value: Integer);
begin
  FMVF_CODPLC_D := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODQTC(const Value: Integer);
begin
  FMVF_CODQTC := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CODUSU(const Value: Integer);
begin
  FMVF_CODUSU := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_CONFERIDO(const Value: String);
begin
  FMVF_CONFERIDO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_DATA(const Value: TDate);
begin
  FMVF_DATA := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_DT_ORIG(const Value: TDate);
begin
  FMVF_DT_ORIG := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_ESPECIE(const Value: String);
begin
  FMVF_ESPECIE := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_HISTORISCO(const Value: String);
begin
  FMVF_HISTORISCO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_NR_DOC(const Value: String);
begin
  FMVF_NR_DOC := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_TIPO(const Value: String);
begin
  FMVF_TIPO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_VL_CREDITO(const Value: Real);
begin
  FMVF_VL_CREDITO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_VL_DEBITO(const Value: Real);
begin
  FMVF_VL_DEBITO := Value;
end;

procedure TMovimentoFinanceiro.setFMVF_VL_FUTURO(const Value: Real);
begin
  FMVF_VL_FUTURO := Value;
end;

end.
