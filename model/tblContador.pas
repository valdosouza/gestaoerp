unit tblContador;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CONTADOR')]
  TContador = Class(TGenericEntity)
  private
    FCON_ATIVO: String;
    FCONCODEMP: Integer;
    procedure setFCON_ATIVO(const Value: String);
    procedure setFCON_CODEMP(const Value: Integer);
  public

    [KeyField('CON_CODEMP')]
    [FieldName('CON_CODEMP')]
    property Codigo: Integer read FCONCODEMP write setFCON_CODEMP;

    [FieldName('CON_ATIVO')]
    property Ativo: String read FCON_ATIVO write setFCON_ATIVO;

  End;

implementation


{ TContador }

procedure TContador.setFCON_ATIVO(const Value: String);
begin
  FCON_ATIVO := Value;
end;

procedure TContador.setFCON_CODEMP(const Value: Integer);
begin
  FCONCODEMP := Value;
end;

end.
