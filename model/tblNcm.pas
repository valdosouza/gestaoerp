unit tblNcm;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_NCM')]
  TNCM = Class(TGenericEntity)
  private
    FNCM_EXC: String;
    FNCM_AQ_IMP: Real;
    FNCM_AQ_MUNICIPAL: Real;
    FNCM_DESCRICAO: String;
    FNCM_TABELA: String;
    FNCM_N_NCM: String;
    FNCM_AQ_ESTADUAL: Real;
    FNCM_AQ_NAC: real;
    procedure setFNCM_AQ_ESTADUAL(const Value: Real);
    procedure setFNCM_AQ_IMP(const Value: Real);
    procedure setFNCM_AQ_MUNICIPAL(const Value: Real);
    procedure setFNCM_AQ_NAC(const Value: real);
    procedure setFNCM_DESCRICAO(const Value: String);
    procedure setFNCM_EXC(const Value: String);
    procedure setFNCM_N_NCM(const Value: String);
    procedure setFNCM_TABELA(const Value: String);

  public

    [KeyField('NCM_N_NCM')]
    [FieldName('NCM_N_NCM')]
    property NCM: String read FNCM_N_NCM write setFNCM_N_NCM;

    [FieldName('NCM_DESCRICAO')]
    property Descricao: String read FNCM_DESCRICAO write setFNCM_DESCRICAO;

    [FieldName('NCM_EXC')]
    property Excecao: String read FNCM_EXC write setFNCM_EXC;

    [FieldName('NCM_TABELA')]
    property Tabela: String read FNCM_TABELA write setFNCM_TABELA;

    [FieldName('NCM_AQ_NAC')]
    property AliqNacional: real read FNCM_AQ_NAC write setFNCM_AQ_NAC;

    [FieldName('NCM_AQ_IMP')]
    property AliqImport: Real read FNCM_AQ_IMP write setFNCM_AQ_IMP;

    [FieldName('NCM_AQ_ESTADUAL')]
    property AliqEstadual: Real read FNCM_AQ_ESTADUAL write setFNCM_AQ_ESTADUAL;

    [FieldName('NCM_AQ_MUNICIPAL')]
    property AliqMunicipal: Real read FNCM_AQ_MUNICIPAL write setFNCM_AQ_MUNICIPAL;


  End;


implementation

{ TNCM }

procedure TNCM.setFNCM_AQ_ESTADUAL(const Value: Real);
begin
  FNCM_AQ_ESTADUAL := Value;
end;

procedure TNCM.setFNCM_AQ_IMP(const Value: Real);
begin
  FNCM_AQ_IMP := Value;
end;

procedure TNCM.setFNCM_AQ_MUNICIPAL(const Value: Real);
begin
  FNCM_AQ_MUNICIPAL := Value;
end;

procedure TNCM.setFNCM_AQ_NAC(const Value: real);
begin
  FNCM_AQ_NAC := Value;
end;

procedure TNCM.setFNCM_DESCRICAO(const Value: String);
begin
  FNCM_DESCRICAO := Value;
end;

procedure TNCM.setFNCM_EXC(const Value: String);
begin
  FNCM_EXC := Value;
end;

procedure TNCM.setFNCM_N_NCM(const Value: String);
begin
  FNCM_N_NCM := Value;
end;

procedure TNCM.setFNCM_TABELA(const Value: String);
begin
  FNCM_TABELA := Value;
end;

end.
