unit tblItenspis;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_PIS')]
  TItensPIS = Class(TGenericEntity)
  private
    FPIS_CODITF: Integer;
    FPIS_VL_NR: Real;
    FPIS_CODIGO: Integer;
    FPIS_CODNFL: Integer;
    FPIS_AQ_NR: Real;
    FPIS_QT_VDA: Real;
    FPIS_VL_AQ: Real;
    FPIS_VL_BC: Real;
    FPIS_CODTBP: Integer;
    procedure setFPIS_AQ_NR(const Value: Real);
    procedure setFPIS_CODIGO(const Value: Integer);
    procedure setFPIS_CODITF(const Value: Integer);
    procedure setFPIS_CODNFL(const Value: Integer);
    procedure setFPIS_CODTBP(const Value: Integer);
    procedure setFPIS_QT_VDA(const Value: Real);
    procedure setFPIS_VL_AQ(const Value: Real);
    procedure setFPIS_VL_BC(const Value: Real);
    procedure setFPIS_VL_NR(const Value: Real);



  public

    [KeyField('PIS_CODIGO')]
    [FieldName('PIS_CODIGO')]
    property Codigo: Integer read FPIS_CODIGO write setFPIS_CODIGO;


    [FieldName('PIS_CODNFL')]
    property Nota : Integer read FPIS_CODNFL write setFPIS_CODNFL;

    [FieldName('PIS_CODITF')]
    property ItemNota:Integer read FPIS_CODITF write setFPIS_CODITF;

    [FieldName('PIS_CODTBP')]
    property CST : Integer read FPIS_CODTBP write setFPIS_CODTBP;

    [FieldName('PIS_VL_BC')]
    property ValorBase : Real read FPIS_VL_BC write setFPIS_VL_BC;

    [FieldName('PIS_AQ_NR')]
    property Aliquota : Real read FPIS_AQ_NR write setFPIS_AQ_NR;

    [FieldName('PIS_VL_NR')]
    property Valor : Real read FPIS_VL_NR write setFPIS_VL_NR;

    [FieldName('PIS_QT_VDA')]
    property QtdeVenda : Real read FPIS_QT_VDA write setFPIS_QT_VDA;

    [FieldName('PIS_VL_AQ')]
    property ValorAliquota : Real read FPIS_VL_AQ write setFPIS_VL_AQ;

  End;

implementation

{ TItensPIS }

procedure TItensPIS.setFPIS_AQ_NR(const Value: Real);
begin
  FPIS_AQ_NR := Value;
end;

procedure TItensPIS.setFPIS_CODIGO(const Value: Integer);
begin
  FPIS_CODIGO := Value;
end;

procedure TItensPIS.setFPIS_CODITF(const Value: Integer);
begin
  FPIS_CODITF := Value;
end;

procedure TItensPIS.setFPIS_CODNFL(const Value: Integer);
begin
  FPIS_CODNFL := Value;
end;

procedure TItensPIS.setFPIS_CODTBP(const Value: Integer);
begin
  FPIS_CODTBP := Value;
end;

procedure TItensPIS.setFPIS_QT_VDA(const Value: Real);
begin
  FPIS_QT_VDA := Value;
end;

procedure TItensPIS.setFPIS_VL_AQ(const Value: Real);
begin
  FPIS_VL_AQ := Value;
end;

procedure TItensPIS.setFPIS_VL_BC(const Value: Real);
begin
  FPIS_VL_BC := Value;
end;

procedure TItensPIS.setFPIS_VL_NR(const Value: Real);
begin
  FPIS_VL_NR := Value;
end;

end.
