unit RN_Financeiro;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,FireDAC.Stan.Param,
  StdCtrls,classes,db,TypInfo,STTransaction, Vcl.Dialogs;

  Function Fc_SaldoDevedorCliente(Pc_cd_Cliente:Integer):Real;
  Function Fc_SaldoCredorCliente(Pc_cd_Cliente:Integer):Real;
  Function Fc_SaldoChequePreDatado(Pc_cd_Cliente:Integer):Real;
  Function Fc_SaldoChequeDevolvido(Pc_cd_Cliente:Integer):Real;

  Function Fc_SaldoPorFormaPagamento(Fc_FormaPAgto:String;Fc_Cd_Cliente:Integer):Real;
  procedure Pc_GeraContasReceber(Pc_Transacao : TSTTransaction;
                                 Pc_Dt_Emissao:TDate;
                                 Pc_Cd_Pedido:Integer;
                                 Pc_Nr_Pedido:String;
                                 Pc_Cd_Nota:Integer;
                                 Pc_Nr_Nota:String;
                                 Pc_cd_Empresa:Integer;
                                 Pc_cd_FormaPagto:Integer;
                                 Pc_Qt_Parcela:Integer;
                                 Pc_Prazo:String;
                                 Pc_VL_Nota:Real);
  procedure Pc_GravaBoleto(Pc_CODIGO:Integer;
                          Pc_CODEMP:Integer;
                          Pc_NUMERO:String;
                          Pc_DATA:TDate;
                          Pc_CODCTB:Integer;
                          Pc_DESCONTO:String;
                          Pc_TX_DESCONTO:Real;
                          Pc_BAIXA:String;
                          Pc_VALOR:Real;
                          Pc_CODQTC:Integer;
                          Pc_VL_TARIFA:Real;
                          Pc_TX_MORA:Real;
                          Pc_CODBLE:Integer;
                          Pc_Dt_Vencimento:TDate);
  procedure Pc_AtivarFinanceiro(Pc_Cd_Financeiro:Integer;Pc_Situacao:Boolean);
  procedure Pc_Excluir_Contas_Financeiro(Pc_Tipo,Pc_cd_Pedido:Integer);
  procedure Pc_AtualizaPlanoContas(Pc_cd_Nota,Pc_Cta_Credito,Pc_Cta_Debito:Integer);

  procedure Pc_ProcessoBaixaFinanceiro(Pc_Vl_Recebido:Real; Pc_Dt_Pagto:TDate; Pc_Cd_Quitacao:Integer);

  procedure Pc_LancaDetalheCheque(Pc_Cd_Pedido:Integer; Pc_Emitente : String;Pc_Valor : Real; Pc_Dt_Vencimento : TdateTime; Nr_Parcela:Integer;Pc_Cd_Quitacao:Integer);
  procedure Pc_LancaDetalheCartao(Pc_CodigoCartao:Integer ;FormaPagto : String;Pc_Parcelas:Integer;Pc_Cd_Quitacao:Integer);
  procedure Pc_LancaValorCartao(CodigoCartao:Integer;PC_Valor:Real;Pc_Parcelas,Pc_cd_Quitacao:Integer;Pc_Nr_Pedido:String);
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet,
  Un_Regra_Negocio, Un_Stored_Procedures,
  RN_FormaPagto, tblCartao,
  ControllerCartao, main,ControllerBase;


