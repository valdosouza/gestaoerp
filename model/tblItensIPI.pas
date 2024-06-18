unit tblItensIPI;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_IPI')]
  TItensIPI = Class(TGenericEntity)
  private
    FIPI_QT_SELO: Real;
    FIPI_CODITF: Integer;
    FIPI_QT_UNID: Real;
    FIPI_CODIGO: Integer;
    FIPI_CL_ENQD: String;
    FIPI_AQ_NR: Real;
    FIPI_CD_ENQD: String;
    FIPI_VL_UNID: Real;
    FIPI_CD_SELO: String;
    FIPI_CNPJ_PROD: String;
    FIPI_VL_BC: Real;
    FIPI_CODTBI: Integer;
    FIPI_CODNFL: Integer;
    procedure setFIPI_AQ_NR(const Value: Real);
    procedure setFIPI_CD_ENQD(const Value: String);
    procedure setFIPI_CD_SELO(const Value: String);
    procedure setFIPI_CL_ENQD(const Value: String);
    procedure setFIPI_CNPJ_PROD(const Value: String);
    procedure setFIPI_CODIGO(const Value: Integer);
    procedure setFIPI_CODITF(const Value: Integer);
    procedure setFIPI_CODTBI(const Value: Integer);
    procedure setFIPI_QT_SELO(const Value: Real);
    procedure setFIPI_QT_UNID(const Value: Real);
    procedure setFIPI_VL_BC(const Value: Real);
    procedure setFIPI_VL_UNID(const Value: Real);
    procedure setFIPI_CODNFL(const Value: Integer);

  public
    [KeyField('IPI_CODIGO')]
    [FieldName('IPI_CODIGO')]
    property Codigo: Integer read FIPI_CODIGO write setFIPI_CODIGO;

    [FieldName('IPI_CODNFL')]
    property Nota: Integer read FIPI_CODNFL write setFIPI_CODNFL;

    [FieldName('IPI_CODITF')]
    property ItemNota: Integer read FIPI_CODITF write setFIPI_CODITF;

    [FieldName('IPI_CODTBI')]
    property CST: Integer read FIPI_CODTBI write setFIPI_CODTBI;

    [FieldName('IPI_CL_ENQD')]
    property ClassEnqu: String read FIPI_CL_ENQD write setFIPI_CL_ENQD;

    [FieldName('IPI_CNPJ_PROD')]
    property CNPJProdutor: String read FIPI_CNPJ_PROD write setFIPI_CNPJ_PROD;

    [FieldName('IPI_CD_SELO')]
    property CodigoSelo: String read FIPI_CD_SELO write setFIPI_CD_SELO;

    [FieldName('IPI_QT_SELO')]
    property QtdeSelo: Real read FIPI_QT_SELO write setFIPI_QT_SELO;

    [FieldName('IPI_CD_ENQD')]
    property CodigoEnqu: String read FIPI_CD_ENQD write setFIPI_CD_ENQD;

    [FieldName('IPI_VL_BC')]
    property ValorBase: Real read FIPI_VL_BC write setFIPI_VL_BC;

    [FieldName('IPI_AQ_NR')]
    property Aliquota: Real read FIPI_AQ_NR write setFIPI_AQ_NR;

    [FieldName('IPI_QT_UNID')]
    property QtdeUnid: Real read FIPI_QT_UNID write setFIPI_QT_UNID;

    [FieldName('IPI_VL_UNID')]
    property ValorUnid: Real read FIPI_VL_UNID write setFIPI_VL_UNID;

	End;

implementation
{ TItensIPI }

procedure TItensIPI.setFIPI_AQ_NR(const Value: Real);
begin
  FIPI_AQ_NR := Value;
end;

procedure TItensIPI.setFIPI_CD_ENQD(const Value: String);
begin
  FIPI_CD_ENQD := Value;
end;

procedure TItensIPI.setFIPI_CD_SELO(const Value: String);
begin
  FIPI_CD_SELO := Value;
end;

procedure TItensIPI.setFIPI_CL_ENQD(const Value: String);
begin
  FIPI_CL_ENQD := Value;
end;

procedure TItensIPI.setFIPI_CNPJ_PROD(const Value: String);
begin
  FIPI_CNPJ_PROD := Value;
end;

procedure TItensIPI.setFIPI_CODIGO(const Value: Integer);
begin
  FIPI_CODIGO := Value;
end;

procedure TItensIPI.setFIPI_CODITF(const Value: Integer);
begin
  FIPI_CODITF := Value;
end;

procedure TItensIPI.setFIPI_CODNFL(const Value: Integer);
begin
  FIPI_CODNFL := Value;
end;

procedure TItensIPI.setFIPI_CODTBI(const Value: Integer);
begin
  FIPI_CODTBI := Value;
end;

procedure TItensIPI.setFIPI_QT_SELO(const Value: Real);
begin
  FIPI_QT_SELO := Value;
end;

procedure TItensIPI.setFIPI_QT_UNID(const Value: Real);
begin
  FIPI_QT_UNID := Value;
end;

procedure TItensIPI.setFIPI_VL_BC(const Value: Real);
begin
  FIPI_VL_BC := Value;
end;

procedure TItensIPI.setFIPI_VL_UNID(const Value: Real);
begin
  FIPI_VL_UNID := Value;
end;

end.

