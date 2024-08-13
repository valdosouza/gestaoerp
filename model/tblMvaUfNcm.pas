unit tblMvaUfNcm;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MVA_UF_NCM')]
  TMvaUfNcm = Class(TGenericEntity)
  private
    FMUN_MVA_AJUSTADO: real;
    FMUN_MR_VL_AGREGADO: real;
    FMUN_CODIGONCM: String;
    FMUN_CODUFE: Integer;
    FMUN_CODMHA: integer;
    FMUN_ALIQ_INTERNA: real;
    procedure setFMUN_ALIQ_INTERNA(const Value: real);
    procedure setFMUN_CODIGONCM(const Value: String);
    procedure setFMUN_CODMHA(const Value: integer);
    procedure setFMUN_CODUFE(const Value: Integer);
    procedure setFMUN_MR_VL_AGREGADO(const Value: real);
    procedure setFMUN_MVA_AJUSTADO(const Value: real);

  public

    [KeyField('MUN_CODUFE')]
    [FieldName('MUN_CODUFE')]
    property CodigoUf: Integer read FMUN_CODUFE write setFMUN_CODUFE;

    [KeyField('MUN_CODIGONCM')]
    [FieldName('MUN_CODIGONCM')]
    property NCM: String  read FMUN_CODIGONCM write setFMUN_CODIGONCM;

    [KeyField('MUN_CODMHA')]
    [FieldName('MUN_CODMHA')]
    property Estabelecimento: integer  read FMUN_CODMHA write setFMUN_CODMHA;

    [FieldName('MUN_MR_VL_AGREGADO')]
    property MVA: real read FMUN_MR_VL_AGREGADO write setFMUN_MR_VL_AGREGADO;

    [FieldName('MUN_ALIQ_INTERNA')]
    property AliqInterna: real  read FMUN_ALIQ_INTERNA write setFMUN_ALIQ_INTERNA;

    [FieldName('MUN_MVA_AJUSTADO')]
    property MvaAjustado: real read FMUN_MVA_AJUSTADO write setFMUN_MVA_AJUSTADO;

  End;

implementation

{ TMvaUfNcm }

procedure TMvaUfNcm.setFMUN_ALIQ_INTERNA(const Value: real);
begin
  FMUN_ALIQ_INTERNA := Value;
end;

procedure TMvaUfNcm.setFMUN_CODIGONCM(const Value: String);
begin
  FMUN_CODIGONCM := Value;
end;

procedure TMvaUfNcm.setFMUN_CODMHA(const Value: integer);
begin
  FMUN_CODMHA := Value;
end;

procedure TMvaUfNcm.setFMUN_CODUFE(const Value: Integer);
begin
  FMUN_CODUFE := Value;
end;

procedure TMvaUfNcm.setFMUN_MR_VL_AGREGADO(const Value: real);
begin
  FMUN_MR_VL_AGREGADO := Value;
end;

procedure TMvaUfNcm.setFMUN_MVA_AJUSTADO(const Value: real);
begin
  FMUN_MVA_AJUSTADO := Value;
end;

end.
