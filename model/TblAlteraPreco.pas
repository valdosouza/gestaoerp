unit TblAlteraPreco;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_altera_preco')]
  TAlteraPreco = Class(TGenericEntity)

  private
    Fapr_Codigo: Integer;
    Fapr_codpro: Integer;
    Fapr_vl_anterior: Real;
    Fapr_vl_atual: Real;
    Fapr_datatime: TDateTime;
    Fapr_codusu : Integer;
    Fapr_codest: Integer;
    Fapr_codtpr: Integer;

    procedure setFapr_codest(const Value: Integer);
    procedure setFapr_codigo(const Value: Integer);
    procedure setFapr_codpro(const Value: Integer);
    procedure setFapr_codtpr(const Value: Integer);
    procedure setFapr_codusu(const Value: Integer);
    procedure setFapr_datatime(const Value: TDateTime);
    procedure setFapr_vl_anterior(const Value: Real);
    procedure setFapr_vl_atual(const Value: Real);
  public

    [FieldName('apr_codigo')]
    [KeyField('apr_codigo')]
    property Codigo: Integer read Fapr_codigo write setFapr_codigo;

    [KeyField('APR_CODPRO')]
    [FieldName('APR_CODPRO')]
    property CodPro: Integer read Fapr_codpro write setFapr_codpro;

    [FieldName('apr_vl_anterior')]
    property VlAnterior: Real read Fapr_vl_anterior write setFapr_vl_anterior;

    [FieldName('apr_vl_atual')]
    property VlAtual: Real read Fapr_vl_atual write setFapr_vl_atual;

    [FieldName('apr_datatime')]
    property DataTime: TDateTime read Fapr_datatime write setFapr_datatime;

    [FieldName('apr_codusu')]
    property Codusu: Integer read Fapr_codusu write setFapr_codusu;

    [FieldName('apr_codest')]
    property Codest: Integer read Fapr_codest write setFapr_codest;

    [FieldName('apr_codtpr')]
    property CodTpr: Integer read Fapr_codtpr write setFapr_codtpr;
  End;

  implementation
{ TAlteraPreco }

procedure TAlteraPreco.setFapr_codest(const Value: Integer);
begin
  Fapr_codest := Value;
end;

procedure TAlteraPreco.setFapr_codigo(const Value: Integer);
begin
  Fapr_codigo := Value;
end;

procedure TAlteraPreco.setFapr_codpro(const Value: Integer);
begin
  Fapr_codpro := Value;
end;

procedure TAlteraPreco.setFapr_codtpr(const Value: Integer);
begin
  Fapr_codtpr := Value;
end;

procedure TAlteraPreco.setFapr_codusu(const Value: Integer);
begin
  Fapr_codusu := Value;
end;

procedure TAlteraPreco.setFapr_datatime(const Value: TDateTime);
begin
  Fapr_datatime := Value;
end;

procedure TAlteraPreco.setFapr_vl_anterior(const Value: Real);
begin
  Fapr_vl_anterior := Value;
end;

procedure TAlteraPreco.setFapr_vl_atual(const Value: Real);
begin
  Fapr_vl_atual := Value;
end;
end.

