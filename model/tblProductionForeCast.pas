unit tblProductionForeCast;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ORPPREV')]
  TProductionForeCast = Class(TGenericEntity)

  private
    FPRE_CODPRO: Integer;
    FPRE_CODIGO: Integer;
    FPRE_QTDUNI: Real;
    FPRE_CODORP: Integer;
    FPRE_VL_CUSTO: Real;
    procedure setFPRE_CODIGO(const Value: Integer);
    procedure setFPRE_CODORP(const Value: Integer);
    procedure setFPRE_CODPRO(const Value: Integer);
    procedure setFPRE_QTDUNI(const Value: Real);
    procedure setFPRE_VL_CUSTO(const Value: Real);


   public

    [KeyField('PRE_CODIGO')]
    [FieldName('PRE_CODIGO')]
    property Codigo: Integer read FPRE_CODIGO write setFPRE_CODIGO;

    [FieldName('PRE_CODORP')]
    property Ordem: Integer read FPRE_CODORP write setFPRE_CODORP;

    [FieldName('PRE_CODPRO')]
    property Produto: Integer read FPRE_CODPRO write setFPRE_CODPRO;

    [FieldName('PRE_QTDUNI')]
    property QtdeUnitario: Real read FPRE_QTDUNI write setFPRE_QTDUNI;

    [FieldName('PRE_VL_CUSTO')]
    property ValorCusto: Real read FPRE_VL_CUSTO write setFPRE_VL_CUSTO;

  End;


  implementation


{ TProductionForeCast }

procedure TProductionForeCast.setFPRE_CODIGO(const Value: Integer);
begin
  FPRE_CODIGO := Value;
end;

procedure TProductionForeCast.setFPRE_CODORP(const Value: Integer);
begin
  FPRE_CODORP := Value;
end;

procedure TProductionForeCast.setFPRE_CODPRO(const Value: Integer);
begin
  FPRE_CODPRO := Value;
end;

procedure TProductionForeCast.setFPRE_QTDUNI(const Value: Real);
begin
  FPRE_QTDUNI := Value;
end;

procedure TProductionForeCast.setFPRE_VL_CUSTO(const Value: Real);
begin
  FPRE_VL_CUSTO := Value;
end;

end.
