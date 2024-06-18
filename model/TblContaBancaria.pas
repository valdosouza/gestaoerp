unit TblContaBancaria;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CONTABANCARIA')]
  TContaBancaria = Class(TGenericEntity)

  private
    FCtb_Fone: String;
    FCtb_Fax: String;
    FCtb_Cc_Dv: String;
    FCtb_Codbco: Integer;
    FCtb_Codigo: Integer;
    FCtb_Gerente: String;
    FCtb_Dt_Abertura: TDateTime;
    FCtb_Dt_Vencto: TDateTime;
    FCtb_Codemp: Integer;
    FCtb_Conta: String;
    FCtb_Codmha: Integer;
    FCtb_Ag_Dv: String;
    FCtb_Agencia: String;
    FCtb_Vl_Limite: Real;
    procedure setFCtb_Ag_Dv(const Value: String);
    procedure setFCtb_Agencia(const Value: String);
    procedure setFCtb_Cc_Dv(const Value: String);
    procedure setFCtb_Codbco(const Value: Integer);
    procedure setFCtb_Codemp(const Value: Integer);
    procedure setFCtb_Codigo(const Value: Integer);
    procedure setFCtb_Codmha(const Value: Integer);
    procedure setFCtb_Conta(const Value: String);
    procedure setFCtb_Dt_Abertura(const Value: TDateTime);
    procedure setFCtb_Dt_Vencto(const Value: TDateTime);
    procedure setFCtb_Fax(const Value: String);
    procedure setFCtb_Fone(const Value: String);
    procedure setFCtb_Gerente(const Value: String);
    procedure setFCtb_Vl_Limite(const Value: Real);

  public

    [FieldName('Ctb_Codigo')]
    [KeyField('Ctb_Codigo')]
    property Codigo: Integer read FCtb_Codigo write setFCtb_Codigo;

    [FieldName('Ctb_Codemp')]
    property Empresa: Integer read FCtb_Codemp write setFCtb_Codemp;

    [FieldName('Ctb_Codbco')]
    property CodigoBanco: Integer read FCtb_Codbco write setFCtb_Codbco;

    [FieldName('Ctb_Dt_Abertura')]
    property DataAbertura: TDateTime read FCtb_Dt_Abertura write setFCtb_Dt_Abertura;

    [FieldName('Ctb_Agencia')]
    property Agencia: String read FCtb_Agencia write setFCtb_Agencia;

    [FieldName('Ctb_Conta')]
    property Conta: String read FCtb_Conta write setFCtb_Conta;

    [FieldName('Ctb_Fone')]
    property Fone: String read FCtb_Fone write setFCtb_Fone;

    [FieldName('Ctb_Fax')]
    property Fax: String read FCtb_Fax write setFCtb_Fax;

    [FieldName('Ctb_Gerente')]
    property Gerente: String read FCtb_Gerente write setFCtb_Gerente;

    [FieldName('Ctb_Vl_Limite')]
    property ValorLimite: Real read FCtb_Vl_Limite write setFCtb_Vl_Limite;

    [FieldName('Ctb_Dt_Vencto')]
    property DataVencto: TDateTime read FCtb_Dt_Vencto write setFCtb_Dt_Vencto;

    [FieldName('Ctb_Codmha')]
    property Estabelecimento: Integer read FCtb_Codmha write setFCtb_Codmha;

    [FieldName('Ctb_Ag_Dv')]
    property DigitoAgencia: String read FCtb_Ag_Dv write setFCtb_Ag_Dv;

    [FieldName('Ctb_Cc_Dv')]
    property DigitoContaCorrente: String read FCtb_Cc_Dv write setFCtb_Cc_Dv;

  End;

  implementation


{ TContaBancaria }

procedure TContaBancaria.setFCtb_Agencia(const Value: String);
begin
  FCtb_Agencia := Value;
end;

procedure TContaBancaria.setFCtb_Ag_Dv(const Value: String);
begin
  FCtb_Ag_Dv := Value;
end;

procedure TContaBancaria.setFCtb_Cc_Dv(const Value: String);
begin
  FCtb_Cc_Dv := Value;
end;

procedure TContaBancaria.setFCtb_Codbco(const Value: Integer);
begin
  FCtb_Codbco := Value;
end;

procedure TContaBancaria.setFCtb_Codemp(const Value: Integer);
begin
  FCtb_Codemp := Value;
end;

procedure TContaBancaria.setFCtb_Codigo(const Value: Integer);
begin
  FCtb_Codigo := Value;
end;

procedure TContaBancaria.setFCtb_Codmha(const Value: Integer);
begin
  FCtb_Codmha := Value;
end;

procedure TContaBancaria.setFCtb_Conta(const Value: String);
begin
  FCtb_Conta := Value;
end;

procedure TContaBancaria.setFCtb_Dt_Abertura(const Value: TDateTime);
begin
  FCtb_Dt_Abertura := Value;
end;

procedure TContaBancaria.setFCtb_Dt_Vencto(const Value: TDateTime);
begin
  FCtb_Dt_Vencto := Value;
end;

procedure TContaBancaria.setFCtb_Fax(const Value: String);
begin
  FCtb_Fax := Value;
end;

procedure TContaBancaria.setFCtb_Fone(const Value: String);
begin
  FCtb_Fone := Value;
end;

procedure TContaBancaria.setFCtb_Gerente(const Value: String);
begin
  FCtb_Gerente := Value;
end;

procedure TContaBancaria.setFCtb_Vl_Limite(const Value: Real);
begin
  FCtb_Vl_Limite := Value;
end;

end.
