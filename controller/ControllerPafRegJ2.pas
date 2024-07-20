unit ControllerPafRegJ2;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_MSg,Generics.Collections,System.Math;

Type
  TPafRegJ2 = class
  private
    FProduto: String;
    FTotalizadorParcial: String;
    FNumeroItem: String;
    FDescricao: String;
    FValorUnitario: Real;
    FCasasDecimaisQtde: String;
    FChaveAcesso: String;
    FSerieNFCE: String;
    FDataEmissao: TDate;
    FNumeroNFCE: String;
    FUnidade: String;
    FAcrescimoItem: REal;
    FDescontoItem: Real;
    FQuantidade: Real;
    FValorLiquido: Real;
    FCasaDecimaisVlUnit: String;
    procedure setFAcrescimoItem(const Value: REal);
    procedure setFCasaDecimaisVlUnit(const Value: String);
    procedure setFCasasDecimaisQtde(const Value: String);
    procedure setFChaveAcesso(const Value: String);
    procedure setFDataEmissao(const Value: TDate);
    procedure setFDescontoItem(const Value: Real);
    procedure setFDescricao(const Value: String);
    procedure setFNumeroItem(const Value: String);
    procedure setFNumeroNFCE(const Value: String);
    procedure setFProduto(const Value: String);
    procedure setFQuantidade(const Value: Real);
    procedure setFSerieNFCE(const Value: String);
    procedure setFTotalizadorParcial(const Value: String);
    procedure setFUnidade(const Value: String);
    procedure setFValorLiquido(const Value: Real);
    procedure setFValorUnitario(const Value: Real);



  public
    property  DataEmissao: TDate read FDataEmissao write setFDataEmissao;
    property  NumeroItem: String  read FNumeroItem write setFNumeroItem;
    property  Produto: String read FProduto write setFProduto;
    property  Descricao: String read FDescricao write setFDescricao;
    property  Quantidade: Real read FQuantidade write setFQuantidade;
    property  Unidade: String read FUnidade write setFUnidade;
    property  ValorUnitario: Real read FValorUnitario write setFValorUnitario;
    property  DescontoItem: Real  read FDescontoItem write setFDescontoItem;
    property  AcrescimoItem: REal read FAcrescimoItem write setFAcrescimoItem;
    property  ValorLiquido: Real read FValorLiquido write setFValorLiquido;
    property  TotalizadorParcial: String read FTotalizadorParcial write setFTotalizadorParcial;
    property  CasasDecimaisQtde: String  read FCasasDecimaisQtde write setFCasasDecimaisQtde;
    property  CasasDecimaisVlUnit: String read FCasaDecimaisVlUnit write setFCasaDecimaisVlUnit;
    property  ChaveAcesso: String read FChaveAcesso write setFChaveAcesso;
    property  NumeroNFCE: String read FNumeroNFCE write setFNumeroNFCE;
    property  SerieNFCE: String read FSerieNFCE write setFSerieNFCE;

  end;

  TListaPafRegJ2 = TObjectList<TPafRegJ2>;

  TControllerPafRegJ2 = Class(TControllerBase)
  private
    FSerieNfce: String;
    FNumeroNFce: String;
    procedure setFNumeroNFce(const Value: String);
    procedure setFSerieNfce(const Value: String);



  public
    Lista :TListaPafRegJ2;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getNfce:Boolean;

    property NumeroNFce : String read FNumeroNFce write setFNumeroNFce;
    property SerieNfce : String read FSerieNfce write setFSerieNfce;
  End;

implementation


{ TControllerPafRegJ2 }

uses un_Padrao;

constructor TControllerPafRegJ2.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListaPafRegJ2.Create;
end;

destructor TControllerPafRegJ2.Destroy;
begin

  inherited;
end;

