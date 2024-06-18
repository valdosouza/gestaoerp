unit ControllerOrderBonus;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblOrderbonus, tblEntity, FireDAC.Comp.Client,Md5,REST.json,
      FireDAC.Stan.Param, ControllerCustomer, ControllerOrder, ControllerSalesman,
      ControllerPaymentTypes,ControllerOrderTotalizer, ControllerOrderItem,
       prm_order_bonus, list_spl_value,list_spl_order_bonus, TypesCollection,
  TypesListCollection, ControllerFinancial,ObjOrderBonus, tblOrderItem,
  System.Generics.Collections,tblorder,tblCustomer,tblOrderTotalizer;

Type
  TObjListOrderBonus = TObjectList<TObjOrderBonus>;

  TControllerOrderBonus = Class(TBaseController)
    procedure clear;
  private
    function getDispositivos:String;
  public
    Registro          : TOrderBonus;
    Parametro         : TPrmOrderBonus;
    Order             : TControllerOrder;
    Customer          : TControllerCustomer;
    SalesMan          : TControllerSalesman;
    PaymentType       : TControllerPaymentTypes;
    Totalizer         : TControllerOrderTotalizer;
    items             : TControllerOrderItem;

    Financial         : TControllerFinancial;
    ListSpl            : TCollSplOrderBonus;
    Lista             : TListOrdemBonus;
    ListaObj          : TObjListOrderBonus;
    Obj               : TObjOrderBonus;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function deleteAll: boolean;
    function getByKey:Boolean;
    function getLastBySalesman:Boolean;
    function getBySalesman:Boolean;
    function getAllLevelOne:Boolean;
    Function getNexNumber:String;
    Function getLastNumber:String;
    Function getLastCodigo:Integer;
    Function getLastOrder:Boolean;
    function getNumber:Boolean;
    function getListSpl : TCollSplOrderBonus;
    function getListSplByHour : TCollSplValue;
    function getListSplByDate : TCollSplValue;
    procedure getListObj;
    procedure getList;
    procedure FillDataObjeto(PcRegistro: TOrderBonus);
    function saveDataObjeto(DObj : TObjOrderBonus):Boolean;
    procedure setParametro(par:String);
  End;

implementation

{ ControllerOrderBonus}

procedure TControllerOrderBonus.clear;
begin
  clearObj(Registro);
end;

constructor TControllerOrderBonus.Create(AOwner: TComponent);
begin
  inherited;
  Registro    := TOrderBonus.Create;
  Parametro   := TPrmOrderBonus.Create;
  PaymentType := TControllerPaymentTypes.Create(self);
  Order       := TControllerOrder.Create(self);
  Customer    := TControllerCustomer.Create(self);
  Totalizer   := TControllerOrderTotalizer.Create(self);
  SalesMan    := TControllerSalesman.Create(self);
  items       := TControllerOrderItem.Create(self);
  Financial   := TControllerFinancial.Create(self);
  ListSpl     := TCollSplOrderBonus.Create;
  Lista       := TListOrdemBonus.Create;
  ListaObj    := TObjListOrderBonus.Create;
  Obj         := TObjOrderBonus.Create;
end;

function TControllerOrderBonus.deleteAll: boolean;
begin
  Try
    items.Registro.Codigo           := Registro.Codigo;
    items.Registro.Estabelecimento  := Registro.Estabelecimento;
    items.Registro.Terminal         := Registro.Terminal;
    items.deletebyOrder;

    Totalizer.Registro.Codigo           := Registro.Codigo;
    Totalizer.Registro.Estabelecimento  := Registro.Estabelecimento;
    Totalizer.Registro.Terminal         := Registro.Terminal;
    Totalizer.delete;

    deleteObj(Registro);

    order.Registro.Codigo           := Registro.Codigo;
    order.Registro.Estabelecimento  := Registro.Estabelecimento;
    order.Registro.Terminal         := Registro.Terminal;
    order.delete;

    Result := True;
  Except
    on E : Exception do
    Begin
      geralog('ControllerOrderBonus',E.Message);
      Result := False;
    End;
  End;

end;

