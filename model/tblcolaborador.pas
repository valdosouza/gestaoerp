unit tblcolaborador;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_Colaborador')]
  TColaborador = Class(TGenericEntity)
  private
    FCLB_AQ_COM_VDA: Real;
    FCLB_NOMEPA: String;
    FCLB_FONE: String;
    FCLB_DEMISSAO: TDate;
    FCLB_AQ_COM_SRV: Real;
    FCLB_OBSERV: String;
    FCLB_TIT_ZONA: String;
    FCLB_EMAIL: String;
    FCLB_BAIRRO: String;
    FCLB_CALC_COM_VDA: String;
    FCLB_NASCIMENTO: TDate;
    FCLB_CERT_MILITAR: String;
    FCLB_CODIGO: Integer;
    FCLB_CALC_COM_SRV: String;
    FCLB_SALARIO: Real;
    FCLB_CPF: String;
    FCLB_CEP: String;
    FCLB_IDENTIDADE: String;
    FCLB_PIS: String;
    FCLB_COM_VDA: String;
    FCLB_SITUACAO: String;
    FCLB_CODMHA: Integer;
    FCLB_COM_SRV: String;
    FCLB_HABILITACAO: String;
    FCLB_NOMEMAE: String;
    FCLB_CODCRG: Integer;
    FCLB_CODUSU: Integer;
    FCLB_SEXO: String;
    FCLB_NOME: String;
    FCLB_TIT_SECAO: String;
    FCLB_CIDADE: String;
    FCLB_CODPAI: Integer;
    FCLB_ADMISSAO: TDate;
    FCLB_ENDER: String;
    FCLB_TIT_ELEITOR: String;
    FCLB_UF: String;
    FCLB_CELULAR: String;
    FCargoDescricao: String;
    FDemitidos: boolean;
    procedure setFCLB_ADMISSAO(const Value: TDate);
    procedure setFCLB_AQ_COM_SRV(const Value: Real);
    procedure setFCLB_AQ_COM_VDA(const Value: Real);
    procedure setFCLB_BAIRRO(const Value: String);
    procedure setFCLB_CALC_COM_SRV(const Value: String);
    procedure setFCLB_CALC_COM_VDA(const Value: String);
    procedure setFCLB_CELULAR(const Value: String);
    procedure setFCLB_CEP(const Value: String);
    procedure setFCLB_CERT_MILITAR(const Value: String);
    procedure setFCLB_CIDADE(const Value: String);
    procedure setFCLB_CODCRG(const Value: Integer);
    procedure setFCLB_CODIGO(const Value: Integer);
    procedure setFCLB_CODMHA(const Value: Integer);
    procedure setFCLB_CODPAI(const Value: Integer);
    procedure setFCLB_CODUSU(const Value: Integer);
    procedure setFCLB_COM_SRV(const Value: String);
    procedure setFCLB_COM_VDA(const Value: String);
    procedure setFCLB_CPF(const Value: String);
    procedure setFCLB_DEMISSAO(const Value: TDate);
    procedure setFCLB_EMAIL(const Value: String);
    procedure setFCLB_ENDER(const Value: String);
    procedure setFCLB_FONE(const Value: String);
    procedure setFCLB_HABILITACAO(const Value: String);
    procedure setFCLB_IDENTIDADE(const Value: String);
    procedure setFCLB_NASCIMENTO(const Value: TDate);
    procedure setFCLB_NOME(const Value: String);
    procedure setFCLB_NOMEMAE(const Value: String);
    procedure setFCLB_NOMEPAI(const Value: String);
    procedure setFCLB_OBSERV(const Value: String);
    procedure setFCLB_PIS(const Value: String);
    procedure setFCLB_SALARIO(const Value: Real);
    procedure setFCLB_SEXO(const Value: String);
    procedure setFCLB_SITUACAOs(const Value: String);
    procedure setFCLB_TIT_ELEITOR(const Value: String);
    procedure setFCLB_TIT_SECAO(const Value: String);
    procedure setFCLB_TIT_ZONA(const Value: String);
    procedure setFCLB_UF(const Value: String);
    procedure setFCargoDescricao(const Value: String);
    procedure setFDemitidos(const Value: boolean);

  public
    [KeyField('CLB_CODIGO')]
    [FieldName('CLB_CODIGO')]
    property Codigo : Integer read FCLB_CODIGO write setFCLB_CODIGO;

    [FieldName('CLB_NOME')]
    property Nome : String read FCLB_NOME write setFCLB_NOME;

    [FieldName('CLB_SEXO')]
    property Sexo: String read FCLB_SEXO write setFCLB_SEXO;

    [FieldName('CLB_ENDER')]
    property Endereco: String read FCLB_ENDER write setFCLB_ENDER;
    [FieldName('CLB_BAIRRO')]
    property Bairro: String read FCLB_BAIRRO write setFCLB_BAIRRO;
    [FieldName('CLB_CEP')]
    property Cep: String read FCLB_CEP write setFCLB_CEP;
    [FieldName('CLB_CIDADE')]
    property Cidade: String read FCLB_CIDADE write setFCLB_CIDADE;
    [FieldName('CLB_UF')]
    property Estado: String read FCLB_UF write setFCLB_UF;
    [FieldName('CLB_FONE')]
    property Fone: String read FCLB_FONE write setFCLB_FONE;
    [FieldName('CLB_CELULAR')]
    property Celular: String read FCLB_CELULAR write setFCLB_CELULAR;
    [FieldName('CLB_EMAIL')]
    property email: String read FCLB_EMAIL write setFCLB_EMAIL;
    [FieldName('CLB_CODCRG')]
    property Cargo: Integer read FCLB_CODCRG write setFCLB_CODCRG;
    [FieldName('CLB_SITUACAO')]
    property Situacao: String read FCLB_SITUACAO write setFCLB_SITUACAOs;
    [FieldName('CLB_ADMISSAO')]
    property Admissao: TDate read FCLB_ADMISSAO write setFCLB_ADMISSAO;
    [FieldName('CLB_DEMISSAO')]
    property Demissao: TDate read FCLB_DEMISSAO write setFCLB_DEMISSAO;
    [FieldName('CLB_SALARIO')]
    property Salario: Real read FCLB_SALARIO write setFCLB_SALARIO;
    [FieldName('CLB_CPF')]
    property CPFCNPJ: String read FCLB_CPF write setFCLB_CPF;
    [FieldName('CLB_PIS')]
    property PIS: String read FCLB_PIS write setFCLB_PIS;
    [FieldName('CLB_IDENTIDADE')]
    property Identidade: String read FCLB_IDENTIDADE write setFCLB_IDENTIDADE;
    [FieldName('CLB_NASCIMENTO')]
    property NAscimento: TDate read FCLB_NASCIMENTO write setFCLB_NASCIMENTO;
    [FieldName('CLB_NOMEPAI')]
    property NomePai: String read FCLB_NOMEPA write setFCLB_NOMEPAI;
    [FieldName('CLB_NOMEMAE')]
    property NomeMae: String read FCLB_NOMEMAE write setFCLB_NOMEMAE;
    [FieldName('CLB_HABILITACAO')]
    property Habilitacao: String read FCLB_HABILITACAO write setFCLB_HABILITACAO;
    [FieldName('CLB_TIT_ELEITOR')]
    property TituloEleitor: String read FCLB_TIT_ELEITOR write setFCLB_TIT_ELEITOR;
    [FieldName('CLB_TIT_ZONA')]
    property TituloZona: String read FCLB_TIT_ZONA write setFCLB_TIT_ZONA;
    [FieldName('CLB_TIT_SECAO')]
    property SecaoZona: String read FCLB_TIT_SECAO write setFCLB_TIT_SECAO;
    [FieldName('CLB_CERT_MILITAR')]
    property CertificadoMilitar: String read FCLB_CERT_MILITAR write setFCLB_CERT_MILITAR;
    [FieldName('CLB_OBSERV')]
    property Observacao: String read FCLB_OBSERV write setFCLB_OBSERV;
    [FieldName('CLB_CODUSU')]
    property Usuario: Integer read FCLB_CODUSU write setFCLB_CODUSU;
    [FieldName('CLB_AQ_COM_VDA')]
    property ComissaoAliqVenda: Real read FCLB_AQ_COM_VDA write setFCLB_AQ_COM_VDA;
    [FieldName('CLB_CODPAI')]
    property Pais: Integer read FCLB_CODPAI write setFCLB_CODPAI;
    [FieldName('CLB_AQ_COM_SRV')]
    property ComissaoAliqServico: Real read FCLB_AQ_COM_SRV write setFCLB_AQ_COM_SRV;
    [FieldName('CLB_COM_VDA')]
    property ComissaoVenda: String read FCLB_COM_VDA write setFCLB_COM_VDA;
    [FieldName('CLB_COM_SRV')]
    property ComissaoServico: String read FCLB_COM_SRV write setFCLB_COM_SRV;
    [FieldName('CLB_CODMHA')]
    property Estabelecimento: Integer read FCLB_CODMHA write setFCLB_CODMHA;
    [FieldName('CLB_CALC_COM_VDA')]
    property ComissaoPorProduto: String read FCLB_CALC_COM_VDA write setFCLB_CALC_COM_VDA;
    [FieldName('CLB_CALC_COM_SRV')]
    property ComissaoPorServico: String read FCLB_CALC_COM_SRV write setFCLB_CALC_COM_SRV;

    property CargoDescricao : String read FCargoDescricao write setFCargoDescricao;
    property Demitidos : boolean read FDemitidos write setFDemitidos;
  End;

