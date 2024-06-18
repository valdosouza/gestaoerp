unit tblProductionRealized;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ORPREAL')]
  TProductionRealized = Class(TGenericEntity)

  private
    FORL_CODPRO: Integer;
    FORL_CODIGO: Integer;
    FORL_QTDTOT: Real;
    FORL_CODORP: Integer;
    procedure setFORL_CODIGO(const Value: Integer);
    procedure setFORL_CODORP(const Value: Integer);
    procedure setFORL_CODPRO(const Value: Integer);
    procedure setFORL_QTDTOT(const Value: Real);

   public

    [KeyField('ORL_CODIGO')]
    [FieldName('ORL_CODIGO')]
    property Codigo: Integer read FORL_CODIGO write setFORL_CODIGO;

    [FieldName('ORL_CODORP')]
    property Ordem: Integer read FORL_CODORP write setFORL_CODORP;

    [FieldName('ORL_CODPRO')]
    property Produto: Integer read FORL_CODPRO write setFORL_CODPRO;

    [FieldName('ORL_QTDTOT')]
    property QtdeProduzida: Real read FORL_QTDTOT write setFORL_QTDTOT;

  End;


  implementation

{ TProductionRealized }

procedure TProductionRealized.setFORL_CODIGO(const Value: Integer);
begin
  FORL_CODIGO := Value;
end;

procedure TProductionRealized.setFORL_CODORP(const Value: Integer);
begin
  FORL_CODORP := Value;
end;

procedure TProductionRealized.setFORL_CODPRO(const Value: Integer);
begin
  FORL_CODPRO := Value;
end;

procedure TProductionRealized.setFORL_QTDTOT(const Value: Real);
begin
  FORL_QTDTOT := Value;
end;

end.
