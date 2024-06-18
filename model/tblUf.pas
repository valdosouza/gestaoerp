unit tblUf;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_UF')]
  TUf = Class(TGenericEntity)
  private
    FUFE_ALIQ_INTERNA: real;
    FUFE_DESCRICAO: string;
    FUFE_CODIGO: integer;
    FUFE_NUMINSC_SUBS: string;
    FUFE_TX_FCP: real;
    FUFE_MR_VL_AGREGADO: real;
    FUFE_CEP: string;
    FUFE_SIGLA: string;
    FUFE_ALIQ_INT_EST: real;
    procedure setFUFE_ALIQ_INTERNA(const Value: real);
    procedure setFUFE_CEP(const Value: string);
    procedure setFUFE_CODIGO(const Value: integer);
    procedure setFUFE_DESCRICAO(const Value: string);
    procedure setFUFE_MR_VL_AGREGADO(const Value: real);
    procedure setFUFE_NUMINSC_SUBS(const Value: string);
    procedure setFUFE_SIGLA(const Value: string);
    procedure setFUFE_TX_FCP(const Value: real);
    procedure setFUFE_ALIQ_INT_EST(const Value: real);


  public

    [KeyField('UFE_CODIGO')]
    [FieldName('UFE_CODIGO')]
    property Codigo: integer read FUFE_CODIGO write setFUFE_CODIGO;

    [FieldName('UFE_SIGLA')]
    property Sigla: string read FUFE_SIGLA write setFUFE_SIGLA;

    [FieldName('UFE_ALIQ_INTERNA')]
    property AliquotaInterna: real read FUFE_ALIQ_INTERNA write setFUFE_ALIQ_INTERNA;

    [FieldName('UFE_DESCRICAO')]
    property Descricao: string read FUFE_DESCRICAO write setFUFE_DESCRICAO;

    [FieldName('UFE_MR_VL_AGREGADO')]
    property MargemValorAgregado: real read FUFE_MR_VL_AGREGADO write setFUFE_MR_VL_AGREGADO;

    [FieldName('UFE_CEP')]
    property CEP: string read FUFE_CEP write setFUFE_CEP;

    [FieldName('UFE_NUMINSC_SUBS')]
    property IncricaoSubstituto: string read FUFE_NUMINSC_SUBS write setFUFE_NUMINSC_SUBS;

    [FieldName('UFE_ALIQ_INT_EST')]
    property AliquotaInterEstadual: real read FUFE_ALIQ_INT_EST write setFUFE_ALIQ_INT_EST;

    [FieldName('UFE_TX_FCP')]
    property TaxaFCP: real read FUFE_TX_FCP write setFUFE_TX_FCP;

  End;

implementation



{ TUf }

procedure TUf.setFUFE_ALIQ_INTERNA(const Value: real);
begin
  FUFE_ALIQ_INTERNA := Value;
end;

procedure TUf.setFUFE_ALIQ_INT_EST(const Value: real);
begin
  FUFE_ALIQ_INT_EST := Value;
end;

procedure TUf.setFUFE_CEP(const Value: string);
begin
  FUFE_CEP := Value;
end;

procedure TUf.setFUFE_CODIGO(const Value: integer);
begin
  FUFE_CODIGO := Value;
end;

procedure TUf.setFUFE_DESCRICAO(const Value: string);
begin
  FUFE_DESCRICAO := Value;
end;

procedure TUf.setFUFE_MR_VL_AGREGADO(const Value: real);
begin
  FUFE_MR_VL_AGREGADO := Value;
end;

procedure TUf.setFUFE_NUMINSC_SUBS(const Value: string);
begin
  FUFE_NUMINSC_SUBS := Value;
end;

procedure TUf.setFUFE_SIGLA(const Value: string);
begin
  FUFE_SIGLA := Value;
end;

procedure TUf.setFUFE_TX_FCP(const Value: real);
begin
  FUFE_TX_FCP := Value;
end;

end.
