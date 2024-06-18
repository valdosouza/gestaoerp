unit tblItensNflTributacao;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  [TableName('TB_ITENS_NFL_TRIBUTACAO')]
  TItensNflTributacao = Class(TGenericEntity)
  private
    FSET_FINANCIAL: String;
    FTB_ORDER_ITENS_ID: Integer;
    FCFOP: String;
    FTB_TAX_RULER_ID: Integer;
    procedure setFCFOP(const Value: String);
    procedure setFSET_FINANCIAL(const Value: String);
    procedure setFTB_ORDER_ITENS_ID(const Value: Integer);
    procedure setFTB_TAX_RULER_ID(const Value: Integer);

  public
    [KeyField('TB_ORDER_ITENS_ID')]
    [FieldName('TB_ORDER_ITENS_ID')]
    property ItemOrdem: Integer Read FTB_ORDER_ITENS_ID write setFTB_ORDER_ITENS_ID;

    [FieldName('TB_TAX_RULER_ID')]
    property Tributacao: Integer read FTB_TAX_RULER_ID write setFTB_TAX_RULER_ID;

    [FieldName('CFOP')]
    property CFOP: String read FCFOP write setFCFOP;

    [FieldName('SET_FINANCIAL')]
    property GeraFinanceiro: String read FSET_FINANCIAL write setFSET_FINANCIAL;

  End;

implementation

{ TItensNflTributacao }

procedure TItensNflTributacao.setFCFOP(const Value: String);
begin
  FCFOP := Value;
end;

procedure TItensNflTributacao.setFSET_FINANCIAL(const Value: String);
begin
  FSET_FINANCIAL := Value;
end;

procedure TItensNflTributacao.setFTB_ORDER_ITENS_ID(const Value: Integer);
begin
  FTB_ORDER_ITENS_ID := Value;
end;

procedure TItensNflTributacao.setFTB_TAX_RULER_ID(const Value: Integer);
begin
  FTB_TAX_RULER_ID := Value;
end;

end.
