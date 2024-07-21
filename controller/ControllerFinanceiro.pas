unit ControllerFinanceiro;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema, tblFinanceiro ,ObjFinancialBills,FireDAC.Stan.Param,
      Generics.Collections, ControllerMovimentoFinanceiro, System.AnsiStrings,
      ControllerGestaoWeb, ControllerFormaPagamento;

Type
  TListaFinanceiro = TObjectList<TFinanceiro>;

  TControllerFinanceiro = Class(TControllerBase)
    Lista : TListaFinanceiro;
  private
  public
    Registro : TFinanceiro;
    Movimento : TControllerMovimentoFinanceiro;
    Obj : TObjFinancialBills;
    ExportGestaoWeb : TControllerGestaoWeb;
    FormaPagto :TControllerFormaPagamento;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    procedure getlist;
    procedure getlistBoleto;
    procedure Clear;
    function salva:boolean;
    function delete:boolean;
    function deleteByNota:boolean;
    function migra:Boolean;
    function Atualiza:boolean;
    function AtualizaFIN_Numero:boolean;
    function ValorTotalNota:Real;
    function insere:boolean;
    procedure AlteraVencimentoValor;
    function deleteFinanceiroErro:Boolean;
    procedure getListSincronia(pData:TDAteTime;Tipo:String);
    procedure ClearDataObjecto;
    function cancelaBaixaByQuitacao:Boolean;
    function cancelaBaixa:Boolean;
    function verificaBaixadobyNota:Boolean;
    procedure FillDataObjeto(PcRegistro:TFinanceiro);
    function AtualizaEmpresaFinanceiro:Boolean;
    procedure Autorizacao;
    function Destinar:boolean;
  End;

implementation

{ TControllerFinanceiro }

uses Un_Regra_Negocio;

procedure TControllerFinanceiro.AlteraVencimentoValor;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_VL_PARCELA =:FIN_VL_PARCELA,'+
              'FIN_DT_VENCIMENTO=:FIN_DT_VENCIMENTO '+
              'WHERE FIN_CODIGO =:FIN_CODIGO ');
      FieldByName('FIN_VL_PARCELA').AsFloat := Registro.ValorParcela;
      FieldByName('FIN_DT_VENCIMENTO').AsDateTime := Registro.DataVencimento;
      FieldByName('FIN_CODIGO').AsFloat := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerFinanceiro.Atualiza: boolean;
begin
  result := True;
  try
    UpdateObj(Registro);
  except
    result := False;
  end;
end;

function TControllerFinanceiro.AtualizaEmpresaFinanceiro: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              'UPDATE TB_FINANCEIRO SET ',
              'FIN_CODEMP =:EMP_CODIGO ',
              'WHERE FIN_CODNFL=:NFL_CODIGO '
      ));
      ParamByName('EMP_CODIGO').AsInteger := registro.CodigoEmpresa;
      ParamByName('NFL_CODIGO').AsInteger := registro.CodigoNota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry )
  End;
end;

