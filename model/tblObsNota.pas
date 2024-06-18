unit tblObsNota;


interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_OBS_NFE')]
  TObsNota = Class(TGenericEntity)
  private
    FOBN_CODITF: Integer;
    FOBN_DETALHE: String;
    FOBN_CODIGO: Integer;
    FOBN_CODNFL: Integer;
    FOBN_TIPO: String;
    procedure setFOBN_CODIGO(const Value: Integer);
    procedure setFOBN_CODITF(const Value: Integer);
    procedure setFOBN_CODNFL(const Value: Integer);
    procedure setFOBN_DETALHE(const Value: String);
    procedure setFOBN_TIPO(const Value: String);

  public
    [KeyField('OBN_CODIGO')]
    [FieldName('OBN_CODIGO')]
    property Codigo: Integer read FOBN_CODIGO write setFOBN_CODIGO;

    [FieldName('OBN_CODITF')]
    property ItemNota: Integer read FOBN_CODITF write setFOBN_CODITF;

    [FieldName('OBN_CODNFL')]
    property Nota: Integer read FOBN_CODNFL write setFOBN_CODNFL;

    [FieldName('OBN_TIPO')]
    property Tipo: String read FOBN_TIPO write setFOBN_TIPO;

    [FieldName('OBN_DETALHE')]
    property Conteudo: String read FOBN_DETALHE write setFOBN_DETALHE;


  End;

implementation


{ TObsNota }

procedure TObsNota.setFOBN_CODIGO(const Value: Integer);
begin
  FOBN_CODIGO := Value;
end;

procedure TObsNota.setFOBN_CODITF(const Value: Integer);
begin
  FOBN_CODITF := Value;
end;

procedure TObsNota.setFOBN_CODNFL(const Value: Integer);
begin
  FOBN_CODNFL := Value;
end;

procedure TObsNota.setFOBN_DETALHE(const Value: String);
begin
  FOBN_DETALHE := Value;
end;

procedure TObsNota.setFOBN_TIPO(const Value: String);
begin
  FOBN_TIPO := Value;
end;

end.
