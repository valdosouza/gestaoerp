unit ControllerPedido;

interface
uses ACBrUtil,STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblPedido ,Un_MSg,ControllerPedidoCtrlMmb,Datasnap.DBClient,
      ControllerEmpresa,ControllerEndereco, ControllerCliente,ControllerGestaoWeb,
      ControllerItensNFL, Generics.Collections, ControllerParcelamento,
      ControllerColaborador, System.Math,objOrderSale,tblOrderItem,ObjCustomer,
      ControllerFormaPagamento,ControllerCtrlEstoque, AnsiStrings,ControllerRestaurante,
      FireDAC.Stan.Param;

Type
  TListaPedido = TObjectList<TPedido>;
  TControllerPedido = Class(TControllerBase)

  private
  protected

  public
    Registro : TPedido;
    Lista: TListaPedido;
    UsuarioIntegracao : Integer;
    Empresa : TControllerEmpresa;
    Endereco : TControllerEndereco;
    Cliente : TcontrollerCliente;
    Controle : TControllerPedidoCtrlMmb;
    Itens : TControllerItensNFL;
    Parcelamento : TControllerParcelamento;
    FormaPagto :TControllerFormaPagamento;
    Vendedor : TControllerColaborador;
    LcGesWeb : TControllerGestaoWeb;
    CtrlEstoque : TControllerCtrlEstoque;
    Restaurante : TControllerRestaurante;
    Numerado : Boolean;

    ExportGestaoWeb : TControllerGestaoWeb;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function atualiza:boolean;
    function migra:Boolean;
    procedure getIdByNumero();
    procedure getByCodigoWeb();
    function getByEmpresa:Boolean;
    procedure getbyId;
    procedure getUsuario;
    function getIdEmpresa:Integer;
    procedure getSincronia;
    procedure getList;
    function insere:boolean;

    procedure nextNumber(Metodo:String);
    function nextCodigo:Integer;
    procedure GravaCredito;
    Function VerificaFaturado(msg:Boolean):boolean;
    Function InconsistenciaFaturado(msg:Boolean):boolean;
    Function InconsistenciaORcamento:boolean;

    function using(Operation: string): Boolean;
    Function delete:boolean;
    procedure enviaLixeira;
    function Faturado:boolean;
    function getIdNota:Integer;
    function WebFaturado: boolean;
    procedure getIdByCodigoWeb;
    procedure DeletaItens;
    Function salvaPedidoInternet:Boolean;
    function UpdateObjInternet:boolean;
    Function CriaPedidoOrcamento:Boolean;
    procedure setSequencia;
    Function getAll:Boolean;
    function valortotalitens:Real;
    function valorFinanceiro:Real;
    procedure Clear;
    function AtualizaPedidoConsumidor:Boolean;
    procedure AplicarValorDescontoItens(PedidoID: Integer; ValorDesconto: real);
    procedure alteraStatus;
    procedure deleteByCodigoWeb(Id:Integer);
    function ValidaParcelamento(ValorCredito:Real):Boolean;
    function LiberaEmUso:boolean;
    function  CorrigirSequenciaItens:Boolean;
  End;

implementation

{ ControllerPedido }

uses Un_Regra_Negocio;


procedure TControllerPedido.alteraStatus;
Var
  Lc_Qry: TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'UPDATE TB_PEDIDO SET ',
              'PED_FATURADO=:PED_FATURADO '
      ));
      if (Registro.Faturado = 'C') then
        SQL.Add(',PED_NUMERO = NULL ');
      SQL.Add('WHERE (PED_CODIGO =:PED_CODIGO)');

      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('PED_FATURADO').AsAnsiString := Registro.Faturado;
      ExecSQL;
    end;
  finally
    FinalizaQuery( Lc_Qry );
  end;

end;

procedure TControllerPedido.AplicarValorDescontoItens(PedidoID: Integer;
  ValorDesconto: real);
var
   Lc_Qry: TSTQuery;
   Lc_Upt: TSTQuery;
   Lc_SqlTxt: string;
   Lc_VL_Pedido : Real;
   Lc_Vl_Subtotal : Real;
   Lc_Aq_Proporcao : Real;
   Lc_Aq_Desconto : real;
   Lc_VL_Desconto : Real;
   Lc_VL_TL_Desconto : Real;
   Lc_Cd_Item : Integer;
   Lc_Cd_Item_Ant : Integer;
   Lc_VL_Desconto_Ant : Real;
   LcBreak : Boolean;
