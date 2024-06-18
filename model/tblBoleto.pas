unit tblBoleto;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_boleto')]
  TBoleto = Class(TGenericEntity)

  private
    Fblt_codigo: Integer;
    Fblt_codemp: Integer;
    Fblt_numero: Integer;
    Fblt_data: TDateTime;
    Fblt_codctb: Integer;
    Fblt_desconto: String;
    Fblt_tx_desconto: Real;
    Fblt_baixa: String;
    Fblt_valor: Real;
    FBlt_codqtc: Integer;
    Fblt_vl_tarifa: Real;
    Fblt_tx_mora: Real;
    Fblt_codble: Integer;
    Fblt_dt_vencimento: TDateTime;
    procedure setFblt_baixa(const Value: String);
    procedure setFblt_blt_vl_tarifa(const Value: Real);
    procedure setFblt_codble(const Value: Integer);
    procedure setFblt_codctb(const Value: Integer);
    procedure setFblt_codemp(const Value: Integer);
    procedure setFblt_codigo(const Value: Integer);
    procedure setFblt_codqtc(const Value: Integer);
    procedure setFblt_data(const Value: TDateTime);
    procedure setFblt_desconto(const Value: String);
    procedure setFblt_dt_vencimento(const Value: TDateTime);
    procedure setFblt_numero(const Value: Integer);
    procedure setFblt_tx_desconto(const Value: Real);
    procedure setFblt_tx_mora(const Value: Real);
    procedure setFblt_valor(const Value: Real);



   public
    [FieldName('blt_codigo')]
    [KeyField('blt_codigo')]
    property Codigo: Integer read Fblt_codigo write setFblt_codigo;

    [KeyField('blt_codemp')]
    [FieldName('blt_codemp')]
    property Codemp: Integer read Fblt_codemp write setFblt_codemp;

    [FieldName('blt_numero')]
    property Numero: Integer read Fblt_numero write setFblt_numero;

   [FieldName('blt_data')]
    property Data: TDateTime read Fblt_data write setFblt_data;

    [FieldName('blt_codctb')]
    property CodCtb: Integer read Fblt_codctb write setFblt_codctb;

    [FieldName('blt_desconto')]
    property Desconto: String read Fblt_desconto write setFblt_desconto;

    [FieldName('blt_tx_desconto')]
    property TxDesconto: Real read Fblt_tx_desconto write setFblt_tx_desconto;

    [FieldName('blt_baixa')]
    property Baixa: String read Fblt_baixa write setFblt_baixa;

    [FieldName('blt_valor')]
    property Valor: Real read Fblt_valor write setFblt_valor;

    [FieldName('blt_codqtc')]
    property CodQtc: Integer read Fblt_codqtc write setFblt_codqtc;

    [FieldName('blt_vl_tarifa')]
    property VlTarifa: Real read Fblt_vl_tarifa write setFblt_blt_vl_tarifa;

    [FieldName('blt_tx_mora')]
    property TxMora: Real read Fblt_tx_mora write setFblt_tx_mora;

    [FieldName('blt_codble')]
    property Codble: Integer read Fblt_codble write setFblt_codble;

    [FieldName('blt_dt_vencimento')]
    property DtVenc: TDateTime read Fblt_dt_vencimento write setFblt_dt_vencimento;


  End;

  implementation


{ TBoleto }

procedure TBoleto.setFblt_baixa(const Value: String);
begin
  Fblt_baixa := Value;
end;

procedure TBoleto.setFblt_blt_vl_tarifa(const Value: Real);
begin
  Fblt_vl_tarifa := Value;
end;

procedure TBoleto.setFblt_codble(const Value: Integer);
begin
  Fblt_codble := Value;
end;

procedure TBoleto.setFblt_codctb(const Value: Integer);
begin
  Fblt_codctb := Value;
end;

procedure TBoleto.setFblt_codemp(const Value: Integer);
begin
  Fblt_codemp := Value;
end;

procedure TBoleto.setFblt_codigo(const Value: Integer);
begin
  Fblt_codigo := Value;
end;

procedure TBoleto.setFblt_codqtc(const Value: Integer);
begin
  Fblt_codqtc := Value;
end;

procedure TBoleto.setFblt_data(const Value: TDateTime);
begin
  Fblt_data := Value;
end;

procedure TBoleto.setFblt_desconto(const Value: String);
begin
  Fblt_desconto := Value;
end;

procedure TBoleto.setFblt_dt_vencimento(const Value: TDateTime);
begin
  Fblt_dt_vencimento := Value;
end;

procedure TBoleto.setFblt_numero(const Value: Integer);
begin
  Fblt_numero := Value;
end;

procedure TBoleto.setFblt_tx_desconto(const Value: Real);
begin
  Fblt_tx_desconto := Value;
end;

procedure TBoleto.setFblt_tx_mora(const Value: Real);
begin
  Fblt_tx_mora := Value;
end;

procedure TBoleto.setFblt_valor(const Value: Real);
begin
  Fblt_valor := Value;
end;

end.
