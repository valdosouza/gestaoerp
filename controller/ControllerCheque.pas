unit ControllerCheque;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblArquivo ,
      Un_RL_ReportChequeEnvioFornecedor, Un_RL_ReportChequeSimples, Un_RL_ReportCheque,
      Un_RL_ReportChequeRastrearOrigem,Un_RL_ReportChequeRastrearDestino,
      UN_RL_ReportChequeEnvioBanco, Un_RL_ReportChequeDisponivelCaixa,
      UN_RL_ReportChequeDevolvidos, Excel2000, ComObj,prmCheques, tblCheque;


type

  TControllerCheque = Class(TControllerBase)
  private

  public
    Registro : TCheque;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function salva:boolean;
    Function delete:boolean;
    procedure UpdateEstado;
    procedure Resgate;
    procedure UpdateDevolvido;
    procedure Deposito;
    procedure Descontar;
    procedure Destinar;
    procedure DesvincularTerceiro;

    procedure ExportChequeOrigem(P : TParamCheques);
    procedure ExportChequeDestino(P : TParamCheques);

    procedure ReportRelacaoSimples(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportRastrearOrigem(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportRastrearDestino(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportEnvioFornecedor(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportEnvioBanco(Operacao,Caminho:String;P : TParamCheques);
    procedure ReportDisponivelCaixa(Operacao,Caminho: String;P : TParamCheques);
    procedure ReportDevolvido(Operacao, Caminho: String;P : TParamCheques);



  End;

implementation

{ TControllerCheque }

uses Un_DM, Un_Excel;


constructor TControllerCheque.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCheque.Create;
end;

function TControllerCheque.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;



procedure TControllerCheque.Destinar;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry, Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO =:CHQ_ESTADO, '+
              'CHQ_QT_PAG =:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


destructor TControllerCheque.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerCheque.DesvincularTerceiro;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry, Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO =:CHQ_ESTADO, '+
              'CHQ_QT_PAG =:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.UpdateDevolvido;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_DEVOLVIDO=:CHQ_DEVOLVIDO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_DEVOLVIDO').AsString := Devolvido;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.updateEstado;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO=:CHQ_ESTADO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Resgate;
Var
  Lc_Qry : TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_DEVOLVIDO=:CHQ_DEVOLVIDO, '+
              'CHQ_VL_AMORT=:CHQ_VL_AMORT, '+
              'CHQ_DT_QUITACAO=:CHQ_DT_QUITACAO '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_DEVOLVIDO').AsString := Devolvido;
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_VL_AMORT').AsFloat := ValorAmortizado;
      ParamByName('CHQ_DT_QUITACAO').AsDateTime := DataQuitacao;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Deposito;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry,Registro do
    Begin
      sql.Add('UPDATE TB_CHEQUES SET '+
              'CHQ_ESTADO=:CHQ_ESTADO, '+
              'CHQ_QT_PAG=:CHQ_QT_PAG, '+
              'CHQ_CODFOR =:CHQ_CODFOR '+
              'WHERE ( CHQ_CODIGO =:CHQ_CODIGO ) '+
              'AND (CHQ_CODMHA =:CHQ_CODMHA)');
      ParamByName('CHQ_CODIGO').AsInteger := Codigo;
      ParamByName('CHQ_ESTADO').AsString := Estado;
      ParamByName('CHQ_QT_PAG').AsInteger := QuitacaoPagamento;
      ParamByName('CHQ_CODFOR').AsInteger := CodigoFornecedor;
      ParamByName('CHQ_CODMHA').AsInteger := CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCheque.Descontar;
begin
  //Utiliza a mesa função do Deposito - Aguardar para implementar algo especifico quando for necessario
  Deposito;
end;


procedure TControllerCheque.ExportChequeDestino(P : TParamCheques);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  lC_Form: TRL_ReportChequeRastrearDestino;
begin
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;

  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Cheque Origem';

  // Cabeçalho 1º Linha
  Lc_Linha := 1;
  lC_Form := TRL_ReportChequeRastrearDestino.Create(Self);
  with Lc_Form do
  Begin
    Parametros := P;
    Buscar;
    Qr_Consulta.First;
    while not Qr_Consulta.Eof do
    begin
      Qr_Financeiro.Active := False;
      Qr_Financeiro.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Financeiro.Active := True;
      Qr_Financeiro.First;
      //Nome do Cliente
      Lc_StrCell := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nome do Cliente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Nome do Cliente
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := Qr_Financeiro.FieldByName('EMP_NOME').AsAnsiString;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      Lc_Linha := Lc_Linha + 1;

      //'N° Pedido';
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'N° Pedido';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Nota Fiscal';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nota Fiscal';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //N° Parcela';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'N° Parcela';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Data Pagto';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data Pagto';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Valor';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Financeiro.Eof do
      Begin
        //'N° Pedido';
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('PED_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Nota Fiscal';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('NFL_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //N° Parcela';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('FIN_NR_PARCELA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Data Pagto';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Financeiro.FieldByName('FIN_DT_PAGTO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //Valor';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsFloat,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Financeiro.Next;
      END;
      // Cheques relacionados
      Qr_Cheque.Active := False;
      Qr_Cheque.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Cheque.Active := True;
      Qr_Cheque.First;
      Lc_Linha := Lc_Linha + 1;
      //Data
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Emitente';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Emitente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Banco';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'Banco';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Agência';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Agência';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Nº Cheque';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nº Cheque';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Valor';
      Lc_StrCell := 'G' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Cheque.Eof do
      Begin
        //Data
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Cheque.FieldByName('CHQ_DATA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Emitente';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_EMITENTE').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Banco';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NR_BANCO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Agência';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_AGENCIA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Nº Cheque';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Valor';
        Lc_StrCell := 'G' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Cheque.FieldByName('CHQ_VALOR').AsFloat,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Cheque.Next;
      end;
      Qr_Consulta.Next;
      Lc_Linha := Lc_Linha + 2;
    end;
    Lc_Excel.Visible := true;
  end;
end;

procedure TControllerCheque.ExportChequeOrigem( P : TParamCheques);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell: string;
  Lc_Texto : String;
  Lc_Form: TRL_ReportChequeRastrearOrigem;
begin
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;

  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Cheque Origem';

  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Cheque Origem'];
  // Cabeçalho 1º Linha
  Lc_Linha := 1;
  Lc_Form := TRL_ReportChequeRastrearOrigem.Create(self);
  with Lc_Form do
  Begin
    Parametros := P;
    Buscar;
    Qr_Consulta.First;
    while not Qr_Consulta.Eof do
    begin
      Qr_Financeiro.Active := False;
      Qr_Financeiro.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Financeiro.Active := True;
      Qr_Financeiro.First;
      //Nome do Cliente
      Lc_StrCell := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nome do Cliente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Nome do Cliente
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := Qr_Financeiro.FieldByName('EMP_NOME').AsAnsiString;
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      Lc_Linha := Lc_Linha + 1;

      //'N° Pedido';
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'N° Pedido';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Nota Fiscal';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nota Fiscal';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //N° Parcela';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'N° Parcela';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

      //Data Pagto';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data Pagto';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //Valor';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Financeiro.Eof do
      Begin
        //'N° Pedido';
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('PED_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Nota Fiscal';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('NFL_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //N° Parcela';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Financeiro.FieldByName('FIN_NR_PARCELA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;

        //Data Pagto';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Financeiro.FieldByName('FIN_DT_PAGTO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //Valor';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Financeiro.FieldByName('FIN_VL_PARCELA').AsFloat,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Financeiro.Next;
      END;
      // Cheques relacionados
      Qr_Cheque.Active := False;
      Qr_Cheque.ParamByName('FIN_CODQTC').AsInteger := Qr_Consulta.FieldByName('FIN_CODQTC').AsInteger;
      Qr_Cheque.Active := True;
      Qr_Cheque.First;
      Lc_Linha := Lc_Linha + 1;
      //Data
      Lc_StrCell := 'B' + IntToStr(Lc_Linha);
      Lc_Texto := 'Data';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Emitente';
      Lc_StrCell := 'C' + IntToStr(Lc_Linha);
      Lc_Texto := 'Emitente';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Banco';
      Lc_StrCell := 'D' + IntToStr(Lc_Linha);
      Lc_Texto := 'Banco';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Agência';
      Lc_StrCell := 'E' + IntToStr(Lc_Linha);
      Lc_Texto := 'Agência';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Nº Cheque';
      Lc_StrCell := 'F' + IntToStr(Lc_Linha);
      Lc_Texto := 'Nº Cheque';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      //'Valor';
      Lc_StrCell := 'G' + IntToStr(Lc_Linha);
      Lc_Texto := 'Valor';
      Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
      Lc_Linha := Lc_Linha + 1;
      while not Qr_Cheque.Eof do
      Begin
        //Data
        Lc_StrCell := 'B' + IntToStr(Lc_Linha);
        Lc_Texto := ''''+Qr_Cheque.FieldByName('CHQ_DATA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Emitente';
        Lc_StrCell := 'C' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_EMITENTE').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Banco';
        Lc_StrCell := 'D' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NR_BANCO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Agência';
        Lc_StrCell := 'E' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_AGENCIA').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Nº Cheque';
        Lc_StrCell := 'F' + IntToStr(Lc_Linha);
        Lc_Texto := Qr_Cheque.FieldByName('CHQ_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        //'Valor';
        Lc_StrCell := 'G' + IntToStr(Lc_Linha);
        Lc_Texto := FloatToStrF(Qr_Cheque.FieldByName('CHQ_VALOR').AsFloat,ffFixed,10,2);
        Lc_Sheet.Range[Lc_StrCell, Lc_StrCell].Value := Lc_Texto;
        Lc_Linha := Lc_Linha + 1;
        Qr_Cheque.Next;
      end;
      Qr_Consulta.Next;
      Lc_Linha := Lc_Linha + 2;
    end;
    Lc_Excel.Visible := true;
  end;


end;


procedure TControllerCheque.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerCheque.ReportDevolvido(Operacao, Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeDevolvidos;
begin
  Try
    Lc_Form  := TRL_ReportChequeDevolvidos.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - DEVOLVIDOS';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;


procedure TControllerCheque.ReportDisponivelCaixa(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeDisponivelCaixa;
begin
  Try
    Lc_Form  := TRL_ReportChequeDisponivelCaixa.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - DISPONÍVEL NO CAIXA';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_Form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TControllerCheque.ReportEnvioBanco(Operacao, Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeEnvioBanco;
begin
  Try
    Lc_Form  := TRL_ReportChequeEnvioBanco.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - ENVIO AO BANCO DEPOSITO/CUSTÓDIA';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;


end;

procedure TControllerCheque.ReportEnvioFornecedor(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeEnvioFornecedor;
begin
  Try
    Lc_Form  := TRL_ReportChequeEnvioFornecedor.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - ENVIO FORNECEDOR';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta,Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;


end;

procedure TControllerCheque.ReportRastrearDestino(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeRastrearDestino;
begin
  Try
    Lc_Form  := TRL_ReportChequeRastrearDestino.Create(Self);
    Lc_Form.Parametros := P;
    if Operacao = 'I' then // IMPRIMIR
    Begin
      Lc_Form.Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - RASTREAR DESTINO';
      Lc_Form.Qrpt.Preview;
    end
    else // EXCEL
    Begin
      ExportChequeDestino(P);
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;

procedure TControllerCheque.ReportRastrearOrigem(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeRastrearOrigem;
begin
  Try
    Lc_Form  := TRL_ReportChequeRastrearOrigem.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - RASTREAR ORIGEM';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        ExportChequeOrigem(P);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;



procedure TControllerCheque.ReportRelacaoSimples(Operacao,Caminho: String;P : TParamCheques);
Var
  Lc_Form : TRL_ReportChequeSimples;
begin
  Try
    Lc_Form  := TRL_ReportChequeSimples.Create(Self);
    with Lc_Form do
    Begin
      Parametros := P;
      if Operacao = 'I' then // IMPRIMIR
      Begin
        Qrpt.ReportTitle := 'RELAÇÃO DE CHEQUES - SIMPLES';
        Qrpt.Preview;
      end
      else // EXCEL
      Begin
        Lc_form.Buscar;
        fr_Excel.Pc_Excel(Lc_Form.Qr_Consulta, Caminho);
      end;
    end;
  finally
    Lc_Form.Close;
    FreeAndNil(Lc_Form);
  end;
end;



function TControllerCheque.salva: boolean;
begin
  if ( Registro.Codigo = 0 ) then
    Registro.Codigo := Generator('GN_CHEQUES');
  SaveObj(Registro);

end;

end.