begin
  if (ValorDesconto > 0) then
  Begin
    //Zerando as variaveis
    Lc_VL_Pedido := 0;
    Lc_Vl_Subtotal :=0;
    Lc_Aq_Proporcao :=0;
    Lc_VL_Desconto :=0;
    Lc_VL_TL_Desconto :=0;
    Lc_VL_Desconto_Ant := 0;
    Lc_Cd_Item_Ant := 0;
    LcBreak := FAlse;
    //Cria a Qry de Atualização
    Lc_Upt := GEraQuery;
    //Cria a Consulta
    Lc_Qry := geraQuery;
    Try
      WITH Lc_Qry do
      Begin
        SQL.Clear;
        //O desconto vai atingir somente os produtos e não os serviços devidoa questões fiscais na NFS-e
        //Seleção do valor unitario acima de 0,05 centavos pois no rateio o valor do desconto poderá ser maior do que o valor unitario
        Lc_SqlTxt := 'SELECT ITF_CODIGO, ITF_VL_UNIT, ITF_QTDE ' +
                      'FROM TB_ITENS_NFL ' +
                      '  INNER JOIN TB_PRODUTO '+
                      '  ON (PRO_CODIGO = ITF_CODPRO) '+
                      'WHERE (ITF_CODPED=:ITF_CODPED) '+
                      ' AND ( PRO_TIPO <> ''S'' )'+
                      ' AND (ITF_VL_UNIT > 0.05) '+

                      'ORDER BY PRO_DESCRICAO ';
        sql.Add(Lc_SqlTxt);
        ParamByName('ITF_CODPED').AsInteger := PedidoID;
        Active := True;
        FetchAll;
        //Calcula o valor total da Cotação
        First;
        while not eof do
        Begin
          Lc_VL_Pedido := Lc_VL_Pedido + (FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat);
          next;
        end;
        Lc_VL_Pedido:= RoundABNT(Lc_VL_Pedido,-2);

        Lc_Upt.SQL.Clear;
        Lc_SqlTxt := 'UPDATE TB_ITENS_NFL SET ' +
                     'ITF_AQ_DESC=:ITF_AQ_DESC, ' +
                     'ITF_VL_DESC=:ITF_VL_DESC ' +
                     'WHERE (ITF_CODIGO=:ITF_CODIGO) ';
        Lc_Upt.SQL.Add(Lc_SqlTxt);
        First;
        while not Eof do
        begin
          //Calculo pega o valor do subtotal do item
          Lc_Vl_Subtotal := (FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat);
          //Guarda o codigo do item a ser atualizado
          Lc_Cd_Item := FieldByName('ITF_CODIGO').AsInteger;
          //Faz o calculo da aliquota
          Lc_Aq_Proporcao := (Lc_Vl_Subtotal / Lc_VL_Pedido);
          Lc_Aq_Proporcao := RoundTo( Lc_Aq_Proporcao,-4);
          Lc_Vl_Desconto := ValorDesconto * Lc_Aq_Proporcao;
          Lc_Vl_Desconto := RoundTo( Lc_Vl_Desconto,-2);
          Lc_Aq_Desconto := (Lc_Vl_Desconto/Lc_Vl_Subtotal)*100;
          Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
          Lc_VL_TL_Desconto := Lc_VL_TL_Desconto + Lc_Vl_Desconto;
          //Avança para o proximo registro
          Next;
          //Verifica se e o ultimo registro para fazer compensação de arredondamento
          if eof or ((Lc_VL_TL_Desconto >=ValorDesconto ) and (ValorDesconto >0) ) then
          Begin
            LcBreak := True;
            if ( ValorDesconto > Lc_VL_TL_Desconto) then
              Lc_VL_Desconto := Lc_VL_Desconto + ( ValorDesconto - Lc_VL_TL_Desconto)
            else
            Begin
              Lc_VL_Desconto := Lc_VL_Desconto - (Lc_VL_TL_Desconto - ValorDesconto );
              if (Lc_VL_Desconto < 0) then
              Begin
                Lc_Cd_Item := Lc_Cd_Item_Ant;
                Lc_VL_Desconto := Lc_VL_Desconto + Lc_VL_Desconto_Ant;
              end;
            end;
          end;
          //Efetua a atualização
          Lc_Cd_Item_Ant := Lc_Cd_Item;
          Lc_VL_Desconto_Ant := Lc_VL_Desconto;
          Lc_Upt.Active := False;
          Lc_Upt.ParamByName('ITF_CODIGO').AsInteger := Lc_Cd_Item;
          Lc_Upt.ParamByName('ITF_AQ_DESC').AsFloat := Lc_Aq_Desconto;
          Lc_Upt.ParamByName('ITF_VL_DESC').AsFloat := Lc_Vl_Desconto;
          Lc_Upt.ExecSQL;
          if LcBreak  then Break;
        end;
      end;
    Finally
      FinalizaQuery( Lc_Upt );
      FinalizaQuery( Lc_Qry );
    End;
  End
  else
  Begin
    //Cria a Qry de Atualização
    Lc_Upt := GEraQuery;
    Try
      Lc_Upt.SQL.Clear;
      Lc_Upt.SQL.Add(concat(
                   'UPDATE TB_ITENS_NFL SET ',
                   'ITF_AQ_DESC=0, ',
                   'ITF_VL_DESC=0 ' ,
                   'WHERE (ITF_CODPED=:ITF_CODPED) '
      ));
      Lc_Upt.ParamByName('ITF_CODPED').AsInteger := PedidoID;
      Lc_Upt.ExecSQL;
    Finally
      FinalizaQuery( Lc_Upt );
    End;
  End;
end;

function TControllerPedido.atualiza: boolean;
begin
  try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := FAlse;
  end;
end;

function TControllerPedido.AtualizaPedidoConsumidor: Boolean;
Var
  Lc_Qry: TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_PEDIDO SET ',
                'PED_CODEMP =:EMP_CODIGO, ',
                'PED_CODEND = :END_CODIGO ',
                'WHERE PED_CODIGO=:PED_CODIGO '
      ));
      ParamByName('EMP_CODIGO').AsInteger := REgistro.Empresa;
      ParamByName('END_CODIGO').AsInteger := REgistro.Endereco;
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  finally
    FinalizaQuery( Lc_Qry );
  end;
end;


procedure TControllerPedido.Clear;
begin
  clearObj(registro);
  Lista.Clear;
  Empresa.clear;
  Endereco.clear;
  Cliente.clear;
  Itens.clear;
  Parcelamento.Clear;
