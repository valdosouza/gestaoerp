unit tblMdfeTotalizer;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_TOTALIZER')]
  TMdfeTotalizer = Class(TGenericEntity)

    private
    FWEIGHT_GROSS: Real;
    FTB_QT_A1A: Integer;
    FTB_MEASURE_ID: Integer;
    FTB_QT_CTE: Integer;
    FTB_MDFE_ID: Integer;
    FTOTAL_VALUE_LOAD: Real;
    FTB_QT_NFE: Integer;
    FTB_INSTITUTION_ID: Integer;
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_MEASURE_ID(const Value: Integer);
    procedure setFTB_QT_A1A(const Value: Integer);
    procedure setFTB_QT_CTE(const Value: Integer);
    procedure setFTB_QT_NFE(const Value: Integer);
    procedure setFTOTAL_VALUE_LOAD(const Value: Real);
    procedure setFWEIGHT_GROSS(const Value: Real);


    public

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('QT_CTE')]
    property QuantidadeCte: Integer read FTB_QT_CTE write setFTB_QT_CTE;

    [FieldName('QT_NFE')]
    property QuantidadeNfe: Integer read FTB_QT_NFE write setFTB_QT_NFE;

    [FieldName('QT_A1A')]
    property QuantidadeA1a: Integer read FTB_QT_A1A write setFTB_QT_A1A;

    [FieldName('TOTAL_VALUE_LOAD')]
    property ValorTotalCarga: Real read FTOTAL_VALUE_LOAD write setFTOTAL_VALUE_LOAD;

    [FieldName('TB_MEASURE_ID')]
    property MedidaId: Integer read FTB_MEASURE_ID write setFTB_MEASURE_ID;

    [FieldName('WEIGHT_GROSS')]
    property PesoBruto: Real read FWEIGHT_GROSS write setFWEIGHT_GROSS;

End;

implementation

{ TMdfeTotalizer }

procedure TMdfeTotalizer.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeTotalizer.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeTotalizer.setFTB_MEASURE_ID(const Value: Integer);
begin
  FTB_MEASURE_ID := Value;
end;

procedure TMdfeTotalizer.setFTB_QT_A1A(const Value: Integer);
begin
  FTB_QT_A1A := Value;
end;

procedure TMdfeTotalizer.setFTB_QT_CTE(const Value: Integer);
begin
  FTB_QT_CTE := Value;
end;

procedure TMdfeTotalizer.setFTB_QT_NFE(const Value: Integer);
begin
  FTB_QT_NFE := Value;
end;

procedure TMdfeTotalizer.setFTOTAL_VALUE_LOAD(const Value: Real);
begin
  FTOTAL_VALUE_LOAD := Value;
end;

procedure TMdfeTotalizer.setFWEIGHT_GROSS(const Value: Real);
begin
  FWEIGHT_GROSS := Value;
end;

end.
