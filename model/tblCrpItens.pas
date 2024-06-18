unit tblCrpItens;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CRP_ITENS')]
  TCrpItens = Class(TGenericEntity)
  private
    FCPI_SEQUENCIA: Integer;
    FCPI_SABOR: String;
    FCPI_VALOR: Real;
    FCPI_CODPRO: Integer;
    FCPI_CODIGO: Integer;
    FCPI_QTDE: Real;
    FCPI_TIPO: String;
    FCPI_CODGRP: Integer;
    procedure setFCPI_CODIGO(const Value: Integer);
    procedure setFCPI_CODPRO(const Value: Integer);
    procedure setFCPI_QTDE(const Value: Real);
    procedure setFCPI_SABOR(const Value: String);
    procedure setFCPI_SEQUENCIA(const Value: Integer);
    procedure setFCPI_TIPO(const Value: String);
    procedure setFCPI_VALOR(const Value: Real);
    procedure setFCPI_CODGRP(const Value: Integer);


  public

    [FieldName('CPI_CODIGO')]
    property Codigo: Integer read FCPI_CODIGO write setFCPI_CODIGO;

    [KeyField('CPI_SABOR')]
    [FieldName('CPI_SABOR')]
    property Sabor: String read FCPI_SABOR write setFCPI_SABOR;

    [FieldName('CPI_SEQUENCIA')]
    property Sequencia: Integer read FCPI_SEQUENCIA write setFCPI_SEQUENCIA;

    [KeyField('CPI_CODPRO')]
    [FieldName('CPI_CODPRO')]
    property CodigoProduto: Integer read FCPI_CODPRO write setFCPI_CODPRO;

    [FieldName('CPI_QTDE')]
    property Qtde: Real read FCPI_QTDE write setFCPI_QTDE;

    [FieldName('CPI_VALOR')]
    property Valor: Real read FCPI_VALOR write setFCPI_VALOR;

    [FieldName('CPI_TIPO')]
    property Tipo: String read FCPI_TIPO write setFCPI_TIPO;

    [FieldName('CPI_CODGRP')]
    property Grupo: Integer read FCPI_CODGRP write setFCPI_CODGRP;
  End;

implementation


{ TCrpItens }

procedure TCrpItens.setFCPI_CODGRP(const Value: Integer);
begin
  FCPI_CODGRP := Value;
end;

procedure TCrpItens.setFCPI_CODIGO(const Value: Integer);
begin
  FCPI_CODIGO := Value;
end;

procedure TCrpItens.setFCPI_CODPRO(const Value: Integer);
begin
  FCPI_CODPRO := Value;
end;

procedure TCrpItens.setFCPI_QTDE(const Value: Real);
begin
  FCPI_QTDE := Value;
end;

procedure TCrpItens.setFCPI_SABOR(const Value: String);
begin
  FCPI_SABOR := Value;
end;

procedure TCrpItens.setFCPI_SEQUENCIA(const Value: Integer);
begin
  FCPI_SEQUENCIA := Value;
end;

procedure TCrpItens.setFCPI_TIPO(const Value: String);
begin
  FCPI_TIPO := Value;
end;

procedure TCrpItens.setFCPI_VALOR(const Value: Real);
begin
  FCPI_VALOR := Value;
end;

end.
