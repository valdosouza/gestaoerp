unit tblFormaPagamento;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('TB_FORMAPAGTO')]
  TFormaPagamento = Class(TGenericEntity)
  private
    FFPT_CODIGO : Integer;
    FFPT_DESCRICAO : String;
    FFPT_BLOQUEA : String;
    FFPT_FINALIDADE : String;
    FFPT_LIMITE : String;
    FFPT_TIPO_NFCE : String;
    FFPT_PARCELAS : Integer;
    FFPT_CODPLC_D : Integer;
    FFPT_CODPLC_C : Integer;
    FFPT_ATIVO : String;
    FFPT_APP_DELIVERY: String;
    FFPT_TEF: String;

    procedure setFFPT_CODIGO( Value : Integer);
    procedure setFFPT_DESCRICAO( Value : String);
    procedure setFFPT_BLOQUEA( Value : String);
    procedure setFFPT_FINALIDADE( Value : String);
    procedure setFFPT_LIMITE( Value : String);
    procedure setFFPT_TIPO_NFCE( Value : String);
    procedure setFFPT_PARCELAS( Value : Integer);
    procedure setFFPT_CODPLC_D( Value : Integer);
    procedure setFFPT_CODPLC_C( Value : Integer);
    procedure setFFPT_ATIVO( Value : String);
    procedure setFFPT_APP_DELIVERY(const Value: String);
    procedure setFFPT_TEF(const Value: String);
  public
    [KeyField('FPT_CODIGO')]
    [FieldName('FPT_CODIGO')]
    property Codigo: Integer read FFPT_CODIGO write setFFPT_CODIGO;

    [FieldName('FPT_DESCRICAO')]
    property Descricao: String read FFPT_DESCRICAO write setFFPT_DESCRICAO;

    [FieldName('FPT_BLOQUEA')]
    property Bloqueia: String read FFPT_BLOQUEA write setFFPT_BLOQUEA;

    [FieldName('FPT_FINALIDADE')]
    property Finalidade: String read FFPT_FINALIDADE write setFFPT_FINALIDADE;

    [FieldName('FPT_LIMITE')]
    property Limite: String read FFPT_LIMITE write setFFPT_LIMITE;

    [FieldName('FPT_TIPO_NFCE')]
    property FormaPagamentoNFCE: String read FFPT_TIPO_NFCE write setFFPT_TIPO_NFCE;

    [FieldName('FPT_PARCELAS')]
    property ParcelamentoMaximo: Integer read FFPT_PARCELAS write setFFPT_PARCELAS;

    [FieldName('FPT_CODPLC_D')]
    property CentroCusto: Integer read FFPT_CODPLC_D write setFFPT_CODPLC_D;

    [FieldName('FPT_CODPLC_C')]
    property ContaResultado: Integer read FFPT_CODPLC_C write setFFPT_CODPLC_C;

    [FieldName('FPT_ATIVO')]
    property Ativo: String read FFPT_ATIVO write setFFPT_ATIVO;

    [FieldName('FPT_APP_DELIVERY')]
    property DisponivelDElivery: String read FFPT_APP_DELIVERY write setFFPT_APP_DELIVERY;

    [FieldName('FPT_TEF')]
    property HabilitaTEF: String read FFPT_TEF write setFFPT_TEF;

  End;

implementation

{ TFormaPagto }

procedure TFormaPagamento.setFFPT_APP_DELIVERY(const Value: String);
begin
  FFPT_APP_DELIVERY := Value;
end;

procedure TFormaPagamento.setFFPT_ATIVO(Value: String);
begin
  FFPT_ATIVO:= Value;
end;

procedure TFormaPagamento.setFFPT_BLOQUEA(Value: String);
begin
  FFPT_BLOQUEA:= Value;
end;

procedure TFormaPagamento.setFFPT_CODIGO(Value: Integer);
begin
  FFPT_CODIGO:= Value;
end;

procedure TFormaPagamento.setFFPT_CODPLC_C(Value: Integer);
begin
  FFPT_CODPLC_C:= Value;
end;

procedure TFormaPagamento.setFFPT_CODPLC_D(Value: Integer);
begin
  FFPT_CODPLC_D:= Value;
end;

procedure TFormaPagamento.setFFPT_DESCRICAO(Value: String);
begin
  FFPT_DESCRICAO:= Value;
end;

procedure TFormaPagamento.setFFPT_FINALIDADE(Value: String);
begin
  FFPT_FINALIDADE:= Value;
end;

procedure TFormaPagamento.setFFPT_LIMITE(Value: String);
begin
  FFPT_LIMITE:= Value;
end;

procedure TFormaPagamento.setFFPT_PARCELAS(Value: Integer);
begin
  FFPT_PARCELAS:= Value;
end;

procedure TFormaPagamento.setFFPT_TEF(const Value: String);
begin
  FFPT_TEF := Value;
end;

procedure TFormaPagamento.setFFPT_TIPO_NFCE(Value: String);
begin
  FFPT_TIPO_NFCE:= Value;
end;

end.
