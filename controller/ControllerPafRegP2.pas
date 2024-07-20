unit ControllerPafRegP2;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_MSg,Generics.Collections;

Type
  TPafRegP2 = class
  private
    FIAT: String;
    FDescricao: String;
    FCEST: String;
    FCodigo: String;
    FValorUnitario: Real;
    FIPPT: String;
    FNCM: String;
    FAliquota: Real;
    FUnidade: String;
    FSituacaoTributaria: String;
    procedure setFAliquota(const Value: Real);
    procedure setFCEST(const Value: String);
    procedure setFCodigo(const Value: String);
    procedure setFDescricao(const Value: String);
    procedure setFIAT(const Value: String);
    procedure setFIPPT(const Value: String);
    procedure setFNCM(const Value: String);
    procedure setFSituacaoTributaria(const Value: String);
    procedure setFUnidade(const Value: String);
    procedure setFValorUnitario(const Value: Real);


    public
      property Codigo : String read FCodigo write setFCodigo;
      property CEST : String Read FCEST write setFCEST;
      property NCM : String read FNCM write setFNCM;
      property Descricao : String read FDescricao write setFDescricao;
      property Unidade : String read FUnidade write setFUnidade;
      property IAT : String read FIAT write setFIAT;
      property IPPT : String read FIPPT write setFIPPT;
      property SituacaoTributaria : String read FSituacaoTributaria write setFSituacaoTributaria;
      property Aliquota : Real read FAliquota write setFAliquota;
      property ValorUnitario : Real read FValorUnitario write setFValorUnitario;

  end;

  TListaPafRegP2 = TObjectList<TPafRegP2>;

  TControllerPafRegP2 = Class(TControllerBase)

  private

  public
    Lista :TListaPafRegP2;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getlist:Boolean;
  End;

implementation


{ TControllerPafRegP2 }

constructor TControllerPafRegP2.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListaPafRegP2.Create;
end;

destructor TControllerPafRegP2.Destroy;
begin

  inherited;
end;

function TControllerPafRegP2.getlist: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegP2;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select p.pro_codigo, p.pro_cest, p.pro_codigoncm, ',
                'p.pro_descricao, m.med_abreviatura, p.pro_iat, p.pro_tributacao, ',
                'p.pro_sub_trib, PR.prc_vl_vda ',
                'from tb_produto p ',
                '  inner join tb_medida m ',
                '  on (m.med_codigo = p.pro_codmed) ',
                '  inner join tb_preco pr ',
                '  on (pr.prc_codpro = p.pro_codigo) ',
                'where pr.prc_codtpr = 1 '
      ));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafRegP2.Create;
        LITem.FIAT            := FieldByname('PRO_IAT').AsString;
        LITem.Descricao      := FieldByname('PRO_DESCRICAO').AsString;
        LITem.CEST           := FieldByname('PRO_CEST').AsString;
        LITem.Codigo         := FieldByname('PRO_CODIGO').AsString;
        LITem.ValorUnitario  := FieldByname('PRC_VL_VDA').AsFloat;
        //1 - Revenda
        //2 - Produção
        //3 - Consignado
        //4 - Industrialização
        //5 - Consumo Interno
        //6 - Prestação de Serviço
        //7 - Ativo Imobilizado
        if ( FieldByname('PRO_TRIBUTACAO').AsString = '2') then
          LITem.IPPT           := 'P'
        ELSE
          LITem.IPPT           := 'T';
        LITem.NCM            := FieldByname('PRO_CODIGONCM').AsString;

        LITem.Unidade        := FieldByname('MED_ABREVIATURA').AsString;
        //Código 	Situação Tributária
        //I 	Isento
        //N 	Não Tributado
        //F 	Substituição Tributária
        //T 	Tributado pelo ICMS
        //S 	Tributado pelo ISSQN
        if ( FieldByname('PRO_SUB_TRIB').AsString = 'S') then
          LITem.SituacaoTributaria := 'F'
        else
          LITem.SituacaoTributaria := 'N';
        LITem.Aliquota       := 0;
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

{ TPafRegP2 }

procedure TPafRegP2.setFAliquota(const Value: Real);
begin
  FAliquota := Value;
end;

procedure TPafRegP2.setFCEST(const Value: String);
begin
  FCEST := Value;
end;

procedure TPafRegP2.setFCodigo(const Value: String);
begin
  FCodigo := Value;
end;

procedure TPafRegP2.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPafRegP2.setFIAT(const Value: String);
begin
  FIAT := Value;
end;

procedure TPafRegP2.setFIPPT(const Value: String);
begin
  FIPPT := Value;
end;

procedure TPafRegP2.setFNCM(const Value: String);
begin
  FNCM := Value;
end;

procedure TPafRegP2.setFSituacaoTributaria(const Value: String);
begin
  FSituacaoTributaria := Value;
end;

procedure TPafRegP2.setFUnidade(const Value: String);
begin
  FUnidade := Value;
end;

procedure TPafRegP2.setFValorUnitario(const Value: Real);
begin
  FValorUnitario := Value;
end;

end.
