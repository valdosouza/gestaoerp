{------------------------------------------------------------
 Funcao : Esta unidade contêm uma biblioteca de funções
 para controlar as Stored procedures
 -----------------------------------------------------------}
unit Un_stored_procedures;

interface

uses
  ControllerComissao, STStoredProc, STDatabase, SysUtils,STTransaction,
  STQuery,Datasnap.DBClient, Vcl.Dialogs, ControllerItensICMS,ControllerBase,
  ControllerItensNFL,FireDAC.Stan.Param;

  {A}

Function GeraStored():TSTTransaction;

function Fc_AtualizaItensNfl( Pc_Transacao : TSTTransaction;
                              Pc_Operacao: string;
                              Pc_Cd_Item: Integer;
                              Pc_Cd_Pedido: Integer;
                              Pc_Cd_Nota: Integer;
                              Pc_Cd_Produto: Integer;
                              Pc_Qtde: Real;
                              Pc_VL_Custo: Real;
                              Pc_VL_Unitario: Real;
                              Pc_AQ_Desconto: Real;
                              Pc_VL_Desconto: Real;
                              Pc_Aliq_COM: Real;
                              Pc_OPER: string;
                              Pc_Estoque: string;
                              Pc_Despacho: string;
                              Pc_Aliq_IPI: Real;
                              Pc_Aliq_ICMS: Real;
                              Pc_Cd_Estoque: Integer;
                              Pc_Cd_Tabela: Integer;
                              Pc_sentido:String;
                              Pc_Imp_Aprox:Real;
                              Pc_Largura:Real;
                              Pc_Altura:Real):Integer;



{B}

procedure Pc_Comissao(Pc_Transacao : TSTTransaction;
                      Pc_Data: TDate;
                      Pc_Cd_Pedido: Integer;
                      Pc_Cd_Financeiro: Integer;
                      Pc_Cd_Empresa: Integer;
                      Pc_Cd_Vendedor: Integer;
                      Pc_Vl_Documento: Real;
                      Pc_Vl_Comissao: Real;
                      Pc_Tipo:String);                     

{E}


{F}
procedure Pc_Fr_FichaTecnica(Pc_Operacao : String;
                             Pc_Cd_ficha : Integer;
                             Pc_tipo : String;
                             Pc_Cd_Ict:Integer;
                             Pc_Cd_Itf:Integer;
                             Pc_Codvcl : Integer;
                             Pc_Produto : String;
                             Pc_Unidade : String;
                             Pc_Vl_Unit : real;
                             Pc_Cs_Unit : real;
                             Pc_Tx_Partic : real;
                             Pc_CodPro :integer);

procedure Pc_Financeiro(Pc_Transacao : TSTTransaction;
                         Pc_Oper_reg: string;
                         Pc_CODIGO: Integer;
                         Pc_CODEMP: Integer;
                         Pc_DATA: TDate;
                         Pc_CODPED: Integer;
                         Pc_CODNFL: Integer;
                         Pc_CODFPG: Integer;
                         Pc_PRAZO: string;
                         Pc_DT_VENCIMENTO: TDate;
                         Pc_NUMERO: string;
                         Pc_VL_PARCELA: Real;
                         Pc_VL_JUROS: Real;
                         Pc_VL_MORA: Real;
                         Pc_VL_DESCONTO: Real;
                         Pc_VL_PAGO: Real;
                         Pc_DT_PAGTO: TDate;
                         Pc_DT_BAIXA: TDate;
                         Pc_BAIXA: string;
                         Pc_NR_PARCELA: Integer;
                         Pc_TIPO: string;
                         Pc_SITUACAO: string;
                         Pc_CODQTC: Integer;
                         PC_Operacao: string;
                         Pc_Etapa: string;
                         Pc_cd_Cheque : Integer);

{L}
procedure Pc_Log_Sistema( pc_log_codmha    : Integer;
                          pc_log_codusu    : Integer;
                          pc_log_timeStamp : TDateTime;
                          pc_log_interface : String;
                          pc_log_registro  : Integer;
                          pc_log_operacao  : String;
                          pc_log_descricao : String );
{M}
procedure Pc_Movim_Financeiro(Pc_Transacao : TSTTransaction;
                              PC_OPERACAO : String;
                              PC_CODIGO : Integer;
                              PC_CODCTB : Integer;
                              PC_DATA : TDate;
                              PC_CODHTB : Integer;
                              PC_CODPLC_C : Integer;
                              PC_CODPLC_D : Integer;
                              PC_VL_CREDITO :Real;
                              PC_VL_DEBITO :Real;
                              PC_HISTORISCO : String;
                              PC_TIPO : String;
                              PC_CODQTC : Integer;
                              PC_CODUSU : Integer;
                              PC_VL_FUTURO :Real;
                              PC_DT_ORIG : TDate;
                              PC_NR_DOC : String;
                              PC_CONFERIDO : String;
                              PC_ESPECIE : String;
                              PC_CODMHA : Integer;
                              PC_CODFPT : Integer);

