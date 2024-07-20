unit ControllerPafCtrl;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblPafCtrl, Un_MSg,Generics.Collections, ControllerPafRegA2,
      ControllerPafRegE2;

Type
  TInterface = class
    private
    FHaMovimentacao: String;
    FAberturaUsuario: String;
    FTempo: TTime;
    FSituacao: String;
    FData: TDate;
    procedure setFAberturaUsuario(const Value: String);
    procedure setFData(const Value: TDate);
    procedure setFHaMovimentacao(const Value: String);
    procedure setFSituacao(const Value: String);
    procedure setFTempo(const Value: TTime);

    public
      property Data : TDate read FData write setFData;
      property Tempo : TTime read FTempo write setFTempo;
      property Situacao: String read FSituacao write setFSituacao;
      property AberturaUsuario : String read FAberturaUsuario write setFAberturaUsuario;
      property HaMovimentacao: String read FHaMovimentacao write setFHaMovimentacao;


  end;

  TListaInterface = TObjectList<TInterface>;
  TListaPafCtrl = TObjectList<TPafCtrl>;


  TControllerPafCtrl = Class(TControllerBase)
  private
    FEstoque: Integer;
    FDataMovimento: TDate;
    procedure setFEstoque(const Value: Integer);
    procedure setFDataMovimento(const Value: TDate);

  public
    Registro : TPafCtrl;
    Lista : TListaPafCtrl;
    ListaInterface : TListaInterface;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    procedure Clear;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function getListInterface:Boolean;
    function forceClosure:Boolean;
    function setClosure:Boolean;
    function getNext:TDate;
    procedure getOpenedPrior;
    function closureDailySsale:Boolean;
    function closureDailyStock:Boolean;
    property Estoque : Integer read FEstoque write setFEstoque;
    Property DataMovimento : TDate read FDataMovimento write setFDataMovimento;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerPafCtrl.Clear;
begin
  ClearObj(Registro);
end;

function TControllerPafCtrl.closureDailySsale: Boolean;
var
  Lc_Qry : TSTQuery;
  RegA2 : TControllerPafRegA2;
begin
  result := False;
  RegA2 := TControllerPafRegA2.create(nil);
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'select ',
              ' NF.nfl_dt_emissao, ',
              ' FP.fpt_descricao, ',
              ' NF.nfl_modelo, ',
              ' Sum(coalesce(fnc.fin_vl_pago,0)) TotalPago, ',
              ' Sum(coalesce(fnc.fin_vl_parcela,0)) TotalPagar ',
              'from tb_nota_fiscal nf ',
              '  inner join tb_pedido ',
              '  on (ped_codigo = nfl_codped) ',
              '  inner join tb_financeiro fnc ',
              '  on (fnc.fin_codnfl = nfl_codigo) ',
              '  inner join tb_formapagto fp ',
              '  on (fp.fpt_codigo = fnc.fin_codfpg) ',
              'where ( nf.nfl_dt_emissao =:DATA ) and fnc.fin_tipo = ''RA'' ',
              'group by 1,2,3 ',
              'order by 2 '
      ));
      parambyname('DATA').asDate := FDataMovimento;
      active := True;
      FetchAll;
      if recordCount > 0 then
      Begin
        result := True;
        first;
        while not eof do
        Begin
          RegA2.Clear;
          RegA2.Registro.DataMovimento := FieldByName('nfl_dt_emissao').AsDateTime;
          RegA2.Registro.MeioPagamento := FieldByName('fpt_descricao').AsString;
          if FieldByName('nfl_modelo').AsString = '65' then
            RegA2.Registro.TipoDocumento := '1'
          else
            RegA2.Registro.TipoDocumento := '2';
          if FieldByName('TOTALPAGO').AsFloat > 0 then
            RegA2.Registro.Valor         := FieldByName('TOTALPAGO').AsFloat
          else
            RegA2.Registro.Valor         := FieldByName('TOTALPAGAR').AsFloat;
          RegA2.salva;

          Next;
        End;
      End;
    end;
  Finally
    RegA2.disposeOf;
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPafCtrl.closureDailyStock: Boolean;
var
  RegA2 : TControllerPafRegE2;
begin
  Try
    RegA2 := TControllerPafRegE2.create(nil);
    RegA2.DataMovimento := FDataMovimento;
    RegA2.Estoque       := FEstoque;
    if ( not RegA2.FirstRegister) then
    Begin
      RegA2.closureDailyStock;
      RegA2.updateDailyStock;
    End;
  Finally
    RegA2.disposeOf;
  End;
end;

constructor TControllerPafCtrl.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPafCtrl.Create;
  Lista := TListaPafCtrl.Create;
  ListaInterface := TListaInterface.Create;
end;

