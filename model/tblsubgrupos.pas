unit tblsubgrupos;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_subgrupos')]
  TSubGrupos = Class(TGenericEntity)
  private
    FSBG_SEQUENCIA: Integer;
    FSBG_DESCRICAO: String;
    FSBG_CODIGO: Integer;
    FSBG_ABAS: String;
    FSBG_CODIMP: Integer;
    FSBG_CODGRP: Integer;
    FSBG_ATIVO: String;
    procedure setFSBG_ABAS(const Value: String);
    procedure setFSBG_CODGRP(const Value: Integer);
    procedure setFSBG_CODIGO(const Value: Integer);
    procedure setFSBG_CODIMP(const Value: Integer);
    procedure setFSBG_DESCRICAO(const Value: String);
    procedure setFSBG_SEQUENCIA(const Value: Integer);
    procedure setFSBG_ATIVO(const Value: String);


  public

    [KeyField('SBG_CODIGO')]
    [FieldName('SBG_CODIGO')]
    property Codigo: Integer read FSBG_CODIGO write setFSBG_CODIGO;

    [FieldName('SBG_CODGRP')]
    property Grupo: Integer read FSBG_CODGRP write setFSBG_CODGRP;

    [FieldName('SBG_DESCRICAO')]
    property Descricao: String read FSBG_DESCRICAO write setFSBG_DESCRICAO;

    [FieldName('SBG_ABAS')]
    property Abas: String read FSBG_ABAS write setFSBG_ABAS;

    [FieldName('SBG_CODIMP')]
    property Impressora: Integer read FSBG_CODIMP write setFSBG_CODIMP;

    [FieldName('SBG_SEQUENCIA')]
    property Sequencia: Integer read FSBG_SEQUENCIA write setFSBG_SEQUENCIA;

    [FieldName('SBG_ATIVO')]
    property ATivos: String read FSBG_ATIVO write setFSBG_ATIVO;

  End;

implementation

{ TSubGrupos }

procedure TSubGrupos.setFSBG_ABAS(const Value: String);
begin
  FSBG_ABAS := Value;
end;

procedure TSubGrupos.setFSBG_ATIVO(const Value: String);
begin
  FSBG_ATIVO := Value;
end;

procedure TSubGrupos.setFSBG_CODGRP(const Value: Integer);
begin
  FSBG_CODGRP := Value;
end;

procedure TSubGrupos.setFSBG_CODIGO(const Value: Integer);
begin
  FSBG_CODIGO := Value;
end;

procedure TSubGrupos.setFSBG_CODIMP(const Value: Integer);
begin
  FSBG_CODIMP := Value;
end;

procedure TSubGrupos.setFSBG_DESCRICAO(const Value: String);
begin
  FSBG_DESCRICAO := Value;
end;

procedure TSubGrupos.setFSBG_SEQUENCIA(const Value: Integer);
begin
  FSBG_SEQUENCIA := Value;
end;

end.