implementation

{ TColaborador }

procedure TColaborador.setFCargoDescricao(const Value: String);
begin
  FCargoDescricao := Value;
end;

procedure TColaborador.setFCLB_ADMISSAO(const Value: TDate);
begin
  FCLB_ADMISSAO := Value;
end;

procedure TColaborador.setFCLB_AQ_COM_SRV(const Value: Real);
begin
  FCLB_AQ_COM_SRV := Value;
end;

procedure TColaborador.setFCLB_AQ_COM_VDA(const Value: Real);
begin
  FCLB_AQ_COM_VDA := Value;
end;

procedure TColaborador.setFCLB_BAIRRO(const Value: String);
begin
  FCLB_BAIRRO := Value;
end;

procedure TColaborador.setFCLB_CALC_COM_SRV(const Value: String);
begin
  FCLB_CALC_COM_SRV := Value;
end;

procedure TColaborador.setFCLB_CALC_COM_VDA(const Value: String);
begin
  FCLB_CALC_COM_VDA := Value;
end;

procedure TColaborador.setFCLB_CELULAR(const Value: String);
begin
  FCLB_CELULAR := Value;
end;

procedure TColaborador.setFCLB_CEP(const Value: String);
begin
  FCLB_CEP := Value;
end;

procedure TColaborador.setFCLB_CERT_MILITAR(const Value: String);
begin
  FCLB_CERT_MILITAR := Value;
