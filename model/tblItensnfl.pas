unit tblItensnfl;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_itens_nfl')]
  TItensNFL = Class(TGenericEntity)
  private

    FCODIGO      : Integer;
    FCODPED      : Integer;
    FCODNFL      : Integer;
    FCODPRO      : Integer;
    FQTDE        : Real;
    FVL_CUSTO    : Real;
    FVL_UNIT     : Real;
    FDESPACHO    : String;
    FESTOQUE     : String;
    FAQ_COM      : Real;
    FVL_DESC     : Real;
    FAQ_DESC     : Real;
    FAQ_IPI      : Real;
    FOPER        : String;
    FAQ_ICMS     : Real;
    FCODEST      : Integer;
    FCODTPR      : Integer;
    FALTURA      : Real;
    FLARGURA     : Real;
    FSENTIDO     : String;
    FCOMPRA      : String;
    FITEM_COMPRA :  String;
    FIMP_APROX   : Real;
    FNR_PECAS    : Real;
    FITF_SEQUENCIA: Integer;
    FCodigoEstabelecimento: Integer;
    FDescricaoProduto: String;
    FSubTotal: Real;
    FCodigoFabrica: string;

    procedure setFCODIGO( Value      : Integer);
    procedure setFCODPED( Value      : Integer);
    procedure setFCODNFL( Value      : Integer);
    procedure setFCODPRO( Value      : Integer);
    procedure setFQTDE( Value        : Real);
    procedure setFVL_CUSTO( Value    : Real);
    procedure setFVL_UNIT( Value     : Real);
    procedure setFDESPACHO( Value    : String);
    procedure setFESTOQUE( Value     : String);
    procedure setFAQ_COM( Value      : Real);
    procedure setFVL_DESC( Value     : Real);
    procedure setFAQ_DESC( Value     : Real);
    procedure setFAQ_IPI( Value      : Real);
    procedure setFOPER( Value        : String);
    procedure setFAQ_ICMS( Value     : Real);
    procedure setFCODEST( Value      : Integer);
    procedure setFCODTPR( Value      : Integer);
    procedure setFALTURA( Value      : Real);
    procedure setFLARGURA( Value     : Real);
    procedure setFSENTIDO( Value     : String);
    procedure setFCOMPRA( Value      : String);
    procedure setFITEM_COMPRA( Value :  String);
    procedure setFIMP_APROX( Value   : Real);
    procedure setFNR_PECAS( Value    : Real);
    procedure setFITF_SEQUENCIA(const Value: Integer);
    procedure setFCodigoEstabelecimento(const Value: Integer);
    procedure setFCodigoFabrica(const Value: string);
    procedure setFDescricaoProduto(const Value: String);
    procedure setFSubTotal(const Value: Real);

  public

    [KeyField('ITF_CODIGO')]
    [FieldName('ITF_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [FieldName('ITF_SEQUENCIA')]
    property Sequencia: Integer read FITF_SEQUENCIA write setFITF_SEQUENCIA;

    [FieldName('ITF_CODPED')]
    property CodigoPedido: Integer read FCODPED write setFCODPED;

    [FieldName('ITF_CODNFL')]
    property CodigoNota: Integer read FCODNFL write setFCODNFL;

    [FieldName('ITF_CODPRO')]
    property CodigoProduto: Integer read FCODPRO write setFCODPRO;

    [FieldName('ITF_QTDE')]
    property Quantidade: Real read FQTDE write setFQTDE;

    [FieldName('ITF_VL_CUSTO')]
    property ValorCusto: Real read FVL_CUSTO write setFVL_CUSTO;

    [FieldName('ITF_VL_UNIT')]
    property ValorUnitario: Real read FVL_UNIT write setFVL_UNIT;

    [FieldName('ITF_DESPACHO')]
    property Despachar: String read FDESPACHO write setFDESPACHO;

    [FieldName('ITF_ESTOQUE')]
    property Estoque: String read FESTOQUE write setFESTOQUE;

    [FieldName('ITF_AQ_COM')]
    property AliqComissao: Real read FAQ_COM write setFAQ_COM;

    [FieldName('ITF_VL_DESC')]
    property ValorDesconto: Real read FVL_DESC write setFVL_DESC;

    [FieldName('ITF_AQ_DESC')]
    property AliqDesconto: Real read FAQ_DESC write setFAQ_DESC;

    [FieldName('ITF_AQ_IPI')]
    property AliqIPI: Real read FAQ_IPI write setFAQ_IPI;

    [FieldName('ITF_OPER')]
    property Operacao: String read FOPER write setFOPER;

    [FieldName('ITF_AQ_ICMS')]
    property AliqICMS: Real read FAQ_ICMS write setFAQ_ICMS;

    [FieldName('ITF_CODEST')]
    property CodigoEstoque: Integer read FCODEST write setFCODEST;

    [FieldName('ITF_CODTPR')]
    property CodigoTabela: Integer read FCODTPR write setFCODTPR;

    [FieldName('ITF_ALTURA')]
    property Altura: Real read FALTURA write setFALTURA;

    [FieldName('ITF_LARGURA')]
    property Largura: Real read FLARGURA write setFLARGURA;

    [FieldName('ITF_SENTIDO')]
    property Sentido: String read FSENTIDO write setFSENTIDO;

    [FieldName('ITF_COMPRA')]
    property PedidoCompra: String read FCOMPRA write setFCOMPRA;

    [FieldName('ITF_ITEM_COMPRA')]
    property ItemCompra: String read FITEM_COMPRA write setFITEM_COMPRA;

    [FieldName('ITF_IMP_APROX')]
    property ImpostoAproximado: Real read FIMP_APROX write setFIMP_APROX;

    [FieldName('ITF_NR_PECAS')]
    property NumeroPecas: Real read FNR_PECAS write setFNR_PECAS;

    //(ITF_QTDE * ITF_VL_UNIT) ITF_VL_SUBTOTAL
    property SubTotal: Real read FSubTotal write setFSubTotal;

    //[FieldName('PRO_CODIGOFAB')]
    property CodigoFabrica: string read FCodigoFabrica write setFCodigoFabrica;

    //[FieldName('PRO_DESCRICAO')]
    property DescricaoProduto: String read FDescricaoProduto write setFDescricaoProduto;

    //[FieldName('PED_CODMHA')]
    property CodigoEstabelecimento: Integer read FCodigoEstabelecimento write setFCodigoEstabelecimento;
  End;

implementation

{ TItensNFL }

procedure TItensNFL.setFALTURA(Value: Real);
begin
  FALTURA := Value;
end;

procedure TItensNFL.setFAQ_COM(Value: Real);
begin
  FAQ_COM := Value;
end;

procedure TItensNFL.setFAQ_DESC(Value: Real);
begin
  FAQ_DESC := Value;
end;

procedure TItensNFL.setFAQ_ICMS(Value: Real);
begin
  FAQ_ICMS := Value;
end;

procedure TItensNFL.setFAQ_IPI(Value: Real);
begin
  FAQ_IPI := Value;
end;

procedure TItensNFL.setFCODEST(Value: Integer);
begin
  FCODEST := Value;
end;

procedure TItensNFL.setFCODIGO(Value: Integer);
begin
  FCODIGO  := Value;
end;

procedure TItensNFL.setFCodigoEstabelecimento(const Value: Integer);
begin
  FCodigoEstabelecimento := Value;
end;

procedure TItensNFL.setFCodigoFabrica(const Value: string);
begin
  FCodigoFabrica := Value;
end;

procedure TItensNFL.setFCODNFL(Value: Integer);
begin
  FCODNFL := Value;
end;

procedure TItensNFL.setFCODPED(Value: Integer);
begin
  FCODPED := Value;
end;

procedure TItensNFL.setFCODPRO(Value: Integer);
begin
  FCODPRO := Value;
end;

procedure TItensNFL.setFCODTPR(Value: Integer);
begin
  FCODTPR := Value;
end;

procedure TItensNFL.setFCOMPRA(Value: String);
begin
  FCOMPRA := Value;
end;

procedure TItensNFL.setFDescricaoProduto(const Value: String);
begin
  FDescricaoProduto := Value;
end;

procedure TItensNFL.setFDESPACHO(Value: String);
begin
  FDESPACHO := Value;
end;

procedure TItensNFL.setFESTOQUE(Value: String);
begin
  FESTOQUE := Value;
end;

procedure TItensNFL.setFIMP_APROX(Value: Real);
begin
  FIMP_APROX := Value;
end;

procedure TItensNFL.setFITEM_COMPRA(Value: String);
begin
  FITEM_COMPRA := Value;
end;

procedure TItensNFL.setFITF_SEQUENCIA(const Value: Integer);
begin
  FITF_SEQUENCIA := Value;
end;

procedure TItensNFL.setFLARGURA(Value: Real);
begin
  FLARGURA := Value;
end;

procedure TItensNFL.setFNR_PECAS(Value: Real);
begin
  FNR_PECAS := Value;
end;

procedure TItensNFL.setFOPER(Value: String);
begin
  FOPER := Value;
end;

procedure TItensNFL.setFQTDE(Value: Real);
begin
  FQTDE := Value;
end;

procedure TItensNFL.setFSENTIDO(Value: String);
begin
  FSENTIDO := Value;
end;

procedure TItensNFL.setFSubTotal(const Value: Real);
begin
  FSubTotal := Value;
end;

procedure TItensNFL.setFVL_CUSTO(Value: Real);
begin
  FVL_CUSTO := Value;
end;

procedure TItensNFL.setFVL_DESC(Value: Real);
begin
  FVL_DESC := Value;
end;

procedure TItensNFL.setFVL_UNIT(Value: Real);
begin
  FVL_UNIT := Value;
end;

end.
