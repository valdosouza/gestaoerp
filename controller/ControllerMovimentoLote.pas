unit ControllerMovimentoLote;

interface

uses STDatabase,Classes,STQuery,  SysUtils,ControllerBase,
      tblMovimentoLote,  Generics.Collections,controllerProduto;


Type
  TListaMovimentoLote = TObjectList<TMovimentoLote>;

  TControllerMovimentoLote = Class(TControllerBase)
  private

  public
    Registro : TMovimentoLote;
    Lista: TListaMovimentoLote;
    Lst_Lote:TStringList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    function atualiza:boolean;
    Function deleteByVinculo:Boolean;
    Function AtualizaSaldoLote(Pc_Lst_Lote:TStringList):Boolean;
    Function AtualizaSaldo:Boolean;
    procedure clear;
    function getSaldoMovimento(vinculoId,produtoId:Integer):REal;
    function getByLote:Boolean;
    function getFirstByLote:Boolean;
    function CorrigeItemExcluido:Boolean;
  End;

implementation

uses  Un_Regra_Negocio;

function TControllerMovimentoLote.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

function TControllerMovimentoLote.AtualizaSaldo: Boolean;
var
  Lc_Qry: TSTQuery;
  Lc_Entrada : Real;
  Lc_Saida : Real;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                 'SELECT MLT_QTDE, MLT_SENTIDO ',
                 'FROM tb_movimento_lote ',
                 'WHERE MLT_CODCLT =:CLT_CODIGO ',
                 ' AND ( (MLT_CODVCL > 0) OR (MLT_TIPO = ''EXT_QUEBRA'') OR (MLT_TIPO = ''AVULSO''))'
      ));
      ParamByName('CLT_CODIGO').AsInteger:= Registro.Lote;
      Active := True;
      Lc_Entrada := 0;
      Lc_Saida := 0;
      while not eof do
      Begin
        if (FieldByName('MLT_SENTIDO').AsAnsiString = 'E') then
          Lc_Entrada := Lc_Entrada +  FieldByName('MLT_QTDE').AsFloat
        else
          Lc_Saida := Lc_Saida +  FieldByName('MLT_QTDE').AsFloat;
        next;
      end;
      //Atualiza
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                ' UPDATE TB_CTRL_LOTE SET ',
                '  CLT_QT_SAIDA   =:CLT_QT_SAIDA ',
                ' ,CLT_QT_ENTRADA =:CLT_QT_ENTRADA ',
                ' ,CLT_QT_SALDO   =:CLT_QT_SALDO ',
                ' Where (CLT_CODIGO=:CLT_CODIGO) '
      ));
      ParamByName('CLT_QT_ENTRADA').AsFloat := Lc_Entrada;
      ParamByName('CLT_QT_SAIDA').AsFloat   := Lc_Saida;
      ParamByName('CLT_QT_SALDO').AsFloat   := Lc_Entrada - Lc_Saida;
      ParamByName('CLT_CODIGO').AsInteger   := Registro.Lote;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerMovimentoLote.AtualizaSaldoLote(Pc_Lst_Lote:TStringList): Boolean;
var
  Lc_Qry: TSTQuery;
  Lc_Upt: TSTQuery;
  Lc_SqlTxt: string;
  Lc_Entrada : Real;
  Lc_Saida : Real;
  I:Integer;
  Lc_Cd_Lote : Integer;
begin
  Try
    Lc_Qry := GeraQuery;
    Lc_Upt := GeraQuery;
    with Lc_Qry do
    Begin
      For I := 0 to (Pc_Lst_Lote.Count -1) do
      Begin
        Lc_Cd_Lote := StrToIntDef(Pc_Lst_Lote.Strings[I],0);
        Active := False;
        SQL.Clear;
        Lc_SqlTxt := 'SELECT MLT_QTDE, MLT_SENTIDO '+
                     'FROM tb_movimento_lote '+
                     'WHERE MLT_CODCLT =:CLT_CODIGO AND ( (MLT_CODVCL > 0) OR (MLT_TIPO = ''EXT_QUEBRA'') OR (MLT_TIPO = ''AVULSO''))';
        SQL.Add(Lc_SqlTxt);
        ParamByName('CLT_CODIGO').AsInteger:= Lc_Cd_Lote;
        Active := True;
        Lc_Entrada := 0;
        Lc_Saida := 0;
        while not eof do
        Begin
          if (FieldByName('MLT_SENTIDO').AsAnsiString = 'E') then
            Lc_Entrada := Lc_Entrada +  FieldByName('MLT_QTDE').AsFloat
          else
            Lc_Saida := Lc_Saida +  FieldByName('MLT_QTDE').AsFloat;
          next;
        end;
        //Atualiza
        with Lc_Upt do
        Begin
          Active := False;
          SQL.Clear;
          Lc_SqlTxt := ' UPDATE TB_CTRL_LOTE SET '+
                       '  CLT_QT_SAIDA   =:CLT_QT_SAIDA '+
                       ' ,CLT_QT_ENTRADA =:CLT_QT_ENTRADA '+
                       ' ,CLT_QT_SALDO   =:CLT_QT_SALDO '+
                       ' Where (CLT_CODIGO=:CLT_CODIGO) ';
          SQL.Add(Lc_SqlTxt);
          ParamByName('CLT_QT_ENTRADA').AsFloat := Lc_Entrada;
          ParamByName('CLT_QT_SAIDA').AsFloat := Lc_Saida;
          ParamByName('CLT_QT_SALDO').AsFloat := Lc_Entrada - Lc_Saida;
          ParamByName('CLT_CODIGO').AsInteger := Lc_Cd_Lote;
          ExecSQL;
        end;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Upt);
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMovimentoLote.clear;
begin
  clearObj(Registro);
