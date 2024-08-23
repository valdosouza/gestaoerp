unit tblOperInterface;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_OPER_INTERFACE')]
  TOperInterface = Class(TObject)
  private
    FOPF_DESCRICAO: String;
    FOPF_CODIGO: Integer;
    FOPF_IMAGEM: String;
    procedure setFOPF_CODIGO(const Value: Integer);
    procedure setFOPF_DESCRICAO(const Value: String);
    procedure setFOPF_IMAGEM(const Value: String);

  public
    [KeyField('OPF_CODIGO')]
    [FieldName('OPF_CODIGO')]
    property Codigo: Integer read FOPF_CODIGO  write setFOPF_CODIGO ;

    [FieldName('OPF_DESCRICAO')]
    property Descricao: String read FOPF_DESCRICAO write setFOPF_DESCRICAO;

    [FieldName('OPF_IMAGEM')]
    property Imagem: String read FOPF_IMAGEM write setFOPF_IMAGEM;
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

procedure TOperInterface.setFOPF_IMAGEM(const Value: String);
begin
  FOPF_IMAGEM := Value;
end;

end.
