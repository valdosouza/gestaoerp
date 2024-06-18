unit tblCartaoEletronico;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CARTAOELETRONICO')]
  TCartaoEletronico = Class(TGenericEntity)

  private
    Fcte_Codigo: Integer;
    Fcte_descricao: String;
    Fcte_tipo: String;
    Fcte_aliq_cred: Real;
    Fcte_przo_cred: Integer;
    Fcte_aliq_debi : Real;
    Fcte_przo_debi: Integer;
    Fcte_contato: String;
    Fcte_fone: String;
    Fcte_validade: TDateTime;
    Fcte_codctb: Integer;
    Fcte_codfpt: Integer;
    Fcte_codplc_d: Integer;
    Fcte_codplc_c: Integer;
    procedure setFcte_aliq_cred(const Value: Real);
    procedure setFcte_aliq_debi(const Value: Real);
    procedure setFcte_codctb(const Value: Integer);
    procedure setFcte_codfpt(const Value: Integer);
    procedure setFcte_codigo(const Value: Integer);
    procedure setFcte_codplc_c(const Value: Integer);
    procedure setFcte_codplc_d(const Value: Integer);
    procedure setFcte_contato(const Value: String);
    procedure setFcte_descricao(const Value: String);
    procedure setFcte_fone(const Value: String);
    procedure setFcte_przo_cred(const Value: Integer);
    procedure setFcte_przo_debi(const Value: Integer);
    procedure setFcte_tipo(const Value: String);
    procedure setFcte_validade(const Value: TDateTime);


  public

    [FieldName('cte_codigo')]
    [KeyField('cte_codigo')]
    property Codigo: Integer read Fcte_codigo write setFcte_codigo;

    [FieldName('cte_descricao')]
    property Descricao: String read Fcte_descricao write setFcte_descricao;

    [FieldName('cte_tipo')]
    property Tipo: String read Fcte_tipo write setFcte_tipo;

    [FieldName('cte_aliq_cred')]
    property AliqCredito: Real read Fcte_aliq_cred write setFcte_aliq_cred;

    [FieldName('cte_przo_cred')]
    property PrazoCredito: Integer read Fcte_przo_cred write setFcte_przo_cred;

    [FieldName('cte_aliq_debi')]
    property AliqDebito: Real read Fcte_aliq_debi write setFcte_aliq_debi;

    [FieldName('cte_przo_debi')]
    property PrazoDebito: Integer read Fcte_przo_debi write setFcte_przo_debi;

    [FieldName('cte_contato')]
    property Contato: String read Fcte_contato write setFcte_contato;

    [FieldName('cte_fone')]
    property Fone: String read Fcte_fone write setFcte_fone;

    [FieldName('cte_validade')]
    property Validade: TDateTime read Fcte_validade write setFcte_validade;

    [FieldName('cte_codctb')]
    property ContaCorrente: Integer read Fcte_codctb write setFcte_codctb;

    [FieldName('cte_codfpt')]
    property FormaPagamento: Integer read Fcte_codfpt write setFcte_codfpt;

    [FieldName('cte_codplc_d')]
    property PlanoDebito: Integer read Fcte_codplc_d write setFcte_codplc_d;

    [FieldName('cte_codplc_c')]
    property PlanoCredito: Integer read Fcte_codplc_c write setFcte_codplc_c;
  End;

  implementation
{ TCartaoEletronico }

procedure TCartaoEletronico.setFcte_aliq_cred(const Value: Real);
begin
  Fcte_aliq_cred := Value;
end;

procedure TCartaoEletronico.setFcte_aliq_debi(const Value: Real);
begin
  Fcte_aliq_debi := Value;
end;

procedure TCartaoEletronico.setFcte_codctb(const Value: Integer);
begin
  Fcte_codctb := Value;
end;

procedure TCartaoEletronico.setFcte_codfpt(const Value: Integer);
begin
  Fcte_codfpt := Value;
end;

procedure TCartaoEletronico.setFcte_codigo(const Value: Integer);
begin
  Fcte_codigo := Value;
end;

procedure TCartaoEletronico.setFcte_codplc_c(const Value: Integer);
begin
  Fcte_codplc_c := Value;
end;

procedure TCartaoEletronico.setFcte_codplc_d(const Value: Integer);
begin
  Fcte_codplc_d := Value;
end;

procedure TCartaoEletronico.setFcte_contato(const Value: String);
begin
  Fcte_contato := Value;
end;

procedure TCartaoEletronico.setFcte_descricao(const Value: String);
begin
  Fcte_descricao := Value;
end;

procedure TCartaoEletronico.setFcte_fone(const Value: String);
begin
  Fcte_fone := Value;
end;

procedure TCartaoEletronico.setFcte_przo_cred(const Value: Integer);
begin
  Fcte_przo_cred := Value;
end;

procedure TCartaoEletronico.setFcte_przo_debi(const Value: Integer);
begin
  Fcte_przo_debi := Value;
end;

procedure TCartaoEletronico.setFcte_tipo(const Value: String);
begin
  Fcte_tipo := Value;
end;

procedure TCartaoEletronico.setFcte_validade(const Value: TDateTime);
begin
  Fcte_validade := Value;
end;

end.
