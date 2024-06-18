unit tblSincronia;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_sincronia')]
  TSincronia = Class(TGenericEntity)
  private
    FSRC_OPER: String;
    FSRC_REGISTRO: Integer;
    FSRC_TABELA: String;
    FSRC_CODIGO: Integer;
    FSRC_TIME: TDatetime;
    FSRC_CHAVE: String;
    FSRC_LOG: String;
    procedure setFSRC_CHAVE(const Value: String);
    procedure setFSRC_CODIGO(const Value: Integer);
    procedure setFSRC_OPER(const Value: String);
    procedure setFSRC_REGISTRO(const Value: Integer);
    procedure setFSRC_TABELA(const Value: String);
    procedure setFSRC_TIME(const Value: TDatetime);
    procedure setFSRC_LOG(const Value: String);

  public

    [KeyField('SRC_CODIGO')]
    [FieldName('SRC_CODIGO')]
    property Codigo: Integer read FSRC_CODIGO write setFSRC_CODIGO;

    [FieldName('SRC_TABELA')]
    property Tabela: String read FSRC_TABELA write setFSRC_TABELA;

    [FieldName('SRC_CHAVE')]
    property Chave: String read FSRC_CHAVE write setFSRC_CHAVE;

    [FieldName('SRC_OPER')]
    property Operacao: String read FSRC_OPER write setFSRC_OPER;

    [FieldName('SRC_TIME')]
    property Tempo: TDatetime read FSRC_TIME write setFSRC_TIME;

    [FieldName('SRC_REGISTRO')]
    property Registro: Integer read FSRC_REGISTRO write setFSRC_REGISTRO;

    [FieldName('SRC_LOG')]
    property LogResult: String read FSRC_LOG write setFSRC_LOG;


  End;

implementation

{ TSincronia }

procedure TSincronia.setFSRC_CHAVE(const Value: String);
begin
  FSRC_CHAVE := Value;
end;

procedure TSincronia.setFSRC_CODIGO(const Value: Integer);
begin
  FSRC_CODIGO := Value;
end;

procedure TSincronia.setFSRC_LOG(const Value: String);
begin
  FSRC_LOG := Value;
end;

procedure TSincronia.setFSRC_OPER(const Value: String);
begin
  FSRC_OPER := Value;
end;

procedure TSincronia.setFSRC_REGISTRO(const Value: Integer);
begin
  FSRC_REGISTRO := Value;
end;

procedure TSincronia.setFSRC_TABELA(const Value: String);
begin
  FSRC_TABELA := Value;
end;

procedure TSincronia.setFSRC_TIME(const Value: TDatetime);
begin
  FSRC_TIME := Value;
end;

end.