Function Fc_SaldoDevedorCliente(Pc_cd_Cliente:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT FIN_VL_PARCELA, FIN_DT_VENCIMENTO '+
                   ' FROM TB_FINANCEIRO tb_financeiro '+
                   '    INNER JOIN TB_FORMAPAGTO tb_formapagto '+
                   '   ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG) '+
                   'WHERE (FIN_BAIXA = ''N'') AND (FIN_CODEMP=:FIN_CODEMP) AND '+
                   '((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'')) and (FIN_OPERACAO = ''C'') '+
                   ' AND ( FPT_DESCRICAO not liKe ''%DINHEIRO%'')  AND FIN_CODMHA=:FIN_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODEMP').AsInteger:= Pc_cd_Cliente;
      ParamByName('FIN_CODMHA').AsInteger:= Gb_CodMha;
      Active := True;
      First;
      Result := 0;
      Gb_SaldoVencido := False;
      while not Eof do
      Begin
        //Duplicatas a Vencidas
        if (FieldByName('FIN_DT_VENCIMENTO').asDateTime < Date) then
          Begin
          Gb_SaldoVencido := True;
          end;
        Result := Result  + FieldByName('FIN_VL_PARCELA').AsFloat;
        Next
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_SaldoCredorCliente(Pc_cd_Cliente:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT FIN_VL_PARCELA, FIN_DT_VENCIMENTO '+
                   ' FROM TB_FINANCEIRO tb_financeiro '+
                   '    INNER JOIN TB_FORMAPAGTO tb_formapagto '+
                   '   ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG) '+
                   'WHERE (FIN_BAIXA = ''N'') AND (FIN_CODEMP=:FIN_CODEMP) AND '+
                   '((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'')) and (FIN_OPERACAO = ''D'') '+
                   ' AND  ( FPT_DESCRICAO not liKe ''%DINHEIRO%'') AND FIN_CODMHA=:FIN_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODEMP').AsInteger:= Pc_cd_Cliente;
      ParamByName('FIN_CODMHA').AsInteger:= Gb_CodMha;
      Active := True;
      First;
      Result := 0;
      while not Eof do
      Begin
        Result := Result  + FieldByName('FIN_VL_PARCELA').AsFloat;
        Next
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


Function Fc_SaldoChequePreDatado(Pc_cd_Cliente:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT Distinct CHQ_NR_BANCO, CHQ_AGENCIA, CHQ_NUMERO, CHQ_EMITENTE, CHQ_VALOR '+
                   'FROM TB_CHEQUES Tb_cheques '+
                   '   INNER JOIN TB_FINANCEIRO tb_financeiro '+
                   '   ON  (tb_financeiro.FIN_CODQTC = Tb_cheques.CHQ_QT_REC) '+
                   'WHERE (CHQ_DATA>=:CHQ_DATA) AND(FIN_CODEMP=:FIN_CODEMP) AND (CHQ_QT_REC > 0) '+
                   'AND FIN_CODMHA =:FIN_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODEMP').AsInteger := Pc_cd_Cliente;
      ParamByName('CHQ_DATA').AsDateTime := date;
      ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      First;
      Result := 0;
      while not Eof do
      Begin
        Result := Result + FieldByName('CHQ_VALOR').AsFloat;
        Next
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_SaldoChequeDevolvido(Pc_cd_Cliente:Integer):Real;
Var
  Lc_Vl_cheque, Lc_Vl_Amortizado : Real;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  TRy
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT Distinct CHQ_NR_BANCO, CHQ_AGENCIA, CHQ_NUMERO, CHQ_EMITENTE, CHQ_VALOR, CHQ_VL_AMORT '+
                   'FROM TB_CHEQUES Tb_cheques '+
                   '   INNER JOIN TB_FINANCEIRO tb_financeiro '+
                   '   ON  (tb_financeiro.FIN_CODQTC = Tb_cheques.CHQ_QT_REC) '+
                   'WHERE (CHQ_DEVOLVIDO = ''S'') AND (FIN_CODEMP=:FIN_CODEMP) AND (CHQ_QT_REC > 0) AND FIN_CODMHA =:FIN_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODEMP').AsInteger := Pc_cd_Cliente;
      ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      First;
      Result := 0;
      Lc_Vl_cheque := 0;
      Lc_Vl_Amortizado := 0;
      while not Eof do
      Begin
        Lc_Vl_Amortizado := Lc_Vl_Amortizado + FieldByName('CHQ_VL_AMORT').AsFloat;
        Lc_Vl_cheque := Lc_Vl_cheque + FieldByName('CHQ_VALOR').AsFloat;
        Next;
      end;
      Result := Lc_Vl_cheque - Lc_Vl_Amortizado;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;





