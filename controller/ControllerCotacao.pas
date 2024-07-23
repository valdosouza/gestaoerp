unit ControllerCotacao;

interface

uses STDatabase,STQuery, Classes, SysUtils,ControllerBase,
      tblCotacao,  Generics.Collections, ControllerItensCotacao, un_Padrao, 
    UnFunctions,System.Math, Un_Msg;
Type
  TListCotacao = TObjectList<TCotacao>;

  TControllerCotacao = Class(TControllerBase)
    Lista :TListCotacao;
  private

  public
    Registro : TCotacao;
    ItensProduto : TControllerItensCotacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:Boolean;
    function migra:Boolean;
    function insert:boolean;
    Function delete:boolean;
    Function getByKey:boolean;
    function getCodigoPedido:Integer;
    procedure getList;
    procedure nextNumber;
    procedure getbyId;
    procedure enviaLixeira;
    procedure clear;
    procedure UpdateEnvio;
    procedure AplicarDescontoItens(PedidoID: Integer; Vl_Desconto: real);
    function using(Operation: string): Boolean;
    function LiberaEmUso:boolean;
  End;

  implementation
{ ControllerCotacao }

procedure TControllerCotacao.AplicarDescontoItens(PedidoID: Integer;
  Vl_Desconto: real);
var
   Lc_Qry: TSTQuery;
   Lc_Upt: TSTQuery;
   Lc_SqlTxt: string;
   Lc_VL_Cotacao : Real;
   Lc_Vl_Subtotal : Real;
   Lc_Aq_Proporcao : Real;
   Lc_Aq_Desconto : real;
   Lc_VL_Desconto : Real;
   Lc_VL_TL_Desconto : Real;
   Lc_Cd_Item : Integer;
begin
  if Vl_Desconto > 0 then
  Begin
    //Zerando as variaveis
     Lc_VL_Cotacao := 0;
     Lc_Vl_Subtotal :=0;
     Lc_Aq_Proporcao :=0;
     Lc_VL_Desconto :=0;
     Lc_VL_TL_Desconto :=0;

    //Cria a Qry de Atualização
    Lc_Upt := GeraQuery;
    //Cria a Consulta
    Lc_Qry := GeraQuery;
    TRy
      WITH Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        Lc_SqlTxt := 'SELECT ICT_CODIGO, ICT_VL_UNIT, ICT_QTDE ' +
                     'FROM TB_ITENS_CTC ' +
                     'WHERE (ICT_CODPED=:ICT_CODPED) ';
        sql.Add(Lc_SqlTxt);
        ParamByName('ICT_CODPED').AsInteger := PedidoID;
        Active := True;
        FetchAll;
        //Calcula o valor total da Cotação
        First;
        while not eof do
        Begin
          Lc_VL_Cotacao := Lc_VL_Cotacao + (FieldByName('ICT_VL_UNIT').AsFloat * FieldByName('ICT_QTDE').AsFloat);
          next;
        end;
        Lc_Upt.SQL.Clear;
        Lc_SqlTxt := 'UPDATE TB_ITENS_CTC SET ' +
                      'ICT_AQ_DESC=:ICT_AQ_DESC, ' +
                      'ICT_VL_DESC=:ICT_VL_DESC ' +
                      'WHERE (ICT_CODIGO=:ICT_CODIGO) ';
        Lc_Upt.SQL.Add(Lc_SqlTxt);
        First;
        while not Eof do
        begin
          //Calculo pega o valor do subtotal do item
          Lc_Vl_Subtotal := (FieldByName('ICT_VL_UNIT').AsFloat * FieldByName('ICT_QTDE').AsFloat);
          //Guarda o codigo do item a ser atualizado
          Lc_Cd_Item := FieldByName('ICT_CODIGO').AsInteger;
          //Faz o calculo da aliquota
          Lc_Aq_Proporcao := (Lc_Vl_Subtotal / Lc_VL_Cotacao);
          Lc_Aq_Proporcao := RoundTo( Lc_Aq_Proporcao,-2);
          Lc_Vl_Desconto := Vl_Desconto * Lc_Aq_Proporcao;
          Lc_Vl_Desconto := RoundTo( Lc_Vl_Desconto,-2);
          Lc_Aq_Desconto := (Lc_Vl_Desconto/Lc_Vl_Subtotal)*100;
          Lc_Aq_Desconto := RoundTo( Lc_Aq_Desconto,-2);
          Lc_VL_TL_Desconto := Lc_VL_TL_Desconto + Lc_Vl_Desconto;

          //Avança para o proximo registro
          Next;
          //Verifica se e o ultimo registro para fazer compensação de arredondamento
          if eof then
            Begin
            if (Vl_Desconto > Lc_VL_TL_Desconto) then
              Lc_VL_Desconto := Lc_VL_Desconto + (Vl_Desconto - Lc_VL_TL_Desconto)
            else
              Lc_VL_Desconto := Lc_VL_Desconto - (Lc_VL_TL_Desconto - Vl_Desconto);
            end;
          //Efetua a atualização
          Lc_Upt.Active := False;
          Lc_Upt.ParamByName('ICT_CODIGO').AsInteger := Lc_Cd_Item;
          Lc_Upt.ParamByName('ICT_AQ_DESC').AsFloat := Lc_Aq_Desconto;
          Lc_Upt.ParamByName('ICT_VL_DESC').AsFloat := Lc_Vl_Desconto;
          Lc_Upt.ExecSQL;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
      FinalizaQuery(Lc_Upt);
    End;
  End;
end;

procedure TControllerCotacao.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerCotacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCotacao.Create;
  Lista := TListCotacao.Create;
  ItensProduto := TControllerItensCotacao.Create(self);
end;

function TControllerCotacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCotacao.Destroy;
begin
  Registro.DisposeOf;
  FreeAndNil(Lista);
  FreeAndNil( ItensProduto );
  inherited;
end;

procedure TControllerCotacao.enviaLixeira;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('UPDATE TB_COTACAO '+
              'SET CTC_STATUS=:CTC_STATUS '+
              'WHERE (CTC_CODIGO =:CTC_CODIGO)');
      ParamByName('CTC_STATUS').AsAnsiString := 'A';
      ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerCotacao.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_COTACAO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCotacao.LiberaEmUso: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE tb_COTACAO SET CTC_emuso = NULL where CTC_codigo =:CTC_codigo');
      ParamByName('CTC_CODIGO').AsInteger := Registro.codigo;
      Active := True;
      FetchAll;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCotacao.migra: Boolean;
begin
  InsertObj(Registro);
end;

procedure TControllerCotacao.nextNumber;
var
   Lc_Codigo: Integer;
   Lc_Ordem: string;
   Lc_Ano: string;
   Lc_Ano_Numero : String;
   Lc_Alterar : boolean;
   Lc_Qry : TSTQuery;
begin
  Lc_Alterar := False;
  Lc_Ano := IntToStr(Fc_Year(registro.Data));
  if Length(registro.Numero) > 0 then
  Begin
    Lc_Ano_Numero := Copy(registro.Numero,Length(registro.Numero)-1,2);
    Lc_Alterar := (Lc_Ano_Numero <> Copy(Lc_Ano,3,2));
  end;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
         'SELECT MAX(CTC_NUMERO) ',
         'FROM TB_COTACAO ',
         ' WHERE (CTC_DATA>=:CTC_DATA) AND ',
         '      (CTC_TIPO=:CTC_TIPO) '
      ));
      ParamByName('CTC_DATA').AsAnsiString := '01/01/' + Lc_ano;
      ParamByName('CTC_TIPO').AsAnsiString := '0';
      Active := True;
      Lc_Ordem := Copy( FieldByName('MAX').AsAnsiString, 7, 5);
      Lc_Codigo := StrToIntDef(Lc_Ordem, 0) + 1;
      Registro.Numero := 'ORC - ' + StrZero(Lc_Codigo, 5, 0) + '/' + Copy(Lc_Ano, 3, 2);

      Active := False;
      SQL.Clear;
      SQL.Add(concat(
                ' update tb_cotacao set            ',
                ' CTC_NUMERO =:CTC_NUMERO         ',
                ' where CTC_CODIGO = :CTC_CODIGO  ',
                ' AND CTC_CODMHA = :CTC_CODMHA    '
      ));

      ParamByName('CTC_NUMERO').Value     := Registro.Numero;
      ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('CTC_CODMHA').AsInteger := Registro.Estabelecimento;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCotacao.save: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_COTACAO');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCotacao.update: Boolean;
begin
  try
    updateObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCotacao.UpdateEnvio;
var
  Lc_Qry :TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with  Lc_Qry do
    Begin
      SQL.Clear;
      SQL.add(concat(
              ' update tb_cotacao set ',
              ' ctc_dt_env_email =:ctc_dt_env_email  ',
              ' where ctc_codigo =:ctc_codigo '
      ));
      ParamByName('ctc_dt_env_email').AsDateTime:=Now;
      ParamByName('ctc_codigo').AsInteger:= Registro.Codigo;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerCotacao.using(Operation: string): Boolean;
Var
  Lc_Qry :TSTQuery;
begin
  Result := True;
  if ( Registro.Codigo > 0 ) then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        Active := False;
        SQL.Clear;
        if (Operation = 'C') then //Consulta
        begin
          SQL.Add('SELECT CTC_EMUSO FROM TB_COTACAO WHERE CTC_CODIGO =:CTC_CODIGO');
          ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
          Active := True;
          FetchAll;
          if (Length(FieldbyName('CTC_EMUSO').AsString) = 0) then
          begin
            Result := True;
            Exit;
          end
          else
          begin
            Result := False;
            MensagemPararExecucao('Orçamento visualizado no terminal ' + FieldbyName('CTC_EMUSO').AsString + '.');
            Exit;
          end;
        end;
        if (Operation = 'B') then //Bloqueia
        begin
          SQL.Add('UPDATE TB_COTACAO SET CTC_EMUSO =:CTC_EMUSO WHERE CTC_CODIGO =:CTC_CODIGO');
          ParamByName('CTC_EMUSO').AsString := NomeComputador;
          ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
          ExecSQL;
        end;
        if (Operation = 'L') then //Libera
        begin
          SQL.Add('UPDATE TB_COTACAO SET CTC_EMUSO =:CTC_EMUSO WHERE CTC_CODIGO =:CTC_CODIGO');
          ParamByName('CTC_EMUSO').AsString := '';
          ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
          ExecSQL;
        end;
      end;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

procedure TControllerCotacao.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCotacao.getByKey: boolean;
begin
  _getByKey(Registro);
end;

function TControllerCotacao.getCodigoPedido: Integer;
var
  Lc_Qry : TSTQuery;
  LcLista : TCotacao;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT CTC_CODPED ',
                'FROM TB_COTACAO ',
                'WHERE ( CTC_CODIGO=:CTC_CODIGO ) ',
                ' and (CTC_CODPED > 0) ',
                ' AND (CTC_CODIGO > 0) '
      ));
      ParamByName('CTC_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      if recordcount > 0 then
        Result := FieldByName('CTC_CODPED').AsInteger
      else
          Result := 0;
    end;
  Finally
   FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCotacao.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TCotacao;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_COTACAO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TCotacao.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
   FinalizaQuery(Lc_Qry);
  End;

end;

end.