function TControllerFinanceiro.AtualizaFIN_Numero: boolean;
Var
  Lc_Qry: TSTQuery;
  Lc_Upt: TSTQuery;
  Lc_Qt_Parcelas: Integer;
  Lc_Fin_Numero: String;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  // Cria o update
  Lc_Upt := GeraQuery;
  try
    Lc_Qry.sql.Clear;
    Lc_Qry.sql.Add(concat(
                    'SELECT FIN_CODIGO,FIN_NR_PARCELA,PED_NUMERO,NFL_NUMERO ',
                    'FROM TB_FINANCEIRO ' ,
                    '  INNER JOIN TB_NOTA_FISCAL ',
                    '  ON (NFL_CODIGO = FIN_CODNFL) ',
                    '  INNER JOIN TB_PEDIDO ' ,
                    '  ON (PED_CODIGO = NFL_CODPED) ',
                    'WHERE FIN_CODNFL=:NFL_CODIGO'
    ));
    Lc_Qry.ParamByName('NFL_CODIGO').AsInteger := REgistro.CodigoNota;

    Lc_Upt.sql.Clear;
    Lc_Upt.sql.Add(concat(
                   'UPDATE TB_FINANCEIRO SET ' +
                   ' FIN_NUMERO=:FIN_NUMERO ' +
                   'WHERE FIN_CODIGO=:FIN_CODIGO'
    ));
    Lc_Qry.Active := True;
    Lc_Qry.FetchAll;
    Lc_Qt_Parcelas := Lc_Qry.recordcount;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    Begin
      IF Trim(Lc_Qry.FieldByName('NFL_NUMERO').AsString) = '' then
      Begin
        Lc_Fin_Numero := Lc_Qry.FieldByName('PED_NUMERO').AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '/' + Lc_Qry.FieldByName('PED_NUMERO')
          .AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '/' + Lc_Qry.FieldByName
          ('FIN_NR_PARCELA').AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '-' + IntToStr(Lc_Qt_Parcelas);
      end
      else
      Begin
        Lc_Fin_Numero := Lc_Qry.FieldByName('PED_NUMERO').AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '/' + Lc_Qry.FieldByName('NFL_NUMERO')
          .AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '/' + Lc_Qry.FieldByName
          ('FIN_NR_PARCELA').AsString;
        Lc_Fin_Numero := Lc_Fin_Numero + '-' + IntToStr(Lc_Qt_Parcelas);
      end;
      Lc_Upt.Active := False;
      Lc_Upt.ParamByName('FIN_NUMERO').AsString := Lc_Fin_Numero;
      Lc_Upt.ParamByName('FIN_CODIGO').AsInteger :=
        Lc_Qry.FieldByName('FIN_CODIGO').AsInteger;
      Lc_Upt.ExecSQL;
      Lc_Qry.Next;
    end;
  finally
    finalizaQuery(Lc_Qry);
    finalizaQuery(Lc_Upt);
  end;
end;

procedure TControllerFinanceiro.Autorizacao;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'UPDATE TB_FINANCEIRO SET ',
                   '  FIN_AUTORIZADO =:FIN_AUTORIZADO ',
                   'WHERE ( FIN_CODIGO =:FIN_CODIGO ) '
            ));
      ParamByName('FIN_AUTORIZADO').AsString := Registro.Autorizado;
      ParamByName('FIN_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerFinanceiro.cancelaBaixa: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'UPDATE TB_FINANCEIRO SET ',
                   '  FIN_BAIXA = ''N'', ',
                   '  FIN_ETAPA = ''N'', ',
                   '  FIN_SITUACAO = ''N'', ',
                   '  FIN_DT_PAGTO = Null, ',
                   '  FIN_VL_PAGO = Null, ',
                   '  FIN_DT_BAIXA = Null ',
                   'WHERE ( FIN_CODIGO =:FIN_CODIGO ) '
            ));
      ParamByName('FIN_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerFinanceiro.cancelaBaixaByQuitacao: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'UPDATE TB_FINANCEIRO SET ',
                   '  FIN_BAIXA = ''N'', ',
                   '  FIN_ETAPA = ''N'', ',
                   '  FIN_SITUACAO = ''N'', ',
                   '  FIN_DT_PAGTO = Null, ',
                   '  FIN_VL_PAGO = Null, ',
                   '  FIN_DT_BAIXA = Null ',
                   'WHERE (FIN_CODQTC =:FIN_CODQTC) ',
                   ' AND (FIN_CODQTC > 0) '
            ));
      ParamByName('FIN_CODQTC').AsInteger := Registro.CodigoQuitacao;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFinanceiro.Clear;
begin
  clearObj(Registro);
end;

procedure TControllerFinanceiro.ClearDataObjecto;
begin
  clearObj(Obj);
end;

constructor TControllerFinanceiro.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFinanceiro.Create;
  Movimento := TControllerMovimentoFinanceiro.Create(Self);
  FormaPagto := TControllerFormaPagamento.Create(Self);
  Lista :=  TListaFinanceiro.Create;
  Obj := TObjFinancialBills.Create;
  ExportGestaoWeb := TControllerGestaoWeb.Create(Self);