Function Fc_SaldoPorFormaPagamento(Fc_FormaPAgto:String;Fc_Cd_Cliente:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin

      Lc_SqlTxt := 'SELECT FIN_VL_PARCELA, FIN_DT_VENCIMENTO '+
                   ' FROM TB_FINANCEIRO tb_financeiro '+
                   '    INNER JOIN TB_FORMAPAGTO tb_formapagto '+
                   '   ON (tb_formapagto.FPT_CODIGO = tb_financeiro.FIN_CODFPG) '+
                   'WHERE (FIN_BAIXA = ''N'') AND (FIN_CODEMP=:FIN_CODEMP) AND '+
                   '((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'')) and (FIN_OPERACAO = ''D'') '+
                   ' AND (FPT_DESCRICAO=:FPT_DESCRICAO) AND FIN_CODMHA=:FIN_CODMHA ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FPT_DESCRICAO').AsAnsiString := Fc_FormaPAgto;
      ParamByName('FIN_CODEMP').AsInteger:= Fc_cd_Cliente;
      ParamByName('FIN_CODMHA').AsInteger:= Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      Result := 0;
      while not Eof do
      Begin
        Result := Result  + FieldByName('FIN_VL_PARCELA').AsFloat;
        Next;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_GeraContasReceber(Pc_Transacao : TSTTransaction;
                               Pc_Dt_Emissao:TDate;
                               Pc_Cd_Pedido:Integer;
                               Pc_Nr_Pedido:String;
                               Pc_Cd_Nota:Integer;
                               Pc_Nr_Nota:String;
                               Pc_cd_Empresa:Integer;
                               Pc_cd_FormaPagto:Integer;
                               Pc_Qt_Parcela:Integer;
                               Pc_Prazo:String;
                               Pc_VL_Nota:Real);
var
   Lc_St_Parcela: string;
   Lc_Vl_Parcela: Real;
   Lc_I, Lc_J: Integer;
   Lc_Prazo: string;
   Lc_Nr_Duplicata : String;

begin
  Pc_Define_FormatoRegional;
  if (Pc_Qt_Parcela = 0) then Pc_Qt_Parcela :=1;
  //Resolvemos o problema da Divisão e dizima periodica
  Lc_Vl_Parcela := Pc_VL_Nota / Pc_Qt_Parcela;
  Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela, ffFixed, 10, 2);
  Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
  for Lc_I := 0 to (Pc_Qt_Parcela - 1) do
    begin
    Lc_Prazo := Copy(Pc_Prazo, ((Lc_I * 4) + 7), 3);
    IF (Lc_I = Pc_Qt_Parcela) THEN
      Begin
      Lc_Vl_Parcela := Pc_VL_Nota -  (Lc_Vl_Parcela * (Pc_Qt_Parcela - 1));
      Lc_St_Parcela := FloatToStrF(Lc_Vl_Parcela,ffFixed,10,2);
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
      end
    else
      Begin
      Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,0);
      end;
    If TRim(Pc_Nr_Nota)<>'' then
      Lc_Nr_Duplicata := Pc_Nr_Pedido + '/' + Pc_Nr_Nota + '/' + IntToStr(Lc_I + 1) + '-' + IntToStr(Pc_Qt_Parcela)
    else
      Lc_Nr_Duplicata := Pc_Nr_Pedido + '/' + Pc_Nr_Pedido + '/' + IntToStr(Lc_I + 1) + '-' + IntToStr(Pc_Qt_Parcela);
    Pc_Financeiro( Pc_Transacao,
                  'I',
                  0,
                  Pc_cd_empresa,
                  Date,
                  Pc_Cd_Pedido,
                  Pc_Cd_Nota,
                  Pc_cd_FormaPagto,
                  Pc_Prazo,
                  Pc_Dt_Emissao + StrToIntDef(Lc_Prazo, 0),
                  Lc_Nr_Duplicata,
                  Lc_Vl_Parcela,
                  0,
                  0,
                  0,
                  0,
                  Date,
                  Date,
                  'N',
                  Lc_I,
                  'RA',
                  'D',
                  Fc_GeraCod_BAixa,
                  'C',
                  'N',
                   0);
    end;
end;

