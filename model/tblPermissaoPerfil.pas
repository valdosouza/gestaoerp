unit tblPermissaoPerfil;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_PERMISSAO_PERFIL')]
  TPermissaoPerfil = Class(TGenericEntity)
  private
    FFPPF_CODPFL: Integer;
    FPPF_CODIIF: Integer;
    procedure setFFPPF_CODPFL(const Value: Integer);
    procedure setFPPF_CODIIF(const Value: Integer);

  public
    [KeyField('PPF_CODPFL')]
    [FieldName('PPF_CODPFL')]
    property Perfil: Integer read FFPPF_CODPFL write setFFPPF_CODPFL;

    [KeyField('PPF_CODIIF')]
    [FieldName('PPF_CODIIF')]
    property Privilegio: Integer read FPPF_CODIIF write setFPPF_CODIIF;
  End;


implementation

{ TPermissaoPerfil }

procedure TPermissaoPerfil.setFFPPF_CODPFL(const Value: Integer);
begin
  FFPPF_CODPFL := Value;
end;

procedure TPermissaoPerfil.setFPPF_CODIIF(const Value: Integer);
begin
  FPPF_CODIIF := Value;
end;

end.
