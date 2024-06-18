unit SetesTEF;

interface

uses System.Classes,System.SysUtils, ACBrTEFD, ACBrTEFDClass, Vcl.Dialogs, Un_Sistema,
    Vcl.StdCtrls;

Type

  tEstadoEcfSimulado = (tpsLivre, tpsVenda, tpsSubTotal, tpsTotalPagar, tpsPagamento, tpsRelatorio);
  TSetesTEF = Class(TComponent)
    Private
      Tef : TACBrTEFD;
      acompanhamento : TMemo;
      IndiceTransacaoTef : Integer;
      estadoSimuladoEcf : tEstadoEcfSimulado;
      SaldoPagamento : Real;
      procedure configura;
    public
      ValorTotal : REal;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function inicializar:Boolean;
      function efetuarPagamento(Valor:Real; NFCE:String):Boolean;
      procedure travarComponentesTEF(abriuVenda : Boolean);
      function verificarSaldoRestante(ValorPago:Real) : Currency;
  End;

implementation

{ TSetesTEF }

procedure TSetesTEF.configura;
begin
  Tef.AutoAtivarGP := True;
  Tef.MultiplosCartoes := True;
  Tef.EsperaSleep := 250;
  Tef.EsperaSTS := 7;
end;

constructor TSetesTEF.Create(AOwner: TComponent);
begin
  inherited;
  Tef := TACBrTEFD.Create(Self);
  acompanhamento := TMemo.Create(Self);
  acompanhamento.Visible := FAlse;
  SaldoPagamento := -1;
end;

destructor TSetesTEF.Destroy;
begin
  FreeAndNil(Tef);
  inherited;
end;

function TSetesTEF.verificarSaldoRestante(ValorPago:Real) : Currency;
begin
  if SaldoPagamento = -1 then
    SaldoPagamento := ValorTotal;

  SaldoPagamento := ValorTotal - ValorPago;

  if SaldoPagamento > 0 then
    Result := SaldoPagamento
  else
    Result := 0;
end;

function TSetesTEF.efetuarPagamento(Valor:Real; NFCE:String):Boolean;
var
  StatusTransacao : Boolean;
begin
  with tef,acompanhamento do
  Begin
    StatusTransacao := CRT( Valor , '02', NFCE);
    if StatusTransacao then
    begin
      Inc(IndiceTransacaoTef);
      // if not(AutoFinalizarCupom) then comentando por que não quero auto finalizar cupom
      Lines.Add('Valor      : ' + FloatToStrF(Valor,ffFixed,10,2));
      Lines.Add('NSU        : ' + RespostasPendentes[IndiceTransacaoTef].NSU);
      Lines.Add('Rede       : ' + RespostasPendentes[IndiceTransacaoTef].Rede);
      Lines.Add('Resultado  : Transação aprovada.');
    end
    else
    begin
      Lines.Add('Resultado  : Transação Negada.');
      Exit;
    end;
  end;
end;

function TSetesTEF.inicializar: Boolean;
begin
  try
    configura;
    Tef.Inicializar( gpCliSiTef );
    Result := True;
  except
    on E : Exception do
    Begin
      ShowMessage(E.ClassName+' Erro encontrado : '+E.Message);
      Result := False;
    End;
  end;
end;

procedure TSetesTEF.travarComponentesTEF(abriuVenda : Boolean);
begin
  {
  EditNumNFCe.Enabled           := not(abriuVenda);
  edValorVenda.Enabled          := not(abriuVenda);
  ButtonIniciaVenda.Enabled     := not(abriuVenda);

  ButtonCancelarVenda.Enabled   := abriuVenda;
  edValorPagamento.Enabled      := abriuVenda;
  ButtonPagarEmDinheiro.Enabled := abriuVenda;
  ButtonPagarEmCartao.Enabled   := abriuVenda;
  }
end;

end.
