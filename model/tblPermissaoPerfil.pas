unit tblPermissaoPerfil;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_PERMISSAO_PERFIL')]

  TPermissaoPerfil = Class(TGenericEntity)
  private
    FPPF_CODPFL: Integer;
    FPPF_CODIIF: Integer;
    procedure setFPPF_CODIIF(const Value: Integer);
    procedure setFPPF_CODPFL(const Value: Integer);

  public
    [KeyField('PPF_CODPFL')]
    [FieldName('PPF_CODPFL')]
    property CodPFL: Integer read FPPF_CODPFL write setFPPF_CODPFL;

    //KeyField('PPF_CODIIF')]
    [FieldName('PPF_CODIIF')]
    property CodIIF: Integer read FPPF_CODIIF write setFPPF_CODIIF;
  End;
{CREATE TABLE TB_PERMISSAO_PERFIL (
    PPF_CODPFL  "Codigo" /* "Codigo" = INTEGER NOT NULL */,
    PPF_CODIIF  "Codigo" /* "Codigo" = INTEGER NOT NULL */
);
/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/
ALTER TABLE TB_PERMISSAO_PERFIL ADD PRIMARY KEY (PPF_CODPFL, PPF_CODIIF);}

implementation

{ TPerfilUsuario }

procedure TPermissaoPerfil.setFPPF_CODIIF(const Value: Integer);
begin
  FPPF_CODIIF := Value;
end;

procedure TPermissaoPerfil.setFPPF_CODPFL(const Value: Integer);
begin
  FPPF_CODPFL := Value;
end;

end.