destructor TControllerOrderBonus.Destroy;
begin
  Obj.Destroy;
  Registro.DisposeOf;
  Parametro.Destroy;
  PaymentType.DisposeOf;
  Order.DisposeOf;
  Customer.DisposeOf;
  Totalizer.DisposeOf;
  SalesMan.DisposeOf;
  items.DisposeOf;
  Financial.DisposeOf;
  ListSpl.DisposeOf;
  Lista.DisposeOf;
  ListaObj.Destroy;
  inherited;
end;

procedure TControllerOrderBonus.FillDataObjeto(PcRegistro: TOrderBonus);
Var
  I : Integer;
  LcOrder : TOrder;
  lcitems : TOrderItem;
begin
    //Order
    Self.Order.clear;
    Self.Order.Registro.Estabelecimento := PcRegistro.Estabelecimento;
    Self.Order.Registro.Codigo          := PcRegistro.Codigo;
    Self.Order.Registro.Terminal        := PcRegistro.Terminal;
    Self.Order.getByKey;
    if Self.Order.exist then
    BEgin
      _assign(Self.Order.Registro, Obj.Order );

      //OrderBonus
      _assign( PcRegistro, Obj.OrderBonus );
       //Cliente
      Customer.Registro.Codigo          :=  Obj.OrderBonus.Cliente;
      Customer.Registro.Estabelecimento :=  PcRegistro.Estabelecimento;
      Customer.getAllByKey;
      Customer.Fiscal.fillDataObjeto(Customer.Registro.Codigo,Obj.Fiscal);
      Customer.assign(Customer.Registro,Obj.Cliente);

      //Vendedor
      Self.SalesMan.Colaborador.Fiscal.Fisica.Registro.Codigo := Obj.OrderBonus.Vendedor;
      Obj.DocFiscalVendedor := Self.SalesMan.Colaborador.Fiscal.Fisica.getCpfById;

      //Items
      Self.items.Registro := TOrderItem.Create;
      Self.items.Registro.Estabelecimento := PcRegistro.Estabelecimento;
      Self.items.Registro.Ordem           := PcRegistro.Codigo;
      Self.items.Registro.Terminal        := PcRegistro.Terminal;
      Self.items.Lista := TListItems.Create;
      Self.items.getList;
      for I := 0 to Self.items.Lista.Count - 1 do
      Begin
        lcitems := TOrderItem.Create;
        _assign(Self.items.Lista[I],lcitems );
        Obj.Items.Add(lcitems)
      end;

    End;
end;

function TControllerOrderBonus.save: boolean;
begin
  if Registro.Numero = 0 then
    Registro.Numero := getNextByField(Registro,'number',Registro.Estabelecimento);
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerOrderBonus.saveDataObjeto(DObj: TObjOrderBonus): Boolean;
VAr
  I : Integer;
  lcitems : TOrderItem;
