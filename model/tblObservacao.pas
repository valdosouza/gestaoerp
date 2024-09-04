unit tblObservacao;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_OBSERVACAO')]

  TObservacao = Class(TGenericEntity)
  private
    FOBS_GERAL: String;
    FOBS_CODMHA: integer;
    FOBS_DESCRICAO: String;
    FOBS_CODIGO: Integer;
    FOBS_DETALHES: String;
    FOBS_DIFER: String;
    procedure setFOBS_CODIGO(const Value: Integer);
    procedure setFOBS_CODMHA(const Value: integer);
    procedure setFOBS_DESCRICAO(const Value: String);
    procedure setFOBS_DETALHES(const Value: String);
    procedure setFOBS_DIFER(const Value: String);
    procedure setFOBS_GERAL(const Value: String);
  public
    [KeyField('OBS_CODIGO')]
    [FieldName('OBS_CODIGO')]
    property Codigo: Integer read FOBS_CODIGO write setFOBS_CODIGO;

    [FieldName('OBS_DESCRICAO')]
    property Descricao: String read FOBS_DESCRICAO write setFOBS_DESCRICAO;

    [FieldName('OBS_DIFER')]
    property Difer: String read FOBS_DIFER write setFOBS_DIFER;//3

    [FieldName('OBS_DETALHES')]
    property Detalhes: String read FOBS_DETALHES write setFOBS_DETALHES; //memo

    [FieldName('OBS_GERAL')]
    property Geral: String read FOBS_GERAL write setFOBS_GERAL; //1

    [FieldName('OBS_CODMHA')]
    property CodMha: integer read FOBS_CODMHA write setFOBS_CODMHA;
  End;

implementation

{ TObservacao }

procedure TObservacao.setFOBS_CODIGO(const Value: Integer);
begin
  FOBS_CODIGO := Value;
end;

procedure TObservacao.setFOBS_CODMHA(const Value: integer);
begin
  FOBS_CODMHA := Value;
end;

procedure TObservacao.setFOBS_DESCRICAO(const Value: String);
begin
  FOBS_DESCRICAO := Value;
end;

procedure TObservacao.setFOBS_DETALHES(const Value: String);
begin
  FOBS_DETALHES := Value;
end;

procedure TObservacao.setFOBS_DIFER(const Value: String);
begin
  FOBS_DIFER := Value;
end;

procedure TObservacao.setFOBS_GERAL(const Value: String);
begin
  FOBS_GERAL := Value;
end;

end.