end;


function TControllerPedido.CorrigirSequenciaItens:boolean;
Var
  Lc_Qry : TSTQuery;
  Lc_Upd : TSTQuery;
  Lc_Seq : Integer;
  Lc_setAll : Boolean;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Lc_Upd := GeraQuery;
  Try
    with Lc_Upd do
    Begin
      SQL.Add(concat(
                'UPDATE TB_ITENS_NFL SET ',
                ' ITF_SEQUENCIA =:ITF_SEQUENCIA ',
                ' WHERE (ITF_CODIGO=:ITF_CODIGO) '
      ));
    End;

    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT ITF_CODIGO, ITF_SEQUENCIA ',
                ' FROM tb_pedido ',
                ' INNER JOIN TB_ITENS_NFL ',
                ' ON (ITF_CODPED = PED_CODIGO) ',
                ' WHERE (PED_CODIGO=:PED_CODIGO) ',
                'order by ITF_SEQUENCIA, ITF_CODIGO '
      ));
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;

      Active := true;
      First;
      Lc_Seq := 0;
      Lc_setAll := False;
      while not eof do
      Begin
        inc(Lc_Seq);
        if not Lc_setAll then
        Begin
          Lc_setAll := (Lc_Seq <> FieldByName('ITF_SEQUENCIA').AsInteger);
        End;
        if Lc_setAll then
        Begin
          Lc_Upd.Active := False;
          Lc_Upd.ParamByName('ITF_CODIGO').AsInteger := FieldByName('ITF_CODIGO').AsInteger;
          Lc_Upd.ParamByName('ITF_SEQUENCIA').AsInteger := Lc_Seq;
          Lc_Upd.ExecSQL;
        End;
        Next;
      end;
    End;
  Finally
    Result := Lc_setAll;
    FinalizaQuery(Lc_Qry);
    FinalizaQuery(Lc_Upd);
  End;

end;

constructor TControllerPedido.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TPedido.Create;
  Lista     := TListaPedido.Create;
  Empresa   := TControllerEmpresa.create(Self);
  Endereco  := TControllerEndereco.create(Self);
  Controle  := TControllerPedidoCtrlMmb.create(Self);
  Itens     := TControllerItensNFL.create(Self);
  Parcelamento := TControllerParcelamento.create(Self);
  Vendedor := TControllerColaborador.create(Self);
  LcGesWeb  := TControllerGestaoWeb.create(Self);
  FormaPagto := TControllerFormaPagamento.create(Self);
  CtrlEstoque := TControllerCtrlEstoque.create(Self);
  ExportGestaoWeb := TControllerGestaoWeb.create(Self);
  Cliente := TcontrollerCliente.create(Self);
  Restaurante := TControllerRestaurante.create(Self);
end;

function TControllerPedido.CriaPedidoOrcamento: Boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerPedido.getIdByCodigoWeb;
Var
  Lc_Qry : TSTQuery;
Begin
  if Registro.CodigoWeb > 0 then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(concaT(
                  'SELECT DISTINCT PED_CODIGO ',
                  ' FROM tb_pedido ',
                  ' WHERE (PED_CODWEB =:PED_CODWEB) ',
                  ' AND (PED_TIPO =:PED_TIPO) '
        ));
        if ( Registro.Vendedor > 0) then
          SQL.Add(' AND (PED_CODVDO =:PED_CODVDO) ');

        ParamByName('PED_CODWEB').AsInteger := Registro.CodigoWeb;
        ParamByName('PED_TIPO').AsInteger := Registro.Tipo;

        if ( Registro.Vendedor > 0) then
          ParamByName('PED_CODVDO').AsInteger := Registro.Vendedor;

        Active := true;
        First;
        if RecordCount > 0 then
          Registro.Codigo := FieldByName('PED_CODIGO').AsInteger
        else
          Registro.Codigo := 0;
      End;
    Finally
      FinalizaQuery(Lc_Qry)
    End;
  End;
End;

procedure TControllerPedido.DeletaItens;
Var
  Lc_Qry : TSTQuery;
Begin
  if Registro.CodigoWeb > 0 then
    getIdByCodigoWeb;
  if Registro.Codigo > 0 then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        sql.Clear;
        sql.Add('DELETE FROM TB_ITENS_NFL WHERE PED_CODIGO=:PED_CODIGO');
        ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
        ExecSQL;
      End;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  end;
end;

function TControllerPedido.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPedido.deleteByCodigoWeb(Id: Integer);
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      //Restaurante
      SQL.Clear;
      SQL.Add(concat(
             'DELETE FROM tb_itens_nfl ',
             ' WHERE ITF_CODPED IN ( ',
             ' SELECT PED_CODIGO ',
             ' FROM TB_PEDIDO ',
             ' WHERE PED_CODWEB =:PED_CODWEB)'
              ));
      ParamByName('PED_CODWEB').AsInteger := id;
      ExecSQL;

    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

destructor TControllerPedido.Destroy;
begin
  Cliente.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  Empresa.DisposeOf;
  Endereco.DisposeOf;
  Controle.DisposeOf;
  Itens.DisposeOf;
  Parcelamento.DisposeOf;
  Vendedor.DisposeOf;
  LcGesWeb.DisposeOf;
  FormaPagto.DisposeOf;
  CtrlEstoque.DisposeOf;
  ExportGestaoWeb.DisposeOf;
  Restaurante.DisposeOf;
  inherited;
end;