end;

procedure TColaborador.setFCLB_CIDADE(const Value: String);
begin
  FCLB_CIDADE := Value;
end;

procedure TColaborador.setFCLB_CODCRG(const Value: Integer);
begin
  FCLB_CODCRG := Value;
end;

procedure TColaborador.setFCLB_CODIGO(const Value: Integer);
begin
  FCLB_CODIGO := Value;
end;

procedure TColaborador.setFCLB_CODMHA(const Value: Integer);
begin
  FCLB_CODMHA := Value;
end;

procedure TColaborador.setFCLB_CODPAI(const Value: Integer);
begin
  FCLB_CODPAI := Value;
end;

procedure TColaborador.setFCLB_CODUSU(const Value: Integer);
begin
  FCLB_CODUSU := Value;
end;

procedure TColaborador.setFCLB_COM_SRV(const Value: String);
begin
  FCLB_COM_SRV := Value;
end;

procedure TColaborador.setFCLB_COM_VDA(const Value: String);
begin
  FCLB_COM_VDA := Value;
end;

procedure TColaborador.setFCLB_CPF(const Value: String);
begin
  FCLB_CPF := Value;
end;

procedure TColaborador.setFCLB_DEMISSAO(const Value: TDate);
begin
  FCLB_DEMISSAO := Value;
end;

procedure TColaborador.setFCLB_EMAIL(const Value: String);
begin
  FCLB_EMAIL := Value;
end;

procedure TColaborador.setFCLB_ENDER(const Value: String);
begin
  FCLB_ENDER := Value;
end;

procedure TColaborador.setFCLB_FONE(const Value: String);
begin
  FCLB_FONE := Value;
end;

procedure TColaborador.setFCLB_HABILITACAO(const Value: String);
begin
  FCLB_HABILITACAO := Value;
end;

procedure TColaborador.setFCLB_IDENTIDADE(const Value: String);
begin
  FCLB_IDENTIDADE := Value;
end;

procedure TColaborador.setFCLB_NASCIMENTO(const Value: TDate);
begin
  FCLB_NASCIMENTO := Value;
end;

procedure TColaborador.setFCLB_NOME(const Value: String);
begin
  FCLB_NOME := Value;
end;

procedure TColaborador.setFCLB_NOMEMAE(const Value: String);
begin
  FCLB_NOMEMAE := Value;
end;

procedure TColaborador.setFCLB_NOMEPAI(const Value: String);
begin
  FCLB_NOMEPA := Value;
end;

procedure TColaborador.setFCLB_OBSERV(const Value: String);
begin
  FCLB_OBSERV := Value;
end;

procedure TColaborador.setFCLB_PIS(const Value: String);
begin
  FCLB_PIS := Value;
end;

procedure TColaborador.setFCLB_SALARIO(const Value: Real);
begin
  FCLB_SALARIO := Value;
end;

procedure TColaborador.setFCLB_SEXO(const Value: String);
begin
  FCLB_SEXO := Value;
end;

procedure TColaborador.setFCLB_SITUACAOs(const Value: String);
begin
  FCLB_SITUACAO := Value;
end;

procedure TColaborador.setFCLB_TIT_ELEITOR(const Value: String);
begin
  FCLB_TIT_ELEITOR := Value;
end;

procedure TColaborador.setFCLB_TIT_SECAO(const Value: String);
begin
  FCLB_TIT_SECAO := Value;
end;

procedure TColaborador.setFCLB_TIT_ZONA(const Value: String);
begin
  FCLB_TIT_ZONA := Value;
end;

procedure TColaborador.setFCLB_UF(const Value: String);
begin
  FCLB_UF := Value;
end;

procedure TColaborador.setFDemitidos(const Value: boolean);
begin
  FDemitidos := Value;
end;

end.
