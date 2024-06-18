unit tblNfeItemsFuel;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_NFE_ITENS_FUEL')]
  TNfeItemsFuel = Class(TGenericEntity)

  private
    FTB_ORDER_ITEMS_ID: Integer;
    FCODIF: String;
    FQTEMP: Real;
    FUFCONS: String;
    Fdescription: String;
    procedure setFCODIF(const Value: String);
    procedure setFQTEMP(const Value: Real);
    procedure setFTB_ORDER_ITEMS_ID(const Value: Integer);
    procedure setFUFCONS(const Value: String);
    procedure setFdescription(const Value: String);



  public

    [FieldName('TB_ORDER_ITEMS_ID')]
    [KeyField('TB_ORDER_ITEMS_ID')]
    property ItemNota: Integer read FTB_ORDER_ITEMS_ID write setFTB_ORDER_ITEMS_ID;

    [FieldName('CODIF')]
    property Codif: String read FCODIF write setFCODIF;


    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    [FieldName('QTEMP')]
    property QuantTemp: Real read FQTEMP write setFQTEMP;

    [FieldName('UFCONS')]
    property UFCONS: String read FUFCONS write setFUFCONS;


  End;

implementation

{ TNfeItemsFuel }

procedure TNfeItemsFuel.setFCODIF(const Value: String);
begin
  FCODIF := Value;
end;

procedure TNfeItemsFuel.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TNfeItemsFuel.setFQTEMP(const Value: Real);
begin
  FQTEMP := Value;
end;

procedure TNfeItemsFuel.setFTB_ORDER_ITEMS_ID(const Value: Integer);
begin
  FTB_ORDER_ITEMS_ID := Value;
end;

procedure TNfeItemsFuel.setFUFCONS(const Value: String);
begin
  FUFCONS := Value;
end;

end.