procedure Pc_GravaBoleto(Pc_CODIGO:Integer;
                          Pc_CODEMP:Integer;
                          Pc_NUMERO:String;
                          Pc_DATA:TDate;
                          Pc_CODCTB:Integer;
                          Pc_DESCONTO:String;
                          Pc_TX_DESCONTO:Real;
                          Pc_BAIXA:String;
                          Pc_VALOR:Real;
                          Pc_CODQTC:Integer;
                          Pc_VL_TARIFA:Real;
                          Pc_TX_MORA:Real;
                          Pc_CODBLE:Integer;
                          Pc_Dt_Vencimento:TDate);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'insert into TB_BOLETO '+
                   ' (BLT_CODIGO,BLT_CODEMP, BLT_NUMERO, BLT_DATA, BLT_CODCTB, BLT_DESCONTO, BLT_TX_DESCONTO, '+
                   'BLT_BAIXA, BLT_VALOR, BLT_CODQTC, BLT_VL_TARIFA, BLT_TX_MORA,BLT_CODBLE,BLT_DT_VENCIMENTO) '+
                   'values '+
                   '(:BLT_CODIGO,:BLT_CODEMP, :BLT_NUMERO, :BLT_DATA, :BLT_CODCTB, :BLT_DESCONTO, :BLT_TX_DESCONTO, '+
                   ':BLT_BAIXA, :BLT_VALOR, :BLT_CODQTC, :BLT_VL_TARIFA, :BLT_TX_MORA,:BLT_CODBLE,:BLT_DT_VENCIMENTO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('BLT_CODIGO').asinteger := Fc_Generator('GN_BOLETO','TB_BOLETO','BLT_CODIGO');
      ParamByName('BLT_CODEMP').asinteger := Pc_CODEMP;
      ParamByName('BLT_NUMERO').AsAnsiString := Pc_NUMERO;
      ParamByName('BLT_DATA').AsDate := Pc_DATA;
      ParamByName('BLT_CODCTB').asinteger := Pc_CODCTB;
      ParamByName('BLT_DESCONTO').AsAnsiString := Pc_DESCONTO;
      ParamByName('BLT_TX_DESCONTO').asfloat := 0;
      ParamByName('BLT_BAIXA').AsAnsiString := Pc_BAIXA;
      ParamByName('BLT_VALOR').asfloat := Pc_VALOR;
      ParamByName('BLT_CODQTC').asinteger := Pc_CODQTC;
      ParamByName('BLT_VL_TARIFA').asfloat := 0;
      ParamByName('BLT_TX_MORA').asfloat := 0;
      ParamByName('BLT_CODBLE').asinteger :=Pc_CODBLE;
      ParamByName('BLT_DT_VENCIMENTO').AsDate := Pc_Dt_Vencimento;
      ExecSql;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_AtivarFinanceiro(Pc_Cd_Financeiro:Integer;Pc_Situacao:Boolean);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  TRy
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'UPDATE TB_FINANCEIRO SET '+
                   'FIN_BAIXA =:FIN_BAIXA '+
                   'WHERE FIN_CODIGO =:FIN_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      if Pc_Situacao then
        ParamByName('FIN_BAIXA').AsAnsiString := 'N'
      else
        ParamByName('FIN_BAIXA').AsAnsiString := 'I';
      ParamByName('FIN_CODIGO').asinteger := Pc_Cd_Financeiro;
      ExecSql;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;



