unit ControllerMovimentoFinanceiro;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblMovimentoFinanceiro,objFinancialStatement,
      Generics.Collections,controllerProduto, ControllerFormaPagamento;


Type
  TListaMovimentoFinanceiro = TObjectList<TMovimentoFinanceiro>;

  TControllerMovimentoFinanceiro = Class(TControllerBase)
    Lista: TListaMovimentoFinanceiro;
  private
    FormaPagto :TControllerFormaPagamento;
    function nextCodigo:Integer;
  public
    Registro : TMovimentoFinanceiro;
    Obj: TObjFinancialStatement;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    function insere:boolean;
    function atualiza:boolean;
    function delete:boolean;
    procedure getCashierList;
    procedure getByQuitacao;
    procedure getQuitacaoList;
    procedure getManualListUpdate(UltimaAtualizacao:TDAteTime);
    function getQuitacao:Integer;
    function getByID:Boolean;
    procedure getList;
    function DeletaByQuitacao:Boolean;
    procedure getListSincronia(Data:TDAteTime;Tipo:String);
    procedure ClearDataObjecto;
    procedure FillDataObjeto(PcRegistro:TMovimentoFinanceiro);
    function GetVinculoCaixaBancoByTransferencia:Boolean;
    procedure DeleteVinculoCaixaBancoByTransferencia;
    procedure UpdateConferido;
  End;

implementation

uses un_funcoes, Un_Regra_Negocio;

function TControllerMovimentoFinanceiro.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

procedure TControllerMovimentoFinanceiro.ClearDataObjecto;
begin
  clearObj(Obj);
end;

constructor TControllerMovimentoFinanceiro.Create(AOwner: TComponent);
begin
  inherited;
  FormaPagto := TControllerFormaPagamento.Create(self);
  Registro := TMovimentoFinanceiro.Create;
  Lista := TListaMovimentoFinanceiro.Create;
  Obj := TObjFinancialStatement.create;
end;

function TControllerMovimentoFinanceiro.DeletaByQuitacao: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE  ',
                      'FROM TB_MOVIM_FINANCEIRO ',
                      'WHERE ( MVF_CODQTC =:MVF_CODQTC ) '
                      ));
      ParamByName('MVF_CODQTC').AsInteger := Registro.Quitacao;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerMovimentoFinanceiro.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := true;
  except
    Result := FAlse;
  end;
end;

procedure TControllerMovimentoFinanceiro.DeleteVinculoCaixaBancoByTransferencia;
var
  Lc_Qry : TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'delete ',
                'from tb_movim_financeiro m ',
                'where m.mvf_historisco =:mvf_historisco  ',
                ' and m.mvf_codqtc =:mvf_codqtc  ',
                ' and m.mvf_codctb >0  '
      ));
      ParamByName('mvf_historisco').AsString := Registro.Historico;
      ParamByName('mvf_codqtc').AsInteger := Registro.Quitacao;
      ExecSQL
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerMovimentoFinanceiro.Destroy;
begin
  FormaPagto.DisposeOf;
  Obj.Destroy;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerMovimentoFinanceiro.FillDataObjeto(
  PcRegistro: TMovimentoFinanceiro);
begin
  with Obj do
  Begin
    with Movimento do
    Begin
      Movimento.Codigo          :=  PcRegistro.Codigo;
      Movimento.Estabelecimento :=  obj.Estabelecimento;
      Movimento.Terminal        :=  obj.Terminal;
      Movimento.ContaCorrente   :=  PcRegistro.ContaCorrente;
      Data                      :=  PcRegistro.Data;
      HistoricoBancario         :=  PcRegistro.HistoricoBancario;
      ValorCredito              :=  PcRegistro.ValorCredito;
      ValorDebito               :=  PcRegistro.ValorDebito;
      HistoricoManual           :=  PcRegistro.Historico;
      TipoMovimento             :=  PcRegistro.Tipo;
      CodigoQuitacao            :=  PcRegistro.Quitacao;
      Usuario                   :=  PcRegistro.Usuario;
      if PcRegistro.ValorFuturo > 0 then
        ValorFuturo             :=  'S'
      else
        ValorFuturo             :=  'N';
      DataOriginal              :=  PcRegistro.DataOriginal;
      DocReferencia             :=  PcRegistro.NrDocumento;
      Conferido                 :=  PcRegistro.Conferido;
      FormaPagamento            :=  PcRegistro.FormaPagto;
      ContaCredito              :=  PcRegistro.PL_Credito;
      ContaDebito               :=  PcRegistro.PL_Debito;
    End;
    FormaPagto.Registro.Codigo :=  PcRegistro.FormaPagto;
    FormaPagto.getById;
    Obj.FormaPagamento          := FormaPagto.Registro.Descricao;
  End;
