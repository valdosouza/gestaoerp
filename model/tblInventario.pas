unit tblInventario;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_INVENTARIO')]
  TInventario = Class(TGenericEntity)
  private
    FIVT_CODPRO: Integer;
    FIVT_VL_CUSTO: Real;
    FIVT_QT_ATUAL: Real;
    FIVT_VL_SAI_VDA: Real;
    FIVT_QT_ENT_OTR: Real;
    FIVT_CODIGO: Integer;
    FIVT_CODETS: Integer;
    FIVT_VL_SAI_OTR: Real;
    FIVT_VL_CUSTO_ANT: Real;
    FIVT_VL_ENT_CPA: Real;
    FIVT_CODMHA: Integer;
    FIVT_QT_SAI_VDA: Real;
    FIVT_VL_ENT_OTR: Real;
    FIVT_QT_AUTO: Real;
    FIVT_QT_SAI_OTR: Real;
    FIVT_QT_ENT_CPA: Real;
    FIVT_QT_ANT: Real;
    FIVT_DATA: TDate;
    procedure setFIVT_CODETS(const Value: Integer);
    procedure setFIVT_CODIGO(const Value: Integer);
    procedure setFIVT_CODMHA(const Value: Integer);
    procedure setFIVT_CODPRO(const Value: Integer);
    procedure setFIVT_DATA(const Value: TDate);
    procedure setFIVT_QT_ANT(const Value: Real);
    procedure setFIVT_QT_ATUAL(const Value: Real);
    procedure setFIVT_QT_AUTO(const Value: Real);
    procedure setFIVT_QT_ENT_CPA(const Value: Real);
    procedure setFIVT_QT_ENT_OTR(const Value: Real);
    procedure setFIVT_QT_SAI_OTR(const Value: Real);
    procedure setFIVT_QT_SAI_VDA(const Value: Real);
    procedure setFIVT_VL_CUSTO(const Value: Real);
    procedure setFIVT_VL_CUSTO_ANT(const Value: Real);
    procedure setFIVT_VL_ENT_CPA(const Value: Real);
    procedure setFIVT_VL_ENT_OTR(const Value: Real);
    procedure setFIVT_VL_SAI_OTR(const Value: Real);
    procedure setFIVT_VL_SAI_VDA(const Value: Real);

  public

    [FieldName('IVT_CODIGO')]
    property  Codigo: Integer read FIVT_CODIGO write setFIVT_CODIGO;

    [KeyField('IVT_DATA')]
    [FieldName('IVT_DATA')]
    property Data:TDate read FIVT_DATA write setFIVT_DATA;

    [KeyField('IVT_CODETS')]
    [FieldName('IVT_CODETS')]
    property Estoque:Integer read FIVT_CODETS write setFIVT_CODETS;

    [KeyField('IVT_CODPRO')]
    [FieldName('IVT_CODPRO')]
    property Produto:Integer read FIVT_CODPRO write setFIVT_CODPRO;

    [KeyField('IVT_CODMHA')]
    [FieldName('IVT_CODMHA')]
    property Estabelecimento:Integer read FIVT_CODMHA write setFIVT_CODMHA;

    [FieldName('IVT_QT_ANT')]
    property QtdeAnterior:Real  read FIVT_QT_ANT write setFIVT_QT_ANT;

    [FieldName('IVT_VL_CUSTO_ANT')]
    property ValorCustoAnterior:Real read FIVT_VL_CUSTO_ANT write setFIVT_VL_CUSTO_ANT;

    [FieldName('IVT_QT_ENT_CPA')]
    property QtdeCompra:Real read FIVT_QT_ENT_CPA write setFIVT_QT_ENT_CPA;

    [FieldName('IVT_VL_ENT_CPA')]
    property  ValorCompra:Real read FIVT_VL_ENT_CPA write setFIVT_VL_ENT_CPA;

    [FieldName('IVT_QT_ENT_OTR')]
    property QtdeOutrasEntradas:Real read FIVT_QT_ENT_OTR write setFIVT_QT_ENT_OTR;

    [FieldName('IVT_VL_ENT_OTR')]
    property ValorOutrasEntradas:Real read FIVT_VL_ENT_OTR write setFIVT_VL_ENT_OTR;

    [FieldName('IVT_QT_SAI_VDA')]
    property QtdeVenda : Real read FIVT_QT_SAI_VDA write setFIVT_QT_SAI_VDA;

    [FieldName('IVT_VL_SAI_VDA')]
    property ValorVenda:Real read FIVT_VL_SAI_VDA write setFIVT_VL_SAI_VDA;

    [FieldName('IVT_QT_SAI_OTR')]
    property QtdeOutrasSaidas:Real read FIVT_QT_SAI_OTR write setFIVT_QT_SAI_OTR;

    [FieldName('IVT_VL_SAI_OTR')]
    property ValorOutrasSaidas:Real read FIVT_VL_SAI_OTR write setFIVT_VL_SAI_OTR;

    [FieldName('IVT_QT_ATUAL')]
    property QtdeAtual:Real read FIVT_QT_ATUAL write setFIVT_QT_ATUAL;

    [FieldName('IVT_VL_CUSTO')]
    property ValorCusto:Real read FIVT_VL_CUSTO write setFIVT_VL_CUSTO;

    [FieldName('IVT_QT_AUTO')]
    property QtdeAutomatica:Real read FIVT_QT_AUTO write setFIVT_QT_AUTO;

  End;


