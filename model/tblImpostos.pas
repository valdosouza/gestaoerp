unit tblImpostos;

interface

Uses TEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_IMPOSTOS')]
  TImpostos = Class(TGenericEntity)
  private
    FIPT_CONT_SOCIAL: Real;
    FIPT_ICMS: Real;
    FIPT_PIS: real;
    FIPT_CODIGO: Integer;
    FIPT_IRPJ: Real;
    FIPT_COFINS: Real;
    FIPT_DT_ALT: Real;
    FIPT_TRANSFOR: Real;
    procedure setFIPT_CODIGO(const Value: Integer);
    procedure setFIPT_COFINS(const Value: Real);
    procedure setFIPT_CONT_SOCIAL(const Value: Real);
    procedure setFIPT_PIS(const Value: real);
    procedure setFIPT_DT_ALT(const Value: Real);
    procedure setFIPT_ICMS(const Value: Real);
    procedure setFIPT_IRPJ(const Value: Real);
    procedure setFIPT_TRANSFOR(const Value: Real);
  public
    [KeyField('IPT_CODIGO')]
    [FieldName('IPT_CODIGO')]
    property Codigo: Integer read FIPT_CODIGO write setFIPT_CODIGO;
    [FieldName('IPT_PIS')]
    property Pis: real read FIPT_PIS write setFIPT_PIS;
    [FieldName('IPT_COFINS')]
    property Cofins: Real read FIPT_COFINS write setFIPT_COFINS;
    [FieldName('IPT_CONT_SOCIAL')]
    property ContSocial: Real read FIPT_CONT_SOCIAL write setFIPT_CONT_SOCIAL;
    [FieldName('IPT_IRPJ')]
    property Irpj: Real read FIPT_IRPJ write setFIPT_IRPJ;
    [FieldName('IPT_TRANSFOR')]
    property Transfor: Real read FIPT_TRANSFOR write setFIPT_TRANSFOR;
    [FieldName('IPT_DT_ALT')]
    property DtAlt: Real read FIPT_DT_ALT write setFIPT_DT_ALT;
    [FieldName('IPT_ICMS')]
    property Icms: Real read FIPT_ICMS write setFIPT_ICMS;
  end;

implementation

{ TImpostos }

procedure TImpostos.setFIPT_CODIGO(const Value: Integer);
begin
  FIPT_CODIGO := Value;
end;

procedure TImpostos.setFIPT_COFINS(const Value: Real);
begin
  FIPT_COFINS := Value;
end;

procedure TImpostos.setFIPT_CONT_SOCIAL(const Value: Real);
begin
  FIPT_CONT_SOCIAL := Value;
end;

procedure TImpostos.setFIPT_PIS(const Value: real);
begin
  FIPT_PIS := Value;
end;

procedure TImpostos.setFIPT_DT_ALT(const Value: Real);
begin
  FIPT_DT_ALT := Value;
end;

procedure TImpostos.setFIPT_ICMS(const Value: Real);
begin
  FIPT_ICMS := Value;
end;

procedure TImpostos.setFIPT_IRPJ(const Value: Real);
begin
  FIPT_IRPJ := Value;
end;

procedure TImpostos.setFIPT_TRANSFOR(const Value: Real);
begin
  FIPT_TRANSFOR := Value;
end;

end.