{N}
procedure Pc_NotaFiscal(Pc_Transacao : TSTTransaction;
                        Pc_Cd_Nota : Integer;
                        Pc_Tp_Operacao : String;
                        Pc_Finalidade:Integer;
                        Pc_Nr_Nota : String;
                        Pc_Serie : Integer;
//                        /Pc_Modelo : String;
                        Pc_Cd_CFOP : Integer;
                        Pc_Cd_Pedido : Integer;
                        Pc_Cd_Empresa : Integer;
                        Pc_Dt_Emissao : TDate;
                        Pc_Dt_Saida : String;
                        Pc_Time :TTime;
                        Pc_VL_Bs_ICMS : Real;
                        Pc_VL_ICMS : Real;
                        Pc_Vl_Bs_Icms_St : Real;
                        Pc_Vl_Icms_St : Real;
                        Pc_VL_Produto : Real;
                        Pc_VL_Frete : Real;
                        Pc_Vl_Seguro : Real;
                        PC_Vl_Outras : Real;
                        Pc_VL_IPI : Real;
                        PC_VL_Nota : Real;
                        Pc_Cd_Transporte : Integer;
                        Pc_Cta_Frete : Integer;
                        Pc_Qt_Produto : Real;
                        Pc_Especie : String;
                        Pc_Marca : String;
                        PC_PesoBruto : String;
                        PC_PesoLiq : String;
                        Pc_Ctrl_Retorno : String;
                        Pc_Nfl_Vinculo : String;
                        Pc_Status : String;
                        Pc_VL_TL_Servicos : Real;
                        Pc_VL_ISS : Real;
                        Pc_Nr_Volume : String;
                        PC_PlacaVeiculo : String;
                        Pc_Uf_Veiculo : String;
                        Pc_RNTC : String;
                        Pc_CodMha : Integer);
{O}
procedure Pc_Observacao(Pc_Transacao : TSTTransaction;
                        Pc_Operacao : String;
                        Pc_CODIGO : Integer;
                        Pc_CODITF : Integer;
                        Pc_CODNFL : Integer;
                        Pc_TIPO : String;
                        Pc_DETALHE : String);


{V}


implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_Regra_Negocio, main,RI_MovimentoFinanceiro;


{A}
Function GeraStored():TSTTransaction;
begin
  Result := TSTTransaction.Create(nil);
  Result.Connection := DM.IBD_Gestao;
end;


Function Fc_AtualizaItensNfl(Pc_Transacao : TSTTransaction;
                              Pc_Operacao: string;
                              Pc_Cd_Item: Integer;
                              Pc_Cd_Pedido: Integer;
                              Pc_Cd_Nota: Integer;
                              Pc_Cd_Produto: Integer;
                              Pc_Qtde: Real;
                              Pc_VL_Custo: Real;
                              Pc_VL_Unitario: Real;
                              Pc_AQ_Desconto: Real;
                              Pc_VL_Desconto: Real;
                              Pc_Aliq_COM: Real;
                              Pc_OPER: string;
                              Pc_Estoque: string;
                              Pc_Despacho: string;
                              Pc_Aliq_IPI: Real;
                              Pc_Aliq_ICMS: Real;
                              Pc_Cd_Estoque: Integer;
                              Pc_Cd_Tabela: Integer;
                              pc_sentido:String;
                              Pc_Imp_Aprox:Real;
                              Pc_Largura:Real;
                              Pc_Altura:Real):Integer;
Var
  Lc_Item : TControllerItensNFL;
