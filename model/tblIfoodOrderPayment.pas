unit tblIfoodOrderPayment;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_IFOOD_ORDER_PAYMENT')]
  TIfoodOrderPayment = Class(TGenericEntity)
  private
    FVALUE: Real;
    FMETHOD: String;
    FCODE: String;
    FCHANGEFOR: Real;
    FCHANGEVALUE: Real;
    FCARD_BRAND: String;
    FID: Integer;
    FPREPAID: String;
    FCOLLETOR: String;
    FTYPE_: String;
    FTB_IFOOD_ORDER_ID: String;
    FCARD_DESCRIPTION: String;
    procedure setFCARD_BRAND(const Value: String);
    procedure setFCARD_DESCRIPTION(const Value: String);
    procedure setFCHANGEFOR(const Value: Real);
    procedure setFCHANGEVALUE(const Value: Real);
    procedure setFCODE(const Value: String);
    procedure setFCOLLETOR(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFMETHOD(const Value: String);
    procedure setFPREPAID(const Value: String);
    procedure setFTB_IFOOD_ORDER_ID(const Value: String);
    procedure setFTYPE_(const Value: String);
    procedure setFVALUE(const Value: Real);

  public

    [KeyField('TB_IFOOD_ORDER_ID')]
    [FieldName('TB_IFOOD_ORDER_ID')]
    property OrderId: String read FTB_IFOOD_ORDER_ID write setFTB_IFOOD_ORDER_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property Id: Integer read FID write setFID;

    [FieldName('METHOD')]
    property Metodo: String read FMETHOD write setFMETHOD;

    [FieldName('TYPE_')]
    property Tipo: String read FTYPE_ write setFTYPE_;

    [FieldName('CODE')]
    property Code: String read FCODE  write setFCODE ;

    [FieldName('VALUE_')]
    property Valor: Real read FVALUE write setFVALUE;

    [FieldName('PREPAID')]
    property PREPAID: String read FPREPAID write setFPREPAID;

    [FieldName('COLLETOR')]
    property Coletor: String read FCOLLETOR write setFCOLLETOR;

    [FieldName('CARD_BRAND')]
    property MarcaCartao: String read FCARD_BRAND write setFCARD_BRAND;

    [FieldName('CARD_DESCRIPTION')]
    property DescricaoCartao: String read FCARD_DESCRIPTION write setFCARD_DESCRIPTION;

    [FieldName('CHANGEFOR')]
    property TrocoPara: Real read FCHANGEFOR write setFCHANGEFOR;

    [FieldName('CHANGEVALUE')]
    property ValorTroco: Real read FCHANGEVALUE write setFCHANGEVALUE;
  End;


implementation

{ TIfoodOrderPayment }

procedure TIfoodOrderPayment.setFCARD_BRAND(const Value: String);
begin
  FCARD_BRAND := Copy(Value,1,25);
end;

procedure TIfoodOrderPayment.setFCARD_DESCRIPTION(const Value: String);
begin
  FCARD_DESCRIPTION := Copy(Value,1,25);
end;

procedure TIfoodOrderPayment.setFCHANGEFOR(const Value: Real);
begin
  FCHANGEFOR := Value;
end;

procedure TIfoodOrderPayment.setFCHANGEVALUE(const Value: Real);
begin
  FCHANGEVALUE := Value;
end;

procedure TIfoodOrderPayment.setFCODE(const Value: String);
begin
  FCODE := Copy(Value,1,50);
end;

procedure TIfoodOrderPayment.setFCOLLETOR(const Value: String);
begin
  FCOLLETOR := Copy(Value,1,25);
end;

procedure TIfoodOrderPayment.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TIfoodOrderPayment.setFMETHOD(const Value: String);
begin
  FMETHOD := Copy(Value,1,50);
end;

procedure TIfoodOrderPayment.setFPREPAID(const Value: String);
begin
  FPREPAID := Copy(Value,1,1);
end;

procedure TIfoodOrderPayment.setFTB_IFOOD_ORDER_ID(const Value: String);
begin
  FTB_IFOOD_ORDER_ID := Value;
end;

procedure TIfoodOrderPayment.setFTYPE_(const Value: String);
begin
  FTYPE_ := Copy(Value,1,50);
end;

procedure TIfoodOrderPayment.setFVALUE(const Value: Real);
begin
  FVALUE := Value;
end;

end.
