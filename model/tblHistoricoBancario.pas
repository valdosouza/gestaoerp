unit tblHistoricoBancario;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_HISTBANCARIO')]
  THistoricoBancario = Class(TGenericEntity)
  private
    FHTB_DESCRICAO: String;
    FHTB_CODIGO: Integer;
    procedure setFHTB_CODIGO(const Value: Integer);
    procedure setFHTB_DESCRICAO(const Value: String);


  public
    [KeyField('HTB_CODIGO')]
    [FieldName('HTB_CODIGO')]
    property Codigo: Integer read FHTB_CODIGO write setFHTB_CODIGO;

    [FieldName('HTB_DESCRICAO')]
    property Descricao: String read FHTB_DESCRICAO write setFHTB_DESCRICAO;

  End;
implementation



{ THistoricoBancario }

procedure THistoricoBancario.setFHTB_CODIGO(const Value: Integer);
begin
  FHTB_CODIGO := Value;
end;

procedure THistoricoBancario.setFHTB_DESCRICAO(const Value: String);
begin
  FHTB_DESCRICAO := Value;
end;

end.