procedure TControllerPedido.enviaLixeira;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('UPDATE TB_PEDIDO '+
              'SET PED_FATURADO=:PED_FATURADO '+
              'WHERE (PED_CODIGO =:PED_CODIGO)');
      ParamByName('PED_FATURADO').AsAnsiString := 'A';
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPedido.Faturado: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := False;
  if ( Registro.Codigo > 0 ) then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        SQL.Add(' select PED_CODIGO '+
                ' from TB_PEDIDO '+
                'where  PED_CODIGO =:PED_CODIGO AND (PED_FATURADO = ''S'') ');
        ParamByName('PED_CODIGO').asinteger:= Registro.Codigo;
        Active:=True;
        FetchAll;
        if (Lc_Qry.RecordCount >0) then
        Begin
          MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                         'Este pedido já foi Faturado.' + EOLN +
                         '    Operação cancelada.'+EOLN,
                         ['OK'], [bEscape], mpInformacao);
          Result := True;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;


function TControllerPedido.WebFaturado: boolean;
Var
  Lc_Qry : TSTQuery;
  Lc_Numero : Integer;
Begin
  //Faturado ou Excluido não serão alterados no sistema
  Result := False;
  if ( Registro.CodigoWeb > 0 ) then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        SQL.Add(concat(
                  'select PED_NUMERO '+
                  'from TB_PEDIDO '+
                  'where ( PED_CODWEB =:PED_CODWEB ) '+
                  '  and ( PED_TERMINAL =:PED_TERMINAL ) '+
                  '  AND ( ( PED_FATURADO = ''S'' ) or ( PED_FATURADO = ''A'' ) OR ( PED_APROVADO = ''S'' ) ) '
        ));
        if ( Registro.Vendedor > 0 ) then
          SQL.Add('  AND ( PED_CODVDO =:PED_CODVDO ) ');


        ParamByName('PED_CODWEB').asinteger:= Registro.CodigoWeb;
        ParamByName('PED_TERMINAL').asinteger:= Registro.Terminal;

        if ( Registro.Vendedor > 0 ) then
          ParamByName('PED_CODVDO').asinteger:= Registro.Vendedor;


        Active:=True;
        FetchAll;
        Lc_Numero := StrToIntDef(FieldByName('PED_NUMERO').AsString,0);
        Numerado := (Lc_Numero > 0);
        result := (Lc_Qry.RecordCount >0);
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

function TControllerPedido.insere: boolean;
begin
  try
    Registro.Codigo := nextCodigo;
    InsertObj(Registro);
  except
    Registro.Codigo := 0;
  end;
end;


function TControllerPedido.LiberaEmUso: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE tb_pedido SET PED_emuso = null where ped_codigo =:ped_codigo');
      ParamByName('PED_CODIGO').AsInteger := Registro.codigo;
      Active := True;
      FetchAll;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerPedido.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerPedido.salva: boolean;
begin
  if Registro.Codigo = 0 then
  Begin
    Registro.Codigo := nextCodigo;
    InsertObj(Registro);
  End
  else
  Begin
    UpdateObj(Registro);
  End;
end;

function TControllerPedido.salvaPedidoInternet: Boolean;
begin
  getIdByCodigoWeb;
  if Registro.Codigo = 0 then
  Begin
    Registro.Codigo := nextCodigo;
    InsertObj(Registro);
  End
  else
  Begin
    UpdateObjInternet;
  End;


end;


procedure TControllerPedido.setSequencia;
begin
  Registro.Codigo := getNextByField(Registro,'PED_CODIGO',0) ;
  setGenerator('GN_PEDIDO',Registro.Codigo.ToString);
end;

function TControllerPedido.UpdateObjInternet(): boolean;
Var
  LcQry : TSTQuery;
