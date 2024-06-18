unit SetesTEF;

interface

uses Classes,SysUtils, ACBrTEFD, ACBrTEFDClass, Vcl.Dialogs, Vcl.StdCtrls;

Type


  TSetesTEF = Class(TComponent)
    Private

      IndiceTransacaoTef : Integer;
      SaldoPagamento : Real;
      procedure configura;
      procedure SetFTEf(const Value: TACBrTEFD);

    protected
      Tef : TACBrTEFD;

    public
      CodigoLoja : String;
      EnderecoIP : String;
      NumeroTErminal : String;
      ValorTotal : Real;
      acompanhamento : TMemo;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function inicializar:Boolean;
      function Terminar :Boolean;
      function efetuarPagamento(Valor:Real; NFCE:String):Boolean;
      procedure travarComponentesTEF(abriuVenda : Boolean);
      function verificarSaldoRestante(ValorPago:Real) : Currency;
  published
    { Published declarations }
    //Informa o banco de dados
    property ComponenteTEF: TACBrTEFD read TEf write SetFTEf;
  End;

implementation

{ TSetesTEF }

procedure TSetesTEF.configura;
begin
  with Tef do
  Begin
    AutoAtivarGP := True;
    MultiplosCartoes := True;
    EsperaSleep := 250;
    EsperaSTS := 7;
    TEFCliSiTef.CodigoLoja := self.CodigoLoja;
    TEFCliSiTef.EnderecoIP := Self.EnderecoIP;
    TEFCliSiTef.NumeroTErminal := Self.NumeroTErminal;
  End;
end;

constructor TSetesTEF.Create(AOwner: TComponent);
begin
  inherited;
  acompanhamento := TMemo.Create(Self);
  acompanhamento.Visible := FAlse;
  SaldoPagamento := -1;
  IndiceTransacaoTef     := -1;
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
      Result := True;
    end
    else
    begin
      Lines.Add('Resultado  : Transação Negada.');
      Result := False;
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

procedure TSetesTEF.SetFTEf(const Value: TACBrTEFD);
begin
  Tef := Value;
end;

function TSetesTEF.Terminar: Boolean;
begin
  try
    Self.Tef.DesInicializar;
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
