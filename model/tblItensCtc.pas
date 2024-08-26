unit tblItensCtc;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_ITENS_CTC')]
  TItensCtc = Class(TGenericEntity)
  private
    FICT_AQ_ICMS: Real;
    FICT_VL_DESC: Real;
    FICT_VL_PRATICADO: Integer;
    FICT_CODVCL: Integer;
    FICT_SEQUENCIA: Integer;
    FICT_COR: String;
    FICT_VL_CUSTO: Real;
    FIICT_TECIDO: String;
    FICT_CODTPR: Integer;
    FICT_CODIGOCTC: Integer;
    FICT_DISPON: String;
    FICT_ALIQ_CT_FINANCEIRO: Real;
    FICT_AQ_COM: Real;
    FICT_DESCRICAO: String;
    FICT_ALTURA: Real;
    FMNU_CODIGO: Integer;
    FICT_VL_UNIT: Real;
    FICT_CODPED: Integer;
    FICT_AQ_VENDEDOR: Real;
    FICT_PRZ_PRATICADO: Integer;
    FICT_LARGURA: Real;
    FICT_QTDE: Real;
    FICT_AQ_DESC: Real;
    FICT_AQ_IPI: Real;
    FICT_MR_LUCRO: Real;
    FICT_CODEST: Integer;
    FICT_TIPO: String;
    FCodigoFabrica: String;
    FSubTotal: currency;
    procedure setFICT_ALIQ_CT_FINANCEIRO(const Value: Real);
    procedure setFICT_ALTURA(const Value: Real);
    procedure setFICT_AQ_COM(const Value: Real);
    procedure setFICT_AQ_DESC(const Value: Real);
    procedure setFICT_AQ_ICMS(const Value: Real);
    procedure setFICT_AQ_IPI(const Value: Real);
    procedure setFICT_AQ_VENDEDOR(const Value: Real);
    procedure setFICT_CODEST(const Value: Integer);
    procedure setFICT_CODIGOCTC(const Value: Integer);
    procedure setFICT_CODPED(const Value: Integer);
    procedure setFICT_CODTPR(const Value: Integer);
    procedure setFICT_CODVCL(const Value: Integer);
    procedure setFICT_COR(const Value: String);
    procedure setFICT_DESCRICAO(const Value: String);
    procedure setFICT_DISPON(const Value: String);
    procedure setFICT_LARGURA(const Value: Real);
    procedure setFICT_MR_LUCRO(const Value: Real);
    procedure setFICT_PRZ_PRATICADO(const Value: Integer);
    procedure setFICT_QTDE(const Value: Real);
    procedure setFICT_SEQUENCIA(const Value: Integer);
    procedure setFICT_TECIDO(const Value: String);
    procedure setFICT_TIPO(const Value: String);
    procedure setFICT_VL_CUSTO(const Value: Real);
    procedure setFICT_VL_DESC(const Value: Real);
    procedure setFICT_VL_PRATICADO(const Value: Integer);
    procedure setFICT_VL_UNIT(const Value: Real);
    procedure setFMNU_CODIGO(const Value: Integer);
    procedure setFCodigoFabrica(const Value: String);
    procedure setFSubTotal(const Value: currency);
  public
    [KeyField('ICT_CODIGO')]
    [FieldName('ICT_CODIGO')]
    property Codigo: Integer read FMNU_CODIGO write setFMNU_CODIGO;

    [FieldName('ICT_CODCTC')]
    property CodCTC: Integer read FICT_CODIGOCTC write setFICT_CODIGOCTC;

    [FieldName('ICT_TIPO')]
    property Tipo: String read FICT_TIPO write setFICT_TIPO;

    [FieldName('ICT_CODVCL')]
    property CodVCL: Integer read FICT_CODVCL write setFICT_CODVCL;

    [FieldName('ICT_DESCRICAO')]
    property Descricao: String read FICT_DESCRICAO write setFICT_DESCRICAO;

    [FieldName('ICT_QTDE')]
    property Qtde: Real read FICT_QTDE write setFICT_QTDE;

    [FieldName('ICT_VL_UNIT')]
    property ValorUnitario: Real read FICT_VL_UNIT write setFICT_VL_UNIT;

    [FieldName('ICT_DISPON')]
    property Dispon: String read FICT_DISPON write setFICT_DISPON;

    [FieldName('ICT_AQ_COM')]
    property AQ_COM: Real read FICT_AQ_COM write setFICT_AQ_COM;

    [FieldName('ICT_VL_DESC')]
    property ValorDesc: Real read FICT_VL_DESC write setFICT_VL_DESC;

    [FieldName('ICT_AQ_DESC')]
    property AQ_Desc: Real read FICT_AQ_DESC write setFICT_AQ_DESC;

    [FieldName('ICT_AQ_IPI')]
    property AQ_IPI: Real read FICT_AQ_IPI write setFICT_AQ_IPI;

    [FieldName('ICT_AQ_ICMS')]
    property AQ_ICMS: Real read FICT_AQ_ICMS write setFICT_AQ_ICMS;

    [FieldName('ICT_CODEST')]
    property CodEst: Integer read FICT_CODEST write setFICT_CODEST;

    [FieldName('ICT_CODTPR')]
    property CodTPR: Integer read FICT_CODTPR write setFICT_CODTPR;

    [FieldName('ICT_VL_CUSTO')]
    property ValorCusto: Real read FICT_VL_CUSTO write setFICT_VL_CUSTO;

    [FieldName('ICT_MR_LUCRO')]
    property MR_Lucro: Real read FICT_MR_LUCRO write setFICT_MR_LUCRO;

    [FieldName('ICT_ALIQ_CT_FINANCEIRO')]
    property Aliq_CT_Financeiro: Real read FICT_ALIQ_CT_FINANCEIRO write setFICT_ALIQ_CT_FINANCEIRO;

    [FieldName('ICT_PRZ_PRATICADO')]
    property PRZ_Praticado: Integer read FICT_PRZ_PRATICADO write setFICT_PRZ_PRATICADO;

    [FieldName('ICT_VL_PRATICADO')]
    property ValorPraticado: Integer read FICT_VL_PRATICADO write setFICT_VL_PRATICADO;   //vl de valor, mas inteiro? *Verificar

    [FieldName('ICT_AQ_VENDEDOR')]
    property Vendedor: Real read FICT_AQ_VENDEDOR write setFICT_AQ_VENDEDOR;

    [FieldName('ICT_TECIDO')]
    property Tecido: String read FIICT_TECIDO write setFICT_TECIDO;

    [FieldName('ICT_COR')]
    property Cor: String read FICT_COR write setFICT_COR;

    [FieldName('ICT_CODPED')]
    property CodPed: Integer read FICT_CODPED write setFICT_CODPED;

    [FieldName('ICT_ALTURA')]
    property Altura: Real read FICT_ALTURA write setFICT_ALTURA;

    [FieldName('ICT_LARGURA')]
    property Largura: Real read FICT_LARGURA write setFICT_LARGURA;

    [FieldName('ICT_SEQUENCIA')]
    property Sequencia: Integer read FICT_SEQUENCIA write setFICT_SEQUENCIA;

    {$Region 'TRegQuotationLog - Campos - Grid - Detalhes do Orçamento'}
    property CodigoFabrica: String read FCodigoFabrica write setFCodigoFabrica; //tblProduto - PRO_CODIGOFAB
    property SubTotal: currency read FSubTotal write setFSubTotal; //tblProduto - PRO_CODIGOFAB
    {property ValorCusto_tblProduto: Real read FValorCusto_tblProduto write setFValorCusto_tblProduto;   //tblProduto - PRO_VL_CUSTO
    property Divisor_tblProduto: Integer read FDivisor_tblProduto write setFDivisor_tblProduto;     //tblProduto - PRO_DIVISOR
    property Codigo_tblProduto: Integer read FCodigo_tblProduto write setFCodigo_tblProduto;        //tblProduto - PRO_CODIGO
    property Modalidade_tblTabelaPreco: String read FModalidade_tblTabelaPreco write setFModalidade_tblTabelaPreco; //tblTabelaPreco - TPR_MODALIDADE }
    {$EndRegion}
  End;

implementation

{ TItensCtc }

procedure TItensCtc.setFCodigoFabrica(const Value: String);
begin
  FCodigoFabrica := Value;
end;

procedure TItensCtc.setFICT_ALIQ_CT_FINANCEIRO(const Value: Real);
begin
  FICT_ALIQ_CT_FINANCEIRO := Value;
end;

procedure TItensCtc.setFICT_ALTURA(const Value: Real);
begin
  FICT_ALTURA := Value;
end;

procedure TItensCtc.setFICT_AQ_COM(const Value: Real);
begin
  FICT_AQ_COM := Value;
end;

procedure TItensCtc.setFICT_AQ_DESC(const Value: Real);
begin
  FICT_AQ_DESC := Value;
end;

procedure TItensCtc.setFICT_AQ_ICMS(const Value: Real);
begin
  FICT_AQ_ICMS := Value;
end;

procedure TItensCtc.setFICT_AQ_IPI(const Value: Real);
begin
  FICT_AQ_IPI := Value;
end;

procedure TItensCtc.setFICT_AQ_VENDEDOR(const Value: Real);
begin
  FICT_AQ_VENDEDOR := Value;
end;

procedure TItensCtc.setFICT_CODEST(const Value: Integer);
begin
  FICT_CODEST := Value;
end;

procedure TItensCtc.setFICT_CODIGOCTC(const Value: Integer);
begin
  FICT_CODIGOCTC := Value;
end;

procedure TItensCtc.setFICT_CODPED(const Value: Integer);
begin
  FICT_CODPED := Value;
end;

procedure TItensCtc.setFICT_CODTPR(const Value: Integer);
begin
  FICT_CODTPR := Value;
end;

procedure TItensCtc.setFICT_CODVCL(const Value: Integer);
begin
  FICT_CODVCL := Value;
end;

procedure TItensCtc.setFICT_COR(const Value: String);
begin
  FICT_COR := Value;
end;

procedure TItensCtc.setFICT_DESCRICAO(const Value: String);
begin
  FICT_DESCRICAO := Value;
end;

procedure TItensCtc.setFICT_DISPON(const Value: String);
begin
  FICT_DISPON := Value;
end;

procedure TItensCtc.setFICT_LARGURA(const Value: Real);
begin
  FICT_LARGURA := Value;
end;

procedure TItensCtc.setFICT_MR_LUCRO(const Value: Real);
begin
  FICT_MR_LUCRO := Value;
end;

procedure TItensCtc.setFICT_PRZ_PRATICADO(const Value: Integer);
begin
  FICT_PRZ_PRATICADO := Value;
end;

procedure TItensCtc.setFICT_QTDE(const Value: Real);
begin
  FICT_QTDE := Value;
end;

procedure TItensCtc.setFICT_SEQUENCIA(const Value: Integer);
begin
  FICT_SEQUENCIA := Value;
end;

procedure TItensCtc.setFICT_TECIDO(const Value: String);
begin
  FIICT_TECIDO := Value;
end;

procedure TItensCtc.setFICT_TIPO(const Value: String);
begin
  FICT_TIPO := Value;
end;

procedure TItensCtc.setFICT_VL_CUSTO(const Value: Real);
begin
  FICT_VL_CUSTO := Value;
end;

procedure TItensCtc.setFICT_VL_DESC(const Value: Real);
begin
  FICT_VL_DESC := Value;
end;

procedure TItensCtc.setFICT_VL_PRATICADO(const Value: Integer);
begin
  FICT_VL_PRATICADO := Value;
end;

procedure TItensCtc.setFICT_VL_UNIT(const Value: Real);
begin
  FICT_VL_UNIT := Value;
end;

procedure TItensCtc.setFMNU_CODIGO(const Value: Integer);
begin
  FMNU_CODIGO := Value;
end;

procedure TItensCtc.setFSubTotal(const Value: currency);
begin
  FSubTotal := Value;
end;

end.