function TControllerPafCtrl.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPafCtrl.Destroy;
begin
  ListaInterface.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPafCtrl.forceClosure: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PAF_CTRL ',
                'WHERE ( STATUS <> ''F'' ) '
      ));
      Active := True;
      FetchAll;
      Result := ( recordCount >=3 ); //D + 2
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPafCtrl.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;



function TControllerPafCtrl.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPafCtrl.setClosure: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'UPDATE TB_PAF_CTRL PC SET ',
                'PC.status =:status, ',
                'PC.user_id_closure =:user_id_closure, ',
                'PC.has_statement =:has_statement, ',
                'PC.ts_closure =:ts_closure ',
                'WHERE PC.dt_record =:dt_record '
      ));
      ParambyName('dt_record').AsDate           := Registro.DataMovimento;
      ParambyName('status').AsString            := Registro.Situacao;
      ParambyName('user_id_closure').AsInteger  := Registro.UsuarioFechamento;
      ParambyName('has_statement').AsString     := Registro.HaMovimentacao;
      ParambyName('ts_closure').AsDateTime      := Registro.TempoFechamento;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPafCtrl.setFDataMovimento(const Value: TDate);
begin
  FDataMovimento := Value;
end;

procedure TControllerPafCtrl.setFEstoque(const Value: Integer);
begin
  FEstoque := Value;
end;

function TControllerPafCtrl.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPafCtrl.getById;
begin
  _getByKey(Registro);
end;

function TControllerPafCtrl.getNext: TDate;
var
  Lc_Qry : TSTQuery;
  LITem : TPafCtrl;
begin
  Result := Date;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select MAX(pc.dt_record) DTMAX ',
                'FROM TB_PAF_CTRL pc '
      ));
      Active := True;
      FetchAll;
      if recordCount > 0 then
      Begin
        Result := FieldByName('DTMAX').AsDatetime + 1;
        if ( Result < Date ) then
          Result := Date;
       End
      else
      Begin
        Result := Date;
      End;

    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerPafCtrl.getOpenedPrior;
var
  Lc_Qry : TSTQuery;
  LITem : TPafCtrl;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT FIRST 1 * ',
                'FROM TB_PAF_CTRL ',
                'WHERE (DT_RECORD <:DT_RECORD ) ',
                ' and STATUS = ''A'' '
      ));
      ParamByName('DT_RECORD').AsDatetime := registro.DataMovimento;
      Active := True;
      FetchAll;
      exist := ( recordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPafCtrl.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafCtrl;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PAF_CTRL ',
                'WHERE DT_RECORD IS NOT NULL '
      ));
      if registro.Situacao <> '' then
        sql.add(' AND (STATUS =:STATUS) ');

      if registro.Situacao <> '' then
        ParamByName('STATUS').AsString := registro.Situacao;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafCtrl.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerPafCtrl.getListInterface: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TInterface;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT pc.DT_RECORD, pc.TS_OPENING, pc.STATUS, ',
                'usu_a.USU_LOGIN, pc.HAS_STATEMENT ',
                'FROM TB_PAF_CTRL pc ',
                ' INNER JOIN TB_USUARIO usu_a ',
                ' ON (pc.USER_ID_OPENING = usu_a.USU_CODIGO) ',
                'WHERE DT_RECORD IS NOT NULL '
      ));
      if registro.Situacao <> '' then
        sql.add(' AND (STATUS =:STATUS) ');
      sql.add('Order by pc.DT_RECORD ');
      if registro.Situacao <> '' then
        ParamByName('STATUS').AsString := registro.Situacao;
      Active := True;
      FetchAll;
      First;
      ListaInterface.Clear;
      while not eof do
      Begin
        LITem := TInterface.Create;
        LITem.Data  := FieldByName('DT_RECORD').AsDateTime;
        LITem.Tempo := FieldByName('TS_OPENING').AsDateTime;
        if FieldByName('STATUS').AsString = 'A' then
          LITem.Situacao  := 'Aberto'
        else
          LITem.Situacao  := 'Fechado';
        LITem.AberturaUsuario := FieldByName('USU_LOGIN').AsString;
        if FieldByName('HAS_STATEMENT').AsString = 'N' then
          LITem.HaMovimentacao  := 'Não'
        else
          LITem.HaMovimentacao  := 'Sim';
        ListaInterface.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

{ TInterface }

procedure TInterface.setFAberturaUsuario(const Value: String);
begin
  FAberturaUsuario := Value;
end;

procedure TInterface.setFData(const Value: TDate);
begin
  FData := Value;
end;

procedure TInterface.setFHaMovimentacao(const Value: String);
begin
  FHaMovimentacao := Value;
end;

procedure TInterface.setFSituacao(const Value: String);
begin
  FSituacao := Value;
end;

procedure TInterface.setFTempo(const Value: TTime);
begin
  FTempo := Value;
end;

end.
