unit tblItensCotacao;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_CTC')]
  TItensCotacao = Class(TGenericEntity)

  private
    FICT_ALIQ_CT_FINANCEIRO: REal;
    FICT_VL_DESC: Real;
    FICT_COR: String;
    FICT_VL_CUSTO: REal;
    FICT_TECIDO: String;
    FICT_AQ_DESC: REal;
    FICT_CODPED: Integer;
    FICT_AQ_IPI: REal;
    FICT_PRZ_PRATICADO: Integer;
    FICT_CODCTC: Integer;
    FICT_DESCRICAO: String;
    FICT_ALTURA: Real;
    FICT_CODIGO: Integer;
    FICT_VL_UNIT: REal;
    FICT_MR_LUCRO: Real;
    FICT_CODVCL: Integer;
    FICT_VL_PRATICADO: Integer;
    FICT_LARGURA: Real;
    FICT_AQ_ICMS: REal;
    FICT_CODTPR: Integer;
    FICT_QTDE: REal;
    FICT_DISPON: String;
    FICT_CODEST: Integer;
    FICT_AQ_VENDEDOR: REal;
    FICT_TIPO: String;
    FICT_AQ_COM: REal;
    FSubTotal: Real;
    FCodigoFabrica: String;

    procedure setFICT_ALIQ_CT_FINANCEIRO(const Value: REal);
    procedure setFICT_ALTURA(const Value: Real);
    procedure setFICT_AQ_COM(const Value: REal);
    procedure setFICT_AQ_DESC(const Value: REal);
    procedure setFICT_AQ_ICMS(const Value: REal);
    procedure setFICT_AQ_IPI(const Value: REal);
    procedure setFICT_AQ_VENDEDOR(const Value: REal);
    procedure setFICT_CODCTC(const Value: Integer);
    procedure setFICT_CODEST(const Value: Integer);
    procedure setFICT_CODIGO(const Value: Integer);
    procedure setFICT_CODPED(const Value: Integer);
    procedure setFICT_CODTPR(const Value: Integer);
    procedure setFICT_CODVCL(const Value: Integer);
    procedure setFICT_COR(const Value: String);
    procedure setFICT_DESCRICAO(const Value: String);
    procedure setFICT_DISPON(const Value: String);
    procedure setFICT_LARGURA(const Value: Real);
    procedure setFICT_MR_LUCRO(const Value: Real);
    procedure setFICT_PRZ_PRATICADO(const Value: Integer);
    procedure setFICT_QTDE(const Value: REal);
    procedure setFICT_TECIDO(const Value: String);
    procedure setFICT_TIPO(const Value: String);
    procedure setFICT_VL_CUSTO(const Value: REal);
    procedure setFICT_VL_DESC(const Value: Real);
    procedure setFICT_VL_PRATICADO(const Value: Integer);
    procedure setFICT_VL_UNIT(const Value: REal);

    procedure setFSubTotal(const Value: Real);
    procedure setFCodigoFabrica(const Value: String);

  PUBLIC
    [FieldName('ICT_CODIGO')]
    [KeyField('ICT_CODIGO')]
    property Codigo: Integer read FICT_CODIGO write setFICT_CODIGO;

    [FieldName('ICT_CODCTC')]
    property Cotacao: Integer read FICT_CODCTC write setFICT_CODCTC;

    [FieldName('ICT_TIPO')]
    property Tipo: String read FICT_TIPO write setFICT_TIPO;

    [FieldName('ICT_CODVCL')]
    property Vinculo: Integer read FICT_CODVCL write setFICT_CODVCL;

    [FieldName('ICT_DESCRICAO')]
    property DEscricao: String read FICT_DESCRICAO write setFICT_DESCRICAO;

    [FieldName('ICT_QTDE')]
    property Quantidade: REal read FICT_QTDE write setFICT_QTDE;

    [FieldName('ICT_VL_UNIT')]
    property ValorUnitario: REal read FICT_VL_UNIT write setFICT_VL_UNIT;

    [FieldName('ICT_DISPON')]
    property Disponivel: String read FICT_DISPON write setFICT_DISPON;

    [FieldName('ICT_AQ_COM')]
    property AliqComissao: REal read FICT_AQ_COM write setFICT_AQ_COM;

    [FieldName('ICT_VL_DESC')]
    property ValorDEsc: Real read FICT_VL_DESC write setFICT_VL_DESC;

    [FieldName('ICT_AQ_DESC')]
    property ALiqDesc: REal read FICT_AQ_DESC write setFICT_AQ_DESC;

    [FieldName('ICT_AQ_IPI')]
    property AliqIPI: REal read FICT_AQ_IPI write setFICT_AQ_IPI;

    [FieldName('ICT_AQ_ICMS')]
    property AliqICMS: REal read FICT_AQ_ICMS write setFICT_AQ_ICMS;

    [FieldName('ICT_CODEST')]
    property CodigoEstoque: Integer read FICT_CODEST write setFICT_CODEST;

    [FieldName('ICT_CODTPR')]
    property TabelaPreco: Integer read FICT_CODTPR write setFICT_CODTPR;

    [FieldName('ICT_VL_CUSTO')]
    property ValorCusto: REal read FICT_VL_CUSTO write setFICT_VL_CUSTO;

    [FieldName('ICT_MR_LUCRO')]
    property MargemLucro: Real read FICT_MR_LUCRO write setFICT_MR_LUCRO;

    [FieldName('ICT_ALIQ_CT_FINANCEIRO')]
    property AliqCtFinanceiro: REal read FICT_ALIQ_CT_FINANCEIRO write setFICT_ALIQ_CT_FINANCEIRO;

    [FieldName('ICT_PRZ_PRATICADO')]
    property PRazoPraticado: Integer read FICT_PRZ_PRATICADO write setFICT_PRZ_PRATICADO;

    [FieldName('ICT_VL_PRATICADO')]
    property ValorPratica: Integer read FICT_VL_PRATICADO write setFICT_VL_PRATICADO;

    [FieldName('ICT_AQ_VENDEDOR')]
    property AliqVendedor: REal read FICT_AQ_VENDEDOR write setFICT_AQ_VENDEDOR;

    [FieldName('ICT_TECIDO')]
    property Tecido: String read FICT_TECIDO write setFICT_TECIDO;

    [FieldName('ICT_COR')]
    property Cor: String read FICT_COR write setFICT_COR;

    [FieldName('ICT_CODPED')]
    property Pedido: Integer read FICT_CODPED write setFICT_CODPED;

    [FieldName('ICT_ALTURA')]
    property Altura: Real read FICT_ALTURA write setFICT_ALTURA;

    [FieldName('ICT_LARGURA')]
    property Largura: Real read FICT_LARGURA write setFICT_LARGURA;

    //Não vinculados ao banco
    property CodigoFabrica: String read FCodigoFabrica write setFCodigoFabrica;
    property SubTotal : Real read FSubTotal write setFSubTotal;

  End;
