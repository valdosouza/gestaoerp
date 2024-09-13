unit tblSituacao;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_SITUACAO')]
  TSituacao = Class(TGenericEntity)

  private
    FSIT_DESCRICAO: String;
    FSIT_CODIGO: Integer;
    FSIT_COLOR: String;
    FSIT_FLAG01: String;
    FSIT_FLAG03: String;
    FSIT_MODULO: String;
    procedure setFSIT_CODIGO(const Value: Integer);
    procedure setFSIT_COLOR(const Value: String);
    procedure setFSIT_DESCRICAO(const Value: String);
    procedure setFSIT_FLAG01(const Value: String);
    procedure setFSIT_FLAG03(const Value: String);
    procedure setFSIT_MODULO(const Value: String);
  public
    [KeyField('SIT_CODIGO')]
    [FieldName('SIT_CODIGO')]
    property Codigo: Integer read FSIT_CODIGO write setFSIT_CODIGO;

    [FieldName('SIT_DESCRICAO')]
    property Descricao: String read FSIT_DESCRICAO write setFSIT_DESCRICAO;

    [FieldName('SIT_FLAG01')]
    property Flag01: String read FSIT_FLAG01 write setFSIT_FLAG01;

    [FieldName('SIT_FLAG02')]
    property Flag02: String read FSIT_FLAG01 write setFSIT_FLAG01;

    [FieldName('SIT_FLAG03')]
    property Flag03: String read FSIT_FLAG03 write setFSIT_FLAG03;

    [FieldName('SIT_MODULO')]
    property Modulo: String read FSIT_MODULO write setFSIT_MODULO;

    [FieldName('SIT_COLOR')]
    property Color: String read FSIT_COLOR write setFSIT_COLOR;
  End;

implementation

{ TSituacao }

procedure TSituacao.setFSIT_CODIGO(const Value: Integer);
begin
  FSIT_CODIGO := Value;
end;

procedure TSituacao.setFSIT_COLOR(const Value: String);
begin
  FSIT_COLOR := Value;
end;

procedure TSituacao.setFSIT_DESCRICAO(const Value: String);
begin
  FSIT_DESCRICAO := Value;
end;

procedure TSituacao.setFSIT_FLAG01(const Value: String);
begin
  FSIT_FLAG01 := Value;
end;

procedure TSituacao.setFSIT_FLAG03(const Value: String);
begin
  FSIT_FLAG03 := Value;
end;

procedure TSituacao.setFSIT_MODULO(const Value: String);
begin
  FSIT_MODULO := Value;
end;

end.