begin
  Result := True;
  LcQry := GeraQuery;
  try
    with LcQry do
    Begin
      sql.Clear;
      sql.Add(concat(
            'UPDATE TB_PEDIDO SET ',
            '    PED_NUMERO =:PED_NUMERO, ',
            '    PED_TIPO =:PED_TIPO, ',
            '    PED_CODUSU =:PED_CODUSU, ',
            '    PED_DATA = :PED_DATA, ',
            '    PED_CODEMP =:PED_CODEMP, ',
            '    PED_CODVDO =:PED_CODVDO, ',
            '    PED_CODFPG =:PED_CODFPG, ',
            '    PED_PRAZO =:PED_PRAZO, ',
            '    PED_CODEND =:PED_CODEND, ',
            '    PED_QT_PRODUTO =:PED_QT_PRODUTO, ',
            '    PED_VL_PRODUTO =:PED_VL_PRODUTO, ',
            '    PED_VL_IPI =:PED_VL_IPI, ',
            '    PED_VL_FRETE =:PED_VL_FRETE, ',
            '    PED_ALIQ_DESCONTO =:PED_ALIQ_DESCONTO, ',
            '    PED_VL_DESCONTO =:PED_VL_DESCONTO, ',
            '    PED_VL_PEDIDO =:PED_VL_PEDIDO, ',
            '    PED_FATURADO =:PED_FATURADO, ',
            '    PED_TP_CONTATO =:PED_TP_CONTATO, ',
            '    PED_DT_ENTREGA =:PED_DT_ENTREGA, ',
            '    PED_NUM_ANT =:PED_NUM_ANT, ',
            '    PED_VL_SERVICO =:PED_VL_SERVICO, ',
            '    PED_CODTRP =:PED_CODTRP, ',
            '    PED_CTA_FRETE =:PED_CTA_FRETE, ',
            '    PED_EMUSO =:PED_EMUSO, ',
            '    PED_CODNAT =:PED_CODNAT, ',
            '    PED_CODENT =:PED_CODENT, ',
            '    PED_CODFAT =:PED_CODFAT, ',
            '    PED_CODCOB =:PED_CODCOB, ',
            '    PED_CODMHA =:PED_CODMHA, ',
            '    PED_APROVADO =:PED_APROVADO, ',
            '    PED_VL_ODESPESA =:PED_VL_ODESPESA, ',
            '    PED_NUM_ORCA =:PED_NUM_ORCA, ',
            '    PED_VALIDADE =:PED_VALIDADE, ',
            '    PED_CODWEB =:PED_CODWEB, ',
            '    PED_VL_CREDITO =:PED_VL_CREDITO, ',
            '    PED_CODNEG =:PED_CODNEG, ',
            '    PED_ENTREGA =:PED_ENTREGA , ',
            '    PED_GARANTIA =:PED_GARANTIA, ',
            '    PED_TP_CUSTOMER =:PED_TP_CUSTOMER, ',
            '    PED_INDPRES =:PED_INDPRES, ',
            '    PED_VL_ST =:PED_VL_ST, ',
            '    PED_NUMWEB =:PED_NUMWEB, ',
            '    PED_HORA =:PED_HORA ',
            'WHERE (PED_CODIGO =:PED_CODIGO) AND ',
            '      (PED_TERMINAL =:PED_TERMINAL) '
      ));

      ParamByName('PED_CODIGO').asInteger := Registro.Codigo;
      ParamByName('PED_NUMERO').asInteger := Registro.Numero;
      ParamByName('PED_TIPO').asInteger := Registro.Tipo;
      ParamByName('PED_CODUSU').asInteger := Registro.Usuario;
      ParamByName('PED_DATA').asDateTime := Registro.Data;
      ParamByName('PED_CODEMP').asInteger := Registro.Empresa;
      ParamByName('PED_CODVDO').asInteger := Registro.Vendedor;
      ParamByName('PED_CODFPG').asInteger := Registro.FormaPagto;
      ParamByName('PED_PRAZO').asString := Registro.Prazo;
      ParamByName('PED_CODEND').asInteger := Registro.Endereco;
      ParamByName('PED_QT_PRODUTO').asFloat := Registro.QtdeProdutos;
      ParamByName('PED_VL_PRODUTO').asFloat := Registro.ValorProdutos;
      ParamByName('PED_VL_IPI').asFloat := Registro.ValorIPI;
      ParamByName('PED_VL_FRETE').asFloat := Registro.ValorFrete;
      ParamByName('PED_ALIQ_DESCONTO').asFloat := Registro.AliqDesconto;
      ParamByName('PED_VL_DESCONTO').asFloat := Registro.ValorDesconto;
      ParamByName('PED_VL_PEDIDO').asFloat := Registro.ValorPedido;
      ParamByName('PED_FATURADO').asString := Registro.Faturado;
      ParamByName('PED_TP_CONTATO').asString := Registro.TipoContato;
      ParamByName('PED_DT_ENTREGA').asDateTime := Registro.DataEntrega;
      ParamByName('PED_NUM_ANT').asInteger := Registro.PedidoAnterior;
      ParamByName('PED_VL_SERVICO').asfloat := Registro.valorServico;
      ParamByName('PED_CODTRP').asInteger := Registro.Transportadora;
      ParamByName('PED_CTA_FRETE').asInteger := Registro.FretePorConta;
      ParamByName('PED_EMUSO').asString := Registro.emUso;
      ParamByName('PED_CODNAT').asInteger := Registro.CodigoNatureza;
      ParamByName('PED_CODENT').asInteger := Registro.EnderecoEntrega;
      ParamByName('PED_CODFAT').asInteger := Registro.EnderecoFaturamento;
      ParamByName('PED_CODCOB').asInteger := Registro.EnderecoCobranca;
      ParamByName('PED_CODMHA').asInteger := Registro.CodigoEstabelecimento;
      ParamByName('PED_APROVADO').asString := Registro.Aprovado;
      ParamByName('PED_VL_ODESPESA').asFloat := Registro.ValorOutrasDEspesas;
      ParamByName('PED_NUM_ORCA').asInteger := Registro.NumeroOrcamento;
      ParamByName('PED_VALIDADE').asDateTime := Registro.Validade;
      ParamByName('PED_CODWEB').asInteger := Registro.CodigoWeb;
      ParamByName('PED_NUMWEB').asInteger := Registro.NumeroWeb;
      ParamByName('PED_VL_CREDITO').asFloat := Registro.ValorCredito;
      ParamByName('PED_CODNEG').asInteger := Registro.CodigoNegocio;
      ParamByName('PED_ENTREGA').asString := Registro.Entrega;
      ParamByName('PED_GARANTIA').asString := Registro.Garantia;
      ParamByName('PED_TP_CUSTOMER').asString := Registro.OrigemCliente;
      ParamByName('PED_INDPRES').asInteger := Registro.IndicaPresenca;
      ParamByName('PED_VL_ST').asFloat := Registro.ValorSubstTributaria;
      ParamByName('PED_TERMINAL').asInteger := Registro.Terminal;
      ParamByName('PED_HORA').AsTime := Registro.Hora;
      ExecSQL;
    End;
  finally
    FinalizaQuery(LcQry);
  end;
end;

