unit TblBoletoEletronico;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_BOLETO_ELETRONICO')]
  TBoletoEletronico = Class(TGenericEntity)

  private
    FDescricaoCarteira: string;
    FBLE_NEGATIVACAO: String;
    Fble_instrucoes: String;
    Fble_convenio: String;
    Fble_codctr: Integer;
    Fble_posto_benef: String;
    Fble_codfpg: Integer;
    Fble_instr_2: String;
    Fble_leiaute: Integer;
    Fble_dias_protesto: Integer;
    Fble_instr_1: String;
    Fble_codigo: Integer;
    Fble_codctb: Integer;
    Fble_aceite: String;
    Fble_localpag: String;
    FNumeroBanco: string;
    Fble_vl_multa: Real;
    Fble_tx_desconto: Real;
    Fble_cod_trans: String;
    FBLE_DIA_NEGATIVACAO: Integer;
    Fble_name_arquivos: String;
    Fble_path_arquivos: String;
    Fble_lay_remessa: String;
    Fble_vl_tarifa: Real;
    Fble_var_cart: Integer;
    FConta: string;
    Fble_vl_mora_min: Real;
    FCarteira: string;
    Fble_protesto: String;
    Fble_tx_mora: Real;
    FAgencia: string;
    FNomeBanco: string;
    Fble_tx_multa: Real;
    Fble_tx_juros: Real;
    Fble_codepd: Integer;
    procedure setAgencia(const Value: string);
    procedure setCarteira(const Value: string);
    procedure setConta(const Value: string);
    procedure setDescricaoCarteira(const Value: string);
    procedure setFble_aceite(const Value: String);
    procedure setFble_cod_trans(const Value: String);
    procedure setFble_codctb(const Value: Integer);
    procedure setFble_codctr(const Value: Integer);
    procedure setFble_codepd(const Value: Integer);
    procedure setFble_codfpg(const Value: Integer);
    procedure setFble_codigo(const Value: Integer);
    procedure setFble_convenio(const Value: String);
    procedure setFBLE_DIAS_NEGATIVACAO(const Value: Integer);
    procedure setFble_dias_protesto(const Value: Integer);
    procedure setFble_instr_1(const Value: String);
    procedure setFble_instr_2(const Value: String);
    procedure setFble_instrucoes(const Value: String);
    procedure setFble_lay_remessa(const Value: String);
    procedure setFble_leiaute(const Value: Integer);
    procedure setFble_localpag(const Value: String);
    procedure setFble_name_arquivos(const Value: String);
    procedure setFBLE_NEGATIVACAO(const Value: String);
    procedure setFble_path_arquivos(const Value: String);
    procedure setFble_post_benef(const Value: String);
    procedure setFble_protesto(const Value: String);
    procedure setFble_tx_desconto(const Value: Real);
    procedure setFble_tx_juros(const Value: Real);
    procedure setFble_tx_mora(const Value: Real);
    procedure setFble_tx_multa(const Value: Real);
    procedure setFble_var_cart(const Value: Integer);
    procedure setFble_vl_mora_min(const Value: Real);
    procedure setFble_vl_multa(const Value: Real);
    procedure setFble_vl_tarifa(const Value: Real);
    procedure setNomeBanco(const Value: string);
    procedure setNumeroBanco(const Value: string);



   public
    [FieldName('ble_codigo')]
    [KeyField('ble_codigo')]
    property Codigo: Integer read Fble_codigo write setFble_codigo;

    [FieldName('ble_codctb')]
    property ContaCorrente: Integer read Fble_codctb write setFble_codctb;

    [FieldName('ble_codfpg')]
    property FormaPagamento: Integer read Fble_codfpg write setFble_codfpg;

    [FieldName('ble_codctr')]
    property CodigoCarteira: Integer read Fble_codctr write setFble_codctr;

    [FieldName('ble_codepd')]
    property EspecieDoc: Integer read Fble_codepd write setFble_codepd;

    [FieldName('ble_convenio')]
    property Convenio: String read Fble_convenio write setFble_convenio;

    [FieldName('ble_var_cart')]
    property VariacaoCarteira: Integer read Fble_var_cart write setFble_var_cart;

    [FieldName('ble_aceite')]
    property Aceite: String read Fble_aceite write setFble_aceite;

    [FieldName('ble_leiaute')]
    property Leiaute: Integer read Fble_leiaute write setFble_leiaute;

    [FieldName('ble_instr_1')]
    property Instr1: String read Fble_instr_1 write setFble_instr_1;

    [FieldName('ble_instr_2')]
    property Instr2: String read Fble_instr_2 write setFble_instr_2;

    [FieldName('ble_instrucoes')]
    property Instrucoes: String read Fble_instrucoes write setFble_instrucoes;

    [FieldName('ble_tx_desconto')]
    property TxDesconto: Real read Fble_tx_desconto write setFble_tx_desconto;

    [FieldName('ble_tx_juros')]
    property TxJuros: Real read Fble_tx_juros write setFble_tx_juros;

    [FieldName('ble_tx_mora')]
    property TxMora: Real read Fble_tx_mora write setFble_tx_mora;

    [FieldName('ble_vl_mora_min')]
    property VlMoraMin: Real read Fble_vl_mora_min write setFble_vl_mora_min;

    [FieldName('ble_vl_multa')]
    property VlMulta: Real read Fble_vl_multa write setFble_vl_multa;

    [FieldName('ble_vl_tarifa')]
    property VlTarifa: Real read Fble_vl_tarifa write setFble_vl_tarifa;

    [FieldName('ble_path_arquivos')]
    property PathArquivos: String read Fble_path_arquivos write setFble_path_arquivos;

    [FieldName('ble_name_arquivos')]
    property NameArquivos: String read Fble_name_arquivos write setFble_name_arquivos;

    [FieldName('ble_protesto')]
    property Protesto: String read Fble_protesto write setFble_protesto;

    [FieldName('BLE_DIAS_PROTESTO')]
    property DiasProtesto: Integer read Fble_dias_protesto write setFble_dias_protesto;

    [FieldName('BLE_NEGATIVACAO')]
    property Negativacao: String read FBLE_NEGATIVACAO write setFBLE_NEGATIVACAO;

    [FieldName('BLE_DIAS_NEGATIVACAO')]
    property DiasNegativacao: Integer read FBLE_DIA_NEGATIVACAO write setFBLE_DIAS_NEGATIVACAO;

    [FieldName('ble_localpag')]
    property LocalPag: String read Fble_localpag write setFble_localpag;

    [FieldName('ble_tx_multa')]
    property TxMulta: Real read Fble_tx_multa write setFble_tx_multa;

    [FieldName('ble_lay_remessa')]
    property LayRemessa: String read Fble_lay_remessa write setFble_lay_remessa;

    [FieldName('ble_cod_trans')]
    property CodTrans: String read Fble_cod_trans write setFble_cod_trans;

    [FieldName('BLE_POSTO_BENEF')]
    property PostoBenef: String read Fble_posto_benef write setFble_post_benef;

    property NomeBanco: string read FNomeBanco write setNomeBanco;
    property NumeroBanco: string read FNumeroBanco write setNumeroBanco;
    property Agencia: string read FAgencia write setAgencia;
    property Conta: string read FConta write setConta;
    property Carteira: string read FCarteira write setCarteira;
    property DescricaoCarteira: string read FDescricaoCarteira write setDescricaoCarteira;
  End;

  implementation


