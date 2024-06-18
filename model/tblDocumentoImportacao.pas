unit tblDocumentoImportacao;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_DEC_IMP')]
  TDocumentoImportacao = Class(TGenericEntity)
  private
    FDIM_CODUFE: Integer;
    FDIM_CODIGO: Integer;
    FDIM_DIV: String;
    FDIM_CODEXP: String;
    FDIM_NUMERO: String;
    FDIM_DT_DESEMB: TDate;
    FDIM_LOCAL_DESEMB: String;
    FDIM_DATA: TDate;
    FDIM_CODITF: Integer;

    procedure setFDIM_CODIGO(Value : Integer);
    procedure setFDIM_CODITF(Value : Integer);
    procedure setFDIM_NUMERO(Value : String);
    procedure setFDIM_DATA(Value : TDate);
    procedure setFDIM_LOCAL_DESEMB(Value : String);
    procedure setFDIM_CODUFE(Value : Integer);
    procedure setFDIM_DT_DESEMB(Value : TDate);
    procedure setFDIM_CODEXP(Value : String);
    procedure setFDIM_DIV(Value : String);

  public

    [KeyField('DIM_CODIGO')]
    [FieldName('DIM_CODIGO')]
    property Codigo: Integer read FDIM_CODIGO write setFDIM_CODIGO;

    [FieldName('DIM_CODITF')]
    property CodigoItem: Integer read FDIM_CODITF write setFDIM_CODITF;

    [FieldName('DIM_NUMERO')]
    property Numero: String read FDIM_NUMERO write setFDIM_NUMERO;

    [FieldName('DIM_DATA')]
    property Data: TDate read FDIM_DATA write setFDIM_DATA;

    [FieldName('DIM_LOCAL_DESEMB')]
    property LocalDesembarque: String read FDIM_LOCAL_DESEMB write setFDIM_LOCAL_DESEMB;

    [FieldName('DIM_CODUFE')]
    property CodigoEstado: Integer read FDIM_CODUFE write setFDIM_CODUFE;

    [FieldName('DIM_DT_DESEMB')]
    property DataDesembarque: TDate read FDIM_DT_DESEMB write setFDIM_DT_DESEMB;

    [FieldName('DIM_CODEXP')]
    property CodigoExportador: String read FDIM_CODEXP write setFDIM_CODEXP;

    [FieldName('DIM_DIV')]
    property DigitoDocumento: String read FDIM_DIV write setFDIM_DIV;


  End;

implementation


{ TDocumentoImportacao }

procedure TDocumentoImportacao.setFDIM_CODEXP(Value: String);
begin
  FDIM_CODEXP := Value;
end;

procedure TDocumentoImportacao.setFDIM_CODIGO(Value: Integer);
begin
  FDIM_CODIGO := Value;
end;

procedure TDocumentoImportacao.setFDIM_CODITF(Value: Integer);
begin
  FDIM_CODITF := Value;
end;

procedure TDocumentoImportacao.setFDIM_CODUFE(Value: Integer);
begin
  FDIM_CODUFE := Value;
end;

procedure TDocumentoImportacao.setFDIM_DATA(Value: TDate);
begin
  FDIM_DATA := Value;
end;

procedure TDocumentoImportacao.setFDIM_DIV(Value: String);
begin
  FDIM_DIV := Value;
end;

procedure TDocumentoImportacao.setFDIM_DT_DESEMB(Value: TDate);
begin
  FDIM_DT_DESEMB := Value;
end;

procedure TDocumentoImportacao.setFDIM_LOCAL_DESEMB(Value: String);
begin
  FDIM_LOCAL_DESEMB := Value;
end;

procedure TDocumentoImportacao.setFDIM_NUMERO(Value: String);
begin
  FDIM_NUMERO := Value;
end;

end.
