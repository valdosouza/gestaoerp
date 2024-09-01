unit tblPermissao;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_PERMISSAO')]

  TPermissao = Class(TGenericEntity)
  private
    FPER_CODIIF: Integer;
    FPER_CODMHA: Integer;
    FPER_CODUSU: Integer;
    procedure setFPER_CODIIF(const Value: Integer);
    procedure setFPER_CODMHA(const Value: Integer);
    procedure setFPER_CODUSU(const Value: Integer);

  public
    [KeyField('PPF_CODPFL')]
    [FieldName('PPF_CODPFL')]
    property CodMha: Integer read FPER_CODMHA write setFPER_CODMHA;

    [KeyField('PER_CODUSU')]
    [FieldName('PER_CODUSU')]
    property CodUsu: Integer read FPER_CODUSU write setFPER_CODUSU;

    [KeyField('PER_CODIIF')]
    [FieldName('PER_CODIIF')]
    property CodIIF: Integer read FPER_CODIIF write setFPER_CODIIF;
  End;
{CREATE TABLE TB_PERMISSAO (
    PER_CODMHA  "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    PER_CODUSU  "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    PER_CODIIF  "Codigo" /* "Codigo" = INTEGER NOT NULL */
);
/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/
ALTER TABLE TB_PERMISSAO ADD PRIMARY KEY (PER_CODMHA, PER_CODUSU, PER_CODIIF);
/******************************************************************************/
/****                             Foreign keys                             ****/
/******************************************************************************/
ALTER TABLE TB_PERMISSAO ADD CONSTRAINT FK_TB_PERMISSAO_1 FOREIGN KEY (PER_CODUSU) REFERENCES TB_USUARIO (USU_CODIGO);}

implementation

{ TPermissao }

procedure TPermissao.setFPER_CODIIF(const Value: Integer);
begin
  FPER_CODIIF := Value;
end;

procedure TPermissao.setFPER_CODMHA(const Value: Integer);
begin
  FPER_CODMHA := Value;
end;

procedure TPermissao.setFPER_CODUSU(const Value: Integer);
begin
  FPER_CODUSU := Value;
end;

end.