begin
  tRY
    //Salva o cliente e reposiciona os registro de cliente e vendedor]
    self.Customer.Fiscal.saveDataObjeto(DObj.Fiscal);
    DObj.Cliente.Codigo := DObj.Fiscal.Entidade.Entidade.Codigo;
    _assign(DObj.Cliente,self.Customer.Registro);
    self.Customer.save;
    //Verifica o codigo do vendedor na web pesquisando pelo vendedor do pedido (não confundir com a função dentro do cliente)
    //O campo DocFiscalVendedor não é preenchhido no Aplicativo por que já está com o codigo correto
    if Length(DObj.DocFiscalVendedor)> 0 then
    Begin
      if Length(DObj.DocFiscalVendedor) = 11 then
        DObj.OrderBonus.Vendedor := self.SalesMan.Colaborador.Fiscal.Fisica.getIDbyCPF(DObj.DocFiscalVendedor)
      else
        DObj.OrderBonus.Vendedor := self.SalesMan.Colaborador.Fiscal.Juridica.getIDbyCNPJ(DObj.DocFiscalVendedor);
    End;
    //O usuairo do Gestão será substituido pelo Vendedor
    //O usuario do Aplicativo já vem com o codigo do vendedor correto.
    if DObj.OrderBonus.Vendedor > 0 then
      DObj.Order.Usuario := DObj.OrderBonus.Vendedor
    else
    Begin
      DObj.OrderBonus.Vendedor := DObj.Estabelecimento;
      DObj.Order.Usuario := DObj.Estabelecimento;
    End;


    if DObj.Descricao = 'SERVER' then
    Begin
      if DObj.CodigoWeb > 0 then
      BEgin
        self.Registro.Codigo           := DObj.CodigoWeb;
        self.Registro.Estabelecimento  := DObj.Estabelecimento;
        //Passou antes pelo Customer.saveDataObjeto para pegar o codigo do vendedor na web.
        self.Registro.Vendedor         := DObj.OrderBonus.Vendedor;
        self.getBySalesman;
        if exist then
        Begin
          DObj.Terminal       := self.Registro.Terminal;
          //Reposiciona os registro OrderBonus
          DObj.OrderBonus      := self.Registro;
          //Reposiciona os registro ordem
          DObj.Order.Codigo   := self.Registro.Codigo;
          DObj.Order.Terminal := self.Registro.Terminal;
          DObj.Order.Usuario  := self.Registro.Vendedor;
        End;
      End;
    End;
    {Na seção anterior reposicionamos todos os dados do objeto principal
      para seguirmos daqui em diante sem complicações
    }
    _assign( DObj.Order, self.Order.Registro);
    self.Order.save;

    _assign( DObj.OrderBonus, self.Registro);
    self.save;


    for I := 0 to DObj.Items.Count -1 do
    Begin
      _assign( DObj.Items[I], self.items.Registro );
      self.items.save;
    End;

    result := True;
  except
    on E: Exception do
    Begin
      Geralog('TControllerOrderBonus.saveDataObjeto',concat(e.Message,Registro.Numero.ToString));
      Result := False;
    End;
  end;
end;

procedure TControllerOrderBonus.setParametro(par: String);
begin
  Parametro:= TJson.JsonToObject<TPrmOrderBonus>(par);
  //Tratar Data
  Parametro.UltimaAtualizacao := dataMysql(Parametro.UltimaAtualizacao);
end;

function TControllerOrderBonus.getAllLevelOne: Boolean;
begin
  _getByKey(Registro);
  //Order
  Order.Registro.Codigo := Registro.Codigo;
  Order.Registro.Estabelecimento := Registro.Estabelecimento;
  Order.Registro.Terminal := Registro.Terminal;
  Order.getByKey;
  //Customer
  Customer.Registro.Estabelecimento := Registro.Estabelecimento;
  Customer.Registro.Codigo := Registro.Cliente;
  Customer.getAllByKey;
  //itens
  items.Registro.Estabelecimento := Registro.Estabelecimento;
  items.Registro.Ordem := Registro.Codigo;
  items.Registro.Terminal := Registro.Terminal;
  items.getList;
  //Totalizador
  Totalizer.Registro.Estabelecimento := Registro.Estabelecimento;
  Totalizer.Registro.Codigo := Registro.Codigo;
  Totalizer.Registro.Terminal := Registro.Terminal;
  Totalizer.getByKey;


end;

function TControllerOrderBonus.getByKey: Boolean;
begin
  Registro.Estabelecimento  := parametro.OrdemBonus.Estabelecimento;
  Registro.Codigo           := parametro.OrdemBonus.Codigo;
  Registro.Terminal         := parametro.OrdemBonus.Terminal;
  Registro.Vendedor         := parametro.OrdemBonus.Vendedor;
  _getByKey(Registro);
end;