{ TBoletoEletronico }

procedure TBoletoEletronico.setAgencia(const Value: string);
begin
  FAgencia := Value;
end;

procedure TBoletoEletronico.setCarteira(const Value: string);
begin
  FCarteira := Value;
end;

procedure TBoletoEletronico.setConta(const Value: string);
begin
  FConta := Value;
end;

procedure TBoletoEletronico.setDescricaoCarteira(const Value: string);
begin
  FDescricaoCarteira := Value;
end;

procedure TBoletoEletronico.setFble_aceite(const Value: String);
begin
  Fble_aceite := Value;
end;

procedure TBoletoEletronico.setFble_codctb(const Value: Integer);
begin
  Fble_codctb := Value;
end;

procedure TBoletoEletronico.setFble_codctr(const Value: Integer);
begin
  Fble_codctr := Value;
end;

procedure TBoletoEletronico.setFble_codepd(const Value: Integer);
begin
  Fble_codepd := Value;
end;

procedure TBoletoEletronico.setFble_codfpg(const Value: Integer);
begin
  Fble_codfpg := Value;
end;

procedure TBoletoEletronico.setFble_codigo(const Value: Integer);
begin
  Fble_codigo := Value;
end;

procedure TBoletoEletronico.setFble_cod_trans(const Value: String);
begin
  Fble_cod_trans := Value;