begin
  Lc_Item := TControllerItensNFL.Create(nil);
  Try
    Try
      with Lc_Item.Registro do
      Begin
        Codigo            := Pc_Cd_Item;
        Sequencia         := 0;
        CodigoPedido      := Pc_Cd_Pedido;
        CodigoNota        := 0;
        CodigoProduto     := Pc_Cd_Produto;
        Quantidade        := Pc_Qtde;
        ValorCusto        := Pc_Vl_custo;
        ValorUnitario     := Pc_Vl_Unitario;
        Despachar         := 'N';
        Estoque           := Pc_Estoque;
        AliqComissao      := Pc_Aliq_COM;
        ValorDesconto     := Pc_VL_Desconto;
        AliqDesconto      := Pc_AQ_Desconto;
        AliqIPI           := Pc_Aliq_IPI;
        Operacao          := Pc_OPER;
        AliqICMS          := Pc_Aliq_ICMS;
        CodigoEstoque     := Pc_Cd_Estoque;
        CodigoTabela      := Pc_Cd_Tabela;
        Altura            := Pc_ALtura;
        Largura           := Pc_Largura;
        Sentido           := Pc_Sentido;
        PedidoCompra      := '';
        ItemCompra        := '';
        ImpostoAproximado := Pc_Imp_Aprox;
        NumeroPecas       := 0;
      End;
      if Pc_Cd_Item = 0 then
      Begin
        lc_Item.insere;
      end
      else
      Begin
        lc_Item.atualiza;
      end;
      Result := lc_Item.Registro.Codigo;
    except
      on E : Exception do
      Begin
        MensagemPararExecucao('Por favor Informe este erro ao Desenvolvedor.' + EOLN +
                               'V2: ' + E.Message);
        DM.Sp_Itens_Nfl.Active := False;
        Result := 0;
    End;
  end;
  Finally
    Lc_Item.DisposeOf;
  End;
  {
  with DM.Sp_Itens_Nfl do
  Begin
    Active :=False;
    Transaction := Pc_Transacao;
    if Pc_Cd_Item = 0 then
    Begin
      Pc_Operacao := 'I';
      Pc_Cd_Item := Fc_Generator('GN_ITENS_NFL','','ITF_CODIGO');
    end
    else
    Begin
      Pc_Operacao := 'E';
    end;

    ForcedRefresh := True;
    ParamByName('ITF_OPER_REG').Value := Pc_Operacao;
    ParamByName('ITF_CODIGO').Value := Pc_Cd_Item;
    ParamByName('ITF_CODPED').Value := Pc_Cd_Pedido;
    ParamByName('ITF_CODNFL').Value := Pc_Cd_Nota;
    ParamByName('ITF_CODPRO').Value := Pc_Cd_Produto;
    ParamByName('ITF_QTDE').Value := Pc_Qtde;
    ParamByName('ITF_VL_CUSTO').Value := Pc_VL_Custo;
    ParamByName('ITF_VL_UNIT').Value := Pc_VL_Unitario;
    ParamByName('ITF_AQ_DESC').Value := Pc_AQ_Desconto;
    ParamByName('ITF_VL_DESC').Value := Pc_VL_Desconto;
    ParamByName('ITF_AQ_COM').Value := Pc_Aliq_COM;
    ParamByName('ITF_OPER').Value := Pc_OPER;
    ParamByName('ITF_ESTOQUE').Value := Pc_Estoque;
    ParamByName('ITF_DESPACHO').Value := Pc_Despacho;
    ParamByName('ITF_AQ_IPI').Value := Pc_Aliq_IPI;
    ParamByName('ITF_AQ_ICMS').Value := Pc_Aliq_ICMS;
    ParamByName('ITF_CODEST').Value := Pc_Cd_Estoque;
    ParamByName('ITF_CODTPR').Value := Pc_Cd_Tabela;
    ParamByName('ITF_ALTURA').Value := Pc_Altura;
    ParamByName('ITF_LARGURA').Value := Pc_Largura;
    ParamByName('ITF_SENTIDO').Value := Pc_sentido;
    ParamByName('ITF_IMP_APROX').Value := Pc_Imp_Aprox;
  end;
  try
    DM.Sp_Itens_Nfl.ExecProc;
    if DM.Sp_Itens_Nfl.Transaction.InTransaction then DM.Sp_Itens_Nfl.Transaction.CommitRetaining;
    Result := Pc_Cd_Item;
  except
    on E : Exception do
    Begin
      MensagemPararExecucao('Por favor Informe este erro ao Desenvolvedor.');
      DM.Sp_Itens_Nfl.Active := False;
      Result := 0;
    End;
  end;
  }
end;


{B}

{C}

procedure Pc_Comissao(Pc_Transacao : TSTTransaction;
                      Pc_Data: TDate;
                      Pc_Cd_Pedido: Integer;
                      Pc_Cd_Financeiro: Integer;
                      Pc_Cd_Empresa: Integer;
                      Pc_Cd_Vendedor: Integer;
                      Pc_Vl_Documento: Real;
                      Pc_Vl_Comissao: Real;
                      Pc_Tipo:String);
Var
  LcComissao : TControllerComissao;
