unit tblNcmControle;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_NCM_CONTROLE')]
  TNcmControle = Class(TGenericEntity)
  private
    FNCM_VERSAO: String;
    FNCM_DT_INI: TDate;
    FNCM_CHAVE: String;
    FNCM_DT_FIM: TDate;
    procedure setFNCM_CHAVE(const Value: String);
    procedure setFNCM_DT_FIM(const Value: TDate);
    procedure setFNCM_DT_INI(const Value: TDate);
    procedure setFNCM_VERSAO(const Value: String);

  public

    [KeyField('NCM_CHAVE')]
    [FieldName('NCM_CHAVE')]
    property Chave: String read FNCM_CHAVE write setFNCM_CHAVE;

    [KeyField('NCM_VERSAO')]
    [FieldName('NCM_VERSAO')]
    property Versao: String read FNCM_VERSAO write setFNCM_VERSAO;

    [FieldName('NCM_DT_INI')]
    property DataInicio: TDate read FNCM_DT_INI write setFNCM_DT_INI;

    [FieldName('NCM_DT_FIM')]
    property dataFinal: TDate read FNCM_DT_FIM write setFNCM_DT_FIM;

  End;

implementation

{ TNcmControle }

procedure TNcmControle.setFNCM_CHAVE(const Value: String);
begin
  FNCM_CHAVE := Value;
end;

procedure TNcmControle.setFNCM_DT_FIM(const Value: TDate);
begin
  FNCM_DT_FIM := Value;
end;

procedure TNcmControle.setFNCM_DT_INI(const Value: TDate);
begin
  FNCM_DT_INI := Value;
end;

procedure TNcmControle.setFNCM_VERSAO(const Value: String);
begin
  FNCM_VERSAO := Value;
end;

end.
