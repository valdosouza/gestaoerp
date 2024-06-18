unit tblRetornoNfe;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETORNO_NFE')]
  TRetornoNFe = Class(TGenericEntity)
  private
    FNFE_MOTIVO: String;
    FNFE_CODNFL: Integer;
    FNFE_CODIGO: Integer;
    FNFE_SERIE: Integer;
    FNFE_NOTA_FIM: String;
    FNFE_NOTA_INI: String;
    FNFE_ARQUIVO: String;
    FNFE_CODSIT: Integer;
    FNFE_CODMHA: Integer;
    procedure setFNFE_ARQUIVO(const Value: String);
    procedure setFNFE_CODIGO(const Value: Integer);
    procedure setFNFE_CODMHA(const Value: Integer);
    procedure setFNFE_CODNFL(const Value: Integer);
    procedure setFNFE_CODSIT(const Value: Integer);
    procedure setFNFE_MOTIVO(const Value: String);
    procedure setFNFE_NOTA_FIM(const Value: String);
    procedure setFNFE_NOTA_INI(const Value: String);
    procedure setFNFE_SERIE(const Value: Integer);


  public
    [KeyField('NFE_CODIGO')]
    [FieldName('NFE_CODIGO')]
    property Codigo: Integer read FNFE_CODIGO write setFNFE_CODIGO;

    [FieldName('NFE_CODNFL')]
    property NotaFiscal: Integer read FNFE_CODNFL write setFNFE_CODNFL;

    [FieldName('NFE_SERIE')]
    property Serie: Integer read FNFE_SERIE write setFNFE_SERIE;

    [FieldName('NFE_CODSIT')]
    property Situacao: Integer read FNFE_CODSIT write setFNFE_CODSIT;

    [FieldName('NFE_ARQUIVO')]
    property NomeArquivo: String read FNFE_ARQUIVO write setFNFE_ARQUIVO;

    [FieldName('NFE_NOTA_INI')]
    property NumeroInicial: String read FNFE_NOTA_INI write setFNFE_NOTA_INI;

    [FieldName('NFE_NOTA_FIM')]
    property NumeroFinal: String read FNFE_NOTA_FIM write setFNFE_NOTA_FIM;

    [FieldName('NFE_MOTIVO')]
    property Motivo: String read FNFE_MOTIVO write setFNFE_MOTIVO;

    [FieldName('NFE_CODMHA')]
    property Estabelecimento: Integer read FNFE_CODMHA write setFNFE_CODMHA;
  End;

implementation

{ TRetornoNFe }

procedure TRetornoNFe.setFNFE_ARQUIVO(const Value: String);
begin
  FNFE_ARQUIVO := Value;
end;

procedure TRetornoNFe.setFNFE_CODIGO(const Value: Integer);
begin
  FNFE_CODIGO := Value;
end;

procedure TRetornoNFe.setFNFE_CODMHA(const Value: Integer);
begin
  FNFE_CODMHA := Value;
end;

procedure TRetornoNFe.setFNFE_CODNFL(const Value: Integer);
begin
  FNFE_CODNFL := Value;
end;

procedure TRetornoNFe.setFNFE_CODSIT(const Value: Integer);
begin
  FNFE_CODSIT := Value;
end;

procedure TRetornoNFe.setFNFE_MOTIVO(const Value: String);
begin
  FNFE_MOTIVO := Value;
end;

procedure TRetornoNFe.setFNFE_NOTA_FIM(const Value: String);
begin
  FNFE_NOTA_FIM := Value;
end;

procedure TRetornoNFe.setFNFE_NOTA_INI(const Value: String);
begin
  FNFE_NOTA_INI := Value;
end;

procedure TRetornoNFe.setFNFE_SERIE(const Value: Integer);
begin
  FNFE_SERIE := Value;
end;

end.