begin
  LcComissao := TControllerComissao.create(nil);
  TRy
    with LcComissao.registro do
    BEgin
      Codigo          := 0;
      DataVenda       := Pc_Data;;
      Pedido          := Pc_Cd_Pedido;
      Cliente         := Pc_Cd_Empresa;
      Vendedor        := Pc_Cd_Vendedor;
      valorDocumento  := Pc_Vl_Documento;
      if (Pc_Vl_Documento <> 0) then
        Aliquota := (Pc_Vl_Comissao / Pc_Vl_Documento) * 100
      else
        Aliquota := (Pc_Vl_Comissao / 1) * 100;
      valorComissao   := Pc_Vl_Comissao;
      Estabelecimento := Gb_CodMha;
      DataPagto       := 0;
      Financeiro      := Pc_Cd_Financeiro;
      Tipo            := Pc_Tipo;
    End;
    LcComissao.Insert;
  Finally
    FreeAndNil( LcComissao );
  End;
end;

{E}

{F}
procedure Pc_Fr_FichaTecnica(Pc_Operacao : String;
                             Pc_Cd_ficha : Integer;
                             Pc_tipo : String;
                             Pc_Cd_Ict:Integer;
                             Pc_Cd_Itf:Integer;
                             Pc_Codvcl : Integer;
                             Pc_Produto : String;
                             Pc_Unidade : String;
                             Pc_Vl_Unit : real;
                             Pc_Cs_Unit : real;
                             Pc_Tx_Partic : real;
                             Pc_CodPro :integer);
Var
   Lc_Sp_FichaTecnica : TSTStoredProc;
begin
  Lc_Sp_FichaTecnica := TSTStoredProc.create(nil);
  try
    with Lc_Sp_FichaTecnica do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := GeraStored;
      StoredProcName :=  'SP_FICHA_TECNICA';
      if Pc_Operacao = 'I' then Pc_Cd_ficha := Fc_Generator('GN_FICHA_TECNICA','','FTC_CODIGO');
      ParamByName('FTC_OPER_REG').AsString := Pc_Operacao;
      ParamByName('FTC_CODIGO').AsInteger := Pc_Cd_ficha;
      ParamByName('FTC_CODICT').AsInteger := Pc_Cd_Ict;
      ParamByName('FTC_CODITF').AsInteger := Pc_Cd_Itf;
      ParamByName('FTC_TIPO').AsString := Pc_Tipo;
      ParamByName('FTC_CODVCL').AsInteger := Pc_CodVcl;
      ParamByName('FTC_DESC_INSUMO').AsString := Pc_Produto;
      ParamByName('FTC_UND').AsString := Pc_Unidade;
      ParamByName('FTC_VL_UNIT').AsFloat := Pc_Vl_Unit;
      ParamByName('FTC_CS_UNIT').AsFloat := Pc_Cs_Unit;
      ParamByName('FTC_TX_PARTIC').AsFloat := Pc_Tx_Partic;
      ParamByName('FTC_CODPRO').AsInteger := Pc_CodPro;
      ExecProc;
      if Transaction.InTransaction then  Transaction.CommitRetaining;
    end;
  finally
    Lc_Sp_FichaTecnica.Close;
    Lc_Sp_FichaTecnica.Transaction.DisposeOf;
    Lc_Sp_FichaTecnica.DisposeOf;
  end;
end;

procedure Pc_Financeiro(Pc_Transacao : TSTTransaction;
                         Pc_Oper_reg: string;
                         Pc_CODIGO: Integer;
                         Pc_CODEMP: Integer;
                         Pc_DATA: TDate;
                         Pc_CODPED: Integer;
                         Pc_CODNFL: Integer;
                         Pc_CODFPG: Integer;
                         Pc_PRAZO: string;
                         Pc_DT_VENCIMENTO: TDate;
                         Pc_NUMERO: string;
                         Pc_VL_PARCELA: Real;
                         Pc_VL_JUROS: Real;
                         Pc_VL_MORA: Real;
                         Pc_VL_DESCONTO: Real;
                         Pc_VL_PAGO: Real;
                         Pc_DT_PAGTO: TDate;
                         Pc_DT_BAIXA: TDate;
                         Pc_BAIXA: string;
                         Pc_NR_PARCELA: Integer;
                         Pc_TIPO: string;
                         Pc_SITUACAO: string;
                         Pc_CODQTC: Integer;
                         PC_Operacao: string;
                         Pc_Etapa: string;
                         Pc_cd_Cheque : Integer);
Var
   Lc_Sp_Financeiro : TSTStoredProc;
