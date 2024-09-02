unit tblNegocio;

interface

Uses GenericEntity, CAtribEntity, System.Classes, System.SysUtils;

Type
  [TableName('TB_NEGOCIO')]

  TNegocio = Class(TGenericEntity)
  private
    FNEG_DESCRICAO: String;
    FNEG_CODIGO: Integer;
    FNEG_EXCLUSIVO: String;
    procedure setFNEG_CODIGO(const Value: Integer);
    procedure setFNEG_DESCRICAO(const Value: String);
    procedure setFNEG_EXCLUSIVO(const Value: String);
  public
    [FieldName('NEG_CODIGO')]
    [KeyField('NEG_CODIGO')]
    property Codigo: Integer read FNEG_CODIGO write setFNEG_CODIGO;

    [FieldName('NEG_DESCRICAO')]
    property Descricao: String read FNEG_DESCRICAO write setFNEG_DESCRICAO;

    [FieldName('NEG_EXCLUSIVO')]
    property Exclusivo: String read FNEG_EXCLUSIVO write setFNEG_EXCLUSIVO;
  End;

implementation

{ TNegocio }

procedure TNegocio.setFNEG_CODIGO(const Value: Integer);
begin
  FNEG_CODIGO := Value;
end;

procedure TNegocio.setFNEG_DESCRICAO(const Value: String);
begin
  FNEG_DESCRICAO := Value;
end;

procedure TNegocio.setFNEG_EXCLUSIVO(const Value: String);
begin
  FNEG_EXCLUSIVO := Value;
end;

end.
