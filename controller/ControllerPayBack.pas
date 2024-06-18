unit ControllerPayBack;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPayBack ,Un_MSg,Generics.Collections,prmbase, prm_pay_back,
  ControllerPayBackExpired;

Type
  TListaPayBack = TObjectList<TPayBack>;


  TControllerPayBack = Class(TControllerBase)
  private
    FCodigoCliente : Integer;
    FValorSaldo : Real;
    function getNextNumero:Integer;
    procedure RegistraCreditoExpiradoCliente;
    procedure RegistraCreditoExpiradoGeral;
  public
    Registro : TPayBack;
    Lista : TListaPayBack;
    Parametros : TPrmPayBack;
    Expired : TControllerPayBackExpired;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure clear;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteByOrder:boolean;
    function getList:Boolean;
    function getListByCustomer:Boolean;
    function getCredito:Real;
    function GetCreditByOrder:Real;
    function getDebito:Real;
    function getSaldo:Real;
    function getbyCustomer:Boolean;
    function getbyOrderToUseCredit:Boolean;
    function getLasData:TDate;
    procedure RegistraCreditoExpirado;

  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

procedure TControllerPayBack.clear;
begin
  clearObj(Registro);
end;

constructor TControllerPayBack.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPayBack.Create;
  Lista := TListaPayBack.Create;
  Parametros := TPrmPAyBack.create;
  Expired := TControllerPayBackExpired.Create(Self);
end;

function TControllerPayBack.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPayBack.deleteByOrder: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'DELETE  ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerPayBack.Destroy;
begin
  Expired.Destroy;
  Parametros.Destroy;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPayBack.insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PAY_BACK');

    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPayBack.RegistraCreditoExpirado;
var
  Lc_Qry : TSTQuery;
  Lc_vl_debito : Real;
  Lc_vl_saldo : Real;
begin
  Try
    Parametros.DataInicial  := StrToDate('01/01/2000');
    Parametros.DataFinal    := Date - self.Parametros.Dias;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT pb.tb_institution_id, pb.tb_customer_id, ( SUM(credit_value) - SUM(debit_value) ) SALDO ' ,
              'FROM TB_PAY_BACK pb ' ,
              'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ' ,
              ' and ( pb.dt_record between :DATAINI AND :DATAFIM ) ',
              //' AND TB_CUSTOMER_ID = 9 ',
              'GROUP BY 1,2 ' ,
              'HAVING ( SUM(credit_value) - SUM(debit_value) ) <> 0 '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  := self.Parametros.Estabelecimento;
      ParamByName('DATAINI').AsDateTime           := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDateTime           := Parametros.DataFinal;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        FCodigoCliente := FieldByName('TB_CUSTOMER_ID').AsInteger;
        FValorSaldo := FieldByName('SALDO').AsFloat;
        RegistraCreditoExpiradoGeral;
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPayBack.RegistraCreditoExpiradoCliente;
var
  Lc_Qry : TSTQuery;
  Lc_VL_Credito : Real;
  Lc_vl_debito : Real;
  Lc_vl_saldo : Real;
begin
  Try
    Parametros.Periodo := True;
    Expired.Registro.CodigoCliente := FCodigoCliente;
    Parametros.DataInicial  := Expired.getLast;
    Parametros.DataFinal    := Date - self.Parametros.Dias;
    Parametros.PayBack.Cliente := FCodigoCliente;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
          'SELECT pb.tb_institution_id, pb.tb_customer_id, max(pb.dt_record) data, ( SUM(credit_value) - SUM(debit_value) ) SALDO ',
          'FROM TB_PAY_BACK pb ',
          'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ',
          'and ( pb.dt_record between :DATAINI AND :DATAFIM ) ',
          ' and ( pb.tb_customer_id =:tb_customer_id )',
          'GROUP BY 1,2 ',
          'HAVING ( SUM(credit_value) - SUM(debit_value) ) <> 0 '
      ));

      ParamByName('TB_INSTITUTION_ID').AsInteger  := self.Parametros.Estabelecimento;
      ParamByName('TB_CUSTOMER_ID').AsInteger     := FCodigoCliente;
      Expired.Registro.CodigoCliente := FCodigoCliente;
      ParamByName('DATAINI').AsDateTime           := Parametros.DataInicial;
      ParamByName('DATAFIM').AsDateTime           := Parametros.DataFinal;
      Active := True;
      FetchAll;
      First;
      Lc_vl_saldo := 0;
      Lc_vl_saldo := FieldByName('saldo').AsFloat;
      if Lc_vl_saldo <> 0 then
      Begin
        Registro.Codigo          := 0;
        Registro.Estabelecimento := Parametros.Estabelecimento;
        Registro.Terminal        := Parametros.Terminal;
        Registro.Data            := FieldByName('DATA').AsDateTime;
        Registro.Cliente         := FieldByName('TB_CUSTOMER_ID').AsInteger;
        Registro.ValorCredito    := 0;
        Registro.ValorDebito     := Lc_vl_saldo;
        Registro.Historico       := Concat('Crédito expirado periodo: ',DateToSTr(Parametros.DataInicial),' à ',DateToSTr(Parametros.DataFinal));
        Registro.Ordem           := 0;
        self.Insert;

        Expired.clear;
        Expired.Registro.Codigo           := Registro.Codigo;
        Expired.Registro.Estabelecimento  := Registro.Estabelecimento;
        Expired.Registro.Terminal         := Registro.Terminal;
        Expired.Registro.CodigoCliente    := FieldByName('TB_CUSTOMER_ID').AsInteger;
        Expired.Registro.Data             := FieldByName('DATA').AsDateTime;
        Expired.Registro.ValorExpirado    := Registro.ValorDebito;
        Expired.insert;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPayBack.RegistraCreditoExpiradoGeral;