function TControllerPafRegJ2.getNfce: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegJ2;
  Lc_Nr_Item : Integer;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                '    i.ITF_SEQUENCIA, ',
                '    I.itf_codpro, ',
                '    pr.pro_descricao, ',
                '    PRO_CODMED_TRIB, ',
                '    i.itf_qtde, ',
                '    m.med_abreviatura, ',
                '    i.itf_vl_unit, ',
                '    i.itf_vl_desc, ',
                '    n.nfl_dt_emissao, ',
                '    nfc.nfc_arquivo, ',
                '    nfc.nfc_codigo, ',
                '    n.nfl_serie ',
                'from tb_nota_fiscal n ',
                '   inner join tb_retorno_nfc nfc ',
                '   on (nfc.nfc_codnfl = n.nfl_codigo) ',
                '   inner join tb_pedido p ',
                '   on (p.ped_codigo = n.nfl_codped) ',
                '   inner join tb_empresa ep ',
                '   on (ep.emp_codigo = n.nfl_codemp) ',
                '   INNER JOIN tb_itens_nfl I ',
                '   ON (I.itf_codnfl = N.nfl_codigo) ',
                '   INNER JOIN tb_produto pr ',
                '   on (pr.pro_codigo = i.itf_codpro) ',
                '   inner join tb_medida m ',
                '   on (m.med_codigo = pr.pro_codmed) ',
                'where (NFC.nfc_codigo =:nfc_codigo ) ',
                ' and ( n.nfl_serie=:nfl_serie ) ',
                'ORDER BY 1 '
      ));
      ParamByName('nfc_codigo').AsString := FNumeroNFce;
      ParamByName('nfl_serie').AsString := FSerieNfce;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      Lc_Nr_Item := 0;
      while not eof do
      Begin
        LITem := TPafRegJ2.Create;
        Lc_Nr_Item := Lc_Nr_Item + 1;
        LITem.DataEmissao         := FieldByname('nfl_dt_emissao').AsDateTime;
        LITem.NumeroItem          := IntToStr(Lc_Nr_Item);
        LITem.Produto             := FieldByname('itf_codpro').AsString;
        LITem.Descricao           := FieldByname('PRO_DESCRICAO').AsString;
        LITem.Quantidade          := FieldByname('ITF_QTDE').AsFloat;
        LITem.Unidade             := FieldByname('med_abreviatura').AsString;
        LITem.ValorUnitario       := FieldByname('ITF_VL_UNIT').AsFloat;
        LITem.DescontoItem        := FieldByname('ITF_VL_DESC').AsFloat;
        LITem.AcrescimoItem       := 0;
        LITem.ValorLiquido        := FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat;
        LITem.ValorLiquido        := RoundTo( LITem.ValorLiquido ,-2);
        LITem.ValorLiquido        := LITem.ValorLiquido - LITem.DescontoItem;
        LITem.TotalizadorParcial  := '';
        LITem.CasasDecimaisQtde   := IntToStr( Fc_NumeroCasaDecima(FloatToStrF(LITem.Quantidade,ffFixed, 10, 6)) );
        LITem.CasasDecimaisVlUnit := IntToStr( Fc_NumeroCasaDecima(FloatToStrF(LITem.ValorLiquido,ffFixed, 10, 6)) );
        LITem.ChaveAcesso         := Copy(FieldByname('nfc_arquivo').AsString,1,44);
        LITem.NumeroNFCE          := FieldByname('nfc_codigo').AsString;
        LITem.SerieNFCE           := FieldByname('nfl_serie').AsString;

        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


procedure TControllerPafRegJ2.setFNumeroNFce(const Value: String);
begin
  FNumeroNFce := Value;
end;

procedure TControllerPafRegJ2.setFSerieNfce(const Value: String);
begin
  FSerieNfce := Value;
end;



{ TPafRegJ2 }

procedure TPafRegJ2.setFAcrescimoItem(const Value: REal);
begin
  FAcrescimoItem := Value;
end;

procedure TPafRegJ2.setFCasaDecimaisVlUnit(const Value: String);
begin
  FCasaDecimaisVlUnit := Value;
end;

procedure TPafRegJ2.setFCasasDecimaisQtde(const Value: String);
begin
  FCasasDecimaisQtde := Value;
end;

procedure TPafRegJ2.setFChaveAcesso(const Value: String);
begin
  FChaveAcesso := Value;
end;

procedure TPafRegJ2.setFDataEmissao(const Value: TDate);
begin
  FDataEmissao := Value;
end;

procedure TPafRegJ2.setFDescontoItem(const Value: Real);
begin
  FDescontoItem := Value;
end;

procedure TPafRegJ2.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPafRegJ2.setFNumeroItem(const Value: String);
begin
  FNumeroItem := Value;
end;

procedure TPafRegJ2.setFNumeroNFCE(const Value: String);
begin
  FNumeroNFCE := Value;
end;

procedure TPafRegJ2.setFProduto(const Value: String);
begin
  FProduto := Value;
end;

procedure TPafRegJ2.setFQuantidade(const Value: Real);
begin
  FQuantidade := Value;
end;

procedure TPafRegJ2.setFSerieNFCE(const Value: String);
begin
  FSerieNFCE := Value;
end;

procedure TPafRegJ2.setFTotalizadorParcial(const Value: String);
begin
  FTotalizadorParcial := Value;
end;

procedure TPafRegJ2.setFUnidade(const Value: String);
begin
  FUnidade := Value;
end;

procedure TPafRegJ2.setFValorLiquido(const Value: Real);
begin
  FValorLiquido := Value;
end;

procedure TPafRegJ2.setFValorUnitario(const Value: Real);
begin
  FValorUnitario := Value;
end;

end.
