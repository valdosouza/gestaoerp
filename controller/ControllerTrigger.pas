unit ControllerTrigger;

interface
uses STDatabase,Classes,  SysUtils,ControllerBase,
      Generics.Collections, STQuery;


Type

  TTrigger = class
  private
    FTabela: String;
    FCampo: String;
    procedure setFCampo(const Value: String);
    procedure setTabela(const Value: String);
  public
    property Tabela: String read FTabela write setTabela;
    property Campo: String read FCampo write setFCampo;
  End;

  TListaTrigger = TObjectList<TTrigger>;

  TControllerTrigger = Class(TComponent)
    Lista : TListaTrigger;
  private

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getlistPDV;
    procedure getlistRetaguarda;
  End;

implementation

{ TControllerTrigger }

constructor TControllerTrigger.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListaTrigger.create;
end;

destructor TControllerTrigger.Destroy;
begin

  inherited;
end;

procedure TControllerTrigger.getlistPDV;
Var
  LcReg : TTrigger;
begin
  Lista.Clear;

  LcReg := TTrigger.create;
  LcReg.Tabela := 'EMPRESA';
  LcReg.Campo := 'EMP_CODIGO';
  Lista.Add(LcReg); // ind - 3

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CLIENTE';
  LcReg.Campo := 'CLI_CODEMP';
  Lista.Add(LcReg); // ind - 16

  LcReg := TTrigger.create;
  LcReg.Tabela := 'NOTA_FISCAL';
  LcReg.Campo := 'NFL_CODIGO';
  Lista.Add(LcReg); // ind - 19

  LcReg := TTrigger.create;
  LcReg.Tabela := 'FINANCEIRO';
  LcReg.Campo := 'FIN_CODIGO';
  Lista.Add(LcReg); // ind - 20

  LcReg := TTrigger.create;
  LcReg.Tabela := 'MOVIM_FINANCEIRO';
  LcReg.Campo := 'MVF_CODIGO';
  Lista.Add(LcReg); // ind - 23


  LcReg := TTrigger.create;
  LcReg.Tabela := 'CTRL_ESTOQUE';
  LcReg.Campo := 'CET_CODIGO';
  Lista.Add(LcReg); // ind - 26

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CASHIER';
  LcReg.Campo := 'ID';
  Lista.Add(LcReg); // ind - 27

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFE';
  LcReg.Campo := 'NFE_CODIGO';
  Lista.Add(LcReg); // ind - 28

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFC';
  LcReg.Campo := 'NFC_CODIGO';
  Lista.Add(LcReg); // ind - 29

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFS';
  LcReg.Campo := 'NFS_CODNFL';
  Lista.Add(LcReg); // ind - 30

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CARTA_CORRECAO';
  LcReg.Campo := 'CCE_CODIGO';
  Lista.Add(LcReg); // ind - 31

  LcReg := TTrigger.create;
  LcReg.Tabela := 'ARQUIVOS';
  LcReg.Campo := 'ARQ_CODIGO';
  Lista.Add(LcReg); // ind - 32

end;

procedure TControllerTrigger.getlistRetaguarda;
Var
  LcReg : TTrigger;