var
  Lc_Qry : TSTQuery;
  Lc_VL_Credito : Real;
  Lc_vl_debito : Real;
  Lc_vl_saldo : Real;
begin
  Registro.Codigo          := 0;
  Registro.Estabelecimento := Parametros.Estabelecimento;
  Registro.Terminal        := Parametros.Terminal;
  Registro.Data            := Parametros.DataFinal;
  Registro.Cliente         := FCodigoCliente;
  Registro.ValorCredito    := 0;
  Registro.ValorDebito     := FValorSaldo;
  Registro.Historico       := Concat('Crédito expirado periodo: ',DateToSTr(Parametros.DataInicial),' à ',DateToSTr(Parametros.DataFinal));
  Registro.Ordem           := 0;
  self.Insert;

  Expired.clear;
  Expired.Registro.Codigo           := Registro.Codigo;
  Expired.Registro.Estabelecimento  := Registro.Estabelecimento;
  Expired.Registro.Terminal         := Registro.Terminal;
  Expired.Registro.CodigoCliente    := FCodigoCliente;
  Expired.Registro.Data             := Parametros.DataFinal;
  Expired.Registro.ValorExpirado    := Registro.ValorDebito;
  Expired.insert;
end;

function TControllerPayBack.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PAY_BACK');

    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerPayBack.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPayBack.getById;
begin
  _getByKey(Registro);
end;

function TControllerPayBack.getbyOrderToUseCredit: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) ',
                  ' and history like ''Utilização Crédito%'' '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger        :=  Parametros.PayBack.Ordem;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.GetCreditByOrder: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT SUM(credit_value) CREDITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_ORDER_ID =:TB_ORDER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;
      ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('CREDITO').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getbyCustomer: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                  ' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  :=  Parametros.Estabelecimento;
      ParamByName('TB_CUSTOMER_ID').AsInteger     :=  Parametros.PayBack.Cliente;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getCredito: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT SUM(credit_value) CREDITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('CREDITO').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getDebito: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT SUM(debit_value) DEBITO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('DEBITO').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getLasData: TDate;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT MAX(DT_RECORD) DATA ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('DATA').AsDateTime;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PAY_BACK '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPayBack.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getListByCustomer: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
          'SELECT pb.tb_customer_id, SUM(credit_value - debit_value) SALDO ',
          'FROM TB_PAY_BACK pb ',
          'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ',
          'and ( pb.dt_record between :DATAINI AND :DATAFIM ) ',
          'GROUP BY 1 '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger  := self.Parametros.Estabelecimento;
      ParamByName('DATAINI').AsDateTime           := self.Parametros.DataInicial;
      ParamByName('DATAFIM').AsDateTime           := self.Parametros.DataFinal;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin




        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getNextNumero: Integer;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT SUM(NUMBER) NUMERO ',
                  'FROM TB_PAY_BACK ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;

      Active := True;
      FetchAll;
      First;
      Result := 0;//StrToIntDef(FieldByName('NUMERO').AsString,0) + 1;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPayBack.getSaldo: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TPayBack;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT SUM(credit_value - debit_value) SALDO ',
                  'FROM TB_PAY_BACK  ',
                  'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));

      if Parametros.PayBack.Cliente > 0 then
        sql.add(' AND ( TB_CUSTOMER_ID =:TB_CUSTOMER_ID ) ');

      if Parametros.PayBack.Ordem > 0 then
        sql.add(concat(' AND (TB_ORDER_ID =:TB_ORDER_ID )'));

      if Parametros.Periodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      ParamByName('TB_INSTITUTION_ID').AsInteger := Parametros.Estabelecimento;

      if Parametros.PayBack.Cliente > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Parametros.PayBack.Cliente;

      //com este parametro preenchidp não somar ao saldo atual, pois trata-se do pedido atual
      if Parametros.PayBack.Ordem > 0 then
        ParamByName('TB_ORDER_ID').AsInteger := Parametros.PayBack.Ordem;

      if Parametros.Periodo then
      Begin
        ParamByName('DATAINI').AsDateTime := Parametros.DataInicial;
        ParamByName('DATAFIM').AsDateTime := Parametros.DataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Result := FieldByName('SALDO').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
