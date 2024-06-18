unit tbltransportadora;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_TRANSPORTADORA ')]
  TTransportadora = Class(TGenericEntity)
  private
    FTRP_ATIVO: String;
    FTRP_CODEMP: Integer;
    procedure setFTRP_ATIVO(const Value: String);
    procedure setFTRP_CODEMP(const Value: Integer);
  public

    [KeyField('TRP_CODEMP')]
    [FieldName('TRP_CODEMP')]
    property Codigo: Integer read FTRP_CODEMP write setFTRP_CODEMP;

    [FieldName('TRP_ATIVO')]
    property Ativo: String read FTRP_ATIVO write setFTRP_ATIVO;


  End;

implementation

{ TTransportadora }

procedure TTransportadora.setFTRP_ATIVO(const Value: String);
begin
  FTRP_ATIVO := Value;
end;

procedure TTransportadora.setFTRP_CODEMP(const Value: Integer);
begin
  FTRP_CODEMP := Value;
end;

end.
