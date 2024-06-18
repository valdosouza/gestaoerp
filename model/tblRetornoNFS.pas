unit tblRetornoNFS;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETORNO_NFS')]
  TRetornoNFS = Class(TGenericEntity)
  private
    FCODNFL    : INTEGER;
    FNUMERO    : String;
    FCOD_VERIF : String;
    FTIPO      : String;
    FCODNAT    : INTEGER;
    FDATETIME  : TDateTime;
    FSINCRONO  : String;
    FCODSIT    : INTEGER;
    FARQUIVO   : String;
    FMOTIVO    : String;
    FCODMHA    : INTEGER;
    FNFS_LOTE: Integer;
    FNFS_RPS: Integer;
    FNFS_PROTOCOLO: String;

    procedure setFCODNFL(Value    : INTEGER);
    procedure setFNUMERO(Value    : String);
    procedure setFCOD_VERIF(Value : String);
    procedure setFTIPO(Value      : String);
    procedure setFCODNAT(Value    : INTEGER);
    procedure setFDATETIME(Value  : TDateTime);
    procedure setFSINCRONO(Value  : String);
    procedure setFCODSIT(Value    : INTEGER);
    procedure setFARQUIVO(Value   : String);
    procedure setFMOTIVO(Value    : String);
    procedure setFCODMHA(Value    : INTEGER);
    procedure setFNFS_LOTE(const Value: Integer);
    procedure setFNFS_RPS(const Value: Integer);
    procedure setFNFS_PROTOCOLO(const Value: String);

  public

    [KeyField('NFS_CODNFL')]
    [FieldName('NFS_CODNFL')]
    property CodigoNotaFiscal: Integer read FCODNFL write setFCODNFL;

    [FieldName('NFS_RPS')]
    property ReciboProvisorios: Integer read FNFS_RPS write setFNFS_RPS;

    [FieldName('NFS_LOTE')]
    property Lote: Integer read FNFS_LOTE write setFNFS_LOTE;

    [FieldName('NFS_NUMERO')]
    property Numero: String read FNUMERO write setFNUMERO;

    [FieldName('NFS_PROTOCOLO')]
    property Protocolo: String read FNFS_PROTOCOLO write setFNFS_PROTOCOLO;


    [FieldName('NFS_COD_VERIF')]
    property CodigoVerificacao: String read FCOD_VERIF write setFCOD_VERIF;

    [FieldName('NFS_TIPO')]
    property Tipo: String read FTIPO write setFTIPO;

    [FieldName('NFS_CODNAT')]
    property CodigoNAtureza: Integer read FCODNAT write setFCODNAT;

    [FieldName('NFS_DATETIME')]
    property Data: TDAteTime read FDATETIME write setFDATETIME;

    [FieldName('NFS_SINCRONO')]
    property Sincrono: String read FSINCRONO write setFSINCRONO;

    [FieldName('NFS_CODSIT')]
    property CodigoSituacao: Integer read FCODSIT write setFCODSIT;

    [FieldName('NFS_ARQUIVO')]
    property Arquivo: String read FARQUIVO write setFARQUIVO;

    [FieldName('NFS_MOTIVO')]
    property Motivo: String read FMOTIVO write setFMOTIVO;

    [FieldName('NFS_CODMHA')]
    property CodigoEstabelecimento: Integer read FCODMHA write setFCODMHA;

  End;

implementation

{ TRetornoNFS }

procedure TRetornoNFS.setFARQUIVO(Value: String);
begin
  FARQUIVO := Value;
end;

procedure TRetornoNFS.setFCODMHA(Value: INTEGER);
begin
  FCODMHA := Value;
end;

procedure TRetornoNFS.setFCODNAT(Value: INTEGER);
begin
  FCODNAT := Value;
end;

procedure TRetornoNFS.setFCODNFL(Value: INTEGER);
begin
  FCODNFL := Value;
end;

procedure TRetornoNFS.setFCODSIT(Value: INTEGER);
begin
  FCODSIT := Value;
end;

procedure TRetornoNFS.setFCOD_VERIF(Value: String);
begin
  FCOD_VERIF := Value;
end;

procedure TRetornoNFS.setFDATETIME(Value: TDateTime);
begin
  FDATETIME := Value;
end;

procedure TRetornoNFS.setFMOTIVO(Value: String);
begin
  FMOTIVO := Value;
end;

procedure TRetornoNFS.setFNFS_LOTE(const Value: Integer);
begin
  FNFS_LOTE := Value;
end;

procedure TRetornoNFS.setFNFS_PROTOCOLO(const Value: String);
begin
  FNFS_PROTOCOLO := Value;
end;

procedure TRetornoNFS.setFNFS_RPS(const Value: Integer);
begin
  FNFS_RPS := Value;
end;

procedure TRetornoNFS.setFNUMERO(Value: String);
begin
  FNUMERO := Value;
end;


procedure TRetornoNFS.setFSINCRONO(Value: String);
begin
  FSINCRONO := Value;
end;

procedure TRetornoNFS.setFTIPO(Value: String);
begin
  FTIPO := Value;
end;

end.