begin
  Lista.Clear;
  //Lista Tabelas e Campos
  LcReg := TTrigger.create;
  LcReg.Tabela := 'USUARIO';
  LcReg.Campo := 'USU_CODIGO';
  Lista.Add(LcReg); // ind - 0

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CARGO';
  LcReg.Campo := 'CRG_CODIGO';
  Lista.Add(LcReg); // ind - 1

  LcReg := TTrigger.create;
  LcReg.Tabela := 'COLABORADOR';
  LcReg.Campo := 'CLB_CODIGO';
  Lista.Add(LcReg); // ind - 2

  LcReg := TTrigger.create;
  LcReg.Tabela := 'EMPRESA';
  LcReg.Campo := 'EMP_CODIGO';
  Lista.Add(LcReg); // ind - 3

  LcReg := TTrigger.create;
  LcReg.Tabela := 'FORMAPAGTO';
  LcReg.Campo := 'FPT_CODIGO';
  Lista.Add(LcReg); // ind - 5

  LcReg := TTrigger.create;
  LcReg.Tabela := 'GRUPOS';
  LcReg.Campo := 'GRP_CODIGO';
  Lista.Add(LcReg); // ind - 6

  LcReg := TTrigger.create;
  LcReg.Tabela := 'SUBGRUPOS';
  LcReg.Campo := 'SBG_CODIGO';
  Lista.Add(LcReg); // ind - 7

  LcReg := TTrigger.create;
  LcReg.Tabela := 'MARCA_PRODUTO';
  LcReg.Campo := 'MRC_CODIGO';
  Lista.Add(LcReg); // ind - 8

  LcReg := TTrigger.create;
  LcReg.Tabela := 'MEDIDA';
  LcReg.Campo := 'MED_CODIGO';
  Lista.Add(LcReg); // ind - 9

  LcReg := TTrigger.create;
  LcReg.Tabela := 'EMBALAGEM';
  LcReg.Campo := 'EMB_CODIGO';
  Lista.Add(LcReg); // ind - 10

  LcReg := TTrigger.create;
  LcReg.Tabela := 'PRODUTO';
  LcReg.Campo := 'PRO_CODIGO';
  Lista.Add(LcReg); // ind - 11

  LcReg := TTrigger.create;
  LcReg.Tabela := 'ESTOQUES';
  LcReg.Campo := 'ETS_CODIGO';
  Lista.Add(LcReg); // ind - 12

  LcReg := TTrigger.create;
  LcReg.Tabela := 'ESTOQUE';
  LcReg.Campo := 'EST_CODIGO';
  Lista.Add(LcReg); // ind - 13

  LcReg := TTrigger.create;
  LcReg.Tabela := 'TABELA_PRECO';
  LcReg.Campo := 'TPR_CODIGO';
  Lista.Add(LcReg); // ind - 14

  LcReg := TTrigger.create;
  LcReg.Tabela := 'PRECO';
  LcReg.Campo := 'PRC_CODIGO';
  Lista.Add(LcReg); // ind - 15

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CLIENTE';
  LcReg.Campo := 'CLI_CODEMP';
  Lista.Add(LcReg); // ind - 16

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CONTABANCARIA';
  LcReg.Campo := 'CTB_CODIGO';
  Lista.Add(LcReg); // ind - 18

  LcReg := TTrigger.create;
  LcReg.Tabela := 'NOTA_FISCAL';
  LcReg.Campo := 'NFL_CODIGO';
  Lista.Add(LcReg); // ind - 19

  LcReg := TTrigger.create;
  LcReg.Tabela := 'FINANCEIRO';
  LcReg.Campo := 'FIN_CODIGO';
  Lista.Add(LcReg); // ind - 20

  LcReg := TTrigger.create;
  LcReg.Tabela := 'PLANOCONTAS';
  LcReg.Campo := 'PLC_CODIGO';
  Lista.Add(LcReg); // ind - 21

  LcReg := TTrigger.create;
  LcReg.Tabela := 'HISTBANCARIO';
  LcReg.Campo := 'HTB_CODIGO';
  Lista.Add(LcReg); // ind - 22

  LcReg := TTrigger.create;
  LcReg.Tabela := 'MOVIM_FINANCEIRO';
  LcReg.Campo := 'MVF_CODIGO';
  Lista.Add(LcReg); // ind - 23

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CATEGORY';
  LcReg.Campo := 'ID';
  Lista.Add(LcReg); // ind - 25

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CTRL_ESTOQUE';
  LcReg.Campo := 'CET_CODIGO';
  Lista.Add(LcReg); // ind - 26

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CASHIER';
  LcReg.Campo := 'ID';
  Lista.Add(LcReg); // ind - 27

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFE';
  LcReg.Campo := 'NFE_CODIGO';
  Lista.Add(LcReg); // ind - 28

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFC';
  LcReg.Campo := 'NFC_CODIGO';
  Lista.Add(LcReg); // ind - 29

  LcReg := TTrigger.create;
  LcReg.Tabela := 'RETORNO_NFS';
  LcReg.Campo := 'NFS_CODNFL';
  Lista.Add(LcReg); // ind - 30

  LcReg := TTrigger.create;
  LcReg.Tabela := 'CARTA_CORRECAO';
  LcReg.Campo := 'CCE_CODIGO';
  Lista.Add(LcReg); // ind - 31

  LcReg := TTrigger.create;
  LcReg.Tabela := 'ARQUIVOS';
  LcReg.Campo := 'ARQ_CODIGO';
  Lista.Add(LcReg); // ind - 32

  LcReg := TTrigger.create;
  LcReg.Tabela := 'PROMOTION';
  LcReg.Campo := 'ID';
  Lista.Add(LcReg); // ind - 33


  LcReg := TTrigger.create;
  LcReg.Tabela := 'CRP_ITENS';
  LcReg.Campo := 'CPI_CODIGO';
  Lista.Add(LcReg); // ind - 33

  LcReg := TTrigger.create;
  LcReg.Tabela := 'GRUPOS';
  LcReg.Campo := 'GRP_CODIGO';
  Lista.Add(LcReg); // ind - 33

  LcReg := TTrigger.create;
  LcReg.Tabela := 'SUBGRUPOS';
  LcReg.Campo := 'SBG_CODIGO';
  Lista.Add(LcReg); // ind - 33

  LcReg := TTrigger.create;
  LcReg.Tabela := 'MEDIDA';
  LcReg.Campo := 'MED_CODIGO';
  Lista.Add(LcReg); // ind - 33

  LcReg := TTrigger.create;
  LcReg.Tabela  := 'PRODUCT_VARIANT_SKU';
  LcReg.Campo   := 'ID';
  Lista.Add(LcReg); // ind - 33

  LcReg := TTrigger.create;
  LcReg.Tabela := 'FORNECEDOR';
  LcReg.Campo := 'FOR_CODEMP';
  Lista.Add(LcReg); // ind - 34

end;

{ TTrigger }

procedure TTrigger.setFCampo(const Value: String);
begin
  FCampo := Value;
end;

procedure TTrigger.setTabela(const Value: String);
begin
  FTabela := Value;
end;

end.
