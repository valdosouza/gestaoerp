unit TblAdicImp;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_adic_imp')]
  TAdicImp = Class(TGenericEntity)

  private
    Fadc_Codigo: Real;
    Fadc_Coddim: Integer;
    Fadc_Numero: String;
    Fadc_sequencia: String;
    Fadc_codfab: string;
    Fadc_vl_desc : Real;
    Fadc_pedcpa: String;
    Fadc_itmcpa: String;
    procedure setFadc_Coddim(const Value: Integer);
    procedure setFadc_codfab(const Value: String);
    procedure setFadc_codigo(const Value: Real);
    procedure setFadc_itmcpa(const Value: String);
    procedure setFadc_Numero(const Value: String);
    procedure setFadc_pedcpa(const Value: String);
    procedure setFadc_sequencia(const Value: String);
    procedure setFadc_vl_desc(const Value: Real);

  public

    [FieldName('adc_codigo')]
    [KeyField('adc_codigo')]
    property Codigo: Real read Fadc_codigo write setFadc_codigo;

    [KeyField('adc_coddim')]
    [FieldName('adc_coddim')]
    property Coddim: Integer read Fadc_Coddim write setFadc_Coddim;

    [FieldName('adc_numero')]
    property Numero: String read Fadc_Numero write setFadc_Numero;

    [FieldName('adc_sequencia')]
    property Sequencia: String read Fadc_sequencia write setFadc_sequencia;

    [FieldName('adc_codfab')]
    property CodFab: String read Fadc_codfab write setFadc_codfab;

    [FieldName('adc_vl_desc')]
    property VlDesc: Real read Fadc_vl_desc write setFadc_vl_desc;

    [FieldName('adc_pedcpa')]
    property Pedcpa: String read Fadc_pedcpa write setFadc_pedcpa;

    [FieldName('adc_itmcpa')]
    property Itcmpa: String read Fadc_itmcpa write setFadc_itmcpa;
  End;

  implementation
{ TAdicImp }

procedure TAdicImp.setFadc_Coddim(const Value: Integer);
begin
  Fadc_Coddim := Value;
end;

procedure TAdicImp.setFadc_codfab(const Value: String);
begin
  Fadc_codfab := Value;
end;

procedure TAdicImp.setFadc_codigo(const Value: Real);
begin
  Fadc_codigo := Value;
end;

procedure TAdicImp.setFadc_itmcpa(const Value: String);
begin
  Fadc_itmcpa := Value;
end;

procedure TAdicImp.setFadc_Numero(const Value: String);
begin
  Fadc_Numero := Value;
end;

procedure TAdicImp.setFadc_pedcpa(const Value: String);
begin
  Fadc_pedcpa := Value;
end;

procedure TAdicImp.setFadc_sequencia(const Value: String);
begin
  Fadc_sequencia := Value;
end;

procedure TAdicImp.setFadc_vl_desc(const Value: Real);
begin
  Fadc_vl_desc := Value;
end;

end.

