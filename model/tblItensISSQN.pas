unit tblItensISSQN;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_ISSQN')]
  TItensISSQN = Class(TGenericEntity)
  private
    FISS_CODITF: Integer;
    FISS_MUN_IBGE: Integer;
    FISS_VL_NR: Real;
    FISS_CODIGO: Integer;
    FISS_CODNFL: Integer;
    FISS_AQ_NR: Real;
    FISS_VL_PIS: Real;
    FISS_LST_SRV: String;
    FISS_VL_CFS: Real;
    FISS_VL_RET: Real;
    FISS_SIT_TRIB: String;
    FISS_VL_BC: Real;
    procedure setFISS_AQ_NR(const Value: Real);
    procedure setFISS_CODIGO(const Value: Integer);
    procedure setFISS_CODITF(const Value: Integer);
    procedure setFISS_CODNFL(const Value: Integer);
    procedure setFISS_LST_SRV(const Value: String);
    procedure setFISS_MUN_IBGE(const Value: Integer);
    procedure setFISS_SIT_TRIB(const Value: String);
    procedure setFISS_VL_BC(const Value: Real);
    procedure setFISS_VL_CFS(const Value: Real);
    procedure setFISS_VL_NR(const Value: Real);
    procedure setFISS_VL_PIS(const Value: Real);
    procedure setFISS_VL_RET(const Value: Real);

  public
    [KeyField('ISS_CODIGO')]
    [FieldName('ISS_CODIGO')]
     property Codigo: Integer read FISS_CODIGO write setFISS_CODIGO;

    [FieldName('ISS_CODNFL')]
     property nota : Integer read FISS_CODNFL write setFISS_CODNFL;

    [FieldName('ISS_CODITF')]
    property ITemNota: Integer read FISS_CODITF write setFISS_CODITF;

    [FieldName('ISS_VL_BC')]
    property VAlorBase: Real read FISS_VL_BC write setFISS_VL_BC;

    [FieldName('ISS_AQ_NR')]
    property Aliquota: Real read FISS_AQ_NR write setFISS_AQ_NR;

    [FieldName('ISS_VL_NR')]
    property Valor: Real read FISS_VL_NR write setFISS_VL_NR;

    [FieldName('ISS_MUN_IBGE')]
    property IBGE: Integer read FISS_MUN_IBGE write setFISS_MUN_IBGE;

    [FieldName('ISS_LST_SRV')]
    property ListaLLC: String read FISS_LST_SRV write setFISS_LST_SRV;

    [FieldName('ISS_SIT_TRIB')]
    property SituacaoTributaria: String read FISS_SIT_TRIB write setFISS_SIT_TRIB;

    [FieldName('ISS_VL_PIS')]
    property ValorPIS: Real read FISS_VL_PIS write setFISS_VL_PIS;

    [FieldName('ISS_VL_CFS')]
    property ValorCofins: Real read FISS_VL_CFS write setFISS_VL_CFS;

    [FieldName('ISS_VL_RET')]
    property VAlorREtido: Real read FISS_VL_RET write setFISS_VL_RET;


	End;

implementation

{ TItensISSQN }

procedure TItensISSQN.setFISS_AQ_NR(const Value: Real);
begin
  FISS_AQ_NR := Value;
end;

procedure TItensISSQN.setFISS_CODIGO(const Value: Integer);
begin
  FISS_CODIGO := Value;
end;

procedure TItensISSQN.setFISS_CODITF(const Value: Integer);
begin
  FISS_CODITF := Value;
end;

procedure TItensISSQN.setFISS_CODNFL(const Value: Integer);
begin
  FISS_CODNFL := Value;
end;

procedure TItensISSQN.setFISS_LST_SRV(const Value: String);
begin
  FISS_LST_SRV := Value;
end;

procedure TItensISSQN.setFISS_MUN_IBGE(const Value: Integer);
begin
  FISS_MUN_IBGE := Value;
end;

procedure TItensISSQN.setFISS_SIT_TRIB(const Value: String);
begin
  FISS_SIT_TRIB := Value;
end;

procedure TItensISSQN.setFISS_VL_BC(const Value: Real);
begin
  FISS_VL_BC := Value;
end;

procedure TItensISSQN.setFISS_VL_CFS(const Value: Real);
begin
  FISS_VL_CFS := Value;
end;

procedure TItensISSQN.setFISS_VL_NR(const Value: Real);
begin
  FISS_VL_NR := Value;
end;

procedure TItensISSQN.setFISS_VL_PIS(const Value: Real);
begin
  FISS_VL_PIS := Value;
end;

procedure TItensISSQN.setFISS_VL_RET(const Value: Real);
begin
  FISS_VL_RET := Value;
end;

END.