end;

function TControllerMovimentoLote.CorrigeItemExcluido: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lst_Lote.Clear;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.Add(Concat(
                'delete from tb_movimento_lote ',
                'where mlt_codigo in ( ',
                'select  ml.mlt_codigo ',
                'from tb_ctrl_lote cl ',
                '  inner join tb_movimento_lote ml ',
                '  on (ml.mlt_codclt = cl.clt_codigo) ',
                '  left outer join tb_extintor et ',
                '  on (et.ext_codigo = ml.mlt_codext) ',
                'where ml.mlt_codvcl in ( ',
                'select io.ios_codigo ',
                'from tb_ext_itens_ors io ',
                '  left join tb_ext_ordem_servico os ',
                '  on (os.ors_codigo = io.ios_codors) ',
                'where os.ors_codigo is null ',
                ') and ( ml.mlt_codigo  > 0 ) ',
                ') '
      ));
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

constructor TControllerMovimentoLote.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMovimentoLote.Create;
  Lista := TListaMovimentoLote.Create;
  Lst_Lote := TStringList.Create;
end;

function TControllerMovimentoLote.deleteByVinculo: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lst_Lote.Clear;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.Add(Concat(
                'SELECT DISTINCT MLT_CODCLT,MLT_CODIGO ',
                'FROM TB_MOVIMENTO_LOTE ',
                'WHERE ( MLT_CODVCL=:MLT_CODVCL ) ',
                '  AND ( MLT_TIPO=:MLT_TIPO) '
      ));
      if (Trim(registro.Sentido)<> '') then
        SQL.Add('  AND ( MLT_SENTIDO =:MLT_SENTIDO ) ');

      ParamByName('MLT_CODVCL').AsInteger := registro.Vinculo;
      ParamByName('MLT_TIPO').AsString := registro.Tipo;
      if (Trim( registro.Sentido )<> '') then
        ParamByName('MLT_SENTIDO').Asstring := registro.Sentido;
      Active := True;
      FetchAll;
      first;
      while not eof do
      Begin
        Lst_Lote.Add(FieldByName('MLT_CODCLT').AsString);
        Registro.Codigo := FieldByName('MLT_CODIGO').AsInteger;
        SELF.deleteObj(Registro);
        Next;
      End;
    End;
    Self.AtualizaSaldoLote(Lst_Lote);
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerMovimentoLote.Destroy;
begin
  Lista.DisposeOf;
  Lst_Lote.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerMovimentoLote.getByLote: Boolean;
Var
  Lc_Qry : TSTQuery;
  Item : TMovimentoLote;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT * ',
                'FROM  TB_MOVIMENTO_LOTE ',
                'WHERE MLT_CODCLT =:MLT_CODCLT ',
                'order by MLT_DATA '
      ));
      ParamByName('MLT_CODCLT').AsInteger := Registro.Lote;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        Item := TMovimentoLote.create;
        get(Lc_Qry,item);
        Lista.Add(Item);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerMovimentoLote.getFirstByLote: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT * ',
                'FROM  TB_MOVIMENTO_LOTE ',
                'WHERE MLT_CODCLT =:MLT_CODCLT ',
                ' and (MLT_SENTIDO=:MLT_SENTIDO ) ',
                'order by MLT_DATA '
      ));
      ParamByName('MLT_CODCLT').AsInteger := Registro.Lote;
      ParamByName('MLT_SENTIDO').AsString := 'E';
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerMovimentoLote.getSaldoMovimento(vinculoId,produtoId: Integer): REal;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT SUM(ml.mlt_qtde) total ',
                'FROM tb_ctrl_estoque ce ',
                '   left outer join tb_movimento_lote ml ',
                '   on (ml.mlt_codvcl = ce.cet_item_ctrl) ',
                '   left outer join tb_ctrl_lote cl ',
                '   on (cl.clt_codigo = ml.mlt_codclt) and (cl.clt_codpro = ce.cet_codpro) ',
                'WHERE ce.cet_item_ctrl =:VINCULO ',
                'AND CE.cet_codpro=:PRO_CODIGO '
      ));
      ParamByName('VINCULO').AsInteger := vinculoId;
      ParamByName('PRO_CODIGO').AsInteger := produtoId;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('total').AsFloat;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerMovimentoLote.insere: boolean;
begin
  Registro.Codigo := Generator('GN_MOVIMENTO_LOTE');
  InsertObj(Registro);
end;

function TControllerMovimentoLote.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MOVIMENTO_LOTE');
  SaveObj(Registro);
end;

end.