function TControllerPedido.getAll: Boolean;
begin
  _getByKey(Registro);
  Empresa.Registro.Codigo := Self.Registro.Empresa;
  Empresa.getAllBykey;

  Cliente.Registro.Codigo := Self.Registro.Empresa;
  Cliente.getById;

  Endereco.Registro.Codigo        := Self.Registro.Endereco;
  Endereco.Registro.CodigoEmpresa := Self.Registro.Empresa;
  Endereco.getAll;
end;

procedure TControllerPedido.getIdByNumero();
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      Sql.add(Concat(
                'Select * FROM TB_PEDIDO ',
                'WHERE (PED_TIPO =:PED_TIPO ) ',
                ' AND (PED_NUMERO =:PED_NUMERO) ',
                ' and (PED_CODMHA=:PED_CODMHA) '
        ));
      ParamByName('PED_TIPO').AsInteger := Registro.Tipo;
      ParamByName('PED_NUMERO').AsInteger := Registro.Numero;
      ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TControllerPedido.getIdNota: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(' select NFL_CODIGO '+
              ' from TB_NOTA_FISCAL '+
              'where  NFL_CODPED =:PED_CODIGO ');
      ParamByName('PED_CODIGO').asinteger:= Registro.Codigo;
      Active:=True;
      FetchAll;
      Result := FieldByName('NFL_CODIGO').asInteger;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TPedido;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_pedido ',
                      'WHERE PED_CODIGO IS NOT NULL '
              ));
      if Registro.CodigoEstabelecimento > 0 then
        sql.add(' and ( PED_CODMHA=:PED_CODMHA )  ');

      if Registro.Tipo > 0 then
        sql.add(' and ( PED_TIPO=:PED_TIPO )  ');

      if Registro.Faturado = 'S' then
        sql.add(' and ( PED_FATURADO=:PED_FATURADO )  ');

      if Registro.CodigoEstabelecimento > 0 then
        ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;

      if Registro.Tipo > 0 then
        ParamByName('PED_TIPO').AsInteger := Registro.Tipo;

      if Registro.Faturado = 'S' then
        ParamByName('PED_FATURADO').AsString := Registro.Faturado;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPedido.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.getSincronia;
var
  Lc_Qry : TSTQuery;
  LITem : TPedido;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select  ',
                '    N.nfl_codigo PED_CODIGO, ',
                '    PED_NUMERO, ',
                '    PED_TIPO, ',
                '    PED_CODUSU, ',
                '    PED_DATA, ',
                '    PED_CODEMP, ',
                '    PED_CODVDO, ',
                '    PED_CODFPG, ',
                '    PED_PRAZO, ',
                '    PED_CODEND, ',
                '    PED_QT_PRODUTO, ',
                '    PED_VL_PRODUTO, ',
                '    PED_VL_IPI, ',
                '    PED_VL_FRETE, ',
                '    PED_ALIQ_DESCONTO, ',
                '    PED_VL_DESCONTO, ',
                '    PED_VL_PEDIDO, ',
                '    PED_FATURADO, ',
                '    PED_TP_CONTATO, ',
                '    PED_DT_ENTREGA, ',
                '    PED_NUM_ANT, ',
                '    PED_DT_ALTERA, ',
                '    PED_VL_SERVICO, ',
                '    PED_CODTRP, ',
                '    PED_CTA_FRETE, ',
                '    PED_EMUSO, ',
                '    PED_CODNAT, ',
                '    PED_CODENT, ',
                '    PED_CODFAT, ',
                '    PED_CODCOB, ',
                '    PED_CODMHA, ',
                '    PED_APROVADO, ',
                '    PED_VL_ODESPESA, ',
                '    PED_OBS, ',
                '    PED_CODCEF, ',
                '    PED_ID_ECF, ',
                '    PED_NUM_ORCA, ',
                '    PED_VALIDADE, ',
                '    PED_CODWEB, ',
                '    PED_VL_CREDITO, ',
                '    PED_CODNEG, ',
                '    PED_ENTREGA, ',
                '    PED_GARANTIA, ',
                '    PED_TP_CUSTOMER, ',
                '    PED_INDPRES, ',
                '    PED_VL_ST, ',
                '    PED_TERMINAL, ',
                '    PED_NUMWEB   ',
                'FROM TB_PEDIDO P ',
                '   INNER JOIN tb_nota_fiscal N ',
                '   ON (N.NFL_CODPED = P.PED_CODIGO) ',
                'WHERE ( NFL_CODIGO =:NFL_CODIGO ) '//O CONTORLE É FEITO PELA TB_NOTA_FISCAL
      ));
      if registro.Tipo > 0 then
        sql.add(' AND ( PED_TIPO =:PED_TIPO ) ');

      sql.add(' ORDER BY PED_DT_ALTERA asc ');

      if registro.Tipo > 0 then
        ParamByName('PED_TIPO').AsInteger := Registro.Tipo;

      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.getUsuario;
var
  Lc_Qry : TSTQuery;
  LITem : TPedido;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('select first 1 usu_codigo ',
                     'from tb_usuario ',
                     'order by usu_codigo'));
      Active := True;
      registro.Usuario := FieldByName('USU_CODIGO').AsInteger;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.getById;
begin
  _getByKey(Registro);
end;

