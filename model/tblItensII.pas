unit tblItensII;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_II ')]
  TItensII = Class(TGenericEntity)
  private
    FIIP_CODITF: Integer;
    FIIP_VL_II: Real;
    FIIP_CODIGO: Integer;
    FIIP_CODNFL: Integer;
    FIIP_VL_IOF: real;
    FIIP_VL_DESP_AD: REal;
    FIIP_VL_BASE: Real;
    procedure setFIIP_CODIGO(const Value: Integer);
    procedure setFIIP_CODITF(const Value: Integer);
    procedure setFIIP_CODNFL(const Value: Integer);
    procedure setFIIP_VL_BASE(const Value: Real);
    procedure setFIIP_VL_DESP_AD(const Value: REal);
    procedure setFIIP_VL_II(const Value: Real);
    procedure setFIIP_VL_IOF(const Value: real);

  public

    [KeyField('IIP_CODIGO')]
    [FieldName('IIP_CODIGO')]
    property Codigo : Integer read FIIP_CODIGO write setFIIP_CODIGO;

    [FieldName('IIP_CODNFL')]
    property Nota : Integer read FIIP_CODNFL write setFIIP_CODNFL;

    [FieldName('IIP_CODITF')]
    property ItemNota : Integer read FIIP_CODITF write setFIIP_CODITF;

    [FieldName('IIP_VL_BASE')]
    property ValorBase : Real read FIIP_VL_BASE write setFIIP_VL_BASE;

    [FieldName('IIP_VL_DESP_AD')]
    property ValorDespesaAd : REal read FIIP_VL_DESP_AD write setFIIP_VL_DESP_AD;

    [FieldName('IIP_VL_II')]
    property Valor : Real read FIIP_VL_II write setFIIP_VL_II;

    [FieldName('IIP_VL_IOF')]
    property ValorIOF : real read FIIP_VL_IOF write setFIIP_VL_IOF;

  End;


implementation

{ TItensII }

procedure TItensII.setFIIP_CODIGO(const Value: Integer);
begin
  FIIP_CODIGO := Value;
end;

procedure TItensII.setFIIP_CODITF(const Value: Integer);
begin
  FIIP_CODITF := Value;
end;

procedure TItensII.setFIIP_CODNFL(const Value: Integer);
begin
  FIIP_CODNFL := Value;
end;

procedure TItensII.setFIIP_VL_BASE(const Value: Real);
begin
  FIIP_VL_BASE := Value;
end;

procedure TItensII.setFIIP_VL_DESP_AD(const Value: REal);
begin
  FIIP_VL_DESP_AD := Value;
end;

procedure TItensII.setFIIP_VL_II(const Value: Real);
begin
  FIIP_VL_II := Value;
end;

procedure TItensII.setFIIP_VL_IOF(const Value: real);
begin
  FIIP_VL_IOF := Value;
end;

end.
