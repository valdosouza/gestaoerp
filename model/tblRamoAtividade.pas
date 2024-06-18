unit tblRamoAtividade;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RAMO_ATIVIDADE')]
  TRamoAtividade = Class(TGenericEntity)
  private
    FDESCRIPTION: String;
    FID: Integer;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFID(const Value: Integer);
  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('DESCRIPTION')]
    property Descricao: String read FDESCRIPTION write setFDESCRIPTION;

  End;

implementation

{ TRamoAtividade }

procedure TRamoAtividade.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TRamoAtividade.setFID(const Value: Integer);
begin
  FID := Value;
end;

end.