implementation

{ TInventario }

procedure TInventario.setFIVT_CODETS(const Value: Integer);
begin
  FIVT_CODETS := Value;
end;

procedure TInventario.setFIVT_CODIGO(const Value: Integer);
begin
  FIVT_CODIGO := Value;
end;

procedure TInventario.setFIVT_CODMHA(const Value: Integer);
begin
  FIVT_CODMHA := Value;
end;

procedure TInventario.setFIVT_CODPRO(const Value: Integer);
begin
  FIVT_CODPRO := Value;
end;

procedure TInventario.setFIVT_DATA(const Value: TDate);
begin
  FIVT_DATA := Value;
end;

procedure TInventario.setFIVT_QT_ANT(const Value: Real);
begin
  FIVT_QT_ANT := Value;
end;

procedure TInventario.setFIVT_QT_ATUAL(const Value: Real);
begin
  FIVT_QT_ATUAL := Value;
end;

procedure TInventario.setFIVT_QT_AUTO(const Value: Real);
begin
  FIVT_QT_AUTO := Value;
end;

procedure TInventario.setFIVT_QT_ENT_CPA(const Value: Real);
begin
  FIVT_QT_ENT_CPA := Value;
end;

procedure TInventario.setFIVT_QT_ENT_OTR(const Value: Real);
begin
  FIVT_QT_ENT_OTR := Value;
end;

procedure TInventario.setFIVT_QT_SAI_OTR(const Value: Real);
begin
  FIVT_QT_SAI_OTR := Value;
end;

procedure TInventario.setFIVT_QT_SAI_VDA(const Value: Real);
begin
  FIVT_QT_SAI_VDA := Value;
end;

procedure TInventario.setFIVT_VL_CUSTO(const Value: Real);
begin
  FIVT_VL_CUSTO := Value;
end;

procedure TInventario.setFIVT_VL_CUSTO_ANT(const Value: Real);
begin
  FIVT_VL_CUSTO_ANT := Value;
end;

procedure TInventario.setFIVT_VL_ENT_CPA(const Value: Real);
begin
  FIVT_VL_ENT_CPA := Value;
end;

procedure TInventario.setFIVT_VL_ENT_OTR(const Value: Real);
begin
  FIVT_VL_ENT_OTR := Value;
end;

procedure TInventario.setFIVT_VL_SAI_OTR(const Value: Real);
begin
  FIVT_VL_SAI_OTR := Value;
end;

procedure TInventario.setFIVT_VL_SAI_VDA(const Value: Real);
begin
  FIVT_VL_SAI_VDA := Value;
end;

end.