function TControllerOrderBonus.getBySalesman: Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT ors.* ',
                'FROM tb_order_bonus orb ',
                'where ( orb.tb_institution_id =:institution_id ) ',
                '  and ( orb.id =:id ) ',
                '  and ( orb.tb_salesman_id =:salesman_id ) '
      ));
      ParamByName('id').AsInteger := Registro.Codigo;
      ParamByName('institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('salesman_id').AsInteger := Registro.Vendedor;
      Active := True;
      FetchAll;
      exist := recordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    Lc_Qry.Unprepare;
    finalizaQuery(Lc_Qry);
  End;
end;

function TControllerOrderBonus.getDispositivos: String;
var
  Lc_Qry : TFDQuery;
  LITem : TOrderBonus;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select id ',
                'from tb_devices ',
                'where tb_institution_id =:institution_id ',
                'and download = ''S'' '
      ));

      //Passagem de parametros
      parambyname('institution_id').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      First;
      Result := '0';
      while not eof do
      Begin
        Result := concat(Result,',',FieldByName('id').AsString);
        next;
      end;
      Result := concat('(',Result,')');
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerOrderBonus.getLastBySalesman: Boolean;
Var
  LcNumber : Integer;
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT * ',
                'FROM tb_order_bonus orb ',
                'where ( orb.tb_institution_id =:institution_id ) ',
                '  and ( orb.tb_salesman_id=:tb_salesman_id) ',
                '  and ( orb.id =:id) '
      ));
      ParamByName('institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;
      ParamByName('tb_salesman_id').AsInteger := Parametro.OrdemBonus.Vendedor;
      ParamByName('id').AsInteger             := Parametro.OrdemBonus.Codigo;
      Active := True;
      FetchAll;
      get(Lc_Qry,Registro);
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;
end;

function TControllerOrderBonus.getLastCodigo: Integer;
Var
  LcNumber : Integer;
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT MAX(orb.id) id ',
                'FROM tb_order_bonus orb ',
                'where orb.tb_institution_id =:institution_id '
      ));
      if Parametro.OrdemBonus.Vendedor > 0 then
        SQL.Add(' and (orb.tb_salesman_id=:tb_salesman_id) ');

      if Parametro.OrdemBonus.Terminal > 0 then
        SQL.Add(' and (orb.terminal =:terminal) ');


      ParamByName('institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;

      if Parametro.OrdemBonus.Vendedor > 0 then
        ParamByName('tb_salesman_id').AsInteger := Parametro.OrdemBonus.Vendedor;

      if Parametro.OrdemBonus.Terminal > 0 then
        ParamByName('terminal').AsInteger := Parametro.OrdemBonus.Terminal;

      Active := True;
      FetchAll;
      Result := FieldByName('id').AsInteger;
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;


end;

function TControllerOrderBonus.getLastNumber: String;
Var
  LcNumber : Integer;
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT MAX(orb.number) ordem ',
                'FROM tb_order_bonus orb ',
                'where orb.tb_institution_id =:institution_id '
      ));
      if registro.Vendedor > 0 then
        SQL.Add(' and (tb_salesman_id=:tb_salesman_id) ');

      ParamByName('institution_id').AsInteger := Registro.Estabelecimento;
      if registro.Vendedor > 0 then
        ParamByName('tb_salesman_id').AsInteger := Registro.Vendedor;

      Active := True;
      FetchAll;
      Result := FieldByName('ordem').AsString;
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;

end;


function TControllerOrderBonus.getLastOrder: Boolean;
begin
  Registro.Estabelecimento := parametro.OrdemBonus.Estabelecimento;
  Registro.Terminal        := parametro.OrdemBonus.Terminal;
  Registro.Vendedor        := parametro.OrdemBonus.Vendedor;
  Registro.Codigo          := getLastCodigo;
  _getByKey(Registro);
end;

