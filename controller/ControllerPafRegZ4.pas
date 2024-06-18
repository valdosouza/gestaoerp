unit ControllerPafRegZ4;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_MSg,Generics.Collections;

Type
  TPafRegZ4 = class
  private
    FTotalizadorMensal: Real;
    FCpfCnpj: String;
    procedure setFCpfCnpj(const Value: String);
    procedure setFTotalizadorMensal(const Value: Real);


  public
    //02 	Número do CPF/CNPJ 	Número do CPF/CNPJ Identificado na NFC-e[
    property CpfCnpj : String read FCpfCnpj write setFCpfCnpj;

    //03 	Totalização Mensal 	Total de vendas no mês, com duas casas decimais, ao CPF/CNPJ indicado no campo
    property  TotalizadorMensal: Real read FTotalizadorMensal write setFTotalizadorMensal;

  end;

  TListaPafRegZ4 = TObjectList<TPafRegZ4>;

  TControllerPafRegZ4 = Class(TControllerBase)

  private
    FDataFinal: TDate;
    FDataInicial: TDate;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);

  public
    Lista :TListaPafRegZ4;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getlist:Boolean;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
  End;

implementation


{ TControllerPafRegZ4 }

constructor TControllerPafRegZ4.Create(AOwner: TComponent);
begin
  inherited;
  Lista := TListaPafRegZ4.Create;
end;

destructor TControllerPafRegZ4.Destroy;
begin

  inherited;
end;

function TControllerPafRegZ4.getlist: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegZ4;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ep.emp_cnpj, sum(n.nfl_vl_tl_nota) TOTAL ',
                'from tb_nota_fiscal n ',
                '   inner join tb_retorno_nfc nfc ',
                '   on (nfc.nfc_codnfl = n.nfl_codigo) ',
                '   inner join tb_pedido p ',
                '   on (p.ped_codigo = n.nfl_codped) ',
                '   inner join tb_empresa ep ',
                '   on (ep.emp_codigo = n.nfl_codemp) ',
                'where(ep.emp_cnpj is not null) and (ep.emp_cnpj <> '''') and (ep.emp_cnpj not like ''%00000000%'') ',
                ' and ( n.nfl_dt_emissao between :DATAINI AND :DATAFIM ) ',
                'group by 1 '
      ));
      ParamByName('DATAINI').AsDate := FDataInicial;
      ParamByName('DATAFIM').AsDate := FDataFinal;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafRegZ4.Create;
        LITem.CpfCnpj            := FieldByname('emp_cnpj').AsString;
        LITem.TotalizadorMensal  := FieldByname('TOTAL').AsFloat;
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


procedure TControllerPafRegZ4.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerPafRegZ4.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;


{ TPafRegZ4 }

procedure TPafRegZ4.setFCpfCnpj(const Value: String);
begin
  FCpfCnpj := Value;
end;

procedure TPafRegZ4.setFTotalizadorMensal(const Value: Real);
begin
  FTotalizadorMensal := Value;
end;

end.