end;

function TControllerMovimentoFinanceiro.getByID: Boolean;
begin
  _getByKey(Registro);
end;

procedure TControllerMovimentoFinanceiro.getByQuitacao;
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MOVIM_FINANCEIRO ',
                      'WHERE ( MVF_CODQTC =:MVF_CODQTC ) '
                      ));

      ParamByName('MVF_CODQTC').AsInteger := Registro.Quitacao;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,LITem);
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMovimentoFinanceiro.getCashierList;
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MOVIM_FINANCEIRO ',
                      'WHERE MVF_DATA=:MVF_DATA ',
                      ' AND (MVF_CODCTB = 0) ',
                      ' ORDER BY MVF_CODIGO '));

      ParamByName('MVF_DATA').AsDateTime := Registro.Data;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMovimentoFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMovimentoFinanceiro.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_MOVIM_FINANCEIRO ',
                'WHERE MVF_CODIGO IS NOT NULL '
     ));

      if FPeriodo then
        sql.add(' AND ( MVF_DATA BETWEEN :DATAINI AND :DATAFIM ) ');

      if registro.Codigo >0 then
        sql.Add(' AND (MVF_CODIGO=:MVF_CODIGO) ' );

      if registro.Quitacao >0 then
        sql.Add(' AND (MVF_CODQTC=:MVF_CODQTC) AND (MVF_CODQTC>0)' );

      if FPeriodo then
      Begin
        ParamByName('DATAINI').AsDateTime := FDataInicial;
        ParamByName('DATAFIM').AsDateTime := FDataFinal;
      End;

      if registro.Quitacao >0 then
        ParamByName('MVF_CODQTC').AsInteger := Registro.Quitacao;

      if Registro.Codigo >0 then
        ParamByName('MVF_CODIGO').AsInteger := Registro.Codigo;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMovimentoFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;

    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerMovimentoFinanceiro.getListSincronia(Data: TDAteTime;
  Tipo: String);
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select * ',
                'FROM TB_MOVIM_FINANCEIRO ',
                'WHERE  ( UPDATED_AT >:UPDATED_AT ) ',
                ' and  UPDATED_AT is not null '
      ));

      sql.add(' ORDER BY UPDATED_AT asc ');
      ParamByName('UPDATED_AT').AsDateTime := Data;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMovimentoFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMovimentoFinanceiro.getManualListUpdate(UltimaAtualizacao:TDAteTime);
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MOVIM_FINANCEIRO '
                    ));

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMovimentoFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerMovimentoFinanceiro.getQuitacao: Integer;
begin
  Result := Generator('GN_COD_BAIXA');
end;

procedure TControllerMovimentoFinanceiro.getQuitacaoList;
var
  Lc_Qry : TSTQuery;
  LITem : TMovimentoFinanceiro;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MOVIM_FINANCEIRO ',
                      'WHERE MVF_CODQTC =:MVF_CODQTC '
                    ));

      ParamByName('MVF_CODQTC').AsInteger := Registro.Quitacao;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMovimentoFinanceiro.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerMovimentoFinanceiro.GetVinculoCaixaBancoByTransferencia: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select m.mvf_codigo ',
                'from tb_movim_financeiro m ',
                'where m.mvf_historisco =:mvf_historisco  ',
                ' and m.mvf_codqtc =:mvf_codqtc  ',
                ' and m.mvf_codctb >0  '
      ));
      ParamByName('mvf_historisco').AsString := Registro.Historico;
      ParamByName('mvf_codqtc').AsInteger := Registro.Quitacao;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerMovimentoFinanceiro.nextCodigo:Integer;
begin
  Result := Generator('GN_MOVIM_FINANCEIRO');
end;

function TControllerMovimentoFinanceiro.insere: boolean;
begin
  Registro.Codigo := nextCodigo;
  InsertObj(Registro);
end;

function TControllerMovimentoFinanceiro.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerMovimentoFinanceiro.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := nextCodigo;
  SaveObj(Registro);
end;

procedure TControllerMovimentoFinanceiro.UpdateConferido;
var
  Lc_Qry : TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'UPDATE TB_MOVIM_FINANCEIRO SET ',
                ' MVF_CONFERIDO=:MVF_CONFERIDO  ',
                ' WHERE (MVF_CODIGO =:MVF_CODIGO) '
      ));
      ParamByName('MVF_CONFERIDO').AsString := Registro.Conferido;
      ParamByName('MVF_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
