unit tblMercadoria;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_produto')]
  TMercadoria = Class(TGenericEntity)
  private
    FPRO_CODIGOFOR: String;
    FPRO_CODMHA: Integer;
    FPRO_CODMRC: Integer;
    FPRO_SERIE: String;
    FPRO_EXCLUSIVO: String;
    FPRO_CEST: String;
    FPRO_CODIGO: Integer;
    FPRO_CODIGOBAR: String;
    FPRO_IMPRIME: String;
    FPRO_CODIGONCM: String;
    FPRO_APLICACAO: String;
    FPRO_TIPO: String;

    procedure setFPRO_CODIGO( Value : Integer);
    procedure setFPRO_CODMHA( Value : Integer);
    procedure setFPRO_CODIGOFOR( Value : String);
    procedure setFPRO_CODIGOBAR( Value : String);
    procedure setFPRO_CODIGONCM( Value : String);
    procedure setFPRO_CEST( Value : String);
    procedure setFPRO_CODMRC( Value : Integer);
    procedure setFPRO_TIPO( Value : String);
    procedure setFPRO_IMPRIME( Value : String);
    procedure setFPRO_SERIE( Value : String);
    procedure setFPRO_EXCLUSIVO( Value : String);
    procedure setFPRO_APLICACAO( Value : String);



  public

    [KeyField('PRO_CODIGO')]
    [FieldName('PRO_CODIGO')]
    property Codigo: Integer read FPRO_CODIGO write setFPRO_CODIGO;

    [KeyField('PRO_CODMHA')]
    [FieldName('PRO_CODMHA')]
    property CodigoEstabelecimento: Integer read FPRO_CODMHA write setFPRO_CODMHA;

    [FieldName('PRO_CODIGOFOR')]
    property CodigoFornecedor: String read FPRO_CODIGOFOR write setFPRO_CODIGOFOR;

    [FieldName('PRO_CODIGOBAR')]
    property CodigoBarras: String read FPRO_CODIGOBAR write setFPRO_CODIGOBAR;

    [FieldName('PRO_CODIGONCM')]
    property NCM: String read FPRO_CODIGONCM write setFPRO_CODIGONCM;

    [FieldName('PRO_CEST')]
    property CEST: String read FPRO_CEST write setFPRO_CEST;

    [FieldName('PRO_CODMRC')]
    property CodigoMarca: Integer read FPRO_CODMRC write setFPRO_CODMRC;

    [FieldName('PRO_TIPO')]
    property Tipo: String read FPRO_TIPO write setFPRO_TIPO;

    [FieldName('PRO_IMPRIME')]
    property Imprime: String read FPRO_IMPRIME write setFPRO_IMPRIME;

    [FieldName('PRO_SERIE')]
    property ControleSerie: String read FPRO_SERIE write setFPRO_SERIE;

    [FieldName('PRO_EXCLUSIVO')]
    property ExclusivoRevenda: String read FPRO_EXCLUSIVO write setFPRO_EXCLUSIVO;

    [FieldName('PRO_APLICACAO')]
    property Aplicacao: String read FPRO_APLICACAO write setFPRO_APLICACAO;


  End;

implementation


{ TMercadoria }

procedure TMercadoria.setFPRO_APLICACAO(Value: String);
begin
  FPRO_APLICACAO := Value;
end;

procedure TMercadoria.setFPRO_CEST(Value: String);
begin
  FPRO_CEST := Value;
end;

procedure TMercadoria.setFPRO_CODIGO(Value: Integer);
begin
  FPRO_CODIGO := Value;
end;

procedure TMercadoria.setFPRO_CODIGOBAR(Value: String);
begin
  FPRO_CODIGOBAR := Value;
end;

procedure TMercadoria.setFPRO_CODIGOFOR(Value: String);
begin
  FPRO_CODIGOFOR := Value;
end;

procedure TMercadoria.setFPRO_CODIGONCM(Value: String);
begin
  FPRO_CODIGONCM := Value;
end;

procedure TMercadoria.setFPRO_CODMHA(Value: Integer);
begin
  FPRO_CODMHA := Value;
end;

procedure TMercadoria.setFPRO_CODMRC(Value: Integer);
begin
  FPRO_CODMRC := Value;
end;

procedure TMercadoria.setFPRO_EXCLUSIVO(Value: String);
begin
  FPRO_EXCLUSIVO := Value;
end;

procedure TMercadoria.setFPRO_IMPRIME(Value: String);
begin
  FPRO_IMPRIME := Value;
end;

procedure TMercadoria.setFPRO_SERIE(Value: String);
begin
  FPRO_SERIE := Value;
end;

procedure TMercadoria.setFPRO_TIPO(Value: String);
begin
  FPRO_TIPO := Value;
end;

end.
