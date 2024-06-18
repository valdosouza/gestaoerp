unit tblVehicleModel;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MODELO')]
  TVehicleModel = Class(TGenericEntity)
  private
    FMOD_CODMRC: Integer;
    FMOD_DESCRICAO: String;
    FMOD_CODIGO: Integer;
    FMOD_RENAVAM: String;
    procedure setFMOD_CODIGO(const Value: Integer);
    procedure setFMOD_CODMRC(const Value: Integer);
    procedure setFMOD_DESCRICAO(const Value: String);
    procedure setFMOD_RENAVAM(const Value: String);

  public

    [KeyField('MOD_CODIGO')]
    [FieldName('MOD_CODIGO')]
    property Codigo: Integer read FMOD_CODIGO write setFMOD_CODIGO;

    [FieldName('MOD_DESCRICAO')]
    property Descricao: String read FMOD_DESCRICAO write setFMOD_DESCRICAO;

    [FieldName('MOD_CODMRC')]
    property CodigoMarca: Integer read FMOD_CODMRC write setFMOD_CODMRC;

    [FieldName('MOD_RENAVAM')]
    property Renavam: String read FMOD_RENAVAM write setFMOD_RENAVAM;

  End;

implementation

{ TVehicleModel }

procedure TVehicleModel.setFMOD_CODIGO(const Value: Integer);
begin
  FMOD_CODIGO := Value;
end;

procedure TVehicleModel.setFMOD_CODMRC(const Value: Integer);
begin
  FMOD_CODMRC := Value;
end;

procedure TVehicleModel.setFMOD_DESCRICAO(const Value: String);
begin
  FMOD_DESCRICAO := Value;
end;

procedure TVehicleModel.setFMOD_RENAVAM(const Value: String);
begin
  FMOD_RENAVAM := Value;
end;

end.