end;

function TControllerFinanceiro.delete: boolean;
begin
  result := True;
  try
    deleteObj(Registro);
  finally
    Result := False;
  end;
end;

function TControllerFinanceiro.deleteByNota: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'DELETE FROM TB_FINANCEIRO F ',
                  'WHERE (FIN_CODNFL =:FIN_CODNFL) '
            ));
      ParamByName('FIN_CODNFL').AsInteger := Registro.CodigoNota;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerFinanceiro.deleteFinanceiroErro: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  'DELETE FROM TB_FINANCEIRO F ',
                  'WHERE (FIN_OPERACAO =:FIN_OPERACAO) '
            ));
      ParamByName('FIN_OPERACAO').AsString := 'D';
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerFinanceiro.Destinar: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_CODQTC =:FIN_CODQTC, '+
              'FIN_SITUACAO =:FIN_SITUACAO, '+
              'FIN_CODFPG =:FIN_CODFPG '+
              'WHERE FIN_CODIGO =:FIN_CODIGO');
      ParamByName('FIN_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('FIN_CODQTC').AsInteger := Registro.CodigoQuitacao;
      ParamByName('FIN_SITUACAO').AsString := 'D';
      ParamByName('FIN_CODFPG').AsInteger := Registro.FormaPagamento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerFinanceiro.Destroy;
begin
  ExportGestaoWeb.DisposeOf;
  Obj.Destroy;
  Lista.DisposeOf;
  FormaPagto.DisposeOf;
  Movimento.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerFinanceiro.FillDataObjeto(PcRegistro: TFinanceiro);
begin
  with Obj.Financeiro do
  Begin
    FormaPagto.Registro.Codigo :=  PcRegistro.FormaPagamento;
    FormaPagto.getById;
    Obj.FormaPagamento          := FormaPagto.Registro.Descricao;

    //Codigo          := PcRegistro.Codigo;
    Ordem           := PcRegistro.CodigoNota;
    Estabelecimento := Obj.Estabelecimento;
    Terminal        := Obj.Terminal;
    Parcela         := PcRegistro.NumeroParcela;
    DataExpiracao   := PcRegistro.DataVencimento;
    TipoPagamento   := 0;
    Valor           := PcRegistro.ValorParcela;
  End;

  with Obj.Contas do
  Begin
    //Codigo          := PcRegistro.Codigo;
    Ordem           := PcRegistro.CodigoNota;
    Estabelecimento := Obj.Estabelecimento;
    Terminal        := Obj.Terminal;
    Parcela         := PcRegistro.NumeroParcela;
    PlanoContas     := PcRegistro.CentroCusto;
    Numero          := PcRegistro.NumeroDuplicata;
    Tipo            := PcRegistro.TipoFinanceiro;
    Situacao        := PcRegistro.SituacaoFinanceiro;
    Operacao        := PcRegistro.OperacaoFinanceiro;
    Fase            :=  PcRegistro.EtapaFinaceiro;
  End;

  IF PcRegistro.DocumentoBaixado = 'S' then
  Begin
    with Obj.Pagamentos do
    Begin
      Codigo          := PcRegistro.Codigo;
      Ordem             := PcRegistro.CodigoNota;
      Estabelecimento   := Obj.Estabelecimento;
      Terminal          := Obj.Terminal;
      Parcela           := PcRegistro.NumeroParcela;
      Juro              := PcRegistro.ValorJuros;
      ValorDeMora       := PcRegistro.ValorMora;
      AliquotaDesconto  := PcRegistro.AliquotaDesconto;
      ValorPago         := PcRegistro.ValorPago;
      DataDoPagamento   := PcRegistro.DataPagamento;
      DataDaBaixa       := PcRegistro.DataBaixa;
      Baixa             := PcRegistro.DocumentoBaixado;
      PlanoContas       := PcRegistro.ContaResultado;
      CodigoBaixa       := PcRegistro.CodigoQuitacao;
    End;
  End;
end;

procedure TControllerFinanceiro.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerFinanceiro.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TFinanceiro;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_financeiro ',
                      'WHERE FIN_CODIGO IS NOT NULL '
                      ));

      if FPeriodo then
        sql.add(' AND ( FIN_DATA BETWEEN :DATAINI AND :DATAFIM ) ');

      if Registro.Codigo >0 then
        sql.add(' AND FIN_CODIGO =:FIN_CODIGO ');

      if Registro.CodigoPedido >0 then
        sql.add(' AND FIN_CODPED=:PED_CODIGO ');

      if Registro.CodigoQuitacao >0 then
        sql.add(' AND FIN_CODQTC=:FIN_CODQTC ');

      if Registro.DataFinanceiro >0 then
        sql.add(' AND FIN_DATA=:FIN_DATA ');

      sql.add(' ORDER BY FIN_CODIGO ');

      if FPeriodo then
      Begin
        ParamByName('DATAINI').AsDateTime := FDataInicial;
        ParamByName('DATAFIM').AsDateTime := FDataFinal;
      End;

      if Registro.Codigo >0 then
        ParamByName('FIN_CODIGO').AsInteger := Registro.Codigo;

      if Registro.CodigoPedido >0 then
        ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;

      if Registro.CodigoQuitacao >0 then
        ParamByName('FIN_CODQTC').AsInteger := Registro.CodigoQuitacao;

      if Registro.DataFinanceiro >0 then
        ParamByName('FIN_DATA').AsDateTime := Registro.DataFinanceiro;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFinanceiro.getlistBoleto;
