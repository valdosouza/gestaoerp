unit tblItensRTR;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_RTR')]
  TItensRTR = Class(TGenericEntity)
  private
    FITR_OBS: String;
    FITR_DESCRICAO: String;
    FITR_VL_UNIT: Real;
    FITR_NR_ITEM: Integer;
    FITR_CORTESIA: String;
    FITR_QTDE: Real;
    FITR_CODITF: Integer;
    FITR_CODSBG: Integer;
    FITR_CODGRC: Integer;
    procedure setFITR_CODGRC(const Value: Integer);
    procedure setFITR_CODITF(const Value: Integer);
    procedure setFITR_CODSBG(const Value: Integer);
    procedure setFITR_CORTESIA(const Value: String);
    procedure setFITR_DESCRICAO(const Value: String);
    procedure setFITR_NR_ITEM(const Value: Integer);
    procedure setFITR_OBS(const Value: String);
    procedure setFITR_QTDE(const Value: Real);
    procedure setFITR_VL_UNIT(const Value: Real);

  public

    [KeyField('ITR_CODITF')]
    [FieldName('ITR_CODITF')]
    property Item: Integer  read FITR_CODITF write setFITR_CODITF;


    [FieldName('ITR_NR_ITEM')]
    property NrITem: Integer  read FITR_NR_ITEM write setFITR_NR_ITEM;


    [FieldName('ITR_DESCRICAO')]
    property Descricao: String  read FITR_DESCRICAO write setFITR_DESCRICAO;


    [FieldName('ITR_QTDE')]
    property Qtde:Real  read FITR_QTDE write setFITR_QTDE;


    [FieldName('ITR_VL_UNIT')]
    property ValorUnitario: Real  read FITR_VL_UNIT write setFITR_VL_UNIT;


    [FieldName('ITR_OBS')]
    property Observacao: String read FITR_OBS write setFITR_OBS;


    [FieldName('ITR_CODGRC')]
    property Garcon:Integer  read FITR_CODGRC write setFITR_CODGRC;


    [FieldName('ITR_CODSBG')]
    property SubGrupo: Integer  read FITR_CODSBG write setFITR_CODSBG;


    [FieldName('ITR_CORTESIA')]
    property Cortesia: String  read FITR_CORTESIA write setFITR_CORTESIA;


  End;

implementation

{ TItensRTR }

procedure TItensRTR.setFITR_CODGRC(const Value: Integer);
begin
  FITR_CODGRC := Value;
end;

procedure TItensRTR.setFITR_CODITF(const Value: Integer);
begin
  FITR_CODITF := Value;
end;

procedure TItensRTR.setFITR_CODSBG(const Value: Integer);
begin
  FITR_CODSBG := Value;
end;

procedure TItensRTR.setFITR_CORTESIA(const Value: String);
begin
  FITR_CORTESIA := Value;
end;

procedure TItensRTR.setFITR_DESCRICAO(const Value: String);
begin
  FITR_DESCRICAO := Value;
end;

procedure TItensRTR.setFITR_NR_ITEM(const Value: Integer);
begin
  FITR_NR_ITEM := Value;
end;

procedure TItensRTR.setFITR_OBS(const Value: String);
begin
  FITR_OBS := Value;
end;

procedure TItensRTR.setFITR_QTDE(const Value: Real);
begin
  FITR_QTDE := Value;
end;

procedure TItensRTR.setFITR_VL_UNIT(const Value: Real);
begin
  FITR_VL_UNIT := Value;
end;

end.
