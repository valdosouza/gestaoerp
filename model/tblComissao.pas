unit tblComissao;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_comissao')]
  TComissao = Class(TGenericEntity)

  private
    Fcom_dt_venda: TDate;
    Fcom_codped: Integer;
    Fcom_codemp: Integer;
    Fcom_codigo: Integer;
    Fcom_dt_pagto: TDateTime;
    Fcom_codvdo: Integer;
    Fcom_codfin: Integer;
    Fcom_aq_com: Real;
    FCOM_VL_DOC: Real;
    Fcom_codmha: Integer;
    FCOM_VL_COM: Real;
    Fcom_tipo: String;
    procedure setFcom_aq_com(const Value: Real);
    procedure setFcom_codemp(const Value: Integer);
    procedure setFcom_codfin(const Value: Integer);
    procedure setFcom_codigo(const Value: Integer);
    procedure setFcom_codmha(const Value: Integer);
    procedure setFcom_codped(const Value: Integer);
    procedure setFcom_codvdo(const Value: Integer);
    procedure setFcom_dt_pagto(const Value: TDateTime);
    procedure setFcom_dt_venda(const Value: TDate);
    procedure setFcom_tipo(const Value: String);
    procedure setFCOM_VL_COM(const Value: Real);
    procedure setFCOM_VL_DOC(const Value: Real);



  public

    [FieldName('com_codigo')]
    [KeyField('com_codigo')]
    property Codigo: Integer read Fcom_codigo write setFcom_codigo;

    [FieldName('com_dt_venda')]
    property DataVenda: TDate read Fcom_dt_venda write setFcom_dt_venda;

    [FieldName('com_codped')]
    property Pedido: Integer read Fcom_codped write setFcom_codped;

    [FieldName('com_codemp')]
    property Cliente: Integer read Fcom_codemp write setFcom_codemp;

    [FieldName('com_codvdo')]
    property Vendedor: Integer read Fcom_codvdo write setFcom_codvdo;

    [FieldName('COM_VL_DOC')]
    property valorDocumento: Real read FCOM_VL_DOC write setFCOM_VL_DOC;

    [FieldName('COM_VL_COM')]
    property valorComissao: Real read FCOM_VL_COM write setFCOM_VL_COM;

    [FieldName('com_aq_com')]
    property Aliquota: Real read Fcom_aq_com write setFcom_aq_com;

    [FieldName('com_dt_pagto')]
    property DataPagto: TDateTime read Fcom_dt_pagto write setFcom_dt_pagto;

    [FieldName('com_codmha')]
    property Estabelecimento: Integer read Fcom_codmha write setFcom_codmha;

    [FieldName('com_codfin')]
    property Financeiro: Integer read Fcom_codfin write setFcom_codfin;

    [FieldName('com_tipo')]
    property Tipo: String read Fcom_tipo write setFcom_tipo;

  End;

  implementation


{ TComissao }

procedure TComissao.setFcom_aq_com(const Value: Real);
begin
  Fcom_aq_com := Value;
end;

procedure TComissao.setFcom_codemp(const Value: Integer);
begin
  Fcom_codemp := Value;
end;

procedure TComissao.setFcom_codfin(const Value: Integer);
begin
  Fcom_codfin := Value;
end;

procedure TComissao.setFcom_codigo(const Value: Integer);
begin
  Fcom_codigo := Value;
end;

procedure TComissao.setFcom_codmha(const Value: Integer);
begin
  Fcom_codmha := Value;
end;

procedure TComissao.setFcom_codped(const Value: Integer);
begin
  Fcom_codped := Value;
end;

procedure TComissao.setFcom_codvdo(const Value: Integer);
begin
  Fcom_codvdo := Value;
end;

procedure TComissao.setFcom_dt_pagto(const Value: TDateTime);
begin
  Fcom_dt_pagto := Value;
end;

procedure TComissao.setFcom_dt_venda(const Value: TDate);
begin
  Fcom_dt_venda := Value;
end;

procedure TComissao.setFcom_tipo(const Value: String);
begin
  Fcom_tipo := Value;
end;

procedure TComissao.setFCOM_VL_COM(const Value: Real);
begin
  FCOM_VL_COM := Value;
end;

procedure TComissao.setFCOM_VL_DOC(const Value: Real);
begin
  FCOM_VL_DOC := Value;
end;

end.