implementation

{ TItensCotacao }

procedure TItensCotacao.setFCodigoFabrica(const Value: String);
begin
  FCodigoFabrica := Value;
end;

procedure TItensCotacao.setFICT_ALIQ_CT_FINANCEIRO(const Value: REal);
begin
  FICT_ALIQ_CT_FINANCEIRO := Value;
end;

procedure TItensCotacao.setFICT_ALTURA(const Value: Real);
begin
  FICT_ALTURA := Value;
end;

procedure TItensCotacao.setFICT_AQ_COM(const Value: REal);
begin
  FICT_AQ_COM := Value;
end;

procedure TItensCotacao.setFICT_AQ_DESC(const Value: REal);
begin
  FICT_AQ_DESC := Value;
end;

procedure TItensCotacao.setFICT_AQ_ICMS(const Value: REal);
begin
  FICT_AQ_ICMS := Value;
end;

procedure TItensCotacao.setFICT_AQ_IPI(const Value: REal);
begin
  FICT_AQ_IPI := Value;
end;

procedure TItensCotacao.setFICT_AQ_VENDEDOR(const Value: REal);
begin
  FICT_AQ_VENDEDOR := Value;
end;

procedure TItensCotacao.setFICT_CODCTC(const Value: Integer);
begin
  FICT_CODCTC := Value;
end;

procedure TItensCotacao.setFICT_CODEST(const Value: Integer);
begin
  FICT_CODEST := Value;
end;

procedure TItensCotacao.setFICT_CODIGO(const Value: Integer);
begin
  FICT_CODIGO := Value;
end;

procedure TItensCotacao.setFICT_CODPED(const Value: Integer);
begin
  FICT_CODPED := Value;
end;

procedure TItensCotacao.setFICT_CODTPR(const Value: Integer);
begin
  FICT_CODTPR := Value;
end;

procedure TItensCotacao.setFICT_CODVCL(const Value: Integer);
begin
  FICT_CODVCL := Value;
end;

procedure TItensCotacao.setFICT_COR(const Value: String);
begin
  FICT_COR := Value;
end;

procedure TItensCotacao.setFICT_DESCRICAO(const Value: String);
begin
  FICT_DESCRICAO := Value;
end;

procedure TItensCotacao.setFICT_DISPON(const Value: String);
begin
  FICT_DISPON := Value;
end;

procedure TItensCotacao.setFICT_LARGURA(const Value: Real);
begin
  FICT_LARGURA := Value;
end;

procedure TItensCotacao.setFICT_MR_LUCRO(const Value: Real);
begin
  FICT_MR_LUCRO := Value;
end;

procedure TItensCotacao.setFICT_PRZ_PRATICADO(const Value: Integer);
begin
  FICT_PRZ_PRATICADO := Value;
end;

procedure TItensCotacao.setFICT_QTDE(const Value: REal);
begin
  FICT_QTDE := Value;
end;

procedure TItensCotacao.setFICT_TECIDO(const Value: String);
begin
  FICT_TECIDO := Value;
end;

procedure TItensCotacao.setFICT_TIPO(const Value: String);
begin
  FICT_TIPO := Value;
end;

procedure TItensCotacao.setFICT_VL_CUSTO(const Value: REal);
begin
  FICT_VL_CUSTO := Value;
end;

procedure TItensCotacao.setFICT_VL_DESC(const Value: Real);
begin
  FICT_VL_DESC := Value;
end;

procedure TItensCotacao.setFICT_VL_PRATICADO(const Value: Integer);
begin
  FICT_VL_PRATICADO := Value;
end;

procedure TItensCotacao.setFICT_VL_UNIT(const Value: REal);
begin
  FICT_VL_UNIT := Value;
end;

procedure TItensCotacao.setFSubTotal(const Value: Real);
begin
  FSubTotal := Value;
end;

end.