end;

procedure TBoletoEletronico.setFble_convenio(const Value: String);
begin
  Fble_convenio := Value;
end;

procedure TBoletoEletronico.setFBLE_DIAS_NEGATIVACAO(const Value: Integer);
begin
  FBLE_DIA_NEGATIVACAO := Value;
end;

procedure TBoletoEletronico.setFble_dias_protesto(const Value: Integer);
begin
  Fble_dias_protesto := Value;
end;

procedure TBoletoEletronico.setFble_instrucoes(const Value: String);
begin
  Fble_instrucoes := Value;
end;

procedure TBoletoEletronico.setFble_instr_1(const Value: String);
begin
  Fble_instr_1 := Value;
end;

procedure TBoletoEletronico.setFble_instr_2(const Value: String);
begin
  Fble_instr_2 := Value;
end;

procedure TBoletoEletronico.setFble_lay_remessa(const Value: String);
begin
  Fble_lay_remessa := Value;
end;

procedure TBoletoEletronico.setFble_leiaute(const Value: Integer);
begin
  Fble_leiaute := Value;
end;

procedure TBoletoEletronico.setFble_localpag(const Value: String);
begin
  Fble_localpag := Value;
end;

procedure TBoletoEletronico.setFble_name_arquivos(const Value: String);
begin
  Fble_name_arquivos := Value;
end;

procedure TBoletoEletronico.setFBLE_NEGATIVACAO(const Value: String);
begin
  FBLE_NEGATIVACAO := Value;
end;

procedure TBoletoEletronico.setFble_path_arquivos(const Value: String);
begin
  Fble_path_arquivos := Value;
end;

procedure TBoletoEletronico.setFble_post_benef(const Value: String);
begin
  Fble_posto_benef := Value;
end;

procedure TBoletoEletronico.setFble_protesto(const Value: String);
begin
  Fble_protesto := Value;
end;

procedure TBoletoEletronico.setFble_tx_desconto(const Value: Real);
begin
  Fble_tx_desconto := Value;
end;

procedure TBoletoEletronico.setFble_tx_juros(const Value: Real);
begin
  Fble_tx_juros := Value;
end;

procedure TBoletoEletronico.setFble_tx_mora(const Value: Real);
begin
  Fble_tx_mora := Value;
end;

procedure TBoletoEletronico.setFble_tx_multa(const Value: Real);
begin
  Fble_tx_multa := Value;
end;

procedure TBoletoEletronico.setFble_var_cart(const Value: Integer);
begin
  Fble_var_cart := Value;
end;

procedure TBoletoEletronico.setFble_vl_mora_min(const Value: Real);
begin
  Fble_vl_mora_min := Value;
end;

procedure TBoletoEletronico.setFble_vl_multa(const Value: Real);
begin
  Fble_vl_multa := Value;
end;

procedure TBoletoEletronico.setFble_vl_tarifa(const Value: Real);
begin
  Fble_vl_tarifa := Value;
end;

procedure TBoletoEletronico.setNomeBanco(const Value: string);
begin
  FNomeBanco := Value;
end;

procedure TBoletoEletronico.setNumeroBanco(const Value: string);
begin
  FNumeroBanco := Value;
end;

end.