procedure TControllerOrderBonus.getList;
var
  Lc_Qry : TFDQuery;
  LITem : TOrderBonus;
  LcAux : String;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT orb.* ',
                     'FROM tb_order_bonus orb ',
                     '  inner join tb_order od ',
                     '  on (od.id = orb.id) ',
                     '   and (od.tb_institution_id = orb.tb_institution_id) ',
                     '   and (od.terminal = orb.terminal) ',
                     'WHERE ( (od.status = ''N'') or (od.status = ''F'') ) ',//N Status app Delphi - F Stattus app Flutter
                     ' and ( orb.tb_institution_id =:institution_id ) '
      ));

      //Incrementa SQL
      //Verifica de quais dispositivos serão feitos os downloads

      if Parametro.OrdemBonus.Terminal > 0 then
        sql.add(' and (orb.terminal =:terminal)' );


      if Trim(Parametro.UltimaAtualizacao) <> '' then
      Begin
        sql.add(' AND ( orb.updated_at >:updated_at ) ');
        sql.add(' order by orb.updated_at asc ');
      End
      else
      Begin
        if Trim(orderby)='' then orderby := 'orb.id';
        sql.add(concat(' ORDER BY ',orderby,'  asc '));
      End;

      //Passagem de parametros
      parambyname('institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;

      if Parametro.OrdemBonus.Terminal > 0 then
        parambyname('terminal').AsInteger := Parametro.OrdemBonus.Terminal;

      if Trim(Parametro.UltimaAtualizacao) <> '' then
        parambyname('updated_at').AsString := Parametro.UltimaAtualizacao;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TOrderBonus.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerOrderBonus.getListObj;
Var
  I : Integer;
  LcReg : TOrderBonus;
begin
  ListaObj.Clear;
  getList;
  for I := 0 to (Lista.Count - 1)do
  Begin
    LcReg := TOrderBonus.Create;
    LcReg := Lista[I];
    try
      FillDataObjeto(LcReg);
    Except on E: Exception do
      geralog(concat('Order Bonus - getListObj - Sequencia ',I.ToString,' | '), E.Message);
    end;
    ListaObj.Add( Obj );
  End;

end;

function TControllerOrderBonus.getListSpl: TCollSplOrderBonus;
Var
  Lc_Qry :TFDQuery;
  Lista : TListSplOrderBonus;
begin
  Try
    result := TCollSplOrderBonus.Create;
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'SELECT distinct orb.id, orb.number, ord.dt_record, ',
              'et.name_company, et.nick_trade, ort.total_value ',
              'FROM tb_order ord ',
              '  inner join tb_order_bonus orb ',
              '  on (orb.id = ord.id) and  (orb.tb_institution_id = ord.tb_institution_id) ',
              '  INNER JOIN tb_entity et ',
              '  on (orb.tb_customer_id = et.id) ',
              '  inner join tb_order_totalizer ort ',
              '  on (ort.id = ord.id) and  (ort.tb_institution_id = ord.tb_institution_id) ',
              'where ord.tb_institution_id =:institution_id ',
              ' and (ord.dt_record between :dataini and :datafim)',
              ' and ( orb.kind =:kind ) '
          ));


      if Parametro.Cliente.NomeRazao <> '' then
        sql.Add(' and ( et.name_company like :name) ');

      //paginação
      //Limite 0,20  - pagina 1 do 00 ao 20
      //Limite 20,40 - pagina 2 do 20 ao 40
      //Limite 40,60 - pagina 3 do 40 ao 60
      //Limite 60,80 - pagina 4 do 60 ao 80
      sql.Add(concat('Limit ', InttoStr( (Parametro.Pagina * 20 ) - 20 ),',', InttoStr( (Parametro.Pagina * 20 ) ) ));
      //passagem de PArametros
      ParamByName('institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;

      ParamByName('dataini').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataInicial,Now)),1,10);
      ParamByName('datafim').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataFinal,Now)),1,10);

      if Parametro.Cliente.NomeRazao <> '' then
        ParamByName('name').AsString := concat('%',Parametro.Cliente.NomeRazao,'%');

      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        Lista := TListSplOrderBonus.Create;
        Lista.Codigo      := FieldByName('id').AsInteger;
        Lista.Pedido      := FieldByName('number').AsString;
        Lista.Data        := FieldByName('dt_record').AsDateTime;
        Lista.NomeCliente := FieldByName('name_company').AsString;
        Lista.ValorPedido := FieldByName('total_value').AsFloat;
        //add lista
        Result.Add(Lista);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerOrderBonus.getListSplByDate: TCollSplValue;
Var
  Lc_Qry :TFDQuery;
  Lista : TListSplValue;
