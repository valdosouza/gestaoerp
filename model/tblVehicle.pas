unit tblVehicle;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_VEICULO')]
  TVehicle = Class(TGenericEntity)
  private
    FVEI_COR: String;
    FVEI_CODMRC: Integer;
    FVEI_KM: String;
    FVEI_CODIGO: Integer;
    FVEI_FROTA: String;
    FVEI_CODCOR: Integer;
    FVEI_ANO: String;
    FVEI_CILINDRADA: Integer;
    FVEI_CODMOD: Integer;
    FVEI_PLACA: String;
    FVEI_CODWEB: Integer;
    FVEI_CODTPV: Integer;
    FVEI_CODEMP: Integer;
    FVEI_CHASSI: String;
    FVEI_TARA_KG: real;
    FVEI_CAPACIDADE_M3: real;
    FVEI_RENAVAN: string;
    FVEI_CAPACIDADE_KG: real;
    FVEI_CARROCERIA: string;
    FTB_UF_ID: Integer;
    FVEI_TIPO_RODADO: string;

    procedure setFVEI_CODIGO( Value : INTEGER);
    procedure setFVEI_CODEMP( Value : INTEGER);
    procedure setFVEI_PLACA( Value : String);
    procedure setFVEI_FROTA( Value : String);
    procedure setFVEI_CODTPV( Value : INTEGER);
    procedure setFVEI_CODMRC( Value : INTEGER);
    procedure setFVEI_CODMOD( Value : INTEGER);
    procedure setFVEI_ANO( Value : String);
    procedure setFVEI_COR( Value : String);
    procedure setFVEI_KM( Value : String);
    procedure setFVEI_CILINDRADA( Value : INTEGER);
    procedure setFVEI_CODCOR( Value : INTEGER);
    procedure setFVEI_CODWEB( Value : INTEGER);
    procedure setFVEI_CHASSI(const Value: String);
    procedure setFTB_UF_ID(const Value: Integer);
    procedure setFVEI_CAPACIDADE_KG(const Value: real);
    procedure setFVEI_CAPACIDADE_M3(const Value: real);
    procedure setFVEI_CARROCERIA(const Value: string);
    procedure setFVEI_RENAVAN(const Value: string);
    procedure setFVEI_TARA_KG(const Value: real);
    procedure setFVEI_TIPO_RODADO(const Value: string);

  public


    [FieldName('VEI_CODIGO')]
    property Codigo: Integer read FVEI_CODIGO write setFVEI_CODIGO;

    [FieldName('VEI_CODEMP')]
    property CodigoEmpresa: Integer read FVEI_CODEMP write setFVEI_CODEMP;

    [KeyField('VEI_PLACA')]
    [FieldName('VEI_PLACA')]
    property Placa: String read FVEI_PLACA write setFVEI_PLACA;

    [FieldName('VEI_FROTA')]
    property Frota: String read FVEI_FROTA write setFVEI_FROTA;

    [FieldName('VEI_CODTPV')]
    property Tipo: Integer read FVEI_CODTPV write setFVEI_CODTPV;

    [FieldName('VEI_CODMRC')]
    property CodigoMarca: Integer read FVEI_CODMRC write setFVEI_CODMRC;

    [FieldName('VEI_CODMOD')]
    property CodigoModelo: Integer read FVEI_CODMOD write setFVEI_CODMOD;

    [FieldName('VEI_ANO')]
    property Ano: String read FVEI_ANO write setFVEI_ANO;

    [FieldName('VEI_COR')]
    property Cor: String read FVEI_COR write setFVEI_COR;

    [FieldName('VEI_KM')]
    property KM: String read FVEI_KM write setFVEI_KM;

    [FieldName('VEI_CHASSI')]
    property Chassi: String read FVEI_CHASSI write setFVEI_CHASSI;

    [FieldName('VEI_CILINDRADA')]
    property Cilindrada: Integer read FVEI_CILINDRADA write setFVEI_CILINDRADA;

    [FieldName('VEI_CODCOR')]
    property CodigoCor: Integer read FVEI_CODCOR write setFVEI_CODCOR;

    [FieldName('VEI_CODWEB')]
    property Codigoweb: Integer read FVEI_CODWEB write setFVEI_CODWEB;

    [FieldName('VEI_CARROCERIA')]
    property Carroceria : string  read FVEI_CARROCERIA write setFVEI_CARROCERIA;

    [FieldName('VEI_TARA_KG')]
    property Tara : real read FVEI_TARA_KG write setFVEI_TARA_KG;

    [FieldName('VEI_RENAVAN')]
    property Renavan : string read FVEI_RENAVAN write setFVEI_RENAVAN;

    [FieldName('TB_UF_ID')]
    property Estado : Integer read FTB_UF_ID write setFTB_UF_ID;

    [FieldName('VEI_TIPO_RODADO')]
    property TipoRodado : string read FVEI_TIPO_RODADO write setFVEI_TIPO_RODADO;

    [FieldName('VEI_CAPACIDADE_KG')]
    property CapacidadeKg : real read FVEI_CAPACIDADE_KG write setFVEI_CAPACIDADE_KG;

    [FieldName('VEI_CAPACIDADE_M3')]
    property CapacidadeM3 : real read FVEI_CAPACIDADE_M3 write setFVEI_CAPACIDADE_M3;

  End;

