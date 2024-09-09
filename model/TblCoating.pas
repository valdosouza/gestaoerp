unit TblCoating;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_REVESTIMENTO')]
  TCoating = Class(TGenericEntity)

  private
    FRVT_CODIGO: Integer;
    FRVT_DESCRICAO: String;
    procedure setFRVT_CODIGO(const Value: Integer);
    procedure setFRVT_DESCRICAO(const Value: String);

  public
    [KeyField('RVT_CODIGO')]
    [FieldName('RVT_CODIGO')]
    property Codigo: Integer read FRVT_CODIGO write setFRVT_CODIGO;

    [FieldName('RVT_DESCRICAO')]
    property Descricao: String read FRVT_DESCRICAO write setFRVT_DESCRICAO;

  End;

implementation
{ TCoating }

procedure TCoating.setFRVT_CODIGO(const Value: Integer);
begin
  FRVT_CODIGO := Value;
end;

procedure TCoating.setFRVT_DESCRICAO(const Value: String);
begin
  FRVT_DESCRICAO := Value;
end;

end.