begin
  Try
    result := TCollSplValue.Create;
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
              'SELECT  SUBSTR( ord.created_at,1,10) dt_venda , sum(inv.VALUE) total_value ',
              'FROM tb_order ord ',
              '  INNER JOIN tb_order_bonus orb ',
              '  on (orb.id = ord.id) ',
              '    and (orb.tb_institution_id = ord.tb_institution_id) ',
              '  INNER JOIN tb_invoice inv ',
              '  on (orb.id = inv.id) ',
              '    and (orb.tb_institution_id = inv.tb_institution_id) ',
              '  INNER JOIN tb_entity ent ',
              '  ON (ent.id = inv.tb_entity_id) ',
              'where ord.tb_institution_id=:tb_institution_id ',
              ' and (dt_emission between :dataini and :datafim) ',
              'group by 1 '
          ));


      //passagem de PArametros
      ParamByName('tb_institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;

      ParamByName('dataini').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataInicial,Now)),1,10);
      ParamByName('datafim').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataFinal,Now)),1,10);

      if Parametro.Cliente.NomeRazao <> '' then
        ParamByName('name').AsString := concat('%',Parametro.Cliente.NomeRazao,'%');

      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        Lista := TListSplValue.Create;
        Lista.Estabelecimento := Parametro.OrdemBonus.Estabelecimento;
        Lista.Terminal        := Parametro.OrdemBonus.Terminal;
        Lista.Descricao       := concat(FieldByName('dt_venda').AsString);
        Lista.Valor           := FieldByName('total_value').AsFloat;
        //add lista
        Result.Add(Lista);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerOrderBonus.getListSplByHour: TCollSplValue;
Var
  Lc_Qry :TFDQuery;
  Lista : TListSplValue;
begin
  Try
    result := TCollSplValue.Create;
    Lc_Qry := createQuery;
    with Lc_Qry,Parametro do
    Begin
      sql.Clear;
      sql.Add(concat(
              'SELECT  SUBSTR( ord.created_at,12, 2) hr_venda , sum(inv.VALUE) total_value ',
              'FROM tb_order ord ',
              '  INNER JOIN tb_order_bonus orb ',
              '  on (orb.id = ord.id) ',
              '    and (orb.tb_institution_id = ord.tb_institution_id) ',
              '  INNER JOIN tb_invoice inv ',
              '  on (orb.id = inv.id) ',
              '    and (orb.tb_institution_id = inv.tb_institution_id) ',
              '  INNER JOIN tb_entity ent ',
              '  ON (ent.id = inv.tb_entity_id) ',
              'where ord.tb_institution_id=:tb_institution_id ',
              ' and (dt_emission between :dataini and :datafim) ',
              'group by 1 '
          ));


      //passagem de PArametros
      ParamByName('tb_institution_id').AsInteger := Parametro.OrdemBonus.Estabelecimento;

      ParamByName('dataini').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataInicial,Now)),1,10);
      ParamByName('datafim').AsString := Copy( ConverteDataMysql( StrToDateDef(Parametro.DataFinal,Now)),1,10);

      if Cliente.NomeRazao <> '' then
        ParamByName('name').AsString := concat('%',Cliente.NomeRazao,'%');

      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        Lista := TListSplValue.Create;
        Lista.Estabelecimento := Parametro.OrdemBonus.Estabelecimento;
        Lista.Terminal        := Parametro.OrdemBonus.Terminal;
        Lista.Descricao       := concat(FieldByName('hr_venda').AsString,':00 Horas');
        Lista.Valor           := FieldByName('total_value').AsFloat;
        //add lista
        Result.Add(Lista);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerOrderBonus.getNexNumber: String;
Var
  LcNumber : Integer;
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT MAX(orb.number) ordem ',
                'FROM tb_order_bonus orb ',
                'where orb.tb_institution_id =:institution_id '
      ));
      ParamByName('institution_id').AsInteger := Registro.Estabelecimento;
      Active := True;
      LcNumber := StrToIntDef(FieldByName('ordem').AsString,0) + 1;
      Result := IntToStr(LcNumber);
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;
end;

function TControllerOrderBonus.getNumber: Boolean;
Var
  Lc_Qry : TFDQuery;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'Select id, number ',
              'from tb_order_bonus orb ',
              'where ( orb.tb_institution_id =:tb_institution_id ) ',
              ' and (orb.number =:number) '
              ));
      ParamByName('tb_institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('number').AsInteger := Registro.Numero;
      Prepare;
      Active := True;
      FetchAll;
      if (RecordCount > 0 ) then
      Begin
        registro.Codigo := FieldByName('id').AsInteger;
        Result := True;
      End
      else
      Begin
        Result := False;
      End;
    End;
  Finally
    finalizaQuery(Lc_Qry);
  End;
end;

end.
