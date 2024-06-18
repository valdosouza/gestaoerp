unit ControllerCtrlLote;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
       tblCtrlLote, Generics.Collections,controllerProduto,
       ControllerCtrlEstoque, ControllerMovimentoLote;


Type
  TListaCtrlLote = TObjectList<TCtrlLote>;

  TControllerCtrlLote = Class(TControllerBase)
  private

  public
    Registro : TCtrlLote;
    Movimento : TControllerMovimentoLote;
    Estoque : TControllerCtrlEstoque;
    Lista: TListaCtrlLote;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure clear;
    function getById:boolean;
    function salva:boolean;
    function insere:boolean;
    function delete:boolean;
    function atualiza:boolean;
    function AplicaLotePedido(pedidoId:Integer):Boolean;
    function getSaldo(loteId, produtoId: Integer): REal;
    function getListLote(produtoId:Integer):Boolean;
    function DeleteLoteItemCtrl(Tipo,Sentido:String;Item:Integer):Boolean;
    function  GetByExintor:TSTQuery;
    function verificaLoteUsado:Boolean;
    function VerificaExistenciaNumeroLote: Boolean;
    function getLoteByVinculo(Vinculo:Integer):Boolean;
  End;


implementation

{ TControllerCtrlLote }

uses Un_Regra_Negocio;

function TControllerCtrlLote.AplicaLotePedido(pedidoId: Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcSaldo : REal;
  LcRestante : Real;
  I : Integer;
  LcQtdeAplicada : Real;
  ListaLote : TStringList;
begin
  Try
    Result := False;
    ListaLote := TStringList.Create;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
              'SELECT ITF_CODPED,ITF_CODIGO, ce.CET_CODPRO, PRO_DESCRICAO, ce.cet_qtde,ce.CET_DATA ',
              'FROM TB_ITENS_NFL i ',
              '   inner join tb_ctrl_estoque ce ',
              '   on (ce.cet_item_ctrl =i.itf_codigo ) ',
              '   INNER JOIN TB_PRODUTO pr ',
              '   ON  (pr.PRO_CODIGO = ce.cet_codpro) ',
              'WHERE ITF_CODPED =:PED_CODIGO ',
              'AND ( ITF_OPER = ''V'' ) '
      ));
      ParamByName('PED_CODIGO').AsInteger := pedidoId;
      Active := True;
      first;
      while not eof do
      Begin
        LcSaldo := Movimento.getSaldoMovimento(FieldByName('ITF_CODIGO').AsInteger,FieldByName('CET_CODPRO').AsInteger);
        LcRestante := FieldByName('CET_QTDE').AsFloat - LcSaldo;
        if LcRestante > 0 then
        Begin
          getListLote(FieldByName('CET_CODPRO').AsInteger);
          if Lista.Count > 0 then
          Begin
            Result := True;
            I:= 0;
            repeat
              if Lista[I].Saldo >= LcRestante then
              Begin
                LcQtdeAplicada := LcRestante;
              End
              else
              Begin
                LcQtdeAplicada := Lista[I].Saldo;
              End;
              LcRestante := LcRestante - LcQtdeAplicada;
              Movimento.Registro.Codigo      := 0;
              Movimento.Registro.Lote        := Lista[I].Codigo;
              Movimento.Registro.Data        := FieldByName('CET_DATA').asDateTime;
              Movimento.Registro.Tipo        := 'VENDAS';
              Movimento.Registro.Vinculo     := FieldByName('ITF_CODIGO').AsInteger;
              Movimento.Registro.Sentido     := 'S';
              Movimento.Registro.Qtde        := LcQtdeAplicada;
              Movimento.Registro.Extintor    := 0;
              Movimento.Registro.Observacao  := '';
              Movimento.Registro.Log         := concat('SISTEMA','-',DateTimeToStr(Now));
              Movimento.insere;
              ListaLote.Add( Lista[I].Codigo.ToString());
              inc(I);
            until (I > (Lista.Count - 1) ) or (LcRestante <= 0) ;
          End;
        end;
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
    //Atualiza saldo dos Lotes
    if ListaLote.Count > 0 then
      Movimento.AtualizaSaldoLote(ListaLote);
    ListaLote.disposeOf;
  End;
end;

function TControllerCtrlLote.atualiza: boolean;
BEgin

end;


procedure TControllerCtrlLote.clear;
begin
  clearObj(Registro);
end;

constructor TControllerCtrlLote.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCtrlLote.Create;
  Movimento := TControllerMovimentoLote.create(nil);
  Estoque := TControllerCtrlEstoque.create(nil);
  Lista := TListaCtrlLote.Create;
end;

function TControllerCtrlLote.delete: boolean;
Var
  Lc_Qry : TSTQuery;
  LcReg : TCtrlLote;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      //Exclui o movimento
      sql.Add(concat(
              'DELETE FROM TB_MOVIMENTO_LOTE ml ',
              'WHERE ( ml.MLT_CODCLT =:MLT_CODCLT ) '
      ));
      ParamByName('MLT_CODCLT').AsInteger := Registro.Codigo;
      ExecSQL;
      //Exclui o lote
      active := False;
      sql.Clear;
      sql.Add(concat(
              'DELETE FROM TB_CTRL_LOTE  ',
              'WHERE ( CLT_CODIGO =:CLT_CODIGO ) '
      ));
      ParamByName('CLT_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlLote.DeleteLoteItemCtrl(Tipo,Sentido: String;
  Item: Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
  LcReg : TCtrlLote;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
              'DELETE FROM TB_MOVIMENTO_LOTE ml ',
              'WHERE ( ml.MLT_TIPO =:MLT_TIPO ) ',
              '  AND ( ml.MLT_SENTIDO =:MLT_SENTIDO ) ',
              '  AND ( ml.MLT_CODVCL =:MLT_CODVCL ) '
      ));
      ParamByName('MLT_TIPO').AsString := Tipo;
      ParamByName('MLT_SENTIDO').AsString := Sentido;
      ParamByName('MLT_CODVC').AsInteger := Item;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerCtrlLote.Destroy;
