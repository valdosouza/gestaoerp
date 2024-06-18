unit itemVenda;

interface

Uses Classes, SysUtils,  Generics.Defaults, Generics.Collections;
Type
  //nome da classe de entidade

  TItemVenda = Class (TPersistent)
    private
    FProduto: Integer;
    FValorOriginal: REal;
    FValorCusto: Real;
    FFabrica: String;
    FValorVenda: REal;
    FDescricao: String;
    Fncm: String;
    FPromocao: String;
    FQuantidade: Real;
    FAbreviatura: String;
    FOrigem: String;
    FItemPedido: Integer;
    FQtdePromocao: Real;
    FPrecoPromocao: Real;
    FObservacao: String;
    FTotalPromocao: Real;
    FAtingiuPromocao: String;
    procedure setFAbreviatura(const Value: String);
    procedure setFDescricao(const Value: String);
    procedure setFFabrica(const Value: String);
    procedure setFncm(const Value: String);
    procedure setFOrigem(const Value: String);
    procedure setFProduto(const Value: Integer);
    procedure setFQuantidade(const Value: Real);
    procedure setFValorCusto(const Value: Real);
    procedure setFValorOriginal(const Value: REal);
    procedure setFValorVenda(const Value: REal);
    procedure setFItemPedido(const Value: Integer);
    procedure setFPromocaopc(const Value: String);
    procedure setFQtdePromocao(const Value: Real);
    procedure setFPrecoPromocao(const Value: Real);
    procedure setFObservacao(const Value: String);
    procedure setFTotalPromocao(const Value: Real);
    procedure setFAtingiuPromocao(const Value: String);


    public
      property Produto : Integer read FProduto write setFProduto;
      property Fabrica : String read FFabrica write setFFabrica;
      property Descricao : String read FDescricao write setFDescricao;
      property Quantidade : Real read FQuantidade write setFQuantidade;
      property ValorVenda : REal read FValorVenda write setFValorVenda;
      property Abreviatura : String read FAbreviatura write setFAbreviatura;
      property ValorCusto : Real read FValorCusto write setFValorCusto;
      property ncm : String read Fncm write setFncm;
      property Origem : String read FOrigem write setFOrigem;
      property ValorOriginal : REal read FValorOriginal write setFValorOriginal;
      property Promocao : String read FPromocao write setFPromocaopc;
      property QtdePromocao : Real read FQtdePromocao write setFQtdePromocao;
      property ItemPedido : Integer read FItemPedido write setFItemPedido;
      property PrecoPromocao : Real read FPrecoPromocao write setFPrecoPromocao;
      property TotalPromocao : Real read FTotalPromocao write setFTotalPromocao;
      property AtingiuPromocao : String read FAtingiuPromocao write setFAtingiuPromocao;
      property Observacao : String read FObservacao write setFObservacao;
      procedure Assign (APersistent: TPersistent) ; override;
  End;

  TListaItemVenda = TObjectList<TItemVenda>;


implementation
{ TItemVenda }

procedure TItemVenda.Assign(APersistent: TPersistent);
begin
  FProduto       := TItemVenda(APersistent).Produto;
  FValorOriginal := TItemVenda(APersistent).ValorOriginal;
  FValorCusto    := TItemVenda(APersistent).ValorCusto;
  FFabrica       := TItemVenda(APersistent).Fabrica;
  FValorVenda    := TItemVenda(APersistent).ValorVenda;
  FDescricao     := TItemVenda(APersistent).Descricao;
  Fncm           := TItemVenda(APersistent).ncm;
  FPromocao      := TItemVenda(APersistent).Promocao;
  FQuantidade    := TItemVenda(APersistent).Quantidade;
  FAbreviatura   := TItemVenda(APersistent).Abreviatura;
  FOrigem        := TItemVenda(APersistent).Origem;
  FItemPedido    := TItemVenda(APersistent).ItemPedido;
  FQtdePromocao  := TItemVenda(APersistent).QtdePromocao;
  FPrecoPromocao := TItemVenda(APersistent).PrecoPromocao;
  FObservacao    := TItemVenda(APersistent).Observacao;
  FAtingiuPromocao := TItemVenda(APersistent).AtingiuPromocao;
end;

procedure TItemVenda.setFAbreviatura(const Value: String);
begin
  FAbreviatura := Value;
end;

procedure TItemVenda.setFAtingiuPromocao(const Value: String);
begin
  FAtingiuPromocao := Value;
end;

procedure TItemVenda.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TItemVenda.setFFabrica(const Value: String);
begin
  FFabrica := Value;
end;


procedure TItemVenda.setFItemPedido(const Value: Integer);
begin
  FItemPedido := Value;
end;

procedure TItemVenda.setFncm(const Value: String);
begin
  Fncm := Value;
end;

procedure TItemVenda.setFObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TItemVenda.setFOrigem(const Value: String);
begin
  FOrigem := Value;
end;

procedure TItemVenda.setFPrecoPromocao(const Value: Real);
begin
  FPrecoPromocao := Value;
end;

procedure TItemVenda.setFProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TItemVenda.setFPromocaopc(const Value: String);
begin
  FPromocao := Value;
end;

procedure TItemVenda.setFQtdePromocao(const Value: Real);
begin
  FQtdePromocao := Value;
end;

procedure TItemVenda.setFQuantidade(const Value: Real);
begin
  FQuantidade := Value;
end;

procedure TItemVenda.setFTotalPromocao(const Value: Real);
begin
  FTotalPromocao := Value;
end;

procedure TItemVenda.setFValorCusto(const Value: Real);
begin
  FValorCusto := Value;
end;

procedure TItemVenda.setFValorOriginal(const Value: REal);
begin
  FValorOriginal := Value;
end;

procedure TItemVenda.setFValorVenda(const Value: REal);
begin
  FValorVenda := Value;
end;

end.