procedure Pc_Excluir_Contas_Financeiro(Pc_Tipo,Pc_cd_Pedido:Integer);
Var
  Lc_Sql_Txt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Sql_Txt := 'DELETE FROM TB_FINANCEIRO '+
                  'WHERE (FIN_CODPED =:FIN_CODPED) ';
      case Pc_Tipo of
        1:Lc_Sql_Txt := Lc_Sql_Txt + ' and (FIN_TIPO = ''RA'') ';
        2:Lc_Sql_Txt := Lc_Sql_Txt + ' and (FIN_TIPO = ''PA'') ';
        4:Lc_Sql_Txt := Lc_Sql_Txt + ' and (FIN_TIPO = ''RA'') ';
      END;
      SQL.Add(Lc_Sql_Txt);
      ParamByName('FIN_CODPED').AsInteger := Pc_cd_Pedido;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_AtualizaPlanoContas(Pc_cd_Nota,Pc_Cta_Credito,Pc_Cta_Debito:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'update tb_financeiro SET '+
                   'fin_plc_credito =:fin_plc_credito, '+
                   'fin_plc_debito =:fin_plc_debito '+
                   'where FIN_CODNFL =:FIN_CODNF';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FIN_CODNF').AsInteger:= Pc_cd_Nota;
      ParamByName('fin_plc_credito').AsInteger:= Pc_Cta_Credito;
      ParamByName('fin_plc_debito').AsInteger:= Pc_Cta_Debito;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_ProcessoBaixaFinanceiro(Pc_Vl_Recebido:Real; Pc_Dt_Pagto:TDate; Pc_Cd_Quitacao:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_VL_PAGO =:FIN_VL_PAGO, '+
              'FIN_DT_PAGTO =:FIN_DT_PAGTO, '+
              'FIN_DT_BAIXA =:FIN_DT_BAIXA, '+
              'FIN_BAIXA =:FIN_BAIXA '+
              'WHERE FIN_CODQTC =:FIN_CODQTC ');

      ParamByName('FIN_VL_PAGO').AsFloat := Pc_Vl_Recebido;
      ParamByName('FIN_DT_PAGTO').AsDate := Pc_Dt_Pagto;
      ParamByName('FIN_DT_BAIXA').AsDate := Date;
      ParamByName('FIN_BAIXA').AsString := 'S';
      ParamByName('FIN_CODQTC').AsInteger := Pc_Cd_Quitacao;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;



procedure Pc_LancaDetalheCheque(Pc_Cd_Pedido:Integer; Pc_Emitente : String; Pc_Valor : Real; Pc_Dt_Vencimento : TdateTime; Nr_Parcela:Integer; Pc_Cd_Quitacao:Integer);
//Var
//  Lc_Form : TFr_DadosCheques;
Begin
  ShowMessage('Revisar');
//  Try
//    Lc_Form := TFr_DadosCheques.Create(nil);
//    Lc_Form.It_Confirma := False;
//    Repeat
//      with Lc_Form do
//      Begin
//        E_Emitente.Text := Pc_Emitente;
//        E_VL_Cheque.Text := FloatToStrF(Pc_Valor,ffFixed,10,2);
//        E_Data.Text := DateToStr(Pc_Dt_Vencimento);
//        CodigoPedido := Pc_Cd_Pedido;
//        CodigoQuitacao := Pc_Cd_Quitacao;
//        E_BandeiraCartao.Caption := IntToStr(Nr_Parcela) + 'º - PARCELA';
//        ShowModal;
//      End;
//    until Lc_Form.It_Confirma;
//  Finally
//    Lc_Form.disposeof;
//  End;
End;

procedure Pc_LancaDetalheCartao(Pc_CodigoCartao:Integer;FormaPagto : String; Pc_Parcelas:Integer; Pc_Cd_Quitacao:Integer);
//Var
//  Lc_Form : TFr_DadosCartaoEletronico;
Begin
  ShowMessage('Revisar');
//  Try
//    Lc_Form := TFr_DadosCartaoEletronico.Create(nil);
//    Lc_Form.It_Confirma := False;
//    Repeat
//      with Lc_Form do
//      Begin
//        CodigoCartao := Pc_CodigoCartao;
//        NumeroParcelas := Pc_Parcelas;
//        CodigoQuitacao := Pc_Cd_Quitacao;
//        E_BandeiraCartao.Caption := FormaPagto;
//        ShowModal;
//      End;
//    until Lc_Form.It_Confirma;
//  Finally
//    Lc_Form.DisposeOf;
//  End;

End;


procedure Pc_LancaValorCartao(CodigoCartao:Integer;PC_Valor:Real;Pc_Parcelas,Pc_cd_Quitacao:Integer;Pc_Nr_Pedido:String);
Var
  Lc_I : Integer;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_Vl_Desconto : Real;
  Lc_Aliq:Real;
  Lc_Data : TDate;
  Lc_Cartao : TControllerCartao;
  Lc_ContaResultado : Integer;
  Lc_CentroCusto : Integer;
  Lc_StrDupl : String;
Begin
  try
    Lc_Cartao := TControllerCartao.Create(nil);

    if (Fc_Tb_Geral('L','FIN_OB_INFO_CARTAO_FATURAMENTO','N') = 'N') then
    begin
      with Lc_Cartao do
      Begin
        Registro.Estabelecimento := Gb_CodMha;
        Registro.CodigoCartao := CodigoCartao;
        Registro.Identificacao := '';
        Registro.Autorizacao := '';
        Registro.Validade := Date;
        Registro.NumeroParcela := Pc_Parcelas;
        Registro.CodigoQuitacaoRec := Pc_cd_Quitacao;
        Registro.CodigoQuitacaoPag := 0;
      End;
      Lc_Cartao.Insere;
    End;

    Lc_Cartao.Eletronico.Registro.Codigo := CodigoCartao;
    Lc_Cartao.Eletronico.getByKey;
    Lc_Cartao.Eletronico.FormaPagto.Registro.Codigo := Lc_Cartao.Eletronico.Registro.FormaPagamento;
    Lc_Cartao.Eletronico.FormaPagto.getById;
    //Resolvemos o problema da Divisão e dizima periodica
    Lc_St_Parcela := FloatToStrF((Pc_Valor / Pc_Parcelas),ffFixed,10,2);
    //Lancamento no Banco
    For Lc_I := 1 to Pc_Parcelas do
    Begin
      Lc_StrDupl := concat(
                      Lc_Cartao.Eletronico.FormaPagto.Registro.Descricao  ,' | ',
                      'Pedido: ' , Pc_Nr_Pedido , ' | PARCELA: ' , IntToStr(Lc_I)+'/'+IntToStr(Pc_Parcelas)
                      );
      if ( Pc_Parcelas = 1 ) then
        Lc_Data := date + ( Lc_Cartao.Eletronico.Registro.PrazoCredito * Lc_I)
      else
        Lc_Data := date + ( Lc_Cartao.Eletronico.Registro.PrazoDebito * Lc_I);

      if not (Lc_I = Pc_Parcelas) then
        Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,1)
      else
        Lc_Vl_Parcela :=(Pc_Valor -(StrToFloatDef(Lc_St_Parcela,0) * (Pc_Parcelas-1)));

      //Centro de Custo observando a primeira coluna
      Lc_CentroCusto := Fc_PegaCentroCustoFormaPagto ( Lc_Cartao.Eletronico.Registro.FormaPagamento );
      //Conta de resultado registrado no cadastro do cartão
      Lc_ContaResultado :=  Lc_Cartao.Eletronico.Registro.PlanoCredito;

      Pc_Movim_Financeiro( dm.IB_Transacao,
                          'I',
                          0,
                          Lc_Cartao.Eletronico.Registro.ContaCorrente,
                          Lc_data,
                          1,
                          Lc_ContaResultado,
                          Lc_CentroCusto,
                          Lc_Vl_Parcela,
                          0,
                          Lc_StrDupl,
                          'C',
                          Pc_Cd_Quitacao,
                          Gb_Cd_Usuario,
                          0,
                          Lc_data,
                          '',
                          'N',
                          'S',
                          Gb_CodMha,
                          Lc_Cartao.Eletronico.Registro.FormaPagamento);

      if ( Pc_Parcelas = 1 ) then
      Begin
        Lc_Data := date + ( Lc_Cartao.Eletronico.Registro.PrazoCredito * Lc_I);
        Lc_Aliq := Lc_Cartao.Eletronico.Registro.AliqCredito / 100;
      end
      else
      Begin
        Lc_Data := date + ( Lc_Cartao.Eletronico.Registro.PrazoDebito * Lc_I );
        Lc_Aliq := ( Lc_Cartao.Eletronico.Registro.AliqDebito /100 );
      end;

      if not ( Lc_I = Pc_Parcelas ) then
        Lc_Vl_Desconto := StrToFloatDef(Lc_St_Parcela,1) * Lc_Aliq
      else
        Lc_Vl_Desconto :=(Pc_Valor -(StrToFloatDef(Lc_St_Parcela,0) * (Pc_Parcelas-1))) * Lc_Aliq;

      //Centro de Custo registrado no cadastro do cartão
      Lc_CentroCusto :=  Lc_Cartao.Eletronico.Registro.PlanoDebito;
      //Conta de resultado registrado no cadastro do cartão
      Lc_ContaResultado :=  Lc_Cartao.Eletronico.Registro.PlanoCredito;
      Lc_StrDupl := concat(
                      Lc_Cartao.Eletronico.FormaPagto.Registro.Descricao ,' | ',
                      'Pedido: ' , Pc_Nr_Pedido , ' Taxa Desconto - | PARCELA: ' , IntToStr(Lc_I)+'/'+IntToStr(Pc_Parcelas)
                      );
      Pc_Movim_Financeiro(dm.IB_Transacao,
                          'I',
                          0,
                          Lc_Cartao.Eletronico.Registro.ContaCorrente,
                          Lc_data,
                          1,
                          Lc_ContaResultado,
                          Lc_CentroCusto,
                          0,
                          Lc_Vl_Desconto,
                          Lc_StrDupl,
                          'C',
                          Pc_Cd_Quitacao,
                          Gb_Cd_Usuario,
                          0,
                          Lc_data,
                          '',
                          'N',
                          'S',
                          Gb_CodMha,
                          Lc_Cartao.Eletronico.Registro.FormaPagamento);
    end;
  finally
    Lc_Cartao.DisposeOf;
  end;
end;


end.


