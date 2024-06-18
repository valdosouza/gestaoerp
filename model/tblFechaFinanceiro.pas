unit tblFechaFinanceiro;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_Fecha_Financeiro')]
  TFechaFinanceiro = Class(TGenericEntity)
  private
    FSET_VALUE: Real;
    FTb_planocontas_id: Integer;
    FDt_Record: TDate;

    procedure SetFDt_record(Value : TDate);
    procedure SetFTb_planocontas_id(Value : Integer);
    procedure SetFSet_value(Value : Real);
  public

    [KeyField('dt_record')]
    [FieldName('dt_record')]
    property Data: TDate read FDt_Record write setFDt_Record;

    [KeyField('tb_planocontas_id')]
    [FieldName('tb_planocontas_id')]
    property CodigoPlanoContas: Integer read FTb_planocontas_id write setFTb_planocontas_id;

    [FieldName('set_value')]
    property Valor: Real read FSET_VALUE write setFSET_VALUE;

  End;

implementation

{ TFechaFinanceiro }

procedure TFechaFinanceiro.SetFDt_record(Value: TDate);
begin
  FDt_Record := Value;
end;

procedure TFechaFinanceiro.SetFSet_value(Value: Real);
begin
  FSET_VALUE := Value;
end;

procedure TFechaFinanceiro.SetFTb_planocontas_id(Value: Integer);
begin
  FTb_planocontas_id := Value;
end;

end.