begin
  Lc_Sp_Financeiro := TSTStoredProc.create(nil);
  TRy
    with Lc_Sp_Financeiro do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := GeraStored;
      StoredProcName :=  'SP_FINANCEIRO';
      ForcedRefresh := True;
      ParamByName('FIN_OPER_REG').AsString := Pc_Oper_reg;
      ParamByName('FIN_CODIGO').AsInteger := Pc_CODIGO;
      ParamByName('FIN_CODEMP').AsInteger := Pc_CODEMP;
      ParamByName('FIN_DATA').AsDate := Pc_DATA;
      ParamByName('FIN_CODPED').AsInteger := Pc_CODPED;
      ParamByName('FIN_CODNFL').AsInteger := Pc_CODNFL;
      ParamByName('FIN_CODFPG').AsInteger := Pc_CODFPG;
      ParamByName('FIN_PRAZO').AsString := Pc_PRAZO;
      ParamByName('FIN_DT_VENCIMENTO').AsDate := Pc_DT_VENCIMENTO;
      ParamByName('FIN_NUMERO').AsString := Pc_NUMERO;
      ParamByName('FIN_VL_PARCELA').AsFloat := Pc_VL_PARCELA;
      ParamByName('FIN_VL_JUROS').AsFloat := Pc_VL_JUROS;
      ParamByName('FIN_VL_MORA').AsFloat := Pc_VL_MORA;
      ParamByName('FIN_VL_DESCONTO').AsFloat := Pc_VL_DESCONTO;
      ParamByName('FIN_VL_PAGO').AsFloat := Pc_VL_PAGO;
      if (Pc_Oper_reg = 'I') and (Pc_BAIXA = 'N') then
        begin
        ParamByName('FIN_DT_PAGTO').AsString := '';
        ParamByName('FIN_DT_BAIXA').AsString := '';
        end
      else
        begin
        ParamByName('FIN_DT_PAGTO').AsDate := Pc_DT_PAGTO;
        ParamByName('FIN_DT_BAIXA').AsDate := Pc_DT_BAIXA;
        end;
      ParamByName('FIN_BAIXA').AsString := Pc_BAIXA;
      ParamByName('FIN_NR_PARCELA').AsInteger := Pc_NR_PARCELA;
      ParamByName('FIN_TIPO').AsString := Pc_TIPO;
      ParamByName('FIN_SITUACAO').AsString := Pc_SITUACAO;
      ParamByName('FIN_CODQTC').AsInteger := Pc_CODQTC;
      ParamByName('FIN_OPERACAO').AsString := PC_Operacao;
      ParamByName('FIN_ETAPA').AsString := pc_Etapa;
      ParamByName('FIN_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('FIN_CODCHQ').AsInteger := Pc_cd_Cheque;
      Try
        if not Transaction.InTransaction then Transaction.StartTransaction;
        ExecProc;
        if Transaction.InTransaction then Transaction.Commit;
      Except
        on E : Exception do
        MensagemPararExecucao('Um erro impossibilitou a execução da tarefa.' + EOLN +
                               E.ClassName + EOLN+
                               E.Message + EOLN);
      end;
    end;
  Finally
    Lc_Sp_Financeiro.Close;
    Lc_Sp_Financeiro.Transaction.DisposeOf;
    Lc_Sp_Financeiro.DisposeOf;
  End;
end;

{L}
procedure Pc_Log_Sistema( pc_log_codmha    : Integer;
                          pc_log_codusu    : Integer;
                          pc_log_timeStamp : TDateTime;
                          pc_log_interface : String;
                          pc_log_registro  : Integer;
                          pc_log_operacao  : String;
                          pc_log_descricao : String );
Var
  Lc_Log_Operacao : TSTStoredProc;
begin
  Lc_Log_Operacao := TSTStoredProc.create(nil);
  Try
    with Lc_Log_Operacao do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := GeraStored;
      ForcedRefresh := True;
      StoredProcName := 'SP_LOG_OPERACAO';
      // Incluí LOG no Login
      ParamByName('LOG_CODIGO').AsInteger     := Fc_Generator('GN_LOG_OPERACAO','','LOG_CODIGO');  //--> Código da log
      ParamByName('LOG_CODMHA').AsInteger     := pc_log_codmha;        //--> Código da Empresa
      ParamByName('LOG_CODUSU').AsInteger     := pc_log_codusu;        //--> Código do Usuário
      ParamByName('Log_timestamp').AsDateTime :=  pc_log_timeStamp;     //--> A hora e data Atual
      ParamByName('LOG_INTERFACE').AsString   := pc_log_interface;     //--> Nome da tela
      ParamByName('LOG_REGISTRO').AsInteger    := pc_log_registro;     //--> Chave prmimara da Tabela Relacionada
      ParamByName('LOG_OPERACAO').AsString    := copy(pc_log_operacao,1,30);      //--> Tipo de Modificação
      ParamByName('LOG_DESCRICAO').AsString   := Copy(pc_log_descricao,1,100);     //--> Descrição operação realizada
      Try
       if not Transaction.InTransaction then  Transaction.StartTransaction;
        ExecProc;
        if Transaction.InTransaction then  Transaction.Commit;
      Except
        on E : Exception do
        MensagemPararExecucao('Um erro impossibilitou a gravação dos Log(s).' + EOLN +
                               E.ClassName + EOLN+
                               E.Message + EOLN);
      end;
    end;
  Finally
    Lc_Log_Operacao.Close;
    Lc_Log_Operacao.Transaction.DisposeOf;
    Lc_Log_Operacao.DisposeOf;
  End;

end;

{M}
procedure Pc_Movim_Financeiro(Pc_Transacao : TSTTransaction;
                              PC_OPERACAO : String;
                              PC_CODIGO : Integer;
                              PC_CODCTB : Integer;
                              PC_DATA : TDate;
                              PC_CODHTB : Integer;
                              PC_CODPLC_C : Integer;
                              PC_CODPLC_D : Integer;
                              PC_VL_CREDITO :Real;
                              PC_VL_DEBITO :Real;
                              PC_HISTORISCO : String;
                              PC_TIPO : String;
                              PC_CODQTC : Integer;
                              PC_CODUSU : Integer;
                              PC_VL_FUTURO :Real;
                              PC_DT_ORIG : TDate;
                              PC_NR_DOC : String;
                              PC_CONFERIDO : String;
                              PC_ESPECIE : String;
                              PC_CODMHA : Integer;
                              PC_CODFPT : Integer);
Var
   Lc_Sp_Movim_Finaceiro : TSTStoredProc;
begin
  Lc_Sp_Movim_Finaceiro := TSTStoredProc.create(nil);
  Try
    IF Gb_DataCaixa = 0 then
    Begin
      Fc_VerificaCaixaAberto(False);
    End;

    with Lc_Sp_Movim_Finaceiro do
      Begin
      Database := DM.IBD_Gestao;
      Transaction := Pc_Transacao;
      StoredProcName := 'SP_MOVIM_FINANCEIRO';
      ForcedRefresh := True;
      If NOT Transaction.InTransaction then Transaction.StartTransaction;
      Active := False;
      ParamByName('MVF_OPER_REG').Value := PC_OPERACAO;
      if PC_OPERACAO = 'I' then
        ParamByName('MVF_CODIGO').AsInteger := Fc_Generator('GN_MOVIM_FINANCEIRO','','MVF_CODIGO')
      else
      ParamByName('MVF_CODIGO').Value := PC_CODIGO;
      ParamByName('MVF_CODCTB').Value := PC_CODCTB;
      ParamByName('MVF_DATA').Value := PC_DATA;
      ParamByName('MVF_CODHTB').Value := PC_CODHTB;
      ParamByName('MVF_CODPLC_C').Value := PC_CODPLC_C;
      ParamByName('MVF_CODPLC_D').Value := PC_CODPLC_D;
      ParamByName('MVF_VL_CREDITO').Value := PC_VL_CREDITO;
      ParamByName('MVF_VL_DEBITO').Value := PC_VL_DEBITO;
      ParamByName('MVF_HISTORISCO').Value := Copy(PC_HISTORISCO,1,100);
      ParamByName('MVF_TIPO').Value := PC_TIPO;
      ParamByName('MVF_CODQTC').Value := PC_CODQTC;
      ParamByName('MVF_CODUSU').Value := PC_CODUSU;
      ParamByName('MVF_VL_FUTURO').Value := PC_VL_FUTURO;
      ParamByName('MVF_DT_ORIG').Value := PC_DT_ORIG;
      ParamByName('MVF_NR_DOC').Value := PC_NR_DOC;
      ParamByName('MVF_CONFERIDO').Value := PC_CONFERIDO;
      ParamByName('MVF_ESPECIE').Value := PC_ESPECIE;
      ParamByName('MVF_CODMHA').Value := PC_CODMHA;
      ParamByName('MVF_CODFPT').Value := PC_CODFPT;
      ExecProc;
      if Transaction.InTransaction then  Transaction.CommitRetaining;
    end;
  Finally
    Lc_Sp_Movim_Finaceiro.Close;
    FreeAndNil(Lc_Sp_Movim_Finaceiro);
  End;
end;


{N}
procedure Pc_NotaFiscal(Pc_Transacao : TSTTransaction;
                        Pc_Cd_Nota : Integer;
                        Pc_Tp_Operacao : String;
                        Pc_Finalidade:Integer;
                        Pc_Nr_Nota : String;
                        Pc_Serie : Integer;
                        //Pc_Modelo : String;
                        Pc_Cd_CFOP : Integer;
                        Pc_Cd_Pedido : Integer;
                        Pc_Cd_Empresa : Integer;
                        Pc_Dt_Emissao : TDate;
                        Pc_Dt_Saida : String;
                        Pc_Time :TTime;
                        Pc_VL_Bs_ICMS : Real;
                        Pc_VL_ICMS : Real;
                        Pc_Vl_Bs_Icms_St : Real;
                        Pc_Vl_Icms_St : Real;
                        Pc_VL_Produto : Real;
                        Pc_VL_Frete : Real;
                        Pc_Vl_Seguro : Real;
                        PC_Vl_Outras : Real;
                        Pc_VL_IPI : Real;
                        PC_VL_Nota : Real;
                        Pc_Cd_Transporte : Integer;
                        Pc_Cta_Frete : Integer;
                        Pc_Qt_Produto : Real;
                        Pc_Especie : String;
                        Pc_Marca : String;
                        PC_PesoBruto : String;
                        PC_PesoLiq : String;
                        Pc_Ctrl_Retorno : String;
                        Pc_Nfl_Vinculo : String;
                        Pc_Status : String;
                        Pc_VL_TL_Servicos : Real;
                        Pc_VL_ISS : Real;
                        Pc_Nr_Volume : String;
                        PC_PlacaVeiculo : String;
                        Pc_Uf_Veiculo : String;
                        Pc_RNTC : String;  
                        Pc_CodMha : Integer);
begin
  with DM.Sp_NotaFiscal do
    Begin
    Transaction := Pc_Transacao;
    ParamByName('NFL_CODIGO').AsInteger := pc_Cd_Nota;
    ParamByName('NFL_TIPO').AsString := Pc_Tp_Operacao;
    ParamByName('NFL_FINALIDADE').AsInteger := Pc_Finalidade;
    if Pc_Tp_Operacao = 'EM' then
      ParamByName('NFL_NUMERO').AsString :=Pc_Nr_Nota
    else
      begin
      if (StrToIntDef(Pc_Nr_Nota,0) > 0) then
        ParamByName('NFL_NUMERO').AsString :=Pc_Nr_Nota
      else
        ParamByName('NFL_NUMERO').AsString := ''
    end;
    ParamByName('NFL_SERIE').AsInteger := Pc_Serie;
    ParamByName('NFL_CODNAT').AsInteger := Pc_Cd_CFOP;
    ParamByName('NFL_CODPED').AsInteger := Pc_Cd_Pedido;
    ParamByName('NFL_CODEMP').AsInteger := Pc_Cd_Empresa;
    ParamByName('NFL_DT_EMISSAO').AsDate := Pc_Dt_Emissao;
    if Length(Pc_Dt_Saida)>0 then
    Begin
      ParamByName('NFL_HR_SAIDA').AsTime := Pc_Time;
      ParamByName('NFL_DT_SAIDA').AsString := Pc_Dt_Saida;
    end
    else
    begin
      ParamByName('NFL_HR_SAIDA').AsString := '';
      ParamByName('NFL_DT_SAIDA').AsString := '';
    end;

    ParamByName('NFL_BS_ICMS').AsFloat := Pc_VL_Bs_ICMS;
    ParamByName('NFL_VL_ICMS').AsFloat := Pc_VL_ICMS;
    ParamByName('NFL_BS_ICMS_SUBST').AsFloat := Pc_Vl_Bs_Icms_St;
    ParamByName('NFL_VL_ICMS_SUBST').AsFloat := Pc_Vl_Icms_St;
    ParamByName('NFL_VL_TL_PROD').AsFloat := Pc_VL_Produto;
    ParamByName('NFL_VL_FRETE').AsFloat := Pc_VL_Frete;
    ParamByName('NFL_VL_SEGURO').AsFloat := Pc_Vl_Seguro;
    ParamByName('NFL_VL_DESP_ACESS').AsFloat := PC_Vl_Outras;
    ParamByName('NFL_VL_IPI').AsFloat := Pc_VL_IPI;
    ParamByName('NFL_VL_TL_NOTA').AsFloat := PC_VL_Nota;
    ParamByName('NFL_CODTRP').AsInteger := Pc_Cd_Transporte;
    ParamByName('NFL_CTA_FRETE').AsInteger := Pc_Cta_Frete;
    ParamByName('NFL_QT_PRODUTO').AsFloat := Pc_Qt_Produto;
    ParamByName('NFL_ESPECIE').AsString := Copy(Pc_Especie,1,10);
    ParamByName('NFL_MARCA').AsString := Copy(Pc_Marca,1,10);
    ParamByName('NFL_PESO_BRUTO').AsString := Copy(PC_PesoBruto,1,10);
    ParamByName('NFL_PESO_LIQ').AsString := Copy(PC_PesoLiq,1,10);
    ParamByName('NFL_CTRL_RETORNO').AsString := Pc_Ctrl_Retorno;
    ParamByName('NFL_NFL_VINCULO').AsString := Pc_Nfl_Vinculo;
    ParamByName('NFL_STATUS').AsString := Pc_Status;
    ParamByName('NFL_VL_TL_SRV').AsFloat := Pc_VL_TL_Servicos;
    ParamByName('NFL_VL_ISS').AsFloat := Pc_VL_ISS;
    Pc_Nr_Volume := IntToStr(StrToIntDef(Pc_Nr_Volume,0));
    ParamByName('NFL_VOL_NUMERO').AsString := Copy(Pc_Nr_Volume,1,8);
    ParamByName('NFL_PLC_VEICULO').AsString := PC_PlacaVeiculo;
    ParamByName('NFL_PLC_UF').AsString := Pc_Uf_Veiculo;
    ParamByName('NFL_PLC_RNTC').AsString := Copy(Pc_RNTC,1,20);
    ParamByName('NFL_CODMHA').AsInteger := Pc_CodMha;
    ExecProc;
    end;
  if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
end;

{O}
procedure Pc_Observacao(Pc_Transacao : TSTTransaction;
                        Pc_Operacao : String;
                        Pc_CODIGO : Integer;
                        Pc_CODITF : Integer;
                        Pc_CODNFL : Integer;
                        Pc_TIPO : String;
                        Pc_DETALHE : String);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Sqltxt : sTRING;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      if Pc_Operacao = 'I' then
      Begin
        Lc_Sqltxt := 'insert into "TB_OBS_NFE"( '+
                     '   "OBN_CODIGO"           '+
                     ' , "OBN_CODITF"           '+
                     ' , "OBN_CODNFL"           '+
                     ' , "OBN_TIPO"             '+
                     ' , "OBN_DETALHE")         '+
                     ' values(                  '+
                     '   :"OBN_CODIGO"          '+
                     ' , :"OBN_CODITF"          '+
                     ' , :"OBN_CODNFL"          '+
                     ' , :"OBN_TIPO"            '+
                     ' , :"OBN_DETALHE")        ';
        Lc_qry.SQL.Add(Lc_Sqltxt);
        Pc_Codigo := Fc_Generator('GN_OBS_NFE','','OBN_CODIGO');
        ParamByName('OBN_CODIGO').Value := Pc_codigo;
        ParamByName('OBN_CODITF').Value := Pc_coditf;
        ParamByName('OBN_CODNFL').Value := Pc_codnfl;
        //[M] MANUAL / [F] FISCAL / [A] AUTOMATICA
        ParamByName('OBN_TIPO').Value := Pc_tipo;
        ParamByName('OBN_DETALHE').Value := Pc_DETALHE;
      end
      else
      if Pc_Operacao = 'E' then
        Begin
          Lc_Sqltxt := 'update "TB_OBS_NFE" set       '+
                       ' OBN_DETALHE =:OBN_DETALHE    '+
                       'WHERE OBN_CODIGO =:OBN_CODIGO ';
          SQL.Add(Lc_Sqltxt);
          ParamByName('OBN_CODIGO').Value := Pc_codigo;
          ParamByName('OBN_DETALHE').Value := Pc_DETALHE;
        end
        else
        if Pc_Operacao = 'A' then
          Begin
            Lc_Sqltxt := 'DELETE FROM "TB_OBS_NFE"      '+
                         'WHERE OBN_CODIGO =:OBN_CODIGO ';
            SQL.Add(Lc_Sqltxt);
            ParamByName('OBN_CODIGO').Value := Pc_codigo;
          end;
      ExecSQL;
      if Pc_Transacao.InTransaction then Pc_Transacao.CommitRetaining;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


{R}

end.