begin
  Registro.DisposeOf;
  Movimento.Disposeof;
  Lista.Disposeof;
  Estoque.Disposeof;
  inherited;
end;


function TControllerCtrlLote.GetByExintor: TSTQuery;
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
begin
  Result := GeraQuery;
  with Result do
  Begin
    SQL.Clear;
    Lc_SqlTxt:='SELECT FIRST 1 '+
               '   CLT_NUMERO, '+
               '   CLT_CODIGO, '+
               '   MLT_CODIGO, '+
               '   MLT_DATA, '+
               '   CLT_DT_VENCIMENTO, '+
               '   CLT_CERTIFICADO, '+
               '   MRC_DESCRICAO,'+
               '   MLT_CODVCL, '+
               '   CLT_CODMRC '+
               ' FROM tb_ctrl_lote '+
               '   INNER JOIN tb_movimento_lote '+
               '   on (MLT_CODCLT = CLT_CODIGO) '+
               '   INNER JOIN TB_EXTINTOR '+
               '   ON (EXT_CODIGO = MLT_CODEXT) '+
               '   LEFT OUTER JOIN TB_MARCA_PRODUTO '+
               '   ON (MRC_CODIGO = CLT_CODMRC)'+
               'WHERE (MLT_CODEXT=:MLT_CODEXT) '+
               'ORDER BY MLT_CODIGO DESC ';
    SQL.Add(Lc_SqlTxt);
    ParamByName('MLT_CODEXT').AsInteger:= Movimento.Registro.Extintor;
    Active := True;
    FetchAll;
  end;
end;

function TControllerCtrlLote.getById: boolean;
begin
  _getByKey(Registro);
end;

function TControllerCtrlLote.getListLote(produtoId: Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
  LcReg : TCtrlLote;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(

              'SELECT * ',
              'FROM TB_CTRL_LOTE cl ',
              'WHERE cl.CLT_codpro=:PRO_CODIGO ',
              ' AND ( CLT_QT_SALDO > 0 ) ',
              ' AND ( cl.clt_dt_vencimento >=:clt_dt_vencimento ) ',
              'order by cl.clt_dt_vencimento ASC '
      ));
      ParamByName('clt_dt_vencimento').AsDate := Date;
      ParamByName('PRO_CODIGO').AsInteger := produtoId;
      Active := True;
      first;
      lista.Clear;
      while not eof do
      begin
        LcReg := TCtrlLote.create;
        get(Lc_Qry,LcReg);
        lista.Add(LcReg);
        Next;
      end;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlLote.getLoteByVinculo(Vinculo:Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    clearObj(Registro);
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT cl.* ',
                'FROM TB_CTRL_LOTE cl ',
                '   INNER JOIN TB_MOVIMENTO_LOTE ml ',
                '   ON (MLT_CODCLT = CLT_CODIGO) ',
                'WHERE ml.MLT_CODVCL =:MLT_CODVCL '
      ));
      ParamByName('MLT_CODVCL').AsInteger := Vinculo;
      Active :=True;
      FetchAll;
      exisT := (recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlLote.getSaldo(loteId, produtoId: Integer): REal;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT CLT_QT_SALDO  ',
                'FROM TB_CTRL_LOTE cl ',
                'WHERE cl.CLT_CODIGO  =:CLT_CODIGO ',
                'AND CE.cet_codpro=:PRO_CODIGO '
      ));
      ParamByName('CLT_CODIGO').AsInteger := loteId;
      ParamByName('PRO_CODIGO').AsInteger := produtoId;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('CLT_QT_SALDO').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCtrlLote.insere: boolean;
begin
  try
    Registro.Codigo := Generator('GN_MOVIMENTO_LOTE');
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerCtrlLote.salva: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CTRL_LOTE');
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerCtrlLote.VerificaExistenciaNumeroLote: Boolean;
var
  Lc_Qry: TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                  ' SELECT * FROM TB_CTRL_LOTE ',
                  'Where (CLT_NUMERO =:CLT_NUMERO) ',
                  ' and (CLT_CODEMP=:CLT_CODEMP) ',
                  ' and (CLT_CODIGO <>:CLT_CODIGO) ',
                  ' and (CLT_CODPRO =:CLT_CODPRO) '
      ));
      ParamByName('CLT_NUMERO').AsAnsiString:= Registro.Numero;
      ParamByName('CLT_CODEMP').AsInteger:= Registro.Empresa;
      ParamByName('CLT_CODIGO').AsInteger:= Registro.Codigo;
      ParamByName('CLT_CODPRO').AsInteger:= Registro.Produto;
      Active :=True;
      FetchAll;
      exisT := (recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerCtrlLote.verificaLoteUsado: Boolean;
var
  Lc_Qry: TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT CLT_CODIGO ',
                'FROM TB_CTRL_LOTE cl ',
                '   INNER JOIN TB_MOVIMENTO_LOTE ml ',
                '   ON (MLT_CODCLT = CLT_CODIGO) ',
                'WHERE ml.mlt_codclt =:CLT_CODIGO ',
                'and ml.mlt_sentido = ''S'' '
      ));
      ParamByName('CLT_CODIGO').AsInteger:= Registro.Codigo;
      Active :=True;
      FetchAll;
      exist := (recordcount > 0);
      result := exist;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
