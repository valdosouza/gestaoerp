unit tblNatureza;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_NATUREZA')]
  TNatureza = Class(TGenericEntity)
  private
    FNAT_REGISTRO: integer;
    FNAT_ATIVO: String;
    FNAT_DESCRICAO: String;
    FNAT_CODIGO: Integer;
    FNAT_INTERNO: String;
    FNAT_CFOP: String;
    FNAT_APLICACAO: String;
    FNAT_RESUMIDO: String;
    FNAT_ALCADA: String;
    FNAT_SENTIDO: String;
    procedure setFNAT_ALCADA(const Value: String);
    procedure setFNAT_ATIVO(const Value: String);
    procedure setFNAT_CFOP(const Value: String);
    procedure setFNAT_CODIGO(const Value: Integer);
    procedure setFNAT_DESCRICAO(const Value: String);
    procedure setFNAT_INTERNO(const Value: String);
    procedure setFNAT_REGISTRO(const Value: integer);
    procedure setFNAT_RESUMIDO(const Value: String);
    procedure setFNAT_SENTIDO(const Value: String);
    procedure setNAT_APLICACAO(const Value: String);

  public
    [KeyField('NAT_CODIGO')]
    [FieldName('NAT_CODIGO')]
    property Codigo: Integer read FNAT_CODIGO write setFNAT_CODIGO;

    [FieldName('NAT_DESCRICAO')]  //250
    property Descricao: String read FNAT_DESCRICAO write setFNAT_DESCRICAO;

    [FieldName('NAT_CFOP')]    //10
    property Cfop: String read FNAT_CFOP write setFNAT_CFOP;

    [FieldName('NAT_RESUMIDO')] //60
    property Resumido: String read FNAT_RESUMIDO write setFNAT_RESUMIDO;

    [FieldName('NAT_ATIVO')]   //1
    property Ativo: String read FNAT_ATIVO write setFNAT_ATIVO;

    [FieldName('NAT_REGISTRO')]
    property Registro: integer read FNAT_REGISTRO write setFNAT_REGISTRO;

    [FieldName('NAT_SENTIDO')] //1
    property Sentido: String read FNAT_SENTIDO write setFNAT_SENTIDO;

    [FieldName('NAT_ALCADA')]  //1
    property Alcada: String read FNAT_ALCADA write setFNAT_ALCADA;

    [FieldName('NAT_APLICACAO')] //memo
    property Aplicacao: String read FNAT_APLICACAO write setNAT_APLICACAO;

    [FieldName('NAT_INTERNO')]  //1
    property Interno: String read FNAT_INTERNO write setFNAT_INTERNO;
  End;

implementation

{ TNatureza }

procedure TNatureza.setFNAT_ALCADA(const Value: String);
begin
  FNAT_ALCADA := Value;
end;

procedure TNatureza.setFNAT_ATIVO(const Value: String);
begin
  FNAT_ATIVO := Value;
end;

procedure TNatureza.setFNAT_CFOP(const Value: String);
begin
  FNAT_CFOP := Value;
end;

procedure TNatureza.setFNAT_CODIGO(const Value: Integer);
begin
  FNAT_CODIGO := Value;
end;

procedure TNatureza.setFNAT_DESCRICAO(const Value: String);
begin
  FNAT_DESCRICAO := Value;
end;

procedure TNatureza.setFNAT_INTERNO(const Value: String);
begin
  FNAT_INTERNO := Value;
end;

procedure TNatureza.setFNAT_REGISTRO(const Value: integer);
begin
  FNAT_REGISTRO := Value;
end;

procedure TNatureza.setFNAT_RESUMIDO(const Value: String);
begin
  FNAT_RESUMIDO := Value;
end;

procedure TNatureza.setFNAT_SENTIDO(const Value: String);
begin
  FNAT_SENTIDO := Value;
end;

procedure TNatureza.setNAT_APLICACAO(const Value: String);
begin
  FNAT_APLICACAO := Value;
end;

end.