var
  Lc_Qry : TSTQuery;
  LITem : TFinanceiro;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_financeiro ',
                      '  INNER JOIN TB_FORMAPAGTO '+
                      '  ON (FPT_CODIGO = FIN_CODFPG) '+
                      'WHERE FIN_CODIGO IS NOT NULL ' +
                      ' AND (FPT_DESCRICAO LIKE :FPT_DESCRICAO) ',
                      ' AND ( FIN_CODNFL=:NFL_CODIGO ) '
                      ));

      ParamByName('NFL_CODIGO').AsInteger := Registro.CodigoNota;
      ParamByName('FPT_DESCRICAO').AsString := '%BOLETO%';
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFinanceiro.getListSincronia(pData: TDAteTime; Tipo: String);
var
  Lc_Qry : TSTQuery;
  LITem : TFinanceiro;
begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select * ',
                'FROM TB_FINANCEIRO ',
                'WHERE  ( UPDATED_AT >:UPDATED_AT ) ',
                ' and  UPDATED_AT is not null '
      ));

      sql.add(' ORDER BY UPDATED_AT asc ');
      ParamByName('UPDATED_AT').AsDateTime := pData;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerFinanceiro.insere: boolean;
begin
  result := True;
  if Registro.codigo = 0 then
    Registro.codigo := Generator('GN_FINANCEIRO');
  InsertObj(Registro);
end;

function TControllerFinanceiro.migra: Boolean;
begin
  result := True;
  InsertObj(Registro);
end;

function TControllerFinanceiro.salva: boolean;
begin
  result := True;
  if Registro.codigo = 0 then
    Registro.codigo := Generator('GN_FINANCEIRO');
  SaveObj(Registro);
end;

function TControllerFinanceiro.ValorTotalNota: Real;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'select sum(F.FIN_VL_PARCELA) VALOR ',
              'FROM TB_FINANCEIRO F ',
              'where F.FIN_CODNFL=:NFL_CODIGO '
      ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.CodigoNota;
      Active := True;
      FetchAll;
      Result := FieldByName('VALOR').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerFinanceiro.verificaBaixadobyNota: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'SELECT FIN_CODIGO ',
              'FROM TB_FINANCEIRO ',
              'WHERE (FIN_CODNFL =:NFL_CODIGO) ',
              ' AND (FIN_BAIXA = ''S'')'
      ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.CodigoNota;
      Active := True;
      FetchAll;
      Result := (recordCount > 0);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
