unit tblPafRegE2;


interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils,System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_PAF_REG_E2')]
  TPafRegE2 = Class(TGenericEntity)
  private
    FDescricao: String;
    FCEST: String;
    FTB_PRODUCT_ID: Integer;
    FTB_STOCK_LIST_ID: Integer;
    FNCM: String;
    FUnidade: String;
    FQUANTTIY: Real;
    FDT_RECORD: TDate;
    procedure setFCEST(const Value: String);
    procedure setFDescricao(const Value: String);
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFNCM(const Value: String);
    procedure setFQUANTTIY(const Value: Real);
    procedure setFTB_PRODUCT_ID(const Value: Integer);
    procedure setFTB_STOCK_LIST_ID(const Value: Integer);
    procedure setFUnidade(const Value: String);

  public
    [KeyField('TB_PRODUCT_ID')]
    [FieldName('TB_PRODUCT_ID')]
    property Codigo: Integer read FTB_PRODUCT_ID write setFTB_PRODUCT_ID;

    property CEST : String Read FCEST write setFCEST;
    property NCM : String read FNCM write setFNCM;
    property Descricao : String read FDescricao write setFDescricao;
    property Unidade : String read FUnidade write setFUnidade;


    [FieldName('QUANTITY')]
    property Quantidade: Real read FQUANTTIY write setFQUANTTIY;

    [FieldName('DT_RECORD')]
    property DataMovimento: TDate read FDT_RECORD write setFDT_RECORD;

    [KeyField('TB_STOCK_LIST_ID')]
    [FieldName('TB_STOCK_LIST_ID')]
    property Estoque: Integer read FTB_STOCK_LIST_ID write setFTB_STOCK_LIST_ID;

  End;

implementation



{ TPafRegE2 }

procedure TPafRegE2.setFCEST(const Value: String);
begin
  FCEST := Value;
end;

procedure TPafRegE2.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPafRegE2.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPafRegE2.setFNCM(const Value: String);
begin
  FNCM := Value;
end;

procedure TPafRegE2.setFQUANTTIY(const Value: Real);
begin
  FQUANTTIY := Value;
end;

procedure TPafRegE2.setFTB_PRODUCT_ID(const Value: Integer);
begin
  FTB_PRODUCT_ID := Value;
end;

procedure TPafRegE2.setFTB_STOCK_LIST_ID(const Value: Integer);
begin
  FTB_STOCK_LIST_ID := Value;
end;

procedure TPafRegE2.setFUnidade(const Value: String);
begin
  FUnidade := Value;
end;

end.
