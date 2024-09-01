unit tblPerfilUsuario;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_PERFIL_USUARIO')]

  TPerfilUsuario = Class(TGenericEntity)
  private
    FPFL_DESCRICAO: String;
    FPFL_CODIGO: Integer;
    FPFL_CODMHA: integer;
    procedure setFPFL_CODIGO(const Value: Integer);
    procedure setFPFL_DESCRICAO(const Value: String);
    procedure setFPFL_CODMHA(const Value: integer);
  public
    [KeyField('PFL_CODIGO')]
    [FieldName('PFL_CODIGO')]
    property Codigo: Integer read FPFL_CODIGO write setFPFL_CODIGO;

    [KeyField('PFL_CODMHA')]
    [FieldName('PFL_CODMHA')]
    property CodMha: integer read FPFL_CODMHA write setFPFL_CODMHA;

    [FieldName('PFL_DESCRICAO')]
    property Descricao: String read FPFL_DESCRICAO write setFPFL_DESCRICAO;
  End;
{CREATE TABLE TB_PERFIL_USUARIO (
    PFL_CODIGO     "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    PFL_CODMHA     "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    PFL_DESCRICAO  "Descricao_30" /* "Descricao_30" = VARCHAR(30) */
);
/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/
ALTER TABLE TB_PERFIL_USUARIO ADD PRIMARY KEY (PFL_CODIGO, PFL_CODMHA);}

implementation

{ TPerfilUsuario }

procedure TPerfilUsuario.setFPFL_CODIGO(const Value: Integer);
begin
  FPFL_CODIGO := Value;
end;

procedure TPerfilUsuario.setFPFL_CODMHA(const Value: integer);
begin
  FPFL_CODMHA := Value;
end;

procedure TPerfilUsuario.setFPFL_DESCRICAO(const Value: String);
begin
  FPFL_DESCRICAO := Value;
end;

end.
