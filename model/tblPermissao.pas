unit tblPermissao;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_PERMISSAO')]

  TPermissao = Class(TGenericEntity)
  private
    FPER_CODIIF: Integer;
    FPER_CODMHA: Integer;
    FPER_CODUSU: Integer;
    FDescricaoOperacao: String;
    FNomeUsuario: String;
    procedure setFPER_CODIIF(const Value: Integer);
    procedure setFPER_CODMHA(const Value: Integer);
    procedure setFPER_CODUSU(const Value: Integer);
    procedure setFDescricaoOperacao(const Value: String);
    procedure setFNomeUsuario(const Value: String);

  public
    [KeyField('PER_CODMHA')]
    [FieldName('PER_CODMHA')]
    property Estabelecimento: Integer read FPER_CODMHA write setFPER_CODMHA;

    [KeyField('PER_CODUSU')]
    [FieldName('PER_CODUSU')]
    property Usuario: Integer read FPER_CODUSU write setFPER_CODUSU;

    [KeyField('PER_CODIIF')]
    [FieldName('PER_CODIIF')]
    property Privilegio: Integer read FPER_CODIIF write setFPER_CODIIF;

    property NomeUsuario : String read FNomeUsuario write setFNomeUsuario;
    property DescricaoOperacao : String read FDescricaoOperacao write setFDescricaoOperacao;
  End;

implementation

{ TPermissao }

procedure TPermissao.setFDescricaoOperacao(const Value: String);
begin
  FDescricaoOperacao := Value;
end;

procedure TPermissao.setFNomeUsuario(const Value: String);
begin
  FNomeUsuario := Value;
end;

procedure TPermissao.setFPER_CODIIF(const Value: Integer);
begin
  FPER_CODIIF := Value;
end;

procedure TPermissao.setFPER_CODMHA(const Value: Integer);
begin
  FPER_CODMHA := Value;
end;

procedure TPermissao.setFPER_CODUSU(const Value: Integer);
begin
  FPER_CODUSU := Value;
end;

end.
