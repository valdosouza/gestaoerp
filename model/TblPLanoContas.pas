unit TblPLanoContas;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PLANOCONTAS')]
  TPLanoContas = Class(TGenericEntity)

  private
    FPLC_DESCRICAO: String;
    FPLC_CODIGO: Integer;
    FPLC_NIVEL: String;
    FPLC_CODMHA: Integer;
    FPLC_TIPO: String;
    FPLC_NATUREZA: String;
    FPLC_CODPLANO: String;
    procedure setFPLC_CODIGO(const Value: Integer);
    procedure setFPLC_CODMHA(const Value: Integer);
    procedure setFPLC_CODPLANO(const Value: String);
    procedure setFPLC_DESCRICAO(const Value: String);
    procedure setFPLC_NATUREZA(const Value: String);
    procedure setFPLC_NIVEL(const Value: String);
    procedure setFPLC_TIPO(const Value: String);



  public
    [KeyField('PLC_CODIGO')]
    [FieldName('PLC_CODIGO')]
    property Codigo: Integer read FPLC_CODIGO write setFPLC_CODIGO;

    [FieldName('PLC_CODPLANO')]
    property PlanoContas: String read FPLC_CODPLANO write setFPLC_CODPLANO;

    [FieldName('PLC_DESCRICAO')]
    property Descricao: String read FPLC_DESCRICAO write setFPLC_DESCRICAO;

    [FieldName('PLC_NATUREZA')]
    property Origem: String read FPLC_NATUREZA write setFPLC_NATUREZA;


    [FieldName('PLC_TIPO')]
    property Tipo: String read FPLC_TIPO write setFPLC_TIPO;


    [FieldName('PLC_CODMHA')]
    property Estabelecimento: Integer read FPLC_CODMHA write setFPLC_CODMHA;

    [FieldName('PLC_NIVEL')]
    property Nivel: String read FPLC_NIVEL write setFPLC_NIVEL;


  End;
implementation


{ TPLanoContas }

procedure TPLanoContas.setFPLC_CODIGO(const Value: Integer);
begin
  FPLC_CODIGO := Value;
end;

procedure TPLanoContas.setFPLC_CODMHA(const Value: Integer);
begin
  FPLC_CODMHA := Value;
end;

procedure TPLanoContas.setFPLC_CODPLANO(const Value: String);
begin
  FPLC_CODPLANO := Value;
end;

procedure TPLanoContas.setFPLC_DESCRICAO(const Value: String);
begin
  FPLC_DESCRICAO := Value;
end;

procedure TPLanoContas.setFPLC_NATUREZA(const Value: String);
begin
  FPLC_NATUREZA := Value;
end;

procedure TPLanoContas.setFPLC_NIVEL(const Value: String);
begin
  FPLC_NIVEL := Value;
end;

procedure TPLanoContas.setFPLC_TIPO(const Value: String);
begin
  FPLC_TIPO := Value;
end;

end.
