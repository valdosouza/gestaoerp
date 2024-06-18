unit TblDskCfop;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_NATUREZA')]
  TDskCfop = Class(TGenericEntity)
  private
    FNAT_REGISTRO: Integer;
    FNAT_ATIVO: String;
    FNAT_CODIGO: Integer;
    FNAT_RESUMIDO: String;
    FNAT_DESCRICAO: String;
    FNAT_CFOP: String;
    FNAT_APLICACAO: String;
    FNAT_ALCADA: STring;
    FNAT_SENTIDO: String;
    procedure setFNAT_ALCADA(const Value: STring);
    procedure setFNAT_APLICACAO(const Value: String);
    procedure setFNAT_ATIVO(const Value: String);
    procedure setFNAT_CFOP(const Value: String);
    procedure setFNAT_CODIGO(const Value: Integer);
    procedure setFNAT_DESCRICAO(const Value: String);
    procedure setFNAT_REGISTRO(const Value: Integer);
    procedure setFNAT_RESUMIDO(const Value: String);
    procedure setFNAT_SENTIDO(const Value: String);

  public
    [KeyField('NAT_CODIGO')]
    [FieldName('NAT_CODIGO')]
    property Codigo:Integer  read FNAT_CODIGO write setFNAT_CODIGO;

    [FieldName('NAT_CFOP')]
    property cfop : String read FNAT_CFOP write setFNAT_CFOP;

    [FieldName('NAT_DESCRICAO')]
    property DescricaoCurta : String read FNAT_DESCRICAO write setFNAT_DESCRICAO;

    [FieldName('NAT_RESUMIDO')]
    property DescricaoLonga : String read FNAT_RESUMIDO write setFNAT_RESUMIDO;

    [FieldName('NAT_ATIVO')]
    property Ativo : String read FNAT_ATIVO write setFNAT_ATIVO;

    [FieldName('NAT_REGISTRO')]
    property Registro : Integer read FNAT_REGISTRO write setFNAT_REGISTRO;

    [FieldName('NAT_SENTIDO')]
    property Sentido : String read FNAT_SENTIDO write setFNAT_SENTIDO;

    [FieldName('NAT_ALCADA')]
    property Alcada : STring read FNAT_ALCADA write setFNAT_ALCADA;

    [FieldName('NAT_APLICACAO')]
    property Aplicacao : String read FNAT_APLICACAO write setFNAT_APLICACAO;

    [FieldName('NAT_INTERNO')]
    property NatInterno : String read FNAT_APLICACAO write setFNAT_APLICACAO;

  End;
implementation

{ TDskCfop }

procedure TDskCfop.setFNAT_ALCADA(const Value: STring);
begin
  FNAT_ALCADA := Value;
end;

procedure TDskCfop.setFNAT_APLICACAO(const Value: String);
begin
  FNAT_APLICACAO := Value;
end;

procedure TDskCfop.setFNAT_ATIVO(const Value: String);
begin
  FNAT_ATIVO := Value;
end;

procedure TDskCfop.setFNAT_CFOP(const Value: String);
begin
  FNAT_CFOP := Value;
end;

procedure TDskCfop.setFNAT_CODIGO(const Value: Integer);
begin
  FNAT_CODIGO := Value;
end;

procedure TDskCfop.setFNAT_DESCRICAO(const Value: String);
begin
  FNAT_DESCRICAO := Value;
end;

procedure TDskCfop.setFNAT_REGISTRO(const Value: Integer);
begin
  FNAT_REGISTRO := Value;
end;

procedure TDskCfop.setFNAT_RESUMIDO(const Value: String);
begin
  FNAT_RESUMIDO := Value;
end;

procedure TDskCfop.setFNAT_SENTIDO(const Value: String);
begin
  FNAT_SENTIDO := Value;
end;

end.
