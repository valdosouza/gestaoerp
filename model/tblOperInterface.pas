unit tblOperInterface;

interface

Uses TEntity, CAtribEntity, System.Classes;

Type
  [TableName('TB_OPER_INTERFACE')]
  TOperInterface = Class(TGenericEntity)
  private
    FOPF_DESCRICAO: String;
    FOPF_CODIGO: Integer;
    FPathImagem: String;
    procedure setFOPF_CODIGO(const Value: Integer);
    procedure setFOPF_DESCRICAO(const Value: String);
    procedure setFPathImagem(const Value: String);

  public
    [KeyField('OPF_CODIGO')]
    [FieldName('OPF_CODIGO')]
    property Codigo: Integer read FOPF_CODIGO write setFOPF_CODIGO;

    [FieldName('OPF_DESCRICAO')]
    property Descricao: String read FOPF_DESCRICAO write setFOPF_DESCRICAO;

    property PathImagem: String read FPathImagem write setFPathImagem;
  End;

implementation

{ TOperInterface }

procedure TOperInterface.setFOPF_CODIGO(const Value: Integer);
begin
  FOPF_CODIGO := Value;
end;

procedure TOperInterface.setFOPF_DESCRICAO(const Value: String);
begin
  FOPF_DESCRICAO := Value;
end;

procedure TOperInterface.setFPathImagem(const Value: String);
begin
  FPathImagem := Value;
end;

end.
