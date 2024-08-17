unit tblMenus;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_MENUS')]
  TMenus = Class(TGenericEntity)
  private
    FMNU_DESCRICAO: String;
    FMNU_CODIGO: Integer;
    FMNU_CODMOD: Integer;
    procedure setFMNU_CODIGO(const Value: Integer);
    procedure setFMNU_CODMOD(const Value: Integer);
    procedure setFMNU_DESCRICAO(const Value: String);

  public
    [KeyField('MNU_CODIGO')]
    [FieldName('MNU_CODIGO')]
    property Codigo: Integer read FMNU_CODIGO write setFMNU_CODIGO;

    [FieldName('MNU_CODMOD')]
    property CODMOD: Integer read FMNU_CODMOD write setFMNU_CODMOD;

    [FieldName('MNU_DESCRICAO')]
    property Descricao: String read FMNU_DESCRICAO write setFMNU_DESCRICAO;
  End;

implementation

{ TMenus }

procedure TMenus.setFMNU_CODIGO(const Value: Integer);
begin
  FMNU_CODIGO := Value;
end;

procedure TMenus.setFMNU_CODMOD(const Value: Integer);
begin
  FMNU_CODMOD := Value;
end;

procedure TMenus.setFMNU_DESCRICAO(const Value: String);
begin
  FMNU_DESCRICAO := Value;
end;

end.
