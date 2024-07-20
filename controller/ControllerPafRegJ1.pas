unit ControllerPafRegJ1;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_MSg,Generics.Collections;

Type
  TPafRegJ1 = class
  private
    FValorTotalLiquido: Real;
    FSubTotal: Real;
    FDescontoSubTotal: Real;
    FChaveAcesso: String;
    FTipoEmissao: String;
    FSerieNFCE: String;
    FDataEmissao: TDate;
    FCPFCNPJADQUIRENTE: String;
    FNumeroNFCE: String;
    procedure setFChaveAcesso(const Value: String);
    procedure setFCPFCNPJADQUIRENTE(const Value: String);
    procedure setFDataEmissao(const Value: TDate);
    procedure setFDescontoSubTotal(const Value: Real);
    procedure setFNumeroNFCE(const Value: String);
    procedure setFSerieNFCE(const Value: String);
    procedure setFSubTotal(const Value: Real);
    procedure setFTipoEmissao(const Value: String);
    procedure setFValorTotalLiquido(const Value: Real);



  public
    property  DataEmissao: TDate read FDataEmissao write setFDataEmissao;

    property  SubTotal: Real read FSubTotal write setFSubTotal;

    property  DescontoSubTotal: Real read FDescontoSubTotal write setFDescontoSubTotal;

    property  ValorTotalLiquido: Real read FValorTotalLiquido write setFValorTotalLiquido;

    property  TipoEmissao: String read FTipoEmissao write setFTipoEmissao;

    property  ChaveAcesso: String read FChaveAcesso write setFChaveAcesso;

    property  NumeroNFCE: String read FNumeroNFCE write setFNumeroNFCE;

    property  SerieNFCE: String read FSerieNFCE write setFSerieNFCE;

    property  CPFCNPJADQUIRENTE: String read FCPFCNPJADQUIRENTE write setFCPFCNPJADQUIRENTE;

  end;

  TListaPafRegJ1 = TObjectList<TPafRegJ1>;

  TControllerPafRegJ1 = Class(TControllerBase)

  private
    FDataFinal: TDate;
    FDataInicial: TDate;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);

  public
    Lista :TListaPafRegJ1;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getlist:Boolean;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
  End;

implementation


{ TControllerPafRegJ1 }

constructor TControllerPafRegJ1.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListaPafRegJ1.Create;
end;

destructor TControllerPafRegJ1.Destroy;
begin

  inherited;
end;

function TControllerPafRegJ1.getlist: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegJ1;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                '    n.nfl_dt_emissao, ',
                '    nfc.nfc_datetime, ',
                '    p.ped_vl_desconto, ',
                '    n.nfl_vl_tl_nota, ',
                '    nfc.nfc_tp_emissao, ',
                '    nfc.nfc_arquivo, ',
                '    nfc.nfc_codigo, ',
                '    n.nfl_serie, ',
                '    ep.emp_cnpj ',
                'from tb_nota_fiscal n ',
                '   inner join tb_retorno_nfc nfc ',
                '   on (nfc.nfc_codnfl = n.nfl_codigo) ',
                '   inner join tb_pedido p ',
                '   on (p.ped_codigo = n.nfl_codped) ',
                '   inner join tb_empresa ep ',
                '   on (ep.emp_codigo = n.nfl_codemp) ',
                'where n.nfl_dt_emissao between :DATAINI AND :DATAFIM '
      ));
      ParamByName('DATAINI').AsDate := FDataInicial;
      ParamByName('DATAFIM').AsDate := FDataFinal;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafRegJ1.Create;
        LITem.DataEmissao         := FieldByname('nfl_dt_emissao').AsDateTime;
        LITem.ValorTotalLiquido   := FieldByname('nfl_vl_tl_nota').AsFloat + FieldByname('ped_vl_desconto').AsFloat;
        LITem.DescontoSubTotal    := FieldByname('ped_vl_desconto').AsFloat;
        LITem.SubTotal            := FieldByname('nfl_vl_tl_nota').AsFloat;
        LITem.ChaveAcesso         := Copy(FieldByname('nfc_arquivo').AsString,1,44);
        LITem.TipoEmissao         := FieldByname('nfc_tp_emissao').AsString;
        LITem.SerieNFCE           := FieldByname('nfl_serie').AsString;
        LITem.CPFCNPJADQUIRENTE   := FieldByname('emp_cnpj').AsString;
        LITem.NumeroNFCE          := FieldByname('nfc_codigo').AsString;
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


procedure TControllerPafRegJ1.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerPafRegJ1.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;


{ TPafRegJ1 }

procedure TPafRegJ1.setFChaveAcesso(const Value: String);
begin
  FChaveAcesso := Value;
end;

procedure TPafRegJ1.setFCPFCNPJADQUIRENTE(const Value: String);
begin
  FCPFCNPJADQUIRENTE := Value;
end;

procedure TPafRegJ1.setFDataEmissao(const Value: TDate);
begin
  FDataEmissao := Value;
end;

procedure TPafRegJ1.setFDescontoSubTotal(const Value: Real);
begin
  FDescontoSubTotal := Value;
end;

procedure TPafRegJ1.setFNumeroNFCE(const Value: String);
begin
  FNumeroNFCE := Value;
end;

procedure TPafRegJ1.setFSerieNFCE(const Value: String);
begin
  FSerieNFCE := Value;
end;

procedure TPafRegJ1.setFSubTotal(const Value: Real);
begin
  FSubTotal := Value;
end;

procedure TPafRegJ1.setFTipoEmissao(const Value: String);
begin
  FTipoEmissao := Value;
end;

procedure TPafRegJ1.setFValorTotalLiquido(const Value: Real);
begin
  FValorTotalLiquido := Value;
end;

end.
