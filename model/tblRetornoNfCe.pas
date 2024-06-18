unit tblRetornoNfCe;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETORNO_NFC')]
  TRetornoNFCe = Class(TGenericEntity)
  private
    FNFC_DATETIME: TDateTime;
    FNFC_SINCRONO: String;
    FNFC_MOTIVO: String;
    FNFC_CODNFL: Integer;
    FNFC_CODIGO: Integer;
    FNFC_TP_EMISSAO: String;
    FNFC_LOTE: Integer;
    FNFC_ARQUIVO: String;
    FNFC_CODSIT: Integer;
    FNFC_IND_PRES: String;
    FNFC_CODMHA: Integer;
    FNFC_FORMATO: String;
    FNFC_SERIE: Integer;
    FNFC_NUMERO: Integer;
    procedure setFNFC_ARQUIVO(const Value: String);
    procedure setFNFC_CODIGO(const Value: Integer);
    procedure setFNFC_CODMHA(const Value: Integer);
    procedure setFNFC_CODNFL(const Value: Integer);
    procedure setFNFC_CODSIT(const Value: Integer);
    procedure setFNFC_DATETIME(const Value: TDateTime);
    procedure setFNFC_FORMATO(const Value: String);
    procedure setFNFC_IND_PRES(const Value: String);
    procedure setFNFC_LOTE(const Value: Integer);
    procedure setFNFC_MOTIVO(const Value: String);
    procedure setFNFC_SINCRONO(const Value: String);
    procedure setFNFC_TP_EMISSAO(const Value: String);
    procedure setFNFC_NUMERO(const Value: Integer);
    procedure setFNFC_SERIE(const Value: Integer);

  public
    [KeyField('NFC_CODIGO')]
    [FieldName('NFC_CODIGO')]
    property Codigo: Integer read FNFC_CODIGO write setFNFC_CODIGO;

    [FieldName('NFC_CODNFL')]
    property NotaFiscal: Integer read FNFC_CODNFL write setFNFC_CODNFL;

    [FieldName('NFC_NUMERO')]
    property Numero: Integer read FNFC_NUMERO write setFNFC_NUMERO;

    [FieldName('NFC_SERIE')]
    property Serie: Integer read FNFC_SERIE write setFNFC_SERIE;

    [FieldName('NFC_LOTE')]
    property Lote: Integer read FNFC_LOTE write setFNFC_LOTE;

    [FieldName('NFC_DATETIME')]
    property DataHora: TDateTime read FNFC_DATETIME write setFNFC_DATETIME;

    [FieldName('NFC_SINCRONO')]
    property Sincrono: String read FNFC_SINCRONO write setFNFC_SINCRONO;

    [FieldName('NFC_TP_EMISSAO')]
    property TipoEmissao: String read FNFC_TP_EMISSAO write setFNFC_TP_EMISSAO;

    [FieldName('NFC_FORMATO')]
    property Formato: String read FNFC_FORMATO write setFNFC_FORMATO;

    [FieldName('NFC_IND_PRES')]
    property IndicacaoPresenca: String read FNFC_IND_PRES write setFNFC_IND_PRES;

    [FieldName('NFC_CODSIT')]
    property Situacao: Integer read FNFC_CODSIT write setFNFC_CODSIT;

    [FieldName('NFC_ARQUIVO')]
    property NomeArquivo: String read FNFC_ARQUIVO write setFNFC_ARQUIVO;

    [FieldName('NFC_MOTIVO')]
    property Motivo: String read FNFC_MOTIVO write setFNFC_MOTIVO;

    [FieldName('NFC_CODMHA')]
    property Estabelecimento: Integer read FNFC_CODMHA write setFNFC_CODMHA;

  End;
implementation


{ TRetornoNFCe }

procedure TRetornoNFCe.setFNFC_ARQUIVO(const Value: String);
begin
  FNFC_ARQUIVO := Value;
end;

procedure TRetornoNFCe.setFNFC_CODIGO(const Value: Integer);
begin
  FNFC_CODIGO := Value;
end;

procedure TRetornoNFCe.setFNFC_CODMHA(const Value: Integer);
begin
  FNFC_CODMHA := Value;
end;

procedure TRetornoNFCe.setFNFC_CODNFL(const Value: Integer);
begin
  FNFC_CODNFL := Value;
end;

procedure TRetornoNFCe.setFNFC_CODSIT(const Value: Integer);
begin
  FNFC_CODSIT := Value;
end;

procedure TRetornoNFCe.setFNFC_DATETIME(const Value: TDateTime);
begin
  FNFC_DATETIME := Value;
end;

procedure TRetornoNFCe.setFNFC_FORMATO(const Value: String);
begin
  FNFC_FORMATO := Value;
end;

procedure TRetornoNFCe.setFNFC_IND_PRES(const Value: String);
begin
  FNFC_IND_PRES := Value;
end;

procedure TRetornoNFCe.setFNFC_LOTE(const Value: Integer);
begin
  FNFC_LOTE := Value;
end;

procedure TRetornoNFCe.setFNFC_MOTIVO(const Value: String);
begin
  FNFC_MOTIVO := Value;
end;

procedure TRetornoNFCe.setFNFC_NUMERO(const Value: Integer);
begin
  FNFC_NUMERO := Value;
end;

procedure TRetornoNFCe.setFNFC_SERIE(const Value: Integer);
begin
  FNFC_SERIE := Value;
end;

procedure TRetornoNFCe.setFNFC_SINCRONO(const Value: String);
begin
  FNFC_SINCRONO := Value;
end;

procedure TRetornoNFCe.setFNFC_TP_EMISSAO(const Value: String);
begin
  FNFC_TP_EMISSAO := Value;
end;

end.
