unit tblParcelamento;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_parcelamento')]
  TParcelamento = Class(TGenericEntity)
  private
    FCODPED :  INTEGER;
    FPARCELA:  INTEGER;
    FDATA   :  TDATE;
    FVALOR  :  REAL;
    FCODFPT :  INTEGER;

    procedure setFCODPED(Value: Integer);
    procedure setFPARCELA(Value: Integer);
    procedure setFDATA(Value: TDAte);
    procedure setFVALOR(Value: Real);
    procedure setFCODFPT(Value: Integer);

  public
    [KeyField('PAR_CODPED')]
    [FieldName('PAR_CODPED')]
    property CodigoPedido: Integer read FCODPED write setFCODPED;
    [KeyField('PAR_PARCELA')]
    [FieldName('PAR_PARCELA')]
    property NumeroParcela: Integer read FPARCELA write setFPARCELA;
    [FieldName('PAR_DATA')]
    property Vencimento: TDAte read FDATA write setFDATA;
    [FieldName('PAR_VALOR')]
    property Valor: Real read FVALOR write setFVALOR;
    [FieldName('PAR_CODFPT')]
    property CodigoFormaPagamento: Integer read FCODFPT write setFCODFPT;

  End;

implementation


{ TParcelamento }

procedure TParcelamento.setFCODFPT(Value: Integer);
begin
  FCODFPT := Value;
end;

procedure TParcelamento.setFCODPED(Value: Integer);
begin
  FCODPED := Value;
end;

procedure TParcelamento.setFDATA(Value: TDAte);
begin
  FDATA := Value;
end;

procedure TParcelamento.setFPARCELA(Value: Integer);
begin
  FPARCELA := Value;
end;

procedure TParcelamento.setFVALOR(Value: Real);
begin
  FVALOR := Value;
end;

end.