function TControllerPedido.getIdEmpresa:Integer;
var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('select PED_CODEMP ',
                     'from tb_PEDIDO ',
                     'WHERE PED_CODIGO=:PED_CODIGO'));
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      if recordCount > 0 then
        Result := FieldByName('PED_CODEMP').AsInteger;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.getByCodigoWeb;
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(Concat(
                'Select * FROM TB_PEDIDO ',
                'WHERE (PED_CODWEB =:PED_CODWEB ) ',
                ' AND (PED_CODWEB > 0) ',
                ' and (PED_CODMHA=:PED_CODMHA) '
          ));
      ParamByName('PED_CODWEB').AsInteger := Registro.CodigoWeb;
      ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerPedido.getByEmpresa:Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(' select PED_CODIGO '+
              ' from TB_PEDIDO '+
              'where  PED_CODEMP =:PED_CODEMP ');
      ParamByName('PED_CODEMP').asinteger:= Registro.Empresa;
      Active:=True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPedido.nextCodigo:Integer;
begin
  Result := Generator('GN_PEDIDO');
end;

procedure TControllerPedido.nextNumber(Metodo:String);
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      getbyId;
      SQL.Clear;
      SQL.Add(concat(
              'SELECT PED_NUMERO FROM TB_PEDIDO  ',
              'WHERE PED_CODMHA=:PED_CODMHA ',
              ' AND PED_CODIGO=:PED_CODIGO '
      ));
      ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      if StrToIntDef(FieldByName('PED_NUMERO').AsString,0) = 0 then
      Begin
        if Metodo = 'T' then
        Begin
          SQL.Clear;
          SQL.Add(concat(
                  'SELECT MAX(PED_NUMERO) FROM TB_PEDIDO  ',
                  'WHERE PED_CODMHA=:PED_CODMHA ',
                  ' AND PED_TIPO=:PED_TIPO '
          ));
          ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
          ParamByName('PED_TIPO').AsInteger := Registro.Tipo;
          Active := True;
          Registro.Numero := FieldByName('MAX').AsInteger + 1;
        end
        else
        begin
          case Registro.Tipo of
            1:Registro.Numero := Generator('GN_PEDIDO_VDA');
            2:Registro.Numero := Generator('GN_PEDIDO_CPA');
            3:Registro.Numero := Generator('GN_PEDIDO_AJT');
            4:Registro.Numero := Generator('GN_PEDIDO_CPM'); //pensei em criar mais um tipo, mas desisti 15/08/2015 - 17:43
          end;
        end;
        SQL.Clear;
        SQL.Add(concat(
                  ' update tb_pedido set ',
                  ' PED_NUMERO =:PED_NUMERO ',
                  ' where PED_CODIGO = :PED_CODIGO ',
                  ' AND PED_CODMHA = :PED_CODMHA  '
        ));
        ParamByName('PED_NUMERO').Value:= Registro.Numero;
        ParamByName('PED_CODIGO').AsInteger:= Registro.Codigo;
        ParamByName('PED_CODMHA').AsInteger:= Registro.CodigoEstabelecimento;
        ExecSQL;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPedido.GravaCredito;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_PEDIDO SET '+
              'PED_VL_CREDITO =:PED_VL_CREDITO '+
              'WHERE PED_CODIGO =:PED_CODIGO ');
      ParamByName('PED_VL_CREDITO').AsFloat := Registro.ValorCredito;
      ParamByName('PED_CODIGO').AsFloat := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPedido.InconsistenciaFaturado(msg:Boolean): boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := False;
  if ( Registro.Codigo > 0 ) then
  Begin
    Result := True;
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(concat(
                  'select PED_CODIGO ',
                  'from TB_PEDIDO pd ',
                  '  INNER JOIN TB_NOTA_FISCAL nf ',
                  '  ON (nf.nfl_codped = pd.ped_codigo) ',
                  'where  PED_CODIGO =:PED_CODIGO '
        ));
        ParamByName('PED_CODIGO').asinteger:= Registro.Codigo;
        Active:=True;
        FetchAll;
        if (RecordCount >0) then
        Begin
          if msg then
          Begin
            MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                           'Há uma inconsistência no faturamento deste pedido.' + EOLN +
                           ' Ele consta como faturado, vá em Nota Fiscal de Produtos '+EOLN+
                           ' e cancele para refazer o processo.'+EOLN,
                           ['OK'], [bEscape], mpInformacao);
            Result := True;
          End;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;

end;

function TControllerPedido.InconsistenciaORcamento: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := False;
  if ( Registro.Codigo > 0 ) then
  Begin
    Result := True;
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(concat(
                  'select PED_CODIGO ',
                  'from TB_PEDIDO pd ',
                  'where  PED_CODIGO =:PED_CODIGO ',
                  ' and PED_FATURADO<>:PED_FATURADO '
        ));
        ParamByName('PED_CODIGO').asinteger := Registro.Codigo;
        ParamByName('PED_FATURADO').asString:= 'C';
        Active:=True;
        FetchAll;
        Result := (RecordCount >0);
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;

end;

Function TControllerPedido.VerificaFaturado(msg:Boolean):boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := False;
  if ( Registro.Codigo > 0 ) then
  Begin
    Result := True;
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(' select PED_CODIGO '+
                ' from TB_PEDIDO '+
                'where  PED_CODIGO =:PED_CODIGO AND (PED_FATURADO = ''S'') ');
        ParamByName('PED_CODIGO').asinteger:= Registro.Codigo;
        Active:=True;
        FetchAll;
        if (RecordCount >0) then
        Begin
          if msg then
          Begin
            MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                           'Este pedido já foi Faturado.' + EOLN +
                           '    Operação cancelada.'+EOLN,
                           ['OK'], [bEscape], mpInformacao);
          End;
          Result := True;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