implementation

{ TVehicle }

procedure TVehicle.setFTB_UF_ID(const Value: Integer);
begin
  FTB_UF_ID := Value;
end;

procedure TVehicle.setFVEI_ANO(Value: String);
begin
  FVEI_ANO := Value;
end;

procedure TVehicle.setFVEI_CAPACIDADE_KG(const Value: real);
begin
  FVEI_CAPACIDADE_KG := Value;
end;

procedure TVehicle.setFVEI_CAPACIDADE_M3(const Value: real);
begin
  FVEI_CAPACIDADE_M3 := Value;
end;

procedure TVehicle.setFVEI_CARROCERIA(const Value: string);
begin
  FVEI_CARROCERIA := Value;
end;

procedure TVehicle.setFVEI_CHASSI(const Value: String);
begin
  FVEI_CHASSI := Value;
end;

procedure TVehicle.setFVEI_CILINDRADA(Value: INTEGER);
begin
  FVEI_CILINDRADA := Value;
end;

procedure TVehicle.setFVEI_CODCOR(Value: INTEGER);
begin
  FVEI_CODCOR := Value;
end;

procedure TVehicle.setFVEI_CODEMP(Value: INTEGER);
begin
  FVEI_CODEMP := Value;
end;

procedure TVehicle.setFVEI_CODIGO(Value: INTEGER);
begin
  FVEI_CODIGO := Value;
end;

procedure TVehicle.setFVEI_CODMOD(Value: INTEGER);
begin
  FVEI_CODMOD := Value;
end;

procedure TVehicle.setFVEI_CODMRC(Value: INTEGER);
begin
  FVEI_CODMRC := Value;
end;

procedure TVehicle.setFVEI_CODTPV(Value: INTEGER);
begin
  FVEI_CODTPV := Value;
end;

procedure TVehicle.setFVEI_CODWEB(Value: INTEGER);
begin
  FVEI_CODWEB := Value;
end;

procedure TVehicle.setFVEI_COR(Value: String);
begin
  FVEI_COR := Value;
end;

procedure TVehicle.setFVEI_FROTA(Value: String);
begin
  FVEI_FROTA := Value;
end;

procedure TVehicle.setFVEI_KM(Value: String);
begin
  FVEI_KM := Value;
end;

procedure TVehicle.setFVEI_PLACA(Value: String);
begin
  FVEI_PLACA := Value;
end;

procedure TVehicle.setFVEI_RENAVAN(const Value: string);
begin
  FVEI_RENAVAN := Value;
end;

procedure TVehicle.setFVEI_TARA_KG(const Value: real);
begin
  FVEI_TARA_KG := Value;
end;

procedure TVehicle.setFVEI_TIPO_RODADO(const Value: string);
begin
  FVEI_TIPO_RODADO := Value;
end;

end.
