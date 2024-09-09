unit TblTaxIcmsNr;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_TRIB_ICMS_NR')]
  TTaxIcmsNr = Class(TGenericEntity)

  private
    FTBI_DESCRICAO: String;
    FTBI_CODIGO: Integer;
    FTBI_GRUPO: String;
    procedure setFTBI_CODIGO(const Value: Integer);
    procedure setFTBI_DESCRICAO(const Value: String);
    procedure setFTBI_GRUPO(const Value: String);

  public
    [KeyField('TBI_CODIGO')]
    [FieldName('TBI_CODIGO')]
    property Codigo: Integer read FTBI_CODIGO write setFTBI_CODIGO;

    [FieldName('TBI_GRUPO')]
    property Grupo: String read FTBI_GRUPO write setFTBI_GRUPO;

    [FieldName('TBI_DESCRICAO')]
    property Descricao: String read FTBI_DESCRICAO write setFTBI_DESCRICAO;

  End;
implementation

{ TPLanoContas }

{ TTaxIcmsNr }

procedure TTaxIcmsNr.setFTBI_CODIGO(const Value: Integer);
begin
  FTBI_CODIGO := Value;
end;

procedure TTaxIcmsNr.setFTBI_DESCRICAO(const Value: String);
begin
  FTBI_DESCRICAO := Value;
end;

procedure TTaxIcmsNr.setFTBI_GRUPO(const Value: String);
begin
  FTBI_GRUPO := Value;
end;

end.