function TControllerPedido.using(Operation: string): Boolean;
Var
  Lc_Qry :TSTQuery;
begin
  Result := False;
  if ( Registro.Codigo > 0 ) then
  Begin
    Result := True;
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        if (Operation = 'C') then //Consulta
        begin
          SQL.Add('SELECT PED_EMUSO FROM TB_PEDIDO WHERE PED_CODIGO =:PED_CODIGO');
          ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
          Active := True;
          FetchAll;
          if (Length(FieldbyName('PED_EMUSO').AsString) = 0) then
          begin
            Result := True;
            Exit;
          end
          else
          begin
            Result := False;
            MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                           'Pedido visualizado no terminal ' + FieldbyName('PED_EMUSO').AsString + '.' + EOLN +
                           'Verifique e tente novamente.' + EOLN,
                           ['OK'], [bEscape], mpErro);
            Exit;
          end;
        end;
        if (Operation = 'B') then //Bloqueia
        begin
          SQL.Add('UPDATE TB_PEDIDO SET PED_EMUSO =:PED_EMUSO WHERE PED_CODIGO =:PED_CODIGO');
          ParamByName('PED_EMUSO').AsString := NomeComputador;
          ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
          ExecSQL;
        end;
        if (Operation = 'L') then //Libera
        begin
          SQL.Add('UPDATE TB_PEDIDO SET PED_EMUSO =:PED_EMUSO WHERE PED_CODIGO =:PED_CODIGO');
          ParamByName('PED_EMUSO').AsString := '';
          ParamByName('PED_CODIGO').AsInteger := Registro.Codigo;
          ExecSQL;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

function TControllerPedido.ValidaParcelamento(ValorCredito:Real): Boolean;
Var
  Lc_ValorPedido : Real;
  Lc_ValorParcelado : Real;
begin
  Result:=true;
  if ( Registro.Codigo > 0 ) then
  Begin
    Lc_ValorPedido := valorFinanceiro - ValorCredito;
    Parcelamento.Registro.CodigoPedido := Registro.Codigo;
    Lc_ValorParcelado := Parcelamento.getValor;
    IF (Lc_ValorPedido <> Lc_ValorParcelado ) AND
       ( Lc_ValorParcelado >0) THEN
    BEGIN
      MensagemPadrao('MENSAGEM DE ERRO','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'O Valor do Pedido não confere com Valor do Parcelamento.'+EOLN+
                     'Refaça o parcelamento.'+EOLN,
                     ['OK'],[BESCAPE],MPERRO);
      Result := FALSE;
    end;
  End;
end;

function TControllerPedido.valortotalitens: Real;
var
  Lc_Qry: TSTQuery;
  Lc_Valor :REal;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.clear;
      sql.add(concat(
              'SELECT ITF_VL_UNIT, ITF_QTDE, ITF_VL_DESC ',
              'FROM TB_ITENS_NFL ',
              'WHERE ( ITF_CODPED=:PED_CODIGO ) '
      ));
      ParambyName('PED_CODIGO').asinteger := Registro.Codigo;
      Active := True;
      First;
      Result := 0;
      Lc_Valor := 0;
      while not Eof do
      begin
        Lc_Valor := FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat;
        Lc_Valor := Lc_Valor - FieldByName('ITF_VL_DESC').AsFloat;
        Result := Result + Lc_Valor;
        Next;
      end;
    End;
    Result := RoundTO(Result,-2);
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPedido.valorFinanceiro: Real;
var
  Lc_Qry: TSTQuery;
  Lc_Subtotal :REal;
  LcValor : Real;
  LcStrValor : String;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.clear;
      sql.add(concat(
                'SELECT ITF_VL_UNIT, ITF_QTDE, ITF_VL_DESC, itb.set_financial, pd.ped_vl_frete ',
                'FROM TB_ITENS_NFL it ',
                '   inner join tb_pedido pd ',
                '   on (pd.ped_codigo = it.itf_codped) ',
                '   left join tb_itens_nfl_tributacao itb ',
                '   on (itb.tb_order_itens_id = it.itf_codigo) ',
                'WHERE (ITF_CODPED =:PED_CODIGO) ',
                ' and ( (itb.set_financial = ''S'' ) or (itb.set_financial is null)  ) '
      ));
      case registro.Tipo of
        1:sql.add(' AND (ITF_OPER = ''V'') ');
        2:sql.add(' AND (ITF_OPER = ''C'') ');
        3:sql.add(' AND (ITF_OPER = ''A'') ');
        4:sql.add(' AND (ITF_OPER = ''V'') ');
      else
        sql.add(' AND (ITF_OPER = ''V'') ');
      end;
      ParambyName('PED_CODIGO').asinteger := Registro.Codigo;
      Active := True;
      First;
      Result := 0;
      while not Eof do
      begin
        Lc_Subtotal := 0;
        LcValor := FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat;
        LcValor := RoundTo( LcValor ,-2);
        LcStrValor  := FloatToStrF(LcValor , ffFixed, 10, 2);
        Lc_Subtotal := StrtoFloatDef(LcStrValor ,0);

        Lc_Subtotal := Lc_Subtotal - FieldByName('ITF_VL_DESC').AsFloat;
        Result := Result + Lc_Subtotal;
        Next;
      end;
      Result := Result + FieldByName('ped_vl_frete').AsFloat;
      Result := RoundTO( Result,-2);
    End;

  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
