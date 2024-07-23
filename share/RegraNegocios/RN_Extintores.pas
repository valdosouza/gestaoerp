unit RN_Extintores;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,ExtCtrls,Gauges,
  StdCtrls,classes,db,Mask,Grids,QRExport, Excel2000, QEdit_Setes, jpeg,ComObj,
  Windows, Messages, Variants, Graphics, Dialogs,prmExtintores;


   procedure Pc_ApagarOrdemServico(Pc_cd_Ordem:Integer);
   function Fc_ValidaExclusaoExtintor(fc_Codigo:Integer):Boolean;
   function Fc_ApagarRegistroExtintor(Fc_Tabela:String;Fc_Campo : array of string;Fc_codigo : array of string):String;
   function Fc_AtualizaExtintor(Fc_CODIGO,
                                  Fc_CODEMP,
                                  Fc_CODEND,
                                  Fc_NUMERO,
                                  Fc_NOVO,
                                  Fc_CODMRC,
                                  Fc_PROJETO,
                                  Fc_PROJ_BOMB,
                                  Fc_SERIE,
                                  Fc_ANO,
                                  Fc_NORMA,
                                  Fc_CODETP,
                                  Fc_CAP_EXTINTORA,
                                  Fc_PRESSURIZACAO,
                                  Fc_Selo,
                                  Fc_CODELZ,
                                  Fc_NR_PATRIMONIO,
                                  Fc_ATIVO,
                                  Fc_Dt_Cadastro:String):Integer;
   procedure Pc_AtualizaExtintorUltimaOs(Fc_Cd_OrdemServico,Fc_Cd_Extintor:String);
   function Fc_AtualizaExtintorUltimaOs(Fc_CODIGO,
                                        Fc_Last_Os:String):Integer;

  function Fc_AtualizaOrdemServico(Fc_CODIGO,
                                   Fc_CODPED,
                                   Fc_CODEMP,
                                   Fc_CODEND,
                                   Fc_DATA,
                                   Fc_CODENM:String;
                                   Fc_Obs:TMemo):Integer;
  function Fc_AtualizaInspecao(Fc_CODORS,
                               Fc_CODEXT,
                               Fc_DATA,
                               Fc_DT_VENC,
                               Fc_RECIPIENTE_VAZIO,
                               Fc_EXTINTOR_VAZIO,
                               Fc_RECIPIENTE_CARREGADO,
                               Fc_EXTINTOR_CARREGADO,
                               Fc_CARGA_REAL,
                               Fc_TX_DIFERENCA_CARGA,
                               Fc_OBS,
                               Fc_CODTEC:String):Integer;
  function Fc_AtualizaManutencao(Fc_CODORS,
                                  Fc_CODEXT,
                                  Fc_DT_ULT_ENSAIO,
                                  Fc_DT_VENC_ENSAIO,
                                  Fc_CODENS,
                                  Fc_DT_CARGA,
                                  Fc_DT_VENC_CARGA,
                                  Fc_Selo,
                                  Fc_OBS,
                                  Fc_CODTEC,
                                  Fc_Reg_Valv_Aliv,
                                  Fc_Pintura:String):Integer;


  function Fc_AtualizaEnsaio( Fc_CODORS,
                              Fc_CODEXT,
                              Fc_PRES_TRAB,
                              Fc_PRES_ENSAIO,
                              Fc_TARA,
                              Fc_MASSA,
                              Fc_TX_PERDA,
                              Fc_VOL_HIDRA,
                              Fc_CARGA_MAX,
                              Fc_EXP_TOTAL,
                              Fc_EXP_PERMAN,
                              Fc_TX_EXPANSAO,
                              Fc_Recipiente_Carregado,
                              Fc_Pneu_indic_pressao,
                              Fc_Pneu_valvula,
                              Fc_Hidr_valvula,
                              Fc_Hidr_Mangueira:String):Integer;

  function Fc_AtualizaResultado(Fc_CODORS,
                                Fc_CODEXT,
                                Fc_RESULTADO,
                                Fc_CODEMC:String):Integer;
  procedure Pc_ExtLocalizacaoCliente(Pc_Cd_Cliente:Integer);

  function Fc_TrataFormatoDataExtintor(Fc_Data:String):String;
  function Fc_GeraExtOrdemServico(Fc_Campo:String;Fc_Codigo:Integer;fc_Data : TDate):String;
  function Fc_VerificaExistenciaSerieExtintor(Fc_Cd_Cliente:Integer;Fc_Cd_Extintor:Integer;Fc_Serie:String):Boolean;
  function Fc_VerificaExistenciaNumeroExtintor(Fc_Cd_Cliente,Fc_Cd_Endereco,Fc_Cd_Extintor:Integer;Fc_Numero:String):Boolean;

  function Fc_BuscaExtintor(Fc_Cd_Cliente:Integer;Fc_Numero:String):TSTQuery;
  function Fc_BuscaExtintorOrdemServico(Fc_Numero:String;Fc_Cd_Ordem:Integer):Boolean;
  function Fc_DefineSequenciaExtintorCliente(Fc_cd_Cliente,Fc_Cd_Endereco:Integer):String;
  function Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Data:TMaskEdit):Integer;
  procedure Pc_DefineVencimentoGeral(Pc_Data,Pc_Vencimento:TMaskEdit;Pc_Ano_Extintor,Prazo:Integer);

  procedure Pc_DefineVencimentoInspecao(Pc_Ano_Extintor,Pc_Dt_Inspecao,Pc_Dt_Venc_Inspecao:TMaskEdit);
  procedure Pc_DefineVencimentoNivel_2(Pc_Ano_Extintor,Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio:TMaskEdit);
  procedure Pc_DefineVencimentoNivel_3(Pc_Ano_Extintor,Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio:TMaskEdit);
  procedure Pc_DefineVencimentoCarga(Pc_Ano_Extintor,Pc_Dt_Carga,Pc_Dt_Venc_Carga:TMaskEdit);
  function Fc_VerificaEncerramento(Fc_Cd_Ordem:Integer):Boolean;

  function CalculaVencimentoAnual(DataIni : TDate; Prazo:Integer):Integer;
  function Fc_VerificaExistenciaSelo():Boolean;
  Procedure Pc_PreencherNumeroSelo(Fc_Cd_Ordem:Integer);
  function Fc_DefineNumeroSelo():String;
  function Fc_MostraSeloAnterior(Fc_Cd_Ordem,Fc_Cd_Extintor:Integer):String;
  Procedure Pc_PreencherDtVencCarga(Fc_Cd_Ordem:Integer);
  Procedure Pc_PreencherDtVencEnsaio(Fc_Cd_Ordem:Integer);

  procedure Pc_DefineDataEncerramento(Pc_Cd_Ordem:Integer);
  function Fc_FormataDataExintor(Fc_Tipo,Fc_Data:String):String;
  Function Fc_UltimaOrdemExtintoresCliente(Pc_Cd_Cliente:Integer):Integer;
  //Relatorios
  procedure Pc_ImpOrdemServico(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpManutencaoNBR12962(Pc_cd_Ordem:Integer;Pc_Dt_Inicio,Pc_Dt_Final,Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpEnsaioHidrostaticoALP_NBR13485(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpEnsaioHidrostaticoBXP_NBR13485(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpExtintoresCliente(Pc_cd_Cliente,Pc_Cd_Endereco:Integer;Pc_Grid : TStringGrid;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpExtintoresOrdem(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpInspecao(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpEntregaRetiradaExtintores(Pc_cd_Ordem:Integer;Pc_Titulo,Pc_Operacao,Pc_Caminho:String);
  procedure Pc_ImpExtRelatorioManutencao(Pc_TipoData:Integer;
                                       Pc_Periodo :Boolean;
                                       Pc_Dt_Inicial : TDAte;
                                       Pc_Dt_Final : TDAte;
                                       Pc_Cd_Cliente:Integer);
  procedure Pc_AtualizaNrPedidoNaOrdem(Pc_cd_Ordem,Pc_Cd_Pedido:Integer);
  procedure Pc_CancelarOrdemServico(Pc_cd_Ordem:Integer);
  //18 - 13.1 - RL_EXT_RELACAO_SERVICOS_PRESTADOS
  Function Fc_ConsultaTipoLote(Pc_Qry:TSTQuery;Fc_Cd_Extintor:Integer;Fc_Dt_Inicial,Fc_Dt_Final:TDateTime):Integer;
  Function Fc_QtdeExintorServicoPrestado(Pc_Qry:TSTQuery;Pc_DataIni,Pc_DataFIm:TDate;Fc_Descricao,Fc_Capacidade,Fc_Classe:String):TStringList;
  Function Fc_QtdeExintorTipoInmetro(Pc_Qry:TSTQuery; Fc_Tipo,Fc_Nr_Ordem:String):Integer;
  Function Fc_SequenciaSeloUtilizado(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
  Function Fc_SequenciaOrdemUtilizado(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
  Function Fc_SequenciaManutencaoUtilizada(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
  procedure Pc_ExpRelacaoServicoPrestado(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel;Pc_DataIni,Pc_DataFIm:TDate);
  function Fc_BuscaNumeroNota(Fc_Qry:TSTQuery;Fc_Cd_Pedido:Integer):TSTQuery;
  function Fc_BuscaNumeroNotaServico(Fc_Qry:TSTQuery;Fc_Cd_Pedido:Integer):TSTQuery;
  procedure Pc_Ext_Anexo_O(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel;Pc_TipoData:String;Pc_DataIni,Pc_DataFIm:TDate);
  Function Fc_MostraFonesDisponiveis(Fc_Fone,Fc_Celular,Fc_Comercial,Fc_Portaria,Fc_Fax:String):String;
  procedure Pc_AtualizaVencimentoInspecao(Fc_Cd_Extintor:Integer; Pc_Novo:String);
  procedure Pc_AtualizaVencimentoEnsaio(Fc_Cd_Extintor:Integer; Pc_Novo:String);
  procedure Pc_AtualizaVencimentoCarga(Fc_Cd_Extintor:Integer; Pc_Novo:String);
  procedure Pc_AtualizaVencimentos(Pc_cd_Ordem:Integer);

  
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio,  UN_RL_Ext_Ordem_Servico, UN_RL_EXT_MANUTENCAO_NBR12962,
  Un_RL_Ext_Extintores_Cliente, Un_RL_Ext_Extintores_Ordem, UN_RL_EXT_ENSAIO_HIDRO_ALP_NBR13485,
  UN_RL_EXT_ENSAIO_HIDRO_BXP_NBR13485,UN_RL_EXT_INSPECAO, UN_Principal,
  StrUtils, UN_RL_EXT_RETIRADA_ENTREGA, UN_RL_EXT_MANUTENCAO, RN_Crud;


procedure Pc_ApagarOrdemServico(Pc_cd_Ordem:Integer);
Var
  Lc_Qry:TSTQuery;
Begin
  try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
    Begin
      Lc_Qry.Database := DM.IBD_Gestao;
      Lc_Qry.Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      CachedUpdates := True;
      //Apaga o resultado
      Active := False;
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      SQL.Clear;
      SQL.Add('DELETE FROM TB_EXT_RESULTADO WHERE ERS_CODORS=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;
      //Apaga o ensaio
      Active := False;
      SQL.Clear;
      SQL.Add('DELETE FROM TB_EXT_ENSAIO WHERE ENS_CODORS=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;
      //Apaga o Manutenção
      Active := False;
      SQL.Clear;
      SQL.Add('DELETE FROM TB_EXT_MANUTENCAO WHERE MNT_CODORS=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;
      //Apaga a inspeção
      Active := False;
      SQL.Clear;
      SQL.Add('DELETE FROM TB_EXT_INSPECAO WHERE IPC_CODORS=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;
      //Apaga os itens da ORdem de servico
      Active := False;
      SQL.Clear;
      SQL.Add('DELETE FROM tb_ext_itens_ors oi WHERE oi.ios_codors=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;

      //Apaga a ordem de servico
      Active := False;
      SQL.Clear;
      SQL.Add('DELETE FROM TB_EXT_ORDEM_SERVICO WHERE ORS_CODIGO=:ORS_CODIGO ');
      ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
      ExecSQL;

      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
  finally
    Lc_Qry.Close;
    Lc_Qry.DisposeOf;
  end;
end;

function Fc_ValidaExclusaoExtintor(fc_Codigo:Integer):Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Result := True;
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('SELECT IPC_CODORS From TB_EXT_INSPECAO WHERE IPC_CODEXT=:EXT_CODIGO');
    ParamByName('EXT_CODIGO').AsInteger := Fc_Codigo;
    Active := True;
    FetchAll;
    if (recordCount >0) then
      Begin
      Result := False;
      MensagemPararExecucao('Não é possível excluir este extintor.' + EOLN +
                            'Ele possue vínculos em inspeção.');
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;



function Fc_ApagarRegistroExtintor(Fc_Tabela:String;Fc_Campo : array of string;Fc_codigo : array of string):String;
Var
  Lc_Qry:TSTQuery;
  Lc_I : Integer;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('DELETE From ' + Fc_Tabela + ' where ');
    For Lc_I := 0 to High(Fc_campo) do
      Begin
      if (Lc_I = 0) then
        SQL.Add(Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I])
      else
        SQL.Add(' and ' + Fc_campo[lc_I] + ' =:' +Fc_campo[lc_I]);
      end;
    //Passagem de parametros
    For Lc_I := 0 to High(Fc_campo) do
      ParamByName(Fc_campo[lc_I]).AsAnsiString := Fc_codigo[lc_I];
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Result := 'OK';
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
      Result := 'Falhou';
    end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_AtualizaExtintor(Fc_CODIGO,
                              Fc_CODEMP,
                              Fc_CODEND,
                              Fc_NUMERO,
                              Fc_NOVO,
                              Fc_CODMRC,
                              Fc_PROJETO,
                              Fc_PROJ_BOMB,
                              Fc_SERIE,
                              Fc_ANO,
                              Fc_NORMA,
                              Fc_CODETP,
                              Fc_CAP_EXTINTORA,
                              Fc_PRESSURIZACAO,
                              Fc_Selo,
                              Fc_CODELZ,
                              Fc_NR_PATRIMONIO,
                              Fc_ATIVO,
                              Fc_Dt_Cadastro:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXTINTOR',['EXT_CODIGO'],[FC_CODIGO],['EXT_CODIGO'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_EXTINTOR" set  '+
              ' "EXT_CODIGO" = :"EXT_CODIGO" '+
              ', "EXT_CODEMP" = :"EXT_CODEMP" '+
              ', "EXT_CODEND" = :"EXT_CODEND" '+
              ', "EXT_NUMERO" = :"EXT_NUMERO" '+
              ', "EXT_NOVO" = :"EXT_NOVO" '+
              ', "EXT_CODMRC" = :"EXT_CODMRC" '+
              ', "EXT_PROJETO" = :"EXT_PROJETO" '+
              ', "EXT_PROJ_BOMB" = :"EXT_PROJ_BOMB" '+
              ', "EXT_SERIE" = :"EXT_SERIE" '+
              ', "EXT_ANO" = :"EXT_ANO" '+
              ', "EXT_NORMA" = :"EXT_NORMA" '+
              ', "EXT_CODETP" = :"EXT_CODETP" '+
              ', "EXT_CAP_EXTINTORA" = :"EXT_CAP_EXTINTORA" '+
              ', "EXT_PRESSURIZACAO" = :"EXT_PRESSURIZACAO" '+
              ', "EXT_SELO" = :"EXT_SELO" '+
              ', "EXT_CODELZ" = :"EXT_CODELZ" '+
              ', "EXT_NR_PATRIMONIO" = :"EXT_NR_PATRIMONIO" '+
              ', "EXT_ATIVO" = :"EXT_ATIVO" '+
              ', "EXT_DT_CADASTRO" =:"EXT_DT_CADASTRO" '+
              'where  "EXT_CODIGO" = :"EXT_CODIGO"');
      end
    else
      Begin//Insere
      Fc_CODIGO := IntToStr(Fc_Generator('GN_EXTINTOR','','EXT_CODIGO'));
      SQL.Add('insert into "TB_EXTINTOR"( '+
              '  "EXT_CODIGO" '+
              ', "EXT_CODEMP" '+
              ', "EXT_CODEND" '+
              ', "EXT_NUMERO" '+
              ', "EXT_NOVO" '+
              ', "EXT_CODMRC" '+
              ', "EXT_PROJETO" '+
              ', "EXT_PROJ_BOMB" '+
              ', "EXT_SERIE" '+
              ', "EXT_ANO" '+
              ', "EXT_NORMA" '+
              ', "EXT_CODETP" '+
              ', "EXT_CAP_EXTINTORA" '+
              ', "EXT_PRESSURIZACAO" '+
              ', "EXT_SELO" '+
              ', "EXT_CODELZ" '+
              ', "EXT_NR_PATRIMONIO" '+
              ', "EXT_ATIVO" '+
              ', "EXT_DT_CADASTRO") '+
              'values( '+
              '  :"EXT_CODIGO" '+
              ', :"EXT_CODEMP" '+
              ', :"EXT_CODEND" '+
              ', :"EXT_NUMERO" '+
              ', :"EXT_NOVO" '+
              ', :"EXT_CODMRC" '+
              ', :"EXT_PROJETO" '+
              ', :"EXT_PROJ_BOMB" '+
              ', :"EXT_SERIE" '+
              ', :"EXT_ANO" '+
              ', :"EXT_NORMA" '+
              ', :"EXT_CODETP" '+
              ', :"EXT_CAP_EXTINTORA" '+
              ', :"EXT_PRESSURIZACAO" '+
              ', :"EXT_SELO" '+
              ', :"EXT_CODELZ" '+
              ', :"EXT_NR_PATRIMONIO" '+
              ', :"EXT_ATIVO" '+
              ', :"EXT_DT_CADASTRO")');
      end;
    //Tratamento de Algumas Variaveis


    //Passagem de Parametros
    ParamByName('EXT_CODIGO').AsAnsiString := Fc_CODIGO;
    ParamByName('EXT_CODEMP').AsAnsiString := Fc_CODEMP;
    ParamByName('EXT_CODEND').AsAnsiString := Fc_CODEND;
    ParamByName('EXT_NUMERO').AsAnsiString := Fc_NUMERO;
    ParamByName('EXT_NOVO').AsAnsiString := Fc_NOVO;
    ParamByName('EXT_CODMRC').AsAnsiString := Fc_CODMRC;
    ParamByName('EXT_PROJETO').AsAnsiString := Fc_PROJETO;
    ParamByName('EXT_PROJ_BOMB').AsAnsiString := Fc_PROJ_BOMB;
    ParamByName('EXT_SERIE').AsAnsiString := Fc_SERIE;
    ParamByName('EXT_ANO').AsAnsiString := Fc_ANO;
    ParamByName('EXT_NORMA').AsAnsiString := Fc_NORMA;
    ParamByName('EXT_CODETP').AsAnsiString := Fc_CODETP;
    ParamByName('EXT_CAP_EXTINTORA').AsAnsiString := Fc_CAP_EXTINTORA;
    ParamByName('EXT_PRESSURIZACAO').AsAnsiString := Fc_PRESSURIZACAO;
    ParamByName('EXT_SELO').AsAnsiString := Fc_Selo;
    ParamByName('EXT_CODELZ').AsAnsiString := Fc_CODELZ;
    ParamByName('EXT_NR_PATRIMONIO').AsAnsiString := Fc_NR_PATRIMONIO;
    ParamByName('EXT_ATIVO').AsAnsiString := Fc_ATIVO;
    ParamByName('EXT_DT_CADASTRO').AsAnsiString :=  Fc_Dt_Cadastro;

      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToInt(Fc_CODIGO);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

procedure Pc_AtualizaExtintorUltimaOs(Fc_Cd_OrdemServico,Fc_Cd_Extintor:String);
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := Dm.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    Lc_Txt := 'SELECT  EXT_CODIGO, MAX(ORS_CODIGO) ORS_CODIGO '+
              'from tb_ext_ordem_servico '+
              '    INNER JOIN tb_ext_inspecao '+
              '    ON (tb_ext_inspecao.ipc_codors = tb_ext_ordem_servico.ors_codigo) '+
              '    INNER JOIN tb_ext_manutencao '+
              '    ON (tb_ext_manutencao.mnt_codors = tb_ext_inspecao.IPC_CODORS) and (mnt_codext = ipc_codext) '+
              '    INNER JOIN TB_EXTINTOR tb_extintor '+
              '    ON (tb_extintor.EXT_CODIGO = tb_ext_inspecao.IPC_CODEXT) '+
              'WHERE (EXT_CODIGO IS NOT NULL)  AND tb_ext_ordem_servico.ors_dt_encerramento is not null ';
    if Trim(Fc_Cd_OrdemServico) <> '' then
      Lc_Txt := Lc_Txt +' AND ORS_CODIGO =:ORS_CODIGO ';
    if Trim(Fc_Cd_Extintor) <> '' then
      Lc_Txt := Lc_Txt +' AND EXT_CODIGO =:EXT_CODIGO ';

    SQL.Add(Lc_Txt);
    if Trim(Fc_Cd_OrdemServico) <> '' then
      ParambyName('ORS_CODIGO').AsAnsiString := Fc_Cd_OrdemServico;
    if Trim(Fc_Cd_Extintor) <> '' then
      ParambyName('EXT_CODIGO').AsAnsiString := Fc_Cd_Extintor;

    Active := True;
    FetchAll;
    First;
    if (recordCount > 0) then
      Begin
      while not eof do
        Begin
        Fc_AtualizaExtintorUltimaOs(FieldByName('EXT_CODIGO').AsAnsiString,
                                    FieldByName('ORS_CODIGO').AsAnsiString);
        next;
        end;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;;
end;

function Fc_AtualizaExtintorUltimaOs(Fc_CODIGO,
                                      Fc_Last_Os:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Add('update "TB_EXTINTOR" set  '+
            ' "EXT_LAST_SO" = :"EXT_LAST_SO" '+
            'where  "EXT_CODIGO" = :"EXT_CODIGO"');
    //Tratamento de Algumas Variaveis
    //Passagem de Parametros
    ParamByName('EXT_CODIGO').AsAnsiString := Fc_CODIGO;
    ParamByName('EXT_LAST_SO').AsAnsiString := Fc_Last_Os;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToInt(Fc_CODIGO);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_AtualizaOrdemServico(Fc_CODIGO,
                                   Fc_CODPED,
                                   Fc_CODEMP,
                                   Fc_CODEND,
                                   Fc_DATA,
                                   Fc_CODENM:String;
                                   Fc_Obs:TMemo):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXT_ORDEM_SERVICO',['ORS_CODIGO'],[FC_CODIGO],['ORS_CODIGO'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_EXT_ORDEM_SERVICO" '+
              'set '+
              '  "ORS_CODIGO" = :"ORS_CODIGO" '+
              ', "ORS_CODPED" = :"ORS_CODPED" '+
              ', "ORS_CODEMP" =:"ORS_CODEMP" '+
              ', "ORS_CODEND" =:"ORS_CODEND" '+
              ', "ORS_DATA" = :"ORS_DATA" '+
              ', "ORS_CODENM" = :"ORS_CODENM" '+
              ', "ORS_OBS" = :"ORS_OBS" '+
              ', "ORS_CODMHA" =:"ORS_CODMHA" '+
              'where '+
              '  "ORS_CODIGO" = :"ORS_CODIGO" ');
    end
    else
    Begin //Insere
      Fc_CODIGO := IntToStr(Fc_Generator('GN_EXT_ORDEM_SERVICO','','ORS_CODIGO'));
      SQL.Add('insert into "TB_EXT_ORDEM_SERVICO"( '+
              '  "ORS_CODIGO" '+
              ', "ORS_CODPED" '+
              ', "ORS_CODEMP" '+
              ', "ORS_CODEND" '+
              ', "ORS_DATA" '+
              ', "ORS_CODENM" '+
              ', "ORS_OBS" '+
              ', "ORS_CODMHA") '+
              'values( '+
              '  :"ORS_CODIGO" '+
              ', :"ORS_CODPED" '+
              ', :"ORS_CODEMP" '+
              ', :"ORS_CODEND" '+
              ', :"ORS_DATA" '+
              ', :"ORS_CODENM" '+
              ', :"ORS_OBS" '+
              ', :"ORS_CODMHA")');
    end;
    //Passagem de Parametros
    ParamByName('ORS_CODIGO').AsAnsiString := Fc_CODIGO;
    ParamByName('ORS_CODPED').AsAnsiString := Fc_CODPED;
    ParamByName('ORS_CODEMP').AsAnsiString := Fc_CODEMP;
    ParamByName('ORS_CODEND').AsAnsiString := Fc_CODEND;
    ParamByName('ORS_DATA').AsAnsiString := Fc_DATA;
    ParamByName('ORS_CODENM').AsAnsiString := Fc_CODENM;
    ParamByName('ORS_OBS').AsAnsiString := Fc_Obs.Lines.Text;
    ParamByName('ORS_CODMHA').AsInteger := Gb_CodMha;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToIntDef(Fc_CODIGO,0);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;


function Fc_AtualizaInspecao(Fc_CODORS,
                             Fc_CODEXT,
                             Fc_DATA,
                             Fc_DT_VENC,
                             Fc_RECIPIENTE_VAZIO,
                             Fc_EXTINTOR_VAZIO,
                             Fc_RECIPIENTE_CARREGADO,
                             Fc_EXTINTOR_CARREGADO,
                             Fc_CARGA_REAL,
                             Fc_TX_DIFERENCA_CARGA,
                             Fc_OBS,
                             Fc_CODTEC:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXT_INSPECAO',['IPC_CODORS','IPC_CODEXT'],[Fc_CODORS,Fc_CODEXT],['IPC_CODEXT'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_EXT_INSPECAO"set '+
              ' "IPC_CODORS" = :"IPC_CODORS" '+
              ', "IPC_CODEXT" = :"IPC_CODEXT" '+
              ', "IPC_DATA" = :"IPC_DATA" '+
              ', "IPC_DT_VENC" = :"IPC_DT_VENC" '+
              ', "IPC_RECIPIENTE_VAZIO" = :"IPC_RECIPIENTE_VAZIO" '+
              ', "IPC_EXTINTOR_VAZIO" = :"IPC_EXTINTOR_VAZIO" '+
              ', "IPC_RECIPIENTE_CARREGADO" = :"IPC_RECIPIENTE_CARREGADO" '+
              ',"IPC_EXTINTOR_CARREGADO" =:"IPC_EXTINTOR_CARREGADO" '+
              ', "IPC_CARGA_REAL" = :"IPC_CARGA_REAL" '+
              ', "IPC_TX_DIFERENCA_CARGA" = :"IPC_TX_DIFERENCA_CARGA" '+
              ', "IPC_OBS" = :"IPC_OBS" '+
              ', "IPC_CODTEC" = :"IPC_CODTEC" '+
              'where  ("IPC_CODORS" = :"IPC_CODORS") AND ("IPC_CODEXT"=:"IPC_CODEXT") ');
    end
    else
    Begin //Insere
      SQL.Add('insert into "TB_EXT_INSPECAO"( '+
              ' "IPC_CODORS" '+
              ', "IPC_CODEXT" '+
              ', "IPC_DATA" '+
              ', "IPC_DT_VENC" '+
              ', "IPC_RECIPIENTE_VAZIO" '+
              ', "IPC_EXTINTOR_VAZIO" '+
              ', "IPC_RECIPIENTE_CARREGADO" '+
              ', "IPC_EXTINTOR_CARREGADO" '+
              ', "IPC_CARGA_REAL" '+
              ', "IPC_TX_DIFERENCA_CARGA" '+
              ', "IPC_OBS" '+
              ', "IPC_CODTEC") '+
              'values( '+
              ' :"IPC_CODORS" '+
              ', :"IPC_CODEXT" '+
              ', :"IPC_DATA" '+
              ', :"IPC_DT_VENC" '+
              ', :"IPC_RECIPIENTE_VAZIO" '+
              ', :"IPC_EXTINTOR_VAZIO" '+
              ', :"IPC_RECIPIENTE_CARREGADO" '+
              ', :"IPC_EXTINTOR_CARREGADO" '+
              ', :"IPC_CARGA_REAL" '+
              ', :"IPC_TX_DIFERENCA_CARGA" '+
              ', :"IPC_OBS" '+
              ', :"IPC_CODTEC")');
    end;
    //Tratamento de algumas variaveis
    Fc_DATA := Fc_TrataFormatoDataExtintor(Fc_DATA);
    Fc_DT_VENC := Fc_TrataFormatoDataExtintor(Fc_DT_VENC);

    //Passagem de Parametros
    ParamByName('IPC_CODORS').AsAnsiString := Fc_CODORS;
    ParamByName('IPC_CODEXT').AsAnsiString := Fc_CODEXT;
    ParamByName('IPC_CODTEC').AsAnsiString := Fc_CODTEC;
    ParamByName('IPC_DATA').AsAnsiString := Fc_DATA;
    ParamByName('IPC_DT_VENC').AsAnsiString := Fc_DT_VENC;
    ParamByName('IPC_RECIPIENTE_VAZIO').AsFloat := StrToFloatDef(Fc_RECIPIENTE_VAZIO,0);
    ParamByName('IPC_EXTINTOR_VAZIO').AsFloat := StrToFloatDef(Fc_EXTINTOR_VAZIO,0);
    ParamByName('IPC_RECIPIENTE_CARREGADO').AsFloat := StrToFloatDef(Fc_RECIPIENTE_CARREGADO,0);
    ParamByName('IPC_EXTINTOR_CARREGADO').AsFloat := StrToFloatDef(Fc_EXTINTOR_CARREGADO,0);
    ParamByName('IPC_CARGA_REAL').AsFloat := StrToFloatDef(Fc_CARGA_REAL,0);
    ParamByName('IPC_TX_DIFERENCA_CARGA').AsFloat := StrToFloatDef(Fc_TX_DIFERENCA_CARGA,0);
    ParamByName('IPC_OBS').AsAnsiString := Fc_OBS;
    ParamByName('IPC_CODTEC').AsAnsiString := Fc_CODTEC;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_AtualizaManutencao(Fc_CODORS,
                                Fc_CODEXT,
                                Fc_DT_ULT_ENSAIO,
                                Fc_DT_VENC_ENSAIO,
                                Fc_CODENS,
                                Fc_DT_CARGA,
                                Fc_DT_VENC_CARGA,
                                Fc_Selo,
                                Fc_OBS,
                                Fc_CODTEC,
                                Fc_Reg_Valv_Aliv,
                                Fc_Pintura:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXT_MANUTENCAO',['MNT_CODORS','MNT_CODEXT'],[Fc_CODORS,Fc_CODEXT],['MNT_CODEXT'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_EXT_MANUTENCAO" set '+
              ' "MNT_CODORS" = :"MNT_CODORS" '+
              ', "MNT_CODEXT" = :"MNT_CODEXT" '+
              ', "MNT_DT_ULT_ENSAIO" = :"MNT_DT_ULT_ENSAIO" '+
              ', "MNT_DT_VENC_ENSAIO" = :"MNT_DT_VENC_ENSAIO" '+
              ', "MNT_CODENS" = :"MNT_CODENS" '+
              ', "MNT_DT_CARGA" = :"MNT_DT_CARGA" '+
              ', "MNT_DT_VENC_CARGA" = :"MNT_DT_VENC_CARGA" '+
              ', "MNT_SELO" = :"MNT_SELO" '+
              ', "MNT_OBS" = :"MNT_OBS" '+
              ', "MNT_CODTEC" = :"MNT_CODTEC" '+
              ', "MNT_REG_VALV_ALIVIO" = :"MNT_REG_VALV_ALIVIO" '+
              ', "MNT_PINTURA" = :"MNT_PINTURA" '+
              'where  ("MNT_CODORS" = :"MNT_CODORS") AND ("MNT_CODEXT"=:"MNT_CODEXT")');
    end
    else
    Begin //Insere
      SQL.Add('insert into "TB_EXT_MANUTENCAO"( '+
              ' "MNT_CODORS" '+
              ', "MNT_CODEXT" '+
              ', "MNT_DT_ULT_ENSAIO" '+
              ', "MNT_DT_VENC_ENSAIO" '+
              ', "MNT_CODENS" '+
              ', "MNT_DT_CARGA" '+
              ', "MNT_DT_VENC_CARGA" '+
              ', "MNT_SELO" '+
              ', "MNT_OBS" '+
              ', "MNT_REG_VALV_ALIVIO" '+
              ', "MNT_PINTURA" '+
              ', "MNT_CODTEC") '+
              'values( '+
              ' :"MNT_CODORS" '+
              ', :"MNT_CODEXT" '+
              ', :"MNT_DT_ULT_ENSAIO" '+
              ', :"MNT_DT_VENC_ENSAIO" '+
              ', :"MNT_CODENS" '+
              ', :"MNT_DT_CARGA" '+
              ', :"MNT_DT_VENC_CARGA" '+
              ', :"MNT_SELO" '+
              ', :"MNT_OBS" '+
              ', :"MNT_REG_VALV_ALIVIO" '+
              ', :"MNT_PINTURA" '+
              ', :"MNT_CODTEC")');
    end;

    //Tratamento de algumas variaveis
    Fc_DT_ULT_ENSAIO  := Fc_TrataFormatoDataExtintor(Fc_DT_ULT_ENSAIO);
    Fc_DT_VENC_ENSAIO := Fc_TrataFormatoDataExtintor(Fc_DT_VENC_ENSAIO);
    Fc_DT_CARGA       := Fc_TrataFormatoDataExtintor(Fc_DT_CARGA);
    Fc_DT_VENC_CARGA  := Fc_TrataFormatoDataExtintor(Fc_DT_VENC_CARGA);

    //Passagem de Parametros
    ParamByName('MNT_CODORS').AsAnsiString := Fc_CODORS;
    ParamByName('MNT_CODEXT').AsAnsiString := Fc_CODEXT;
    ParamByName('MNT_DT_ULT_ENSAIO').AsAnsiString := Fc_DT_ULT_ENSAIO;
    ParamByName('MNT_DT_VENC_ENSAIO').AsAnsiString := Fc_DT_VENC_ENSAIO;
    ParamByName('MNT_CODENS').AsAnsiString := Fc_CODENS;
    ParamByName('MNT_DT_CARGA').AsAnsiString := Fc_DT_CARGA;
    ParamByName('MNT_DT_VENC_CARGA').AsAnsiString := Fc_DT_VENC_CARGA;
    ParamByName('MNT_SELO').AsAnsiString := Fc_Selo;
    ParamByName('MNT_OBS').AsAnsiString := Fc_obs;
    ParamByName('MNT_CODTEC').AsAnsiString := Fc_CODTEC;
    ParamByName('MNT_REG_VALV_ALIVIO').asString := Fc_Reg_Valv_Aliv;
    ParamByName('MNT_PINTURA').asString := Fc_Pintura;
    Try
      ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      Result := 0;
    except
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
      Result := 0;
    end;
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_AtualizaEnsaio(Fc_CODORS,
                            Fc_CODEXT,
                            Fc_PRES_TRAB,
                            Fc_PRES_ENSAIO,
                            Fc_TARA,
                            Fc_MASSA,
                            Fc_TX_PERDA,
                            Fc_VOL_HIDRA,
                            Fc_CARGA_MAX,
                            Fc_EXP_TOTAL,
                            Fc_EXP_PERMAN,
                            Fc_TX_EXPANSAO,
                            Fc_Recipiente_Carregado,
                            Fc_Pneu_indic_pressao,
                            Fc_Pneu_valvula,
                            Fc_Hidr_valvula,
                            Fc_Hidr_Mangueira:String):Integer;


Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXT_ENSAIO',['ENS_CODORS','ENS_CODEXT'],[Fc_CODORS,Fc_CODEXT],['ENS_CODEXT'])).Strings[0],0) > 0 then
    Begin //Atualiza
      SQL.Add('update "TB_EXT_ENSAIO" set '+
              ' "ENS_CODORS" = :"ENS_CODORS" '+
              ', "ENS_CODEXT" = :"ENS_CODEXT" '+
              ', "ENS_PRES_TRAB" = :"ENS_PRES_TRAB" '+
              ', "ENS_PRES_ENSAIO" = :"ENS_PRES_ENSAIO" '+
              ', "ENS_TARA" = :"ENS_TARA" '+
              ', "ENS_MASSA" = :"ENS_MASSA" '+
              ', "ENS_TX_PERDA" = :"ENS_TX_PERDA" '+
              ', "ENS_VOL_HIDRA" = :"ENS_VOL_HIDRA" '+
              ', "ENS_CARGA_MAX" = :"ENS_CARGA_MAX" '+
              ', "ENS_EXP_TOTAL" = :"ENS_EXP_TOTAL" '+
              ', "ENS_EXP_PERMAN" = :"ENS_EXP_PERMAN" '+
              ', "ENS_TX_EXPANSAO" = :"ENS_TX_EXPANSAO" '+
              ', "ENS_RECIPIENTE_CARREGADO" = :"ENS_RECIPIENTE_CARREGADO" '+
              ', "ENS_PN_IND_PRESSAO" =:"ENS_PN_IND_PRESSAO" '+
              ', "ENS_PN_VALVULA" =:"ENS_PN_VALVULA" '+
              ', "ENS_HD_VALVULA" =:"ENS_HD_VALVULA" '+
              ', "ENS_HD_MANG_EXT" =:"ENS_HD_MANG_EXT" '+
              'where  ("ENS_CODORS" = :"ENS_CODORS") AND ("ENS_CODEXT"=:"ENS_CODEXT")');
    end
    else
    Begin //Insere
      SQL.Add('insert into "TB_EXT_ENSAIO"( '+
              ' "ENS_CODORS" '+
              ', "ENS_CODEXT" '+
              ', "ENS_PRES_TRAB" '+
              ', "ENS_PRES_ENSAIO" '+
              ', "ENS_TARA" '+
              ', "ENS_MASSA" '+
              ', "ENS_TX_PERDA" '+
              ', "ENS_VOL_HIDRA" '+
              ', "ENS_CARGA_MAX" '+
              ', "ENS_EXP_TOTAL" '+
              ', "ENS_EXP_PERMAN" '+
              ', "ENS_TX_EXPANSAO" '+
              ', "ENS_RECIPIENTE_CARREGADO" '+
              ', "ENS_PN_IND_PRESSAO" '+
              ', "ENS_PN_VALVULA" '+
              ', "ENS_HD_VALVULA" '+
              ', "ENS_HD_MANG_EXT") '+
              'values( '+
              ' :"ENS_CODORS" '+
              ', :"ENS_CODEXT" '+
              ', :"ENS_PRES_TRAB" '+
              ', :"ENS_PRES_ENSAIO" '+
              ', :"ENS_TARA" '+
              ', :"ENS_MASSA" '+
              ', :"ENS_TX_PERDA" '+
              ', :"ENS_VOL_HIDRA" '+
              ', :"ENS_CARGA_MAX" '+
              ', :"ENS_EXP_TOTAL" '+
              ', :"ENS_EXP_PERMAN" '+
              ', :"ENS_TX_EXPANSAO" '+
              ', :"ENS_RECIPIENTE_CARREGADO" '+
              ', :"ENS_PN_IND_PRESSAO" '+
              ', :"ENS_PN_VALVULA" '+
              ', :"ENS_HD_VALVULA" '+
              ', :"ENS_HD_MANG_EXT") ');
    end;
    //Passagem de Parametros
    ParamByName('ENS_CODORS').AsAnsiString := Fc_CODORS;
    ParamByName('ENS_CODEXT').AsAnsiString := Fc_CODEXT;
    ParamByName('ENS_PRES_TRAB').AsFloat := StrToFloatDef(Fc_PRES_TRAB,0);
    ParamByName('ENS_PRES_ENSAIO').AsFloat := StrToFloatDef(Fc_PRES_ENSAIO,0);
    ParamByName('ENS_TARA').AsFloat := StrToFloatDef(Fc_TARA,0);
    ParamByName('ENS_MASSA').AsFloat := StrToFloatDef(Fc_MASSA,0);
    ParamByName('ENS_TX_PERDA').AsFloat := StrToFloatDef(Fc_TX_PERDA,0);
    ParamByName('ENS_VOL_HIDRA').AsFloat := StrToFloatDef(Fc_VOL_HIDRA,0);
    ParamByName('ENS_CARGA_MAX').AsFloat := StrToFloatDef(Fc_CARGA_MAX,0);
    ParamByName('ENS_EXP_TOTAL').AsFloat := StrToFloatDef(Fc_EXP_TOTAL,0);
    ParamByName('ENS_EXP_PERMAN').AsFloat := StrToFloatDef(Fc_EXP_PERMAN,0);
    ParamByName('ENS_TX_EXPANSAO').AsFloat := StrToFloatDef(Fc_TX_EXPANSAO,0);
    ParamByName('ENS_RECIPIENTE_CARREGADO').AsFloat := StrToFloatDef(Fc_Recipiente_Carregado,0);
    ParamByName('ENS_PN_IND_PRESSAO').asString := Fc_Pneu_indic_pressao;
    ParamByName('ENS_PN_VALVULA').asString := Fc_Pneu_valvula;
    ParamByName('ENS_HD_VALVULA').asString := Fc_Hidr_valvula;
    ParamByName('ENS_HD_MANG_EXT').asString := Fc_Hidr_Mangueira;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := 0;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_AtualizaResultado(Fc_CODORS,
                              Fc_CODEXT,
                              Fc_RESULTADO,
                              Fc_CODEMC:String):Integer;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    if StrToIntDef(TStringList(Fc_VerificaRegistro('TB_EXT_RESULTADO',['ERS_CODORS','ERS_CODEXT'],[Fc_CODORS,Fc_CODEXT],['ERS_CODORS'])).Strings[0],0) > 0 then
      Begin //Atualiza
      SQL.Add('update "TB_EXT_RESULTADO" set '+
              ' "ERS_CODORS" = :"ERS_CODORS" '+
              ', "ERS_CODEXT" = :"ERS_CODEXT" '+
              ', "ERS_RESULTADO" = :"ERS_RESULTADO" '+
              ', "ERS_CODEMC" = :"ERS_CODEMC" '+
              'where  ("ERS_CODORS" = :"ERS_CODORS") AND ("ERS_CODEXT"=:"ERS_CODEXT")');
      end
    else
      Begin //Insere
      SQL.Add('insert into "TB_EXT_RESULTADO"( '+
              ' "ERS_CODORS" '+
              ', "ERS_CODEXT" '+
              ', "ERS_RESULTADO" '+
              ', "ERS_CODEMC") '+
              'values( '+
              ' :"ERS_CODORS" '+
              ', :"ERS_CODEXT" '+
              ', :"ERS_RESULTADO" '+
              ', :"ERS_CODEMC")');
      end;
    //Passagem de Parametros
    ParamByName('ERS_CODORS').AsAnsiString := Fc_CODORS;
    ParamByName('ERS_CODEXT').AsAnsiString := Fc_CODEXT;
    ParamByName('ERS_RESULTADO').AsAnsiString := Fc_RESULTADO;
    ParamByName('ERS_CODEMC').AsAnsiString := Fc_CODEMC;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := 0;
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

procedure Pc_ExtLocalizacaoCliente(Pc_Cd_Cliente:Integer);
Begin
  with DM.Qr_Ext_LocalExtintor do
    Begin
    Active := False;
    ParamByName('ELZ_CODEMP').AsInteger := Pc_Cd_Cliente;
    Active := True;
    FetchAll;
    end;
end;

function Fc_TrataFormatoDataExtintor(Fc_Data:String):String;
Begin
  Result := '';
  if (Trim(Fc_Data)  = '/  /')  or (Trim(Fc_Data) ='/')  or (Trim(Fc_Data) ='') then
  Begin
    Result := '';
    exit;
  end;

  if (Length(Fc_Data) = 4) then
  Begin
    Result := '01/' + Copy(DateToStr(Date),4,2)+ '/' + Fc_Data;
  end
  else
  Begin
    if (Length(Fc_Data) = 7) then
    Begin
      Result := '01/' + Fc_Data;
    end
    else
    Begin
      Result := Fc_Data;
    End;
  end;
end;


function Fc_GeraExtOrdemServico(Fc_Campo:String;Fc_Codigo:Integer;fc_Data : TDate):String;
var
   Lc_Codigo: Integer;
   Lc_Ano: string;
   Lc_Qry :TSTQuery;
begin
  //Pega o Ano Atual
  Lc_Ano := IntToStr(Fc_Year(fc_Data));
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT MAX(' + Fc_Campo + ') '+
            'FROM TB_EXT_ORDEM_SERVICO ');
    Active := True;
    Result := FieldByName('MAX').AsAnsiString;
    Lc_Codigo := StrToIntDef(Result, 0) + 1;
    Result := StrZero(Lc_Codigo, 6, 0);
    //Atualiza o Registro
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_EXT_ORDEM_SERVICO SET ' + Fc_Campo + '=:' + Fc_Campo + ' WHERE ORS_CODIGO=:ORS_CODIGO ');
    ParamByName(Fc_Campo).AsAnsiString := Result;
    ParamByName('ORS_CODIGO').AsInteger := Fc_Codigo;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_VerificaExistenciaSerieExtintor(Fc_Cd_Cliente:Integer;Fc_Cd_Extintor:Integer;Fc_Serie:String):Boolean;
var
  Lc_Qry :TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT EXT_CODIGO '+
            'FROM TB_EXTINTOR '+
            'WHERE (EXT_SERIE=:EXT_SERIE)  ');
    //desativada em 19/08/2015 - a pedido da Andreia
    //SQL.Add(' AND (EXT_CODEMP=:EMP_CODIGO) ');
    if (Fc_Cd_Extintor > 0) then
      SQL.Add('AND (EXT_CODIGO <> :EXT_CODIGO) ');
    //Passagem de parametros
    //desativada em 19/08/2015 - a pedido da Andreia
    //ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
    ParamByName('EXT_SERIE').AsAnsiString := Fc_Serie;
    if (Fc_Cd_Extintor > 0) then
      ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;    
    Active := True;
    FetchAll;
    Result := (RecordCount >0);
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_VerificaExistenciaNumeroExtintor(Fc_Cd_Cliente,Fc_Cd_Endereco,Fc_Cd_Extintor:Integer;Fc_Numero:String):Boolean;
var
  Lc_Qry :TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT EXT_CODIGO '+
            'FROM TB_EXTINTOR '+
            'WHERE (EXT_CODEMP=:EMP_CODIGO) AND (EXT_CODEND=:END_CODIGO) AND (EXT_NUMERO=:EXT_NUMERO) AND (EXT_ATIVO = ''S'') ');
    if (Fc_Cd_Extintor > 0) then
      SQL.Add('AND (EXT_CODIGO <> :EXT_CODIGO) ');
    //Passagem de Paramentros
    ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
    ParamByName('END_CODIGO').AsInteger := Fc_Cd_Endereco;
    ParamByName('EXT_NUMERO').AsAnsiString := Fc_Numero;
    if (Fc_Cd_Extintor > 0) then
      ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
    Result := (RecordCount >0);
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_BuscaExtintor(Fc_Cd_Cliente:Integer;Fc_Numero:String):TSTQuery;
begin
  Result := TSTQuery.Create(nil);
  with Result do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select * '+
            'from  TB_EXTINTOR tb_extintor '+
            'where EXT_NUMERO=:EXT_NUMERO AND (EXT_CODEMP=:EMP_CODIGO) ' );
    ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
    ParamByName('EXT_NUMERO').AsAnsiString := Fc_Numero;
    Active := True;
    FetchAll;
  end;
end;

function Fc_BuscaExtintorOrdemServico(Fc_Numero:String;Fc_Cd_Ordem:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := False;
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select EXT_CODIGO '+
            'from  TB_EXT_INSPECAO tb_ext_inspecao '+
            '  INNER JOIN  TB_EXTINTOR tb_extintor '+
            '  ON (tb_ext_inspecao.IPC_CODEXT = tb_extintor.EXT_CODIGO) '+
            'where (EXT_NUMERO=:EXT_NUMERO) AND (IPC_CODORS=:ORS_CODIGO) ' );
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    ParamByName('EXT_NUMERO').AsAnsiString := Fc_Numero;
    Active := True;
    FetchAll;
    Result := (RecordCount >0);
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_DefineSequenciaExtintorCliente(Fc_cd_Cliente,Fc_Cd_Endereco:Integer):String;
Var
  Lc_Qry : TSTQuery;
  Lc_Lista:TStringList;
begin
  Try
    Lc_Lista := TStringList.create;
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry do
      Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      ForcedRefresh := True;
      CachedUpdates := True;
      Active := False;
      SQL.Clear;
      SQL.Add('Select EXT_NUMERO '+
              'from  TB_EXTINTOR '+
              'WHERE (EXT_CODEMP=:EMP_CODIGO) AND (EXT_CODEND=:END_CODIGO) ');
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
      ParamByName('END_CODIGO').AsInteger := Fc_Cd_Endereco;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Begin
        First;
        Lc_Lista.Clear;
        while not eof do
          Begin
          Lc_Lista.Add(StrZero(FieldByname('EXT_NUMERO').AsInteger,4,0));
          next;
          end;

        Result := StrZero(Fc_RetornaSequenciaLista(Lc_Lista),4,0);
        end
      else
        Result := '0001';//Numero Inicial
      end;
  Finally
    //Libera Memoria
    Lc_Qry.Close;
    Lc_Qry.DisposeOf;
    Lc_Lista.DisposeOf;
  End;
end;


procedure Pc_DefineVencimentoGeral(Pc_Data,Pc_Vencimento:TMaskEdit;Pc_Ano_Extintor,Prazo:Integer);
var
  Lc_Dt_Data : TDate;
  LcStrData: String;
Begin
  LcStrData := Fc_RemoveCaracterInformado(Pc_Data.Text, ['/','/',' ',' ',' ',' ',' ',' ',' ',' ']);
  if (Pc_Data.EditMask = '!##/##/####;1;_') then
  Begin //01/01/2018
    if (LcStrData <> '') then
      Lc_Dt_Data := StrToDateDef(Copy(Pc_Data.Text,1,6) + IntToStr(Pc_Ano_Extintor),Date)
    else
      Lc_Dt_Data := StrToDateDef( Copy(DateToStr(Date),1,6) + IntToStr(Pc_Ano_Extintor),Date);
    Lc_Dt_Data := Lc_Dt_Data + CalculaVencimentoAnual(Lc_Dt_Data, Prazo);
    Pc_Vencimento.Text := DateToStr(Lc_Dt_Data);
  end
  else
  Begin
    if (Pc_Data.EditMask = '!##/####;1;_') then
    Begin
      if (LcStrData <> '') then
        Lc_Dt_Data := StrToDateDef('15/' + Copy(Pc_Data.Text,1,3) + IntToStr(Pc_Ano_Extintor),Date)
      else
        Lc_Dt_Data := StrToDateDef('15' + Copy(DateToStr(Date),3,4) + IntToStr(Pc_Ano_Extintor),Date);
      Lc_Dt_Data := Lc_Dt_Data + CalculaVencimentoAnual(Lc_Dt_Data, Prazo);
      Pc_Vencimento.Text := Copy(DateToStr(Lc_Dt_Data),4,7);
    end
    else
    Begin                       //01/01/2018
      Lc_Dt_Data := StrToDateDef('15/01/' + IntToStr(Pc_Ano_Extintor),Date);
      Lc_Dt_Data := Lc_Dt_Data + CalculaVencimentoAnual(Lc_Dt_Data, Prazo);
      Pc_Vencimento.Text := Copy(DateToStr(Lc_Dt_Data),7,4);
    end;
  end;

end;

function Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Data:TMaskEdit):Integer;
var
  Lc_Ano_Extintor : Integer;
  LcStrData : String;
Begin
  Lc_Ano_Extintor := StrToIntDef(Pc_Ano_Extintor.Text,Fc_Year(Date));
  LcStrData := Fc_RemoveCaracterInformado(Pc_Data.Text, ['/','/',' ',' ',' ',' ',' ',' ',' ',' ']);
  Result := Lc_Ano_Extintor;
  if (LcStrData <> '') then
  Begin
    if (Pc_Data.EditMask = '!##/##/####;1;_') then
      Result := StrToIntDef(Copy(Pc_Data.Text,7,4),Fc_Year(Date))
    else                     //01/01/2018
    if (Pc_Data.EditMask = '!##/####;1;_') then
      Result := StrToIntDef(Copy(Pc_Data.Text,4,4),Fc_Year(Date))
    else
      Result := StrToIntDef(Copy(Pc_Data.Text,1,4),Fc_Year(Date));
  End;
  If (Result < Lc_Ano_Extintor) then
    Result := Lc_Ano_Extintor;
End;

procedure Pc_DefineVencimentoInspecao(Pc_Ano_Extintor,Pc_Dt_Inspecao,Pc_Dt_Venc_Inspecao:TMaskEdit);
var
  Prazo : Integer;
  Lc_Ano_Extintor : Integer;
Begin
  Lc_Ano_Extintor := Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Dt_Inspecao);
  Prazo := DM.Qr_Ext_ListaTipoExtintor.FieldByname('ETP_VENC_INSPECAO').AsInteger;
  Pc_DefineVencimentoGeral(Pc_Dt_Inspecao,Pc_Dt_Venc_Inspecao,Lc_Ano_Extintor,Prazo);
end;

procedure Pc_DefineVencimentoNivel_2(Pc_Ano_Extintor,Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio:TMaskEdit);
var
  Prazo : Integer;
  Lc_Ano_Extintor : Integer;
Begin
  Lc_Ano_Extintor := Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Dt_Ensaio);
  Prazo := DM.Qr_Ext_ListaTipoExtintor.FieldByname('ETP_VENC_NIVEL_2').AsInteger;
  Pc_DefineVencimentoGeral(Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio,Lc_Ano_Extintor,Prazo);
end;

procedure Pc_DefineVencimentoNivel_3(Pc_Ano_Extintor,Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio:TMaskEdit);
var
  Prazo : Integer;
  Lc_Ano_Extintor : Integer;
Begin
  Lc_Ano_Extintor := Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Dt_Ensaio);
  Prazo := DM.Qr_Ext_ListaTipoExtintor.FieldByname('ETP_VENC_NIVEL_3').AsInteger;
  Pc_DefineVencimentoGeral(Pc_Dt_Ensaio,Pc_Dt_Venc_Ensaio,Lc_Ano_Extintor,Prazo);
End;

function CalculaVencimentoAnual(DataIni : TDate; Prazo:Integer):Integer;
Var
  LcMeses : Array[0..11] of integer;
  I : Integer;
  MesInicio : Integer;
  ContaMes : Integer;
  AnoAtual : Integer;
Begin
  AnoAtual := Fc_Year(Date);
  LcMeses[0]  := 31;
  //Verifica se o ano é ano bissexto
  If IsLeapYear(AnoAtual) then
    LcMeses[1]  := 29
  else
    LcMeses[1]  := 28;
  LcMeses[2]  := 31;
  LcMeses[3]  := 30;
  LcMeses[4]  := 31;
  LcMeses[5]  := 30;
  LcMeses[6]  := 31;
  LcMeses[7]  := 31;
  LcMeses[8]  := 30;
  LcMeses[9]  := 31;
  LcMeses[10] := 30;
  LcMeses[11] := 31;

  MesInicio := Fc_Month(DataIni);
  Result := 0;
  ContaMes := MesInicio - 1;
  for I := 1 to Prazo do
  Begin
    Result := Result + LcMeses[ContaMes];
    inc(ContaMes);
    if ContaMes = 12 then
    Begin
      ContaMes := 0;
      //Verifica se o proximo ano será ano bissexto
      If IsLeapYear(AnoAtual+1) then
        LcMeses[1]  := 29
      else
        LcMeses[1]  := 28;

    End;
  End;
End;


procedure Pc_DefineVencimentoCarga(Pc_Ano_Extintor,Pc_Dt_Carga,Pc_Dt_Venc_Carga:TMaskEdit);
var
  Prazo : Integer;
  Lc_Ano_Extintor : Integer;
Begin
  Lc_Ano_Extintor := Fc_DefineAnoExtintor(Pc_Ano_Extintor,Pc_Dt_Carga);
  Prazo := DM.Qr_Ext_ListaTipoExtintor.FieldByname('ETP_VENC_CARGA').AsInteger;
  Pc_DefineVencimentoGeral(Pc_Dt_Carga,Pc_Dt_Venc_Carga,Lc_Ano_Extintor,Prazo);
End;

function Fc_VerificaEncerramento(Fc_Cd_Ordem:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := False;
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select ORS_DT_ENCERRAMENTO '+
            'from  TB_EXT_ORDEM_SERVICO '+
            'where (ORS_CODIGO =:ORS_CODIGO) ' );
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    Active := True;
    FetchAll;
    Result := (not FieldByName('ORS_DT_ENCERRAMENTO').IsNull) or (FieldByName('ORS_DT_ENCERRAMENTO').AsAnsiString <> '');
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_VerificaExistenciaSelo():Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT FIRST 1 ESL_CODIGO, ESL_ULTIMO '+
            'from  TB_EXT_SELOS  '+
            'where (cast (ESL_ULTIMO as integer)  < cast (ESL_FIM as integer)) ' +
            'ORDER BY ESL_DATA ASC ');
    Active := True;
    FetchAll;
    if (recordcount = 0) then
      Begin
      MensagemPararExecucao('Não existem selos disponíveis.');
      Result := False;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

Procedure Pc_PreencherNumeroSelo(Fc_Cd_Ordem:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Upd_Mnt : TSTQuery;
  Lc_Upd_Ext : TSTQuery;
  Lc_Nr_Selo : String;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select DISTINCT MNT_CODORS, MNT_CODEXT, MNT_SELO '+
            'from tb_ext_ordem_servico '+
            '  inner join tb_ext_manutencao '+
            '  on (MNT_CODORS = ORS_CODIGO) '+
            '  INNER JOIN TB_EXTINTOR '+
            '  on (EXT_CODIGO = MNT_CODEXT) '+
            '  INNER JOIN TB_EXT_RESULTADO '+
            '  ON (ERS_CODORS = ORS_CODIGO)  and (EXT_CODIGO = ERS_CODEXT) '+
            'WHERE (ORS_CODIGO=:ORS_CODIGO) AND ((ORS_CODENM = 3) or (ORS_CODENM = 4))  AND (ERS_RESULTADO = ''S'') '+
            'ORDER BY EXT_NUMERO ASC ' );
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    Active := True;
    FetchAll;
    if recordCount>0 then
      Begin
      //Atualiza o selo na manunteção
      Lc_Upd_Mnt := TSTQuery.Create(nil);
      Lc_Upd_Mnt.Database := DM.IBD_Gestao;
      Lc_Upd_Mnt.Transaction := DM.IB_Transacao;
      Lc_Upd_Mnt.ForcedRefresh := True;
      Lc_Upd_Mnt.CachedUpdates := True;
      Lc_Upd_Mnt.Active := False;
      Lc_Upd_Mnt.SQL.Clear;
      Lc_Upd_Mnt.SQL.Add('UPDATE TB_EXT_MANUTENCAO SET '+
                     'MNT_SELO =:MNT_SELO '+
                     'WHERE (MNT_CODORS=:ORS_CODIGO) AND (MNT_CODEXT=:EXT_CODIGO) ');
      //Atualiza o selo na manunteção
      Lc_Upd_Ext := TSTQuery.Create(nil);
      Lc_Upd_Ext.Database := DM.IBD_Gestao;
      Lc_Upd_Ext.Transaction := DM.IB_Transacao;
      Lc_Upd_Ext.ForcedRefresh := True;
      Lc_Upd_Ext.CachedUpdates := True;
      Lc_Upd_Ext.Active := False;
      Lc_Upd_Ext.SQL.Clear;
      Lc_Upd_Ext.SQL.Add('UPDATE TB_EXTINTOR SET '+
                     'EXT_SELO =:EXT_SELO '+
                     'WHERE (EXT_CODIGO=:EXT_CODIGO) ');


      while not eof do
        Begin
        if Trim(FieldByName('MNT_SELO').AsAnsiString) = '' then
          Begin
          Lc_Nr_Selo := Fc_DefineNumeroSelo;
          if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
          //Atualiza o Selo na Manunteçãos
          Lc_Upd_Mnt.Active := False;
          Lc_Upd_Mnt.ParamByName('ORS_CODIGO').AsInteger := FieldByname('MNT_CODORS').AsInteger;
          Lc_Upd_Mnt.ParamByName('EXT_CODIGO').AsInteger := FieldByname('MNT_CODEXT').AsInteger;
          Lc_Upd_Mnt.ParamByName('MNT_SELO').AsAnsiString := Lc_Nr_Selo;
          Lc_Upd_Mnt.ExecSQL;
          //Atualiza o Selo no Extintor
          Lc_Upd_Ext.Active := False;
          Lc_Upd_Ext.ParamByName('EXT_CODIGO').AsInteger := FieldByname('MNT_CODEXT').AsInteger;
          Lc_Upd_Ext.ParamByName('EXT_SELO').AsAnsiString := Lc_Nr_Selo;
          Lc_Upd_Ext.ExecSQL;
          if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
          end;
        next;
        end;
      Lc_Upd_Mnt.Close;
      Lc_Upd_Mnt.DisposeOf;
      Lc_Upd_Ext.Close;
      Lc_Upd_Ext.DisposeOf;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;


function Fc_DefineNumeroSelo():String;
Var
  Lc_Qry : TSTQuery;
  Lc_Upd : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT FIRST 1 ESL_CODIGO, ESL_INICIO,ESL_ULTIMO '+
            'from  TB_EXT_SELOS  '+
            'where (cast (ESL_ULTIMO as integer)  < cast (ESL_FIM as integer)) ' +
            'ORDER BY ESL_DATA ASC, ESL_ULTIMO DESC ');
    Active := True;
    FetchAll;
    if (recordcount > 0) then
      Begin
      if Trim(FieldByName('ESL_ULTIMO').AsAnsiString)='0' then
        Begin
        Result := FieldByName('ESL_INICIO').AsAnsiString;
        end
      else
        Begin
        Result := FieldByName('ESL_ULTIMO').AsAnsiString;
        Result := StrZero(StrToIntDef(Result,0) + 1,Length(FieldByName('ESL_INICIO').AsAnsiString),0);
        end;
      //Atualiza com o ultimo numero fornecido
      Lc_Upd := TSTQuery.Create(nil);
      Lc_Upd.Database := DM.IBD_Gestao;
      Lc_Upd.Transaction := DM.IB_Transacao;
      Lc_Upd.ForcedRefresh := True;
      Lc_Upd.CachedUpdates := True;
      Lc_Upd.Active := False;
      Lc_Upd.SQL.Clear;
      Lc_Upd.SQL.Add('UPDATE TB_EXT_SELOS SET '+
                     'ESL_ULTIMO =:ESL_ULTIMO '+
                     'WHERE (ESL_CODIGO=:ESL_CODIGO) ');
      Lc_Upd.ParamByName('ESL_ULTIMO').AsAnsiString := Result;
      Lc_Upd.ParamByName('ESL_CODIGO').AsInteger := FieldByName('ESL_CODIGO').AsInteger;
      Lc_Upd.ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end

    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
  Lc_Upd.Close;
  Lc_Upd.DisposeOf;
end;

function Fc_MostraSeloAnterior(Fc_Cd_Ordem,Fc_Cd_Extintor:Integer):String;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT FIRST 1 MNT_SELO '+
            'FROM tb_ext_manutencao '+
            'WHERE (MNT_CODORS=:ORS_CODIGO) AND (MNT_CODEXT =:EXT_CODIGO) '+
            'ORDER BY MNT_CODORS DESC');
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
    if (recordcount > 0) then
      Result := FieldByName('MNT_SELO').AsAnsiString
    else
      Result := '';
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

Procedure Pc_PreencherDtVencCarga(Fc_Cd_Ordem:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Upd_Mnt : TSTQuery;
  Lc_Dt_Carga : TDate;
  prazo : Integer;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select MNT_CODORS, MNT_CODEXT,MNT_DT_CARGA,EXT_ANO, ETP_VENC_CARGA '+
            'from tb_ext_ordem_servico '+
            '  inner join tb_ext_manutencao '+
            '  on (MNT_CODORS = ORS_cODIGO) '+
            '  INNER JOIN TB_EXTINTOR '+
            '  on (EXT_CODIGO = MNT_CODEXT) '+
            '  inner join tb_ext_tipo '+
            '  on (ETP_CODIGO = EXT_CODETP) '+
            'WHERE (ORS_CODIGO=:ORS_CODIGO) AND ((ORS_CODENM = 3) or (ORS_CODENM = 4))'+
            'ORDER BY EXT_NUMERO ASC ' );
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    Active := True;
    FetchAll;
    if recordCount>0 then
    Begin
      //Atualiza a data da carga e vencimento
      Lc_Upd_Mnt := TSTQuery.Create(nil);
      Lc_Upd_Mnt.Database := DM.IBD_Gestao;
      Lc_Upd_Mnt.Transaction := DM.IB_Transacao;
      Lc_Upd_Mnt.ForcedRefresh := True;
      Lc_Upd_Mnt.CachedUpdates := True;
      Lc_Upd_Mnt.Active := False;
      Lc_Upd_Mnt.SQL.Clear;
      Lc_Upd_Mnt.SQL.Add('UPDATE TB_EXT_MANUTENCAO SET '+
                     'MNT_DT_CARGA =:MNT_DT_CARGA, '+
                     'MNT_DT_VENC_CARGA =:MNT_DT_VENC_CARGA '+
                     'WHERE (MNT_CODORS=:ORS_CODIGO) AND (MNT_CODEXT=:EXT_CODIGO) ');


      while not eof do
      Begin
        if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
        //Atualiza a data da carga e vencimento
        Lc_Upd_Mnt.Active := False;
        Lc_Upd_Mnt.ParamByName('ORS_CODIGO').AsInteger := FieldByname('MNT_CODORS').AsInteger;
        Lc_Upd_Mnt.ParamByName('EXT_CODIGO').AsInteger := FieldByname('MNT_CODEXT').AsInteger;
        //TRATA O VENCIMENTO DA CARGA
        Lc_Dt_Carga := StrToDateDef('01/' + Copy(DatetoStr(date) ,4,7),Date);
        Lc_Upd_Mnt.ParamByName('MNT_DT_CARGA').AsDate := Lc_Dt_Carga;
        prazo := FieldByname('ETP_VENC_CARGA').AsInteger;
        Lc_Upd_Mnt.ParamByName('MNT_DT_VENC_CARGA').AsDate := Lc_Dt_Carga + CalculaVencimentoAnual(Lc_Dt_Carga, prazo);
        Lc_Upd_Mnt.ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        next;
      end;
    end;
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
  Lc_Upd_Mnt.Close;
  Lc_Upd_Mnt.DisposeOf;
end;

Procedure Pc_PreencherDtVencEnsaio(Fc_Cd_Ordem:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Upd_Mnt : TSTQuery;
  prazo : Integer;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('Select MNT_CODORS, MNT_CODEXT,ETP_VENC_NIVEL_3 '+
            'from tb_ext_ordem_servico '+
            '  inner join tb_ext_manutencao '+
            '  on (MNT_CODORS = ORS_cODIGO) '+
            '  INNER JOIN TB_EXTINTOR '+
            '  on (EXT_CODIGO = MNT_CODEXT) '+
            '  inner join tb_ext_tipo '+
            '  on (ETP_CODIGO = EXT_CODETP) '+
            'WHERE (ORS_CODIGO=:ORS_CODIGO) AND ((ORS_CODENM = 3) or (ORS_CODENM = 4))'+
            'ORDER BY EXT_NUMERO ASC ' );
    ParamByName('ORS_CODIGO').AsInteger := Fc_Cd_Ordem;
    Active := True;
    FetchAll;
    if recordCount>0 then
      Begin
      //Atualiza a data da carga e vencimento
      Lc_Upd_Mnt := TSTQuery.Create(nil);
      Lc_Upd_Mnt.Database := DM.IBD_Gestao;
      Lc_Upd_Mnt.Transaction := DM.IB_Transacao;
      Lc_Upd_Mnt.ForcedRefresh := True;
      Lc_Upd_Mnt.CachedUpdates := True;
      Lc_Upd_Mnt.Active := False;
      Lc_Upd_Mnt.SQL.Clear;
      Lc_Upd_Mnt.SQL.Add('UPDATE TB_EXT_MANUTENCAO SET '+
                     'MNT_DT_ULT_ENSAIO =:MNT_DT_ULT_ENSAIO, '+
                     'MNT_DT_VENC_ENSAIO =:MNT_DT_VENC_ENSAIO '+
                     'WHERE (MNT_CODORS=:ORS_CODIGO) AND (MNT_CODEXT=:EXT_CODIGO) ');


      while not eof do
        Begin
        if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
        //Atualiza a data da carga e vencimento
        Lc_Upd_Mnt.Active := False;
        Lc_Upd_Mnt.ParamByName('ORS_CODIGO').AsInteger := FieldByname('MNT_CODORS').AsInteger;
        Lc_Upd_Mnt.ParamByName('EXT_CODIGO').AsInteger := FieldByname('MNT_CODEXT').AsInteger;
        Lc_Upd_Mnt.ParamByName('MNT_DT_ULT_ENSAIO').AsDate := Date;

        prazo := FieldByname('ETP_VENC_NIVEL_3').AsInteger;
        Lc_Upd_Mnt.ParamByName('MNT_DT_VENC_ENSAIO').AsDate := Date + CalculaVencimentoAnual(Date, prazo);

        Lc_Upd_Mnt.ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        next;
        end;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
  Lc_Upd_Mnt.Close;
  Lc_Upd_Mnt.DisposeOf;
end;

procedure Pc_DefineDataEncerramento(Pc_Cd_Ordem:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_EXT_ORDEM_SERVICO SET '+
            'ORS_DT_ENCERRAMENTO =:ORS_DT_ENCERRAMENTO  '+
            'where (ORS_CODIGO =:ORS_CODIGO) ' );
    ParamByName('ORS_DT_ENCERRAMENTO').AsDate := Date;
    ParamByName('ORS_CODIGO').AsInteger := Pc_Cd_Ordem;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

function Fc_FormataDataExintor(Fc_Tipo,Fc_Data:String):String;
begin
  if (Fc_Tipo = 'AAAA') then
    Result :=  Copy(Fc_Data,7,4)
  else
  if (Fc_Tipo = 'MM/AAAA') then  // - MM/AAAA
    Result :=  Copy(Fc_Data,4,7)
  else //DD/MM/AAAA
    Result :=  Fc_Data;
end;

Function Fc_UltimaOrdemExtintoresCliente(Pc_Cd_Cliente:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT FIRST 1 ORS_CODIGO '+
            'FROM TB_EXT_oRDEM_sERVICO  '+
            'where (ORS_CODEMP =:EMP_CODIGO) '+
            'order by ORS_CODIGO DESC ');
    ParamByName('EMP_CODIGO').AsInteger := Pc_Cd_cLIENTE;
    Active := True;
    FetchAll;
    Result := FieldByName('ORS_CODIGO').AsInteger;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;
//Relatórios
//01 - 01.1 - RL_EXT_ANEXO_O

//02 - 02.1 - RL_EXT_ORDEM_SERVICO
procedure Pc_ImpOrdemServico(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_Ext_Ordem_Servico;
Begin
  Try
    Lc_Rel := TRL_Ext_Ordem_Servico.Create(nil);
    Lc_Rel.It_Cd_Ordem := Pc_cd_Ordem;
    Lc_Rel.Qrpt.Preview;
  finally
    Lc_rel.Close;
    Lc_rel.DisposeOf;
  end;
end;

//03 - 03.1 - RL_EXT_MANUTENCAO_NBR12962

procedure Pc_ImpManutencaoNBR12962(Pc_cd_Ordem:Integer;Pc_Dt_Inicio,Pc_Dt_Final,Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_EXT_MANUTENCAO_NBR12962;
Begin
  Try
    Lc_Rel := TRL_EXT_MANUTENCAO_NBR12962.Create(nil);
    Lc_Rel.It_Cd_Ordem := Pc_cd_Ordem;
    Lc_Rel.It_Dt_inicio := Pc_Dt_Inicio;
    Lc_Rel.It_Dt_Final := Pc_Dt_Final;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Rel.Qrpt.Preview
    else
      Lc_Rel.Qrpt.Print;
  finally
    Lc_Rel.Close;
    Lc_Rel.DisposeOf;
  end;
      
end;

//04 - 04.1 - RL_EXT_ENSAIO_HIDRO_ALP_NBR13485
procedure Pc_ImpEnsaioHidrostaticoALP_NBR13485(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_EXT_ENSAIO_HIDRO_ALP_NBR13485;
Begin
  Try
    Lc_Rel := TRL_EXT_ENSAIO_HIDRO_ALP_NBR13485.Create(nil);
    Lc_Rel.It_Cd_Ordem := Pc_cd_Ordem;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Rel.Qrpt.Preview
    else
      Lc_Rel.Qrpt.Print;
  finally
    Lc_Rel.Close;
    Lc_Rel.DisposeOf;
  end;
end;

//05 - 05.1 - RL_EXT_ENSAIO_HIDRO_BXP_NBR13485
procedure Pc_ImpEnsaioHidrostaticoBXP_NBR13485(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_EXT_ENSAIO_HIDRO_BXP_NBR13485;
Begin
  try
    Lc_Rel := TRL_EXT_ENSAIO_HIDRO_BXP_NBR13485.Create(nil);
    Lc_Rel.It_Cd_Ordem := Pc_cd_Ordem;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Rel.Qrpt.Preview
    else
      Lc_Rel.Qrpt.Print;
  finally
    Lc_Rel.Close;
    Lc_Rel.DisposeOf;
  end;
end;

//08 - 07.1 - RL_EXT_EXTINTORES_CLIENTE
procedure Pc_ImpExtintoresCliente(Pc_cd_Cliente,Pc_Cd_Endereco:Integer;Pc_Grid : TStringGrid;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Form : TRL_Ext_Extintores_Cliente;
  Lc_Lista : String;
  Lc_I : Integer;
begin
  Lc_Lista := '';
  For Lc_I := 1 to Pc_Grid.RowCount - 1 do
  Begin
    if Pc_Grid.Cells[2,Lc_I] = 'X' then
    Begin
      if Trim(Lc_Lista) = '' then
        Lc_Lista := Pc_Grid.Cells[3,Lc_I]
      else
        Lc_Lista := Lc_Lista + ',' + Pc_Grid.Cells[3,Lc_I];
    end;
  end;

  try
    Lc_Form := TRL_Ext_Extintores_Cliente.Create(nil);
    Lc_Form.It_Cd_Cliente := Pc_cd_Cliente;
    Lc_Form.It_Cd_Endereco := Pc_Cd_Endereco;
    Lc_Form.It_ListaExtintores := Lc_Lista;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Form.Qrpt.Preview
    else
      Lc_Form.Qrpt.Print;
  finally
    Lc_Form.DisposeOf;
  end;
end;

//09 - 07.2 - RL_EXT_EXTINTORES_ORDEM
procedure Pc_ImpExtintoresOrdem(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_rel : TRL_Ext_Extintores_Ordem;
begin
  Try
    Lc_rel := TRL_Ext_Extintores_Ordem.Create(nil);
    Lc_rel.It_Cd_OrdemServico := Pc_cd_Ordem;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_rel.Qrpt.Preview
    else
      Lc_rel.Qrpt.Print;
  finally
    Lc_rel.Close;
    Lc_rel.DisposeOf;
  end;
end;

procedure Pc_ImpInspecao(Pc_cd_Ordem:Integer;Pc_Operacao,Pc_Caminho:String);
Var
  Lc_rel : TRL_EXT_INSPECAO;
begin
  Try
    Lc_rel := TRL_EXT_INSPECAO.Create(nil);
    Lc_rel.It_Cd_Ordem := Pc_cd_Ordem;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_rel.Qrpt.Preview
    else
      Lc_rel.Qrpt.Print;
  finally
    Lc_rel.close;
    Lc_rel.DisposeOf;
  end;
end;

procedure Pc_ImpEntregaRetiradaExtintores(Pc_cd_Ordem:Integer;Pc_Titulo,Pc_Operacao,Pc_Caminho:String);
Var
  Lc_Rel : TRL_EXT_RETIRADA_ENTREGA;
Begin
  try
    Lc_Rel := TRL_EXT_RETIRADA_ENTREGA.Create(nil);
    Lc_Rel.It_Titulo := Pc_Titulo;
    Lc_Rel.It_Cd_Ordem := Pc_cd_Ordem;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Rel.Qrpt.Preview
    else
      Lc_Rel.Qrpt.Print;
  finally
    Lc_Rel.Close;
    Lc_Rel.DisposeOf;
  end;
end;

procedure Pc_ImpExtRelatorioManutencao(Pc_TipoData:Integer;
                                       Pc_Periodo :Boolean;
                                       Pc_Dt_Inicial : TDAte;
                                       Pc_Dt_Final : TDAte;
                                       Pc_Cd_Cliente:Integer);
Var
  Lc_Rel : TRL_EXT_MANUTENCAO;
Begin
  Try
    Lc_Rel := TRL_EXT_MANUTENCAO.Create(nil);
    Lc_Rel.It_TipoData := Pc_TipoData;
    Lc_Rel.It_Periodo := Pc_Periodo;
    Lc_Rel.It_Dt_Inicial := Pc_Dt_Inicial;
    Lc_Rel.It_Dt_Final := Pc_Dt_Final;
    Lc_Rel.It_Cd_Cliente := Pc_Cd_Cliente;
    if (Fc_Aq_Geral('L','IMPRESSAO','IMP_P_VISUALIZA','S') = 'S') then
      Lc_Rel.Qrpt.Preview
    else
      Lc_Rel.Qrpt.Print;
  finally
    Lc_Rel.Close;
    Lc_Rel.DisposeOf;
  end;
end;



procedure Pc_AtualizaNrPedidoNaOrdem(Pc_cd_Ordem,Pc_Cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_EXT_ORDEM_SERVICO SET '+
            'ORS_CODPED =:ORS_CODPED  '+
            'where (ORS_CODIGO =:ORS_CODIGO) ' );
    ParamByName('ORS_CODPED').AsInteger := Pc_Cd_Pedido;
    ParamByName('ORS_CODIGO').AsInteger := Pc_Cd_Ordem;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;    
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;


procedure Pc_CancelarOrdemServico(Pc_cd_Ordem:Integer);
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    //Apaga o resultado
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('UPDATE TB_EXT_ORDEM_SERVICO SET ORS_DT_ENCERRAMENTO = NULL WHERE ORS_CODIGO=:ORS_CODIGO ');
    ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

Function Fc_ConsultaTipoLote(Pc_Qry:TSTQuery;Fc_Cd_Extintor:Integer;Fc_Dt_Inicial,Fc_Dt_Final:TDateTime):Integer;
Begin
  with Pc_Qry do
    Begin
    //Apaga o resultado
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('Select FIRST 1 MLT_CODVCL '+
            'from tb_movimento_lote '+
            ' INNER JOIN tb_ext_itens_ors '+
            '  ON (tb_ext_itens_ors.ios_codigo = tb_movimento_lote.mlt_codvcl) '+
            '  INNER JOIN tb_ext_ordem_servico '+
            '  ON (tb_ext_ordem_servico.ors_codigo = tb_ext_itens_ors.ios_codors ) '+
            'WHERE MLT_CODEXT =:EXT_CODIGO '+
            'AND (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) '+
            'ORDER BY MLT_DATA DESC');
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    ParamByName('DATAINI').AsDateTime := Fc_Dt_Inicial;
    ParamByName('DATAFIM').AsDateTime := Fc_Dt_Final;
    Active := True;
    FetchAll;
    Result := StrToIntDef(FieldByName('MLT_CODVCL').AsAnsiString,0);
    end;
end;

Function Fc_QtdeExintorServicoPrestado(Pc_Qry:TSTQuery;Pc_DataIni,Pc_DataFIm:TDate;Fc_Descricao,Fc_Capacidade,Fc_Classe:String):TStringList;
Var
  Lc_Qt_Rastreado : Integer;
  Lc_Qt_Reutilizado : Integer;
  Lc_Cd_Exintor : Integer;
  Lc_Qry_Aux : TSTQuery;
Begin
  Lc_Qry_Aux := TSTQuery.Create(nil);
  Lc_Qry_Aux.Database := Dm.IBD_Gestao;
  Lc_Qry_Aux.Transaction := DM.IB_Transacao;
  Lc_Qry_Aux.ForcedRefresh := True;
  Lc_Qry_Aux.CachedUpdates := True;
  result := TStringList.Create;
  result.Clear;
  with Pc_Qry do
    Begin
    //Apaga o resultado
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('Select distinct '+
            'ext_codigo, '+
            'MNT_SELO '+
            'from tb_ext_inspecao '+
            '  INNER JOIN tb_ext_manutencao '+
            '  ON (tb_ext_manutencao.mnt_codors = tb_ext_inspecao.IPC_CODORS) and (mnt_codext = ipc_codext) '+
            '  INNER JOIN tb_ext_resultado '+
            '  ON (tb_ext_resultado.ers_codors = tb_ext_inspecao.IPC_CODORS) and (ers_codext = ipc_codext) '+
            '  inner join tb_ext_ordem_servico '+
            '  on (ORS_CODIGO = IPC_CODORS) '+
            '  INNER JOIN TB_EXTINTOR tb_extintor '+
            '  ON (tb_extintor.EXT_CODIGO = tb_ext_resultado.ERS_CODEXT) '+
            '  INNER JOIN TB_EXT_TIPO tb_ext_tipo '+
            '  ON (tb_ext_tipo.ETP_CODIGO = tb_extintor.EXT_CODETP) '+
            '  LEFT OUTER JOIN TB_MOVIMENTO_LOTE '+
            '  ON (MLT_CODEXT = ipc_codext) '+
            'where (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) '+
            ' AND tb_ext_ordem_servico.ors_codenm >2 '+
            ' AND tb_ext_resultado.ers_resultado = ''S'' ');
    IF (trim(Fc_Descricao)<> '') then
      SQL.Add(' AND (ETP_DESCRICAO LIKE :ETP_DESCRICAO) ');
    IF (trim(Fc_Capacidade)<> '') then
      SQL.Add(' and (ETP_CAPACIDADE =:ETP_CAPACIDADE) ');
    IF (trim(Fc_Classe)<> '') then
      SQL.Add(' AND (ETP_CLASSE = :ETP_CLASSE) ');

    SQL.Add('ORDER BY EXT_CODIGO ASC, MLT_CODVCL DESC ');
    IF (trim(Fc_Descricao)<> '') then
      ParamByName('ETP_DESCRICAO').AsAnsiString  := '%' + Fc_Descricao + '%';
    IF (trim(Fc_Capacidade)<> '') then
      ParamByName('ETP_CAPACIDADE').AsAnsiString := Fc_Capacidade;
    IF (trim(Fc_Classe)<> '') then
      ParamByName('ETP_CLASSE').AsAnsiString := Fc_Classe;
    ParamByName('DATAINI').AsDate := Pc_DataIni;
    ParamByName('DATAFIM').AsDate := Pc_DataFim;
    Active := True;
    FetchAll;
    Lc_Qt_Rastreado := 0;
    Lc_Qt_Reutilizado := 0;
    Lc_Cd_Exintor := 0;
    First;
    while not eof do
      Begin
      if (Fc_ConsultaTipoLote(Lc_Qry_Aux,FieldByName('EXT_CODIGO').asinteger,Pc_DataIni,Pc_DataFIm) > 0) then
        Lc_Qt_Rastreado := Lc_Qt_Rastreado + 1
      else
        Lc_Qt_Reutilizado := Lc_Qt_Reutilizado + 1;
      next;
      end;
    end;
    Result.Add(IntToStr(Lc_Qt_Rastreado));
    Result.Add(IntToStr(Lc_Qt_Reutilizado));

end;

Function Fc_QtdeExintorTipoInmetro(Pc_Qry:TSTQuery;Fc_Tipo,Fc_Nr_Ordem:String):Integer;
Begin
  with Pc_Qry do
    Begin
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('SELECT MNT_CODORS, etp_desc_inmetro, count(MNT_SELO) MNT_QT_SELOS '+
            'FROM tb_ext_ordem_servico '+
            '   INNER JOIN tb_ext_manutencao '+
            '   ON (tb_ext_manutencao.MNT_CODORS = tb_ext_ordem_servico.ors_codigo) '+
            '   INNER JOIN TB_EXTINTOR '+
            '   ON (EXT_CODIGO = MNT_CODEXT) '+
            '   INNER JOIN tb_ext_tipo '+
            '   ON (TB_EXT_TIPO.ETP_CODIGO = tb_extintor.ext_codetp) '+
            'WHERE ORS_NUMERO=:ORS_NUMERO AND  etp_desc_inmetro=:etp_desc_inmetro '+
            ' AND tb_ext_ordem_servico.ors_codenm >2' +
            ' AND (MNT_SELO <> '''' )'+
            ' GROUP BY 1,2');
    ParamByName('ORS_NUMERO').AsAnsiString := Fc_Nr_Ordem;
    ParamByName('ETP_DESC_INMETRO').AsAnsiString := Fc_Tipo;
    Active := True;
    FetchAll;
    Result := FieldByName('MNT_QT_SELOS').AsInteger;
    end;
end;


Function Fc_SequenciaSeloUtilizado(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if Fc_tipo = 'MINIMO' then
      Fc_tipo := 'Select MIN(CAST(MNT_SELO AS INTEGER)) SELO '
    else
      Fc_tipo := 'Select MAX( CAST(MNT_SELO AS INTEGER)) SELO ';
    Fc_tipo := Fc_tipo +  
            'from tb_ext_ordem_servico '+
            '  inner join tb_ext_manutencao '+
            '  on (ORS_CODIGO =MNT_CODORS) '+
            '  INNER JOIN TB_EXTINTOR tb_extintor '+
            '  ON (EXT_CODIGO = MNT_CODEXT) '+
            '  inner join tb_ext_resultado  '+
            '  on (EXT_CODIGO = ers_codext)and  (tb_ext_resultado.ers_codors =MNT_CODORS) '+
            'WHERE tb_ext_ordem_servico.ors_dt_encerramento BETWEEN :DATAINI AND :DATAFIM AND MNT_SELO IS not NULL AND MNT_SELO <>'''' '+
            'AND tb_ext_ordem_servico.ors_codenm >2 '+
            'and (tb_ext_resultado.ers_resultado = ''S'') '; 
    SQL.Add(Fc_Tipo);
    ParamByName('DATAINI').AsDate := Fc_DataIni;
    ParamByName('DATAFIM').AsDate := Fc_DataFIm;            
    Active := True;
    FetchAll;
    Result := FieldByName('SELO').AsAnsiString;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

Function Fc_SequenciaOrdemUtilizado(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if (Fc_Tipo = 'MINIMO') then
      SQL.Add('Select MIN(ORS_NUMERO) NUMERO ')
    else
      SQL.Add('Select MAX(ORS_NUMERO) NUMERO ');
    SQL.Add('from tb_ext_ordem_servico '+
            'WHERE ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM ');
    ParamByName('DATAINI').AsDate := Fc_DataIni;
    ParamByName('DATAFIM').AsDate := Fc_DataFIm;
    Active := True;
    FetchAll;
    Result := FieldByName('NUMERO').AsAnsiString;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

Function Fc_SequenciaManutencaoUtilizada(Fc_Tipo:String;Fc_DataIni,Fc_DataFIm:TDate):String;
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if (Fc_Tipo = 'MINIMO') then
      SQL.Add('Select MIN(ORS_NR_MANUTENCAO) NUMERO ')
    else
      SQL.Add('Select MAX(ORS_NR_MANUTENCAO) NUMERO ');
    SQL.Add('from tb_ext_ordem_servico '+
            'WHERE ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM ');
    ParamByName('DATAINI').AsDate := Fc_DataIni;
    ParamByName('DATAFIM').AsDate := Fc_DataFIm;
    Active := True;
    FetchAll;
    Result := FieldByName('NUMERO').AsAnsiString;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;


//18 - 13.1 - RL_EXT_RELACAO_SERVICOS_PRESTADOS
procedure Pc_ExpRelacaoServicoPrestado(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel;Pc_DataIni,Pc_DataFIm:TDate);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Cont_Ini : Integer;
  Lc_Cont_Fim : Integer;
  Lc_Texto : String;
  Lc_Qry : TSTQuery;
  Jp_IMage: TImage;
  Lc_Total_Carga : Real;
  Lc_cd_Edit_Color : Integer;
  Lc_cd_Tl_Qtde_Color : Integer;
  Lc_cd_Tl_Carga_Color : Integer;
  Lc_SeloIni_1:String;
  Lc_SeloFim_1:String;
  Lc_SeloIni_2:String;
  Lc_SeloFim_2:String;
  Lc_Qt_Selo : Integer;
  Lc_Qt_Exintores : TStringList;
  Lc_TL_Qt_Extintores : Integer;
  Lc_Qry_Aux : TSTQuery;
  Lc_I : Integer;
begin
  Lc_Qt_Exintores := TStringList.Create;
  Lc_TL_Qt_Extintores := 0;
  //Controla o acompanhamento
  Pc_Progresso.Progress := 1;
  Pc_Progresso.MinValue := 1;
  Pc_Progresso.MaxValue := 4;
  Pc_Progresso.Visible := True;
  Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
  Pc_Acompanhamento.Visible := True;
  Pc_Acompanhamento.Update;

  //Cor dos campos editaveis
  Lc_cd_Edit_Color := 65535;
  Lc_cd_Tl_Qtde_Color := 5296274;
  Lc_cd_Tl_Carga_Color := 12611584;
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Periodo';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  // Cabeçalho 1º Linha
  Lc_Sheet.Range['A1', 'G1'].Select;
  Lc_Sheet.Range['A1', 'G1'].Activate;
  Lc_Sheet.Range['A1', 'G1'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['A1', 'G1'].Cells.RowHeight := 30;
  Lc_Sheet.Range['A1', 'G1'].Cells.WrapText := True;
  Lc_Sheet.Range['A1', 'G1'].Cells.VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range['A1', 'G1'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['A1', 'G1'].Merge(xlAutomatic);
  Lc_Sheet.Range['A1', 'G1'].Orientation := 0;
  Lc_Sheet.Range['A1', 'G1'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A1', 'A1'].Value := 'RELATÓRIO MENSAL DE SERVIÇOS PRESTADOS NA ÁREA DE INSPEÇÃO TÉCNICA E MANUNTEÇÃO DE EXTINTORES DE INCÊNDIO';

  // Cabeçalho 2º Linha - Logomarca
  Lc_Sheet.Range['A2', 'A8'].Select;
  Lc_Sheet.Range['A2', 'A8'].Activate;
  Lc_Sheet.Range['A2', 'A8'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['A2', 'A8'].Cells.RowHeight := 15;
  Lc_Sheet.Range['A2', 'A8'].Cells.WrapText := True;
  Lc_Sheet.Range['A2', 'A8'].Cells.VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range['A2', 'A8'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['A2', 'A8'].MergeCells := True;//Merge(xlAutomatic);
  Lc_Sheet.Range['A2', 'A8'].Orientation := 0;
  Lc_Sheet.Range['A2', 'A8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Pc_Progresso.Progress := 2;
  Pc_Acompanhamento.Caption := 'Aplicando a Logo no Arquivo..';
  Pc_Acompanhamento.Update;
  Try
    Jp_IMage := TImage.Create(nil);
    Fc_BuscaImagemEmpresa(Jp_IMage.Picture,'LOGO');
    if (Jp_IMage.Picture.Graphic <> Nil) then
      Begin
      Jp_IMage.Picture.SaveToFile(GbPathExe + 'logo.jpg');
      Lc_Sheet.Shapes.AddPicture(GbPathExe + 'logo.jpg', 0, 1, 002, 060, 72,51);
      end;
  Finally
    FreeAndNil(Jp_IMage);
  End;
  //Dados do Estabelecimento
  Pc_AtivaEstabelecimento;
  // Cabeçalho 2º Linha - Label Empresa
  Lc_Sheet.Range['B2', 'B2'].Select;
  Lc_Sheet.Range['B2', 'B2'].Activate;
  Lc_Sheet.Range['B2', 'B2'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B2', 'B2'].Value := 'EMPRESA';

  // Cabeçalho 2º Linha - Texto Empresa
  Lc_Sheet.Range['C2', 'G2'].Select;
  Lc_Sheet.Range['C2', 'G2'].Activate;
  Lc_Sheet.Range['C2', 'G2'].Merge(xlAutomatic);
  Lc_Sheet.Range['C2', 'G2'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C2', 'G2'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C2', 'C2'].Value := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsAnsiString;

  // Cabeçalho 3º Linha - ENDERECO
  Lc_Sheet.Range['B3', 'B3'].Select;
  Lc_Sheet.Range['B3', 'B3'].Activate;
  Lc_Sheet.Range['B3', 'B3'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B3', 'B3'].Value := 'ENDEREÇO';

  // Cabeçalho 3º Linha - Texto do Endereço
  Lc_Sheet.Range['C3', 'G3'].Select;
  Lc_Sheet.Range['C3', 'G3'].Activate;
  Lc_Sheet.Range['C3', 'G3'].Merge(xlAutomatic);
  Lc_Sheet.Range['C3', 'G3'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C3', 'G3'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C3', 'C3'].Value := DM.Qr_Estabelecimento.FieldByName('END_ENDER').AsAnsiString + ', '+ DM.Qr_Estabelecimento.FieldByName('END_NUMERO').AsAnsiString;

  // Cabeçalho 4º Linha - Label Mes
  Lc_Sheet.Range['B4', 'B4'].Select;
  Lc_Sheet.Range['B4', 'B4'].Activate;
  Lc_Sheet.Range['B4', 'B4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B4', 'B4'].Value := 'MÊS';

  // Cabeçalho 4º Linha - Texto Mes
  Lc_Sheet.Range['C4', 'G4'].Select;
  Lc_Sheet.Range['C4', 'G4'].Activate;
  Lc_Sheet.Range['C4', 'G4'].Merge(xlAutomatic);
  Lc_Sheet.Range['C4', 'G4'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C4', 'G4'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C4', 'G4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C4', 'C4'].Value := Fc_DesMes(StrToInt(Copy(DateToStr(Pc_DataIni),4,2)),True);

  // Cabeçalho 5º Linha - Label Periodo
  Lc_Sheet.Range['B5', 'B5'].Select;
  Lc_Sheet.Range['B5', 'B5'].Activate;
  Lc_Sheet.Range['B5', 'B5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B5', 'B5'].Value := 'PERÍODO';

  // Cabeçalho 5º Linha - Texto Periodo Inicial
  Lc_Sheet.Range['C5', 'C5'].Select;
  Lc_Sheet.Range['C5', 'C5'].Activate;
  Lc_Sheet.Range['C5', 'C5'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C5', 'C5'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C5', 'C5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C5', 'C5'].Value := ''''+DateToStr(Pc_DataIni);

  // Cabeçalho 5º Linha - Label Periodo final
  Lc_Sheet.Range['D5', 'D5'].Select;
  Lc_Sheet.Range['D5', 'D5'].Activate;
  Lc_Sheet.Range['D5', 'D5'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D5', 'D5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D5', 'D5'].Value := 'A';

  // Cabeçalho 5º Linha - Texto Periodo final
  Lc_Sheet.Range['E5', 'E5'].Select;
  Lc_Sheet.Range['E5', 'E5'].Activate;
  Lc_Sheet.Range['E5', 'E5'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['E5', 'E5'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E5', 'E5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['E5', 'E5'].Value := ''''+DateToStr(Pc_DataFIm);

  Pc_Progresso.Progress := 3;
  Pc_Acompanhamento.Caption := 'Verificando Sequência de Selos Utilizados..';
  Pc_Acompanhamento.Update;

  //Inicializa as variaveis com o primeiro e o ultimo selo utilizado
  Lc_SeloIni_1 := Fc_SequenciaSeloUtilizado('MINIMO',Pc_DataIni,Pc_DataFIm);
  Lc_SeloFim_1 := Fc_SequenciaSeloUtilizado('MAXIMO',Pc_DataIni,Pc_DataFIm);
  //Segundo Lote
  Lc_SeloIni_2 := '';
  Lc_SeloFim_2 := '';

  //Verifica quantos lotes de Selos foram utilizados
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM TB_EXT_SELOS '+
            'WHERE (:INICIO between esl_inicio and esl_fim) or '+
            '      (:FIM    between esl_inicio and esl_fim) '+
            ' ORDER BY ESL_DATA');
    ParamByName('INICIO').AsInteger := StrToIntDef(Lc_SeloIni_1,0);
    ParamByName('FIM').AsInteger := StrToIntDef(Lc_SeloFim_1,0);
    Active := True;
    FetchAll;
    //Se a Quantidade de lote de selo for maior que 1 então refazer as sequencias de selo
    if (RecordCount > 1) then
    Begin
      //Redefine o ultimo selo do primeiro para o ultimo selo do segundo
      Lc_SeloFim_2 := Lc_SeloFim_1;
      //Redefine o final do primeiro com o primeiro registro da consulta do lote
      Lc_SeloFim_1 := FieldByname('ESL_FIM').AsAnsiString;
      //Redefine o inicio do segundo com o ultimo registro da consulta do lote
      Next;//avança para o segundo registro
      Lc_SeloIni_2 := FieldByname('ESL_INICIO').AsAnsiString;
    end;
  end;



  // Cabeçalho 6º Linha - Label Selo
  Lc_Sheet.Range['B6', 'B6'].Select;
  Lc_Sheet.Range['B6', 'B6'].Activate;
  Lc_Sheet.Range['B6', 'B6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B6', 'B6'].Value := 'SELO INICIAL';

  // Cabeçalho 6º Linha - Texto Selo Inicial
  Lc_Sheet.Range['C6', 'C6'].Select;
  Lc_Sheet.Range['C6', 'C6'].Activate;
  Lc_Sheet.Range['C6', 'C6'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C6', 'C6'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C6', 'C6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C6', 'C6'].Value := Lc_SeloIni_1;

  // Cabeçalho 6º Linha - Label Selo final
  Lc_Sheet.Range['D6', 'D6'].Select;
  Lc_Sheet.Range['D6', 'D6'].Activate;
  Lc_Sheet.Range['D6', 'D6'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D6', 'D6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D6', 'D6'].Value := 'SELO FINAL';

  // Cabeçalho 6º Linha - Texto Selo final
  Lc_Sheet.Range['E6', 'E6'].Select;
  Lc_Sheet.Range['E6', 'E6'].Activate;
  Lc_Sheet.Range['E6', 'E6'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['E6', 'E6'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E6', 'E6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['E6', 'E6'].Value := Lc_SeloFim_1;

  // Cabeçalho 7º Linha - Label Selo - 2
  Lc_Sheet.Range['B7', 'B7'].Select;
  Lc_Sheet.Range['B7', 'B7'].Activate;
  Lc_Sheet.Range['B7', 'B7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B7', 'B7'].Value := 'SELO INICIAL';

  // Cabeçalho 7º Linha - Texto Selo Inicial - 2
  Lc_Sheet.Range['C8', 'C7'].Select;
  Lc_Sheet.Range['C8', 'C7'].Activate;
  Lc_Sheet.Range['C8', 'C7'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C8', 'C7'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C8', 'C7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C8', 'C7'].Value := Lc_SeloIni_2;

  // Cabeçalho 7º Linha - Label Selo final - 2
  Lc_Sheet.Range['D7', 'D7'].Select;
  Lc_Sheet.Range['D7', 'D7'].Activate;
  Lc_Sheet.Range['D7', 'D7'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D7', 'D7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D7', 'D7'].Value := 'SELO FINAL';

  // Cabeçalho 7º Linha - Texto Selo final - 2
  Lc_Sheet.Range['E7', 'E7'].Select;
  Lc_Sheet.Range['E7', 'E7'].Activate;
  Lc_Sheet.Range['E7', 'E7'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['E7', 'E7'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E7', 'E7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['E7', 'E7'].Value := Lc_SeloFim_2;

  Pc_Progresso.Progress := 4;
  Pc_Acompanhamento.Caption := 'Verificando Sequência de Ordens de Serviço..';
  Pc_Acompanhamento.Update;

  // Cabeçalho 8º Linha - Label O.S
  Lc_Sheet.Range['B8', 'B8'].Select;
  Lc_Sheet.Range['B8', 'B8'].Activate;
  Lc_Sheet.Range['B8', 'B8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B8', 'B8'].Value := 'MAN. INICIAL';

  // Cabeçalho 8º Linha - Texto  O.S
  Lc_Sheet.Range['C8', 'C8'].Select;
  Lc_Sheet.Range['C8', 'C8'].Activate;
  Lc_Sheet.Range['C8', 'C8'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['C8', 'C8'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C8', 'C8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C8', 'C8'].Value := StrTOIntDef( Fc_SequenciaManutencaoUtilizada('MINIMO',Pc_DataIni,Pc_DataFIm),0);

  // Cabeçalho 8º Linha - Label  O.S final
  Lc_Sheet.Range['D8', 'D8'].Select;
  Lc_Sheet.Range['D8', 'D8'].Activate;
  Lc_Sheet.Range['D8', 'D8'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D8', 'D8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D8', 'D8'].Value := 'MAN. FINAL';

  // Cabeçalho 8º Linha - Texto  O.S final
  Lc_Sheet.Range['E8', 'E8'].Select;
  Lc_Sheet.Range['E8', 'E8'].Activate;
  Lc_Sheet.Range['E8', 'E8'].Interior.Color := Lc_cd_Edit_Color;
  Lc_Sheet.Range['E8', 'E8'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E8', 'E8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['E8', 'E8'].Value := Fc_SequenciaManutencaoUtilizada('MAXIMO',Pc_DataIni,Pc_DataFIm);

  //Quantidade de Selos Celulas Mesclada
  Lc_Sheet.Range['F5', 'G8'].Select;
  Lc_Sheet.Range['F5', 'G8'].Activate;
  Lc_Sheet.Range['F5', 'G8'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['F5', 'G8'].Cells.WrapText := True;
  Lc_Sheet.Range['F5', 'G8'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F5', 'G8'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F5', 'G8'].MergeCells := True;
  Lc_Sheet.Range['F5', 'G8'].Orientation := 0;
  Lc_Sheet.Range['F5', 'G8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  if (StrtoIntDef(Lc_SeloFim_1,0) - StrtoIntDef(Lc_SeloIni_1,0)) > 0 then
    Lc_Qt_Selo := StrtoIntDef(Lc_SeloFim_1,0) - StrtoIntDef(Lc_SeloIni_1,0) + 1;

  if (StrtoIntDef(Lc_SeloFim_2,0) - StrtoIntDef(Lc_SeloIni_2,0)) > 0 then
    Lc_Qt_Selo := Lc_Qt_Selo + StrtoIntDef(Lc_SeloFim_2,0) - StrtoIntDef(Lc_SeloIni_2,0) + 1;

  Lc_Sheet.Range['F5', 'F5'].Value := 'QUANTIDADE TOTAL DE SELOS ' + IntToStr(Lc_Qt_Selo);

  // Cabeçalho 9º Linha - Observação envio ao inmetro
  Lc_Sheet.Range['A9', 'G9'].Select;
  Lc_Sheet.Range['A9', 'G9'].Activate;
  Lc_Sheet.Range['A9', 'G9'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['A9', 'G9'].MergeCells := True;
  Lc_Sheet.Range['A9', 'G9'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A9', 'A9'].Value := 'OBS: Enviar o relatório mensal ao Inmetro/RS até o dia 10 d mês subsequente';

  // Cabeçalho 10° e 11º Linha - Cabeçalho do Tipo
  Lc_Sheet.Range['A10', 'A11'].Select;
  Lc_Sheet.Range['A10', 'A11'].Activate;
  Lc_Sheet.Range['A10', 'A11'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['A10', 'A11'].Cells.RowHeight := 15;
  Lc_Sheet.Range['A10', 'A11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['A10', 'A11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['A10', 'A11'].MergeCells := True;
  Lc_Sheet.Range['A10', 'A11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A10', 'A10'].Value := 'TIPO';

  // Cabeçalho 10° e 11º Linha - Cabeçalho do Cap. Ext. (kg)
  Lc_Sheet.Range['B10', 'B11'].Select;
  Lc_Sheet.Range['B10', 'B11'].Activate;
  Lc_Sheet.Range['B10', 'B11'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['B10', 'B11'].Cells.RowHeight := 15;
  Lc_Sheet.Range['B10', 'B11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['B10', 'B11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['B10', 'B11'].MergeCells := True;
  Lc_Sheet.Range['B10', 'B11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['B10', 'B10'].Value := 'CAP. EXT. (kg)';

  // Cabeçalho 10° e 11º Linha - Cabeçalho do Ext. Novo e Rastreado (kg)
  Lc_Sheet.Range['C10', 'C11'].Select;
  Lc_Sheet.Range['C10', 'C11'].Activate;
  Lc_Sheet.Range['C10', 'C11'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['C10', 'C11'].Cells.RowHeight := 15;
  Lc_Sheet.Range['C10', 'C11'].Cells.WrapText := True;
  Lc_Sheet.Range['C10', 'C11'].Cells.VerticalAlignment := integer(xlTop);
  Lc_Sheet.Range['C10', 'C10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C10', 'C11'].MergeCells := True;
  Lc_Sheet.Range['C10', 'C11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C10', 'C10'].Value := 'EXT. NOVO E RASTREADO (kg)';

  // Cabeçalho 10° Linha - Cabeçalho do QUANT. EXT. C/ PÓ NOVO';
  Lc_Sheet.Range['D10', 'E10'].Select;
  Lc_Sheet.Range['D10', 'E10'].Activate;
  Lc_Sheet.Range['D10', 'E10'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['D10', 'E10'].Cells.RowHeight := 15;
  Lc_Sheet.Range['D10', 'E10'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D10', 'E10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D10', 'E10'].MergeCells := True;
  Lc_Sheet.Range['D10', 'E10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D10', 'E10'].Value := 'QUANT. EXT. C/ PÓ NOVO';

  // Cabeçalho 11° Linha - Cabeçalho do QUANTIDADE
  Lc_Sheet.Range['D11', 'D11'].Select;
  Lc_Sheet.Range['D11', 'D11'].Activate;
  Lc_Sheet.Range['D11', 'D11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D11', 'D11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D11', 'D11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['D11', 'D11'].Value := 'QUANTIDADE';

  // Cabeçalho 11° Linha - Cabeçalho do CARGA(KG)
  Lc_Sheet.Range['E11', 'E11'].Select;
  Lc_Sheet.Range['E11', 'E11'].Activate;
  Lc_Sheet.Range['E11', 'E11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E11', 'E11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E11', 'E11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['E11', 'E11'].Value := 'CARGA (kg)';

  // Cabeçalho 10° Linha - Cabeçalho do QUANT. EXT. C/ PÓ RASTREADO
  Lc_Sheet.Range['F10', 'G10'].Select;
  Lc_Sheet.Range['F10', 'G10'].Activate;
  Lc_Sheet.Range['F10', 'G10'].Cells.ColumnWidth := 14.14;
  Lc_Sheet.Range['F10', 'G10'].Cells.RowHeight := 15;
  Lc_Sheet.Range['F10', 'G10'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F10', 'G10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F10', 'G10'].Merge(xlAutomatic);
  Lc_Sheet.Range['F10', 'G10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['F10', 'F10'].Value := 'QUANT. EXT. C/ PÓ RASTREADO';

  // Cabeçalho 11° Linha - Cabeçalho do QUANTIDADE
  Lc_Sheet.Range['F11', 'F11'].Select;
  Lc_Sheet.Range['F11', 'F11'].Activate;
  Lc_Sheet.Range['F11', 'F11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F11', 'F11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F11', 'F11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['F11', 'F11'].Value := 'QUANTIDADE';

  // Cabeçalho 11° Linha - Cabeçalho do CARGA(KG)
  Lc_Sheet.Range['G11', 'G11'].Select;
  Lc_Sheet.Range['G11', 'G11'].Activate;
  Lc_Sheet.Range['G11', 'G11'].Cells.VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['G11', 'G11'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['G11', 'G11'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['G11', 'G11'].Value := 'CARGA (kg)';
  //Consulta para Preencher o Tipo PO
  with Lc_Qry do
    Begin
    Active := False;
    SQL.Clear;
    SQL.Add('Select  '+
            '  ETP_CAPACIDADE, '+
            '  ETP_DESCRICAO, '+
            '  ETP_CLASSE, '+
            '  COUNT(IPC_CODORS) TOTAL '+
            'from tb_ext_inspecao '+
            '  INNER JOIN tb_ext_manutencao '+
            '  ON (tb_ext_manutencao.mnt_codors = tb_ext_inspecao.IPC_CODORS) and (mnt_codext = ipc_codext) '+
            '  INNER JOIN tb_ext_resultado '+
            '  ON (tb_ext_resultado.ers_codors = tb_ext_inspecao.IPC_CODORS) and (ers_codext = ipc_codext) '+
            '  inner join tb_ext_ordem_servico '+
            '  on (ORS_CODIGO = IPC_CODORS) '+
            '  INNER JOIN TB_EXTINTOR tb_extintor '+
            '  ON (tb_extintor.EXT_CODIGO = tb_ext_resultado.ERS_CODEXT) '+
            '  INNER JOIN TB_EXT_TIPO tb_ext_tipo '+
            '  ON (tb_ext_tipo.ETP_CODIGO = tb_extintor.EXT_CODETP) '+
            'WHERE (ETP_DESCRICAO LIKE :ETP_DESCRICAO) '+
            ' AND  (ETP_CLASSE =:ETP_CLASSE ) '+
            ' and (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) '+
            ' AND tb_ext_ordem_servico.ors_codenm >2 '+
            ' AND tb_ext_resultado.ers_resultado = ''S'' ' +
            'group by 1,2,3 '+
            'order by 2 DESC,1,3');
    ParamByName('ETP_DESCRICAO').AsAnsiString := '%PO%';
    ParamByName('ETP_CLASSE').AsAnsiString := 'BC';
    ParamByName('DATAINI').AsDate := Pc_DataIni;
    ParamByName('DATAFIM').AsDate := Pc_DataFIm;
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
      Begin
      //CRia Query para auxiliar função
      Lc_Qry_Aux  :=TSTQuery.Create(nil);
      Lc_Qry_Aux.Database := Dm.IBD_Gestao;
      Lc_Qry_Aux.Transaction := DM.IB_Transacao;
      LC_Qry_Aux.ForcedRefresh := True;
      LC_Qry_Aux.CachedUpdates := True;
      LC_Qry_Aux.ForcedRefresh := True;

      //Controla Acompanhamento
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Acompanhamento.Caption := 'Gerando dados de Pó BC...';
      Pc_Acompanhamento.Update;
      Lc_Linha := 12;
      Lc_Cont_Ini := Lc_Linha;
      Lc_Cont_Fim := Lc_Linha;
      //Cria a Qry

      while not eof do
        Begin
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Progresso.Update;

        //Coluna Capacidade Nominal
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'B' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := FieldByName('ETP_CAPACIDADE').AsString;
        //Coluna Ext Novo e Rastreado
        Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := FieldByName('TOTAL').Value;
        Lc_TL_Qt_Extintores := Lc_TL_Qt_Extintores + FieldByName('TOTAL').Value;
        //Coluna quantidade de Ext com pó novo
        Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'D' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                          Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Qt_Exintores.Strings[0];
        //Coluna carga de Ext com pó novo
        Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'E' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Total_Carga := StrToIntDef(Lc_Qt_Exintores.Strings[0],0) * FieldByName('ETP_CAPACIDADE').AsFloat;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Total_Carga;
        //Coluna quantidade de Ext com pó rastreado/Reutilizado
        Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'F' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                          Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[1],0);
        //Coluna carga de Ext com pó rastreado/Reutilizado
        Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Total_Carga := StrToIntDef(Lc_Qt_Exintores.Strings[1],0) * FieldByName('ETP_CAPACIDADE').AsFloat;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Total_Carga;
        inc(Lc_linha);
        inc(Lc_Cont_Fim);
        next;
        end;
      //Totaliza o tipo e classe BC
      Lc_StrCell1 := 'A' + IntToStr(Lc_Cont_Ini);
      Lc_StrCell2 := 'A' + IntToStr(Lc_Cont_Fim - 1);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('ETP_DESCRICAO').AsAnsiString + ' "' + FieldByName('ETP_CLASSE').AsAnsiString + '"';
      //LAbel do total
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'B' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Totais';
      //Texto do total Extintores
      Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Unidades po novo
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'D' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Carga po novo
      Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'E' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Unidades po Reutilizado
      Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Carga po Reutilizado
      Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      end;
    //------------------------------------------------------------------------------
    //Consulta Nova Classe
    Active := False;
    ParamByName('ETP_DESCRICAO').AsAnsiString := '%PO%';
    ParamByName('ETP_CLASSE').AsAnsiString := 'ABC';
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
      Begin
      Inc(Lc_Linha);
      Lc_Cont_Ini := Lc_Linha;
      Lc_Cont_Fim := Lc_Linha;
      //Controla Acompanhamento
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Acompanhamento.Caption := 'Gerando dados de Pó ABC...';
      Pc_Acompanhamento.Update;
      while not eof do
        Begin
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Progresso.Update;


        //Coluna Capacidade Nominal
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'B' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := FieldByName('ETP_CAPACIDADE').AsString;
        //Coluna Ext Novo e Rastreado
        Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := FieldByName('TOTAL').Value;
        Lc_TL_Qt_Extintores := Lc_TL_Qt_Extintores + FieldByName('TOTAL').Value;
        //Coluna quantidade de Ext com pó novo
        Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'D' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                          Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[0],0);
        //Coluna carga de Ext com pó novo
        Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'E' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Total_Carga := StrToIntDef(Lc_Qt_Exintores.Strings[0],0) * FieldByName('ETP_CAPACIDADE').AsFloat;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Total_Carga;

        //Coluna quantidade de Ext com pó rastreado/Reutilizado
        Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'F' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                          Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[1],0);
        //Coluna carga de Ext com pó rastreado/Reutilizado
        Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Total_Carga := StrToIntDef(Lc_Qt_Exintores.Strings[1],0) * FieldByName('ETP_CAPACIDADE').AsFloat;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Total_Carga;
        inc(Lc_linha);
        inc(Lc_Cont_Fim);
        next;
        end;
      //Totaliza o tipo e classe BC
      Lc_StrCell1 := 'A' + IntToStr(Lc_Cont_Ini);
      Lc_StrCell2 := 'A' + IntToStr(Lc_Cont_Fim - 1);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('ETP_DESCRICAO').AsAnsiString + ' "' + FieldByName('ETP_CLASSE').AsAnsiString + '"';
      //LAbel do total
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'B' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Totais';
      //Texto do total Extintores
      Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Unidades po novo
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'D' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Carga po novo
      Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'E' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Unidades po Reutilizado
      Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'F' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //Texto do total Carga po Reutilizado
      Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      end;
    //------------------------------------------------------------------------------
    //Novo cabecho para a Nova Classe de extintores - Capacidade
    Inc(Lc_Linha);
    Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'A' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.RowHeight := 30;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := 'TIPO';
    //Novo cabecho para a Nova Classe de extintores - Capacidade
    Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.RowHeight := 30;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := 'CAPACIDADE DOS EXTINTORES';
    //Novo cabecho para a Nova Classe de extintores - Quantidade
    Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.RowHeight := 30;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := 'QUANTIDADE DE EXTINTORES';
    //Consulta Nova Classe
    Active := False;
    ParamByName('ETP_DESCRICAO').AsAnsiString := 'AG';
    ParamByName('ETP_CLASSE').AsAnsiString := 'A';
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
      Begin
      //Nova Linha
      Inc(Lc_Linha);
      Lc_Cont_Ini := Lc_Linha;
      Lc_Cont_Fim := Lc_Linha;
      Lc_Total_Carga := 0;
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Acompanhamento.Caption := 'Gerando dados de Água...';
      Pc_Acompanhamento.Update;
      while not eof do
        Begin
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Progresso.Update;

        //Coluna Ext Novo e Rastreado
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := FieldByName('ETP_CAPACIDADE').AsString;
        //Coluna quantidade de Ext com pó novo
        Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                        Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[0],0) + StrToIntDef(Lc_Qt_Exintores.Strings[1],0);
        Lc_Total_Carga := Lc_Total_Carga + (StrToIntDef(Lc_Qt_Exintores.Strings[1],0) * FieldByName('ETP_CAPACIDADE').AsFloat);
        Lc_TL_Qt_Extintores := Lc_TL_Qt_Extintores +  + FieldByName('TOTAL').Value;
        inc(Lc_linha);
        inc(Lc_Cont_Fim);
        next;
        end;
      //Totaliza o tipo e classe BC
      Lc_StrCell1 := 'A' + IntToStr(Lc_Cont_Ini);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;//Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('ETP_DESCRICAO').AsAnsiString + ' "' + FieldByName('ETP_CLASSE').AsAnsiString + '"';
      //LAbel do total - 1
      Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Quantidade total Ext. AP';
      //Texto do total Extintores
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //LAbel do total - 2
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Total Carga de Água (L)';
      //Texto do total Extintores - 2
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Total_Carga;
      end;
    //------------------------------------------------------------------------------
    //Consulta Nova Classe
    Active := False;
    ParamByName('ETP_DESCRICAO').AsAnsiString := '%EM%';
    ParamByName('ETP_CLASSE').AsAnsiString := 'AB';
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
      Begin
      //Nova Linha
      Inc(Lc_Linha);
      Lc_Cont_Ini := Lc_Linha;
      Lc_Cont_Fim := Lc_Linha;
      Lc_Total_Carga := 0;
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Acompanhamento.Caption := 'Gerando dados Espuma Mecânica...';
      Pc_Acompanhamento.Update;
      while not eof do
        Begin
        Pc_Progresso.Progress := Pc_Progresso.Progress  +1;
        Pc_Progresso.Update;
        //Coluna capacidade
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := FieldByName('ETP_CAPACIDADE').AsString;
        //Coluna quantidade de Extintores
        Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                        Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[0],0) + StrToIntDef(Lc_Qt_Exintores.Strings[1],0);
        Lc_Total_Carga := Lc_Total_Carga + (StrToIntDef(Lc_Qt_Exintores.Strings[1],0) * FieldByName('ETP_CAPACIDADE').AsFloat);
        Lc_TL_Qt_Extintores := Lc_TL_Qt_Extintores +  + FieldByName('TOTAL').Value;
        inc(Lc_linha);
        inc(Lc_Cont_Fim);
        next;
        end;
      //Totaliza o tipo e classe BC
      Lc_StrCell1 := 'A' + IntToStr(Lc_Cont_Ini);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;//Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('ETP_DESCRICAO').AsAnsiString + ' "' + FieldByName('ETP_CLASSE').AsAnsiString + '"';
      //LAbel do total - 1
      Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Quantidade total E.M';
      //Texto do total Extintores
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //LAbel do total - 2
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Quantidade total Espuma Mecânica (L)';
      //Texto do total Extintores - 2
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Total_Carga;
      end;
      //------------------------------------------------------------------------------
    //Consulta Nova Classe
    Active := False;
    ParamByName('ETP_DESCRICAO').AsAnsiString := '%CO2%';
    ParamByName('ETP_CLASSE').AsAnsiString := 'BC';
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
    Begin
      //Nova Linha
      Inc(Lc_Linha);
      Lc_Cont_Ini := Lc_Linha;
      Lc_Cont_Fim := Lc_Linha;
      Lc_Total_Carga := 0;
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Acompanhamento.Caption := 'Gerando dados CO2 BC...';
      Pc_Acompanhamento.Update;
      For Lc_I := 1 to  RecordCount do
      BEgin
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Pc_Progresso.Update;
        //Coluna capacidade
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := FieldByName('ETP_CAPACIDADE').AsString;
        //Coluna quantidade de Extintores
        Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Edit_Color;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
        Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,
                                                          Pc_DataIni,
                                                          Pc_DataFIm,
                                                          FieldByName('ETP_DESCRICAO').AsAnsiString,
                                                          FieldByName('ETP_CAPACIDADE').AsAnsiString,
                                                          FieldByName('ETP_CLASSE').AsAnsiString);
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := StrToIntDef(Lc_Qt_Exintores.Strings[0],0) + StrToIntDef(Lc_Qt_Exintores.Strings[1],0);
        Lc_Total_Carga := Lc_Total_Carga + ( (StrToIntDef(Lc_Qt_Exintores.Strings[0],0) + StrToIntDef(Lc_Qt_Exintores.Strings[1],0) ) * FieldByName('ETP_CAPACIDADE').AsFloat);
        Lc_TL_Qt_Extintores := Lc_TL_Qt_Extintores +  + FieldByName('TOTAL').Value;
        inc(Lc_linha);
        inc(Lc_Cont_Fim);
        next;
      end;
      //Totaliza o tipo e classe BC
      Lc_StrCell1 := 'A' + IntToStr(Lc_Cont_Ini);
      Lc_StrCell2 := 'A' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].MergeCells := True;//Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := FieldByName('ETP_DESCRICAO').AsAnsiString + ' "' + FieldByName('ETP_CLASSE').AsAnsiString + '"';
      //LAbel do total - 1
      Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Quantidade total Ext. CO2';
      //Texto do total Extintores
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := '=SUM(R[-' + IntToStr(Lc_Cont_Fim - Lc_Cont_Ini) +']C:R[-1]C)';
      //LAbel do total - 2
      inc(Lc_Linha);
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'Quantidade total Carga CO2 (kg)';
      //Texto do total Extintores - 2
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Carga_Color;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Total_Carga;
    end;
      //------------------------------------------------------------------------------
    inc(Lc_Linha);
    inc(Lc_Linha);
    //Rodape dos totalizadores - Label
    Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'TOTAL DE EXTINTORES MANUTENIDOS';
    //Rodape dos totalizadores - Valor
    Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Qt_Exintores := Fc_QtdeExintorServicoPrestado(Lc_Qry_Aux,Pc_DataIni,Pc_DataFIm,'','','');
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_TL_Qt_Extintores;

    inc(Lc_Linha);
    //Rodape dos totalizadores - Labels selos Utilizados
    Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'C' + IntToStr(lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := 'TOTAL DE SELOS UTILIZADOS';
    //Rodape dos totalizadores - Valor  selos Utilizados
    Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'G' + IntToStr(lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Interior.Color := Lc_cd_Tl_Qtde_Color;
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Value := Lc_Qt_Selo;

    //Verifica se tem algum extintor sem lote
    Lc_Linha := Lc_Linha + 3;
    Active := False;
    SQL.Clear;
    SQL.Add('Select '+
            '  EXT_NUMERO, '+
            '  EXT_SERIE, '+
            '  EMP_NOME '+
            'from tb_ext_inspecao '+
            '  INNER JOIN tb_ext_manutencao '+
            '  ON (tb_ext_manutencao.mnt_codors = tb_ext_inspecao.IPC_CODORS) and (mnt_codext = ipc_codext) '+
            '  INNER JOIN tb_ext_resultado '+
            '  ON (tb_ext_resultado.ers_codors = tb_ext_inspecao.IPC_CODORS) and (ers_codext = ipc_codext) '+
            '  inner join tb_ext_ordem_servico '+
            '  on (ORS_CODIGO = IPC_CODORS) '+
            '  INNER JOIN TB_EMPRESA '+
            '  ON (EMP_CODIGO = ORS_CODEMP) '+
            '  INNER JOIN TB_EXTINTOR tb_extintor '+
            '  ON (tb_extintor.EXT_CODIGO = tb_ext_resultado.ERS_CODEXT) '+
            '  INNER JOIN TB_EXT_TIPO tb_ext_tipo '+
            '  ON (tb_ext_tipo.ETP_CODIGO = tb_extintor.EXT_CODETP) '+
            '  LEFT OUTER JOIN  TB_MOVIMENTO_LOTE '+
            '  ON (MLT_CODEXT = ipc_codext) '+
            'WHERE ORS_DT_ENCERRAMENTO between :DATAINI and :DATAFIM '+
            'and ((ETP_DESCRICAO LIKE ''%PO%'') or (ETP_DESCRICAO LIKE ''%PÓ%'')) '+
            'AND (ERS_RESULTADO <> ''N'') '+
            'AND (MLT_TIPO IS NULL)');
    //Passagem de Parametros
    ParamByName('DATAINI').AsDate := Pc_DataIni;
    ParamByName('DATAFIM').AsDate := Pc_DataFIm;
    Active := True;
    FetchAll;
    First;
    if (RecordCount > 0) then
      Begin
      Pc_Progresso.Progress := 0;
      Pc_Progresso.MinValue := 1;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Progresso.Update;
      //tITULO
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'RELAÇÃO DOS EXTINTORES SEM INFORMAÇÃO DE LOTE DE PÓ';
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
      inc(Lc_Linha);
      //Numero
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_Texto := 'Número';
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
      //Serie
      Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'B' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
      Lc_Texto := 'Série';
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
      //Cliente
      Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
      Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
      Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlLeft);
      Lc_Texto := 'Cliente';
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value := Lc_Texto;
      inc(Lc_Linha);


      while not Eof do
        begin
        //Atualiza Status
        Pc_Progresso.Progress :=Pc_Progresso.Progress + 1;
        Pc_Acompanhamento.Caption := 'Relacionando Extintores sem lote';
        Pc_Acompanhamento.Update;
        //Numero
        Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
        Lc_Texto := FieldByName('EXT_NUMERO').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
        //Serie
        Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'B' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].HorizontalAlignment := integer(xlRight);
        Lc_Texto := FieldByName('EXT_SERIE').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
        //Cliente
        Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
        Lc_StrCell2 := 'G' + IntToStr(Lc_Linha);
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Activate;
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Merge(xlAutomatic);
        Lc_Sheet.Range[Lc_StrCell1,Lc_StrCell2].Cells.HorizontalAlignment := integer(xlLeft);
        Lc_Texto := FieldByName('EMP_NOME').AsAnsiString;
        Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;

        inc(Lc_Linha);
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        next;
        end;
      end;
    end; //FIM DO WITH LC_QRY

  //fecha a consulta
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
  Pc_Progresso.Progress := 0;
  Pc_Progresso.Visible := false;
  Pc_Acompanhamento.Visible := false;
  Pc_Acompanhamento.Update;

  //Abre o excel
  Lc_Excel.Visible := true;
end;

function Fc_BuscaNumeroNota(Fc_Qry:TSTQuery; Fc_Cd_Pedido:Integer):TSTQuery;
Begin
  with Fc_Qry do
    Begin
    //Apaga o resultado
    Active := False;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    SQL.Clear;
    SQL.Add('SELECT NFL_NUMERO FROM TB_NOTA_FISCAL WHERE (NFL_CODPED =:PED_CODIGO) AND (NFL_CODPED > 0)');
    ParamByName('PED_CODIGO').AsInteger := Fc_cd_Pedido;
    Active := True;
    FetchAll;
    end;
  Result := Fc_Qry;
end;

function Fc_BuscaNumeroNotaServico(Fc_Qry:TSTQuery; Fc_Cd_Pedido:Integer):TSTQuery;
Begin
  with Fc_Qry do
  Begin
    //Apaga o resultado
    Active := False;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    SQL.Clear;
    SQL.Add('SELECT S.nfs_numero '+
            'FROM TB_NOTA_FISCAL N '+
            '  INNER JOIN tb_retorno_nfs S '+
            '  ON (N.nfl_codigo = S.nfs_codnfl) '+
            'WHERE (NFL_CODPED =:PED_CODIGO) AND (NFL_CODPED > 0)');
    ParamByName('PED_CODIGO').AsInteger := Fc_cd_Pedido;
    Active := True;
    FetchAll;
  end;
  Result := Fc_Qry;
end;

procedure Pc_Ext_Anexo_O(Pc_Progresso:TGauge;Pc_Acompanhamento:TLabel; Pc_TipoData:String;Pc_DataIni,Pc_DataFIm:TDate);
var
  Lc_Excel, Lc_Sheet : Variant;
  Lc_Linha : Integer;
  Lc_StrCell1: string;
  Lc_StrCell2: string;
  Lc_Texto : String;
  Jp_IMage : TJpegImage;
  Lc_Qry_Ordem : TSTQuery;
  LC_Qry_Aux :TSTQuery;
  Lc_Selo_Aux : Integer;
begin
  //Controla o acompanhamento
  Pc_Progresso.Progress := 1;
  Pc_Progresso.MinValue := 1;
  Pc_Progresso.MaxValue := 4;
  Pc_Progresso.Visible := True;
  Pc_Acompanhamento.Caption := 'Abrindo e Configurando Arquivo..';
  Pc_Acompanhamento.Visible := True;
  Pc_Acompanhamento.Update;


  //Cor dos campos editaveis
  //cria a aplicação
  Lc_Excel := CreateOleObject('Excel.Application');
  //adiciona pasta de trabalho
  Lc_Excel.WorkBooks.Add;
  //planilha recebendo variável nome
  Lc_Excel.WorkSheets[1].Name := 'Periodo';
  //Repassando variável
  Lc_Sheet := Lc_Excel.WorkSheets['Periodo'];
  //Configura as Margens
  Lc_Sheet.PageSetup.LeftMargin := Lc_Excel.InchesToPoints(0.236220472440945);
  Lc_Sheet.PageSetup.RightMargin := Lc_Excel.InchesToPoints(0.118110236220472);
  Lc_Sheet.PageSetup.TopMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.BottomMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.HeaderMargin := Lc_Excel.InchesToPoints(0.393700787401575);
  Lc_Sheet.PageSetup.FooterMargin := Lc_Excel.InchesToPoints(0.393700787401575);

  // Cabeçalho 1º Linha
  Lc_Sheet.Range['A1', 'A1'].Select;
  Lc_Sheet.Range['A1', 'A1'].Activate;
  Lc_Sheet.Range['A1', 'A1'].Cells.ColumnWidth := 5.14;

  Lc_Sheet.Range['B1', 'B1'].Select;
  Lc_Sheet.Range['B1', 'B1'].Activate;
  Lc_Sheet.Range['B1', 'B1'].Cells.ColumnWidth := 12.86;

  Lc_Sheet.Range['A1', 'B1'].MergeCells := True;
  Lc_Sheet.Range['A1', 'B1'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['C1', 'C1'].Activate;
  Lc_Sheet.Range['C1', 'C1'].Cells.ColumnWidth := 13.57;
  Lc_Sheet.Range['C1', 'C1'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['C1', 'C1'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['C1', 'C1'].Font.Size := 12;
  Lc_Sheet.Range['C1', 'C1'].Font.Bold := True;
  Lc_Sheet.Range['C1', 'C1'].Value := 'ANEXO  O                    Requisitos de Avaliação da Conformidade';
  Lc_Sheet.Range['C1', 'C1'].HorizontalAlignment := integer(integer(xlCenter));
  Lc_Sheet.Range['C1', 'C1'].VerticalAlignment := integer(integer(xlCenter));
  Lc_Sheet.Range['C1', 'C1'].WrapText := True;

  Lc_Sheet.Range['D1', 'D1'].Activate;
  Lc_Sheet.Range['D1', 'D1'].Cells.ColumnWidth := 5.57;

  Lc_Sheet.Range['E1', 'E1'].Activate;
  Lc_Sheet.Range['E1', 'E1'].Cells.ColumnWidth := 5.57;

  //Mesclar
  Lc_Sheet.Range['C1', 'E1'].Select;
  Lc_Sheet.Range['C1', 'E1'].Activate;
  Lc_Sheet.Range['C1', 'E1'].Merge(xlAutomatic);
    
  Lc_Sheet.Range['F1', 'F1'].Activate;
  Lc_Sheet.Range['F1', 'F1'].Cells.ColumnWidth := 5.57;

  Lc_Sheet.Range['G1', 'G1'].Activate;
  Lc_Sheet.Range['G1', 'G1'].Cells.ColumnWidth := 5.57;

  Lc_Sheet.Range['H1', 'H1'].Activate;
  Lc_Sheet.Range['H1', 'H1'].Cells.ColumnWidth := 5.57;

  Lc_Sheet.Range['I1', 'I1'].Activate;
  Lc_Sheet.Range['I1', 'I1'].Cells.ColumnWidth := 8;

  Lc_Sheet.Range['J1', 'J1'].Activate;
  Lc_Sheet.Range['J1', 'J1'].Cells.ColumnWidth := 10.43;

  Lc_Sheet.Range['K1', 'K1'].Activate;
  Lc_Sheet.Range['K1', 'K1'].Cells.ColumnWidth := 10.43;

  Lc_Sheet.Range['L1', 'L1'].Activate;
  Lc_Sheet.Range['L1', 'L1'].Cells.ColumnWidth := 7.43;

  Lc_Sheet.Range['F1', 'L1'].Select;
  Lc_Sheet.Range['F1', 'L1'].Activate;
  Lc_Sheet.Range['F1', 'L1'].Merge(xlAutomatic);


  // Adiciona Grade nas Colunas
  {
  Sheet.Range['A1','D11'].Borders.LineStyle := 1;
  Sheet.Range['A1','D11'].Borders.Weight := 2;
  Sheet.Range['A1','D11'].Borders.ColorIndex := 1;
  }
  Lc_Sheet.Range['F1', 'L1'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['F1', 'L1'].Interior.ColorIndex := 19;

  Lc_Sheet.Range['F1', 'L1'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['F1', 'L1'].Font.Size := 12;
  Lc_Sheet.Range['F1', 'L1'].Font.Bold := True;
  Lc_Sheet.Range['F1', 'L1'].Value := 'RELATÓRIO ORDEM DE SERVIÇO                            (MODELOEXEMPLIFICATIVO)';
  Lc_Sheet.Range['F1', 'L1'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F1', 'L1'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F1', 'L1'].WrapText := True;
  Lc_Sheet.Range['A1', 'L1'].Cells.RowHeight := 49.5;
  Lc_Sheet.Range['A1', 'A1'].Select;
  Lc_Sheet.Range['A1', 'A1'].Activate;
  Pc_Progresso.Progress := 2;
  Pc_Acompanhamento.Caption := 'Aplicando a Logo no Arquivo..';
  Pc_Acompanhamento.Update;
  Fr_Principal.Img_Inmetro.Picture.SaveToFile(GbPathExe + 'inmetro.jpg');
  Lc_Sheet.Shapes.AddPicture(GbPathExe + 'inmetro.jpg', 0, 1, 020, 001, 45, 45);

  // Cabeçalho 2º Linha
  Lc_Sheet.Range['A2', 'L2'].Select;
  Lc_Sheet.Range['A2', 'L2'].Activate;
  Lc_Sheet.Range['A2', 'L2'].Merge(xlAutomatic);
  Lc_Sheet.Range['A2', 'L2'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A2', 'L2'].Cells.RowHeight := 21;

  Lc_Sheet.Range['A2', 'L2'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A2', 'L2'].Font.Size := 10;
  Lc_Sheet.Range['A2', 'L2'].Font.Bold := True;
  Lc_Sheet.Range['A2', 'L2'].Value := 'Período: ' + DateToStr(Pc_DataIni) + ' à ' + DateToStr(Pc_DataFIm);
  Lc_Sheet.Range['A2', 'L2'].HorizontalAlignment := integer(xlRight);
  Lc_Sheet.Range['A2', 'L2'].VerticalAlignment := integer(xlCenter);

  // Cabeçalho 3º Linha
  Lc_Sheet.Range['A3', 'B3'].Select;
  Lc_Sheet.Range['A3', 'B3'].Activate;
  Lc_Sheet.Range['A3', 'B3'].Merge(xlAutomatic);
  Lc_Sheet.Range['A3', 'B3'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A3', 'A3'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A3', 'A3'].Font.Size := 12;
  Lc_Sheet.Range['A3', 'A3'].Font.Bold := True;
  Lc_Sheet.Range['A3', 'A3'].Value := 'Razão Social';
  Lc_Sheet.Range['A3', 'A3'].HorizontalAlignment := integer(xlLeft);

  Lc_Sheet.Range['C3', 'C3'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['C3', 'C3'].Font.Size := 12;
  Lc_Sheet.Range['C3', 'C3'].Font.Bold := True;
  Lc_Sheet.Range['C3', 'C3'].Value := DM.Qr_Estabelecimento.FieldByname('EMP_NOME').AsAnsiString;

  Lc_Sheet.Range['C3', 'L3'].Select;
  Lc_Sheet.Range['C3', 'L3'].Activate;
  Lc_Sheet.Range['C3', 'L3'].Merge(xlAutomatic);
  Lc_Sheet.Range['C3', 'L3'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A3', 'L3'].Cells.RowHeight := 21;
  Lc_Sheet.Range['A3', 'L3'].VerticalAlignment := integer(xlCenter);

  // Cabeçalho 4º Linha
  Lc_Sheet.Range['A4', 'B4'].Select;
  Lc_Sheet.Range['A4', 'B4'].Activate;
  Lc_Sheet.Range['A4', 'B4'].Merge(xlAutomatic);
  Lc_Sheet.Range['A4', 'B4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A4', 'A4'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A4', 'A4'].Font.Size := 12;
  Lc_Sheet.Range['A4', 'A4'].Font.Bold := True;
  Lc_Sheet.Range['A4', 'A4'].Value := 'CNPJ';

  Lc_Sheet.Range['C4', 'D4'].Select;
  Lc_Sheet.Range['C4', 'D4'].Activate;
  Lc_Sheet.Range['C4', 'D4'].Merge(xlAutomatic);
  Lc_Sheet.Range['C4', 'D4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['C4', 'D4'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['C4', 'D4'].Font.Size := 12;
  Lc_Sheet.Range['C4', 'D4'].Font.Bold := True;
  Lc_Sheet.Range['C4', 'D4'].Value := fc_MascaraCNPJ(DM.Qr_Estabelecimento.FieldByname('EMP_CNPJ').AsAnsiString);

  Lc_Sheet.Range['E4', 'E4'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['E4', 'E4'].Font.Size := 12;
  Lc_Sheet.Range['E4', 'E4'].Font.Bold := True;
  Lc_Sheet.Range['E4', 'E4'].Value := 'REGISTRO DCF  Nº';


  Lc_Sheet.Range['E4', 'I4'].Select;
  Lc_Sheet.Range['E4', 'I4'].Activate;
  Lc_Sheet.Range['E4', 'I4'].Merge(xlAutomatic);
  Lc_Sheet.Range['E4', 'I4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J4', 'L4'].Select;
  Lc_Sheet.Range['J4', 'L4'].Activate;
  Lc_Sheet.Range['J4', 'L4'].Merge(xlAutomatic);
  Lc_Sheet.Range['J4', 'L4'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A4', 'L4'].Cells.RowHeight := 21;
  Lc_Sheet.Range['A4', 'L4'].VerticalAlignment := integer(xlCenter);

  // Cabeçalho 5º Linha
  Lc_Sheet.Range['A5', 'D5'].Select;
  Lc_Sheet.Range['A5', 'D5'].Activate;
  Lc_Sheet.Range['A5', 'D5'].Merge(xlAutomatic);
  Lc_Sheet.Range['A5', 'D5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A5', 'A5'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A5', 'A5'].Font.Size := 10;
  Lc_Sheet.Range['A5', 'A5'].Font.Bold := True;
  Lc_Sheet.Range['A5', 'A5'].Value := 'Numeração sequencial';

  Lc_Sheet.Range['E5', 'F5'].Select;
  Lc_Sheet.Range['E5', 'F5'].Activate;
  Lc_Sheet.Range['E5', 'F5'].Merge(xlAutomatic);
  Lc_Sheet.Range['E5', 'F5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['E5', 'E5'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['E5', 'E5'].Font.Size := 10;
  Lc_Sheet.Range['E5', 'E5'].Font.Bold := True;
  Lc_Sheet.Range['E5', 'E5'].Font.Italic := True;
  Lc_Sheet.Range['E5', 'E5'].Value := 'Inicial';

  Lc_Sheet.Range['G5', 'I5'].Select;
  Lc_Sheet.Range['G5', 'I5'].Activate;
  Lc_Sheet.Range['G5', 'I5'].Merge(xlAutomatic);
  Lc_Sheet.Range['G5', 'I5'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['G5', 'I5'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['G5', 'G5'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['G5', 'G5'].Font.Size := 10;
  Lc_Sheet.Range['G5', 'I5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['G5', 'I5'].Value := Fc_SequenciaSeloUtilizado('MINIMO',Pc_DataIni,Pc_DataFIm);

  Lc_Sheet.Range['J5', 'J5'].Select;
  Lc_Sheet.Range['J5', 'J5'].Activate;
  Lc_Sheet.Range['J5', 'J5'].Merge(xlAutomatic);
  Lc_Sheet.Range['J5', 'J5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J5', 'J5'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['J5', 'J5'].Font.Size := 10;
  Lc_Sheet.Range['J5', 'J5'].Font.Bold := True;
  Lc_Sheet.Range['J5', 'J5'].Font.Italic := True;
  Lc_Sheet.Range['J5', 'J5'].Value := 'Final';

  Lc_Sheet.Range['K5', 'L5'].Select;
  Lc_Sheet.Range['K5', 'L5'].Activate;
  Lc_Sheet.Range['K5', 'L5'].Merge(xlAutomatic);
  Lc_Sheet.Range['K5', 'L5'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['K5', 'L5'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['K5', 'L5'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['K5', 'L5'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['K5', 'L5'].Font.Size := 10;

  Lc_Sheet.Range['K5', 'L5'].Value := Fc_SequenciaSeloUtilizado('MAXIMO',Pc_DataIni,Pc_DataFIm);
  Lc_Sheet.Range['A5', 'L5'].Cells.RowHeight := 21;
  // Cabeçalho 6º Linha
  Lc_Sheet.Range['A6', 'D6'].Select;
  Lc_Sheet.Range['A6', 'D6'].Activate;
  Lc_Sheet.Range['A6', 'D6'].Merge(xlAutomatic);
  Lc_Sheet.Range['A6', 'D6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A6', 'A6'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A6', 'A6'].Font.Size := 10;
  Lc_Sheet.Range['A6', 'A6'].Font.Bold := True;
  Lc_Sheet.Range['A6', 'A6'].Value := 'Numeração sequencial';

  Lc_Sheet.Range['E6', 'F6'].Select;
  Lc_Sheet.Range['E6', 'F6'].Activate;
  Lc_Sheet.Range['E6', 'F6'].Merge(xlAutomatic);
  Lc_Sheet.Range['E6', 'F6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['E6', 'E6'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['E6', 'E6'].Font.Size := 10;
  Lc_Sheet.Range['E6', 'E6'].Font.Bold := True;
  Lc_Sheet.Range['E6', 'E6'].Font.Italic := True;
  Lc_Sheet.Range['E6', 'E6'].Value := 'Inicial';

  Lc_Sheet.Range['G6', 'I6'].Select;
  Lc_Sheet.Range['G6', 'I6'].Activate;
  Lc_Sheet.Range['G6', 'I6'].Merge(xlAutomatic);
  Lc_Sheet.Range['G6', 'I6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J6', 'J6'].Select;
  Lc_Sheet.Range['J6', 'J6'].Activate;
  Lc_Sheet.Range['J6', 'J6'].Merge(xlAutomatic);
  Lc_Sheet.Range['J6', 'J6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J6', 'J6'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['J6', 'J6'].Font.Size := 10;
  Lc_Sheet.Range['J6', 'J6'].Font.Bold := True;
  Lc_Sheet.Range['J6', 'J6'].Font.Italic := True;
  Lc_Sheet.Range['J6', 'J6'].Value := 'Final';

  Lc_Sheet.Range['K6', 'L6'].Select;
  Lc_Sheet.Range['K6', 'L6'].Activate;
  Lc_Sheet.Range['K6', 'L6'].Merge(xlAutomatic);
  Lc_Sheet.Range['K6', 'L6'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A6', 'L6'].Cells.RowHeight := 21;
  Lc_Sheet.Range['A1', 'L6'].VerticalAlignment := integer(xlCenter);

  // Cabeçalho 7º Linha
  Lc_Sheet.Range['A7', 'D7'].Select;
  Lc_Sheet.Range['A7', 'D7'].Activate;
  Lc_Sheet.Range['A7', 'D7'].Merge(xlAutomatic);
  Lc_Sheet.Range['A7', 'D7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A7', 'A7'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A7', 'A7'].Font.Size := 10;
  Lc_Sheet.Range['A7', 'A7'].Font.Bold := True;
  Lc_Sheet.Range['A7', 'A7'].Value := 'Numeração sequencial de Selos em estoque';
  //lista os Selos em Estoque
  Pc_Progresso.Progress := 3;
  Pc_Acompanhamento.Caption := 'Verificando selos no Estoque..';
  Pc_Acompanhamento.Update;

  Lc_Qry_Ordem := TSTQuery.Create(nil);
  with Lc_Qry_Ordem do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT ESL_INICIO, ESL_FIM '+
            'from  TB_EXT_SELOS '+
            'where (cast (ESL_ULTIMO as integer)  < cast (ESL_FIM as integer)) '+
            'ORDER BY ESL_DATA ASC');
    Active := True;

    Lc_Sheet.Range['E7', 'F7'].Select;
    Lc_Sheet.Range['E7', 'F7'].Activate;
    Lc_Sheet.Range['E7', 'F7'].Merge(xlAutomatic);
    Lc_Sheet.Range['E7', 'F7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_Sheet.Range['E7', 'E7'].Font.Name := 'Times New Roman';
    Lc_Sheet.Range['E7', 'E7'].Font.Size := 10;
    Lc_Sheet.Range['E7', 'E7'].Font.Bold := True;
    Lc_Sheet.Range['E7', 'E7'].Font.Italic := True;
    Lc_Sheet.Range['E7', 'E7'].Value := 'Inicial';

    Lc_Sheet.Range['G7', 'I7'].Select;
    Lc_Sheet.Range['G7', 'I7'].Activate;
    Lc_Sheet.Range['G7', 'I7'].Merge(xlAutomatic);
    Lc_Sheet.Range['G7', 'I7'].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range['G7', 'I7'].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range['G7', 'I7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_Sheet.Range['G7', 'G7'].Font.Name := 'Times New Roman';
    Lc_Sheet.Range['G7', 'G7'].Font.Size := 10;
    //Pega o ultimo selo usado que foi setado na celula em questão
    Lc_Sheet.Range['G7', 'G7'].Value := StrToInt( Fc_SequenciaSeloUtilizado('MAXIMO',Pc_DataIni,Pc_DataFIm)) + 1;


    Lc_Sheet.Range['J7', 'J7'].Select;
    Lc_Sheet.Range['J7', 'J7'].Activate;
    Lc_Sheet.Range['J7', 'J7'].Merge(xlAutomatic);
    Lc_Sheet.Range['J7', 'J7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

    Lc_Sheet.Range['J7', 'J7'].Font.Name := 'Times New Roman';
    Lc_Sheet.Range['J7', 'J7'].Font.Size := 10;
    Lc_Sheet.Range['J7', 'J7'].Value := 'Final';

    Lc_Sheet.Range['K7', 'L7'].Select;
    Lc_Sheet.Range['K7', 'L7'].Activate;
    Lc_Sheet.Range['K7', 'L7'].Merge(xlAutomatic);
    Lc_Sheet.Range['K7', 'L7'].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range['K7', 'L7'].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range['K7', 'L7'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range['A7', 'L7'].Cells.RowHeight := 21;
    Lc_Sheet.Range['A1', 'L7'].VerticalAlignment := integer(xlCenter);

    Lc_Sheet.Range['K7', 'K7'].Font.Name := 'Times New Roman';
    Lc_Sheet.Range['K7', 'K7'].Font.Size := 10;
    Lc_Sheet.Range['K7', 'K7'].Value := FieldByName('ESL_FIM').AsAnsiString;
  end;
  // Cabeçalho 8º Linha
  Lc_Sheet.Range['A8', 'C8'].Select;
  Lc_Sheet.Range['A8', 'C8'].Activate;
  Lc_Sheet.Range['A8', 'C8'].Merge(xlAutomatic);
  Lc_Sheet.Range['A8', 'C8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A8', 'A8'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A8', 'A8'].Font.Size := 10;
  Lc_Sheet.Range['A8', 'A8'].Font.Bold := True;
  Lc_Sheet.Range['A8', 'A8'].Value := 'Quantidade de Selos Inutilizados';

  Lc_Sheet.Range['D8', 'I8'].Select;
  Lc_Sheet.Range['D8', 'I8'].Activate;
  Lc_Sheet.Range['D8', 'I8'].Merge(xlAutomatic);
  Lc_Sheet.Range['D8', 'I8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J8', 'L8'].Select;
  Lc_Sheet.Range['J8', 'L8'].Activate;
  Lc_Sheet.Range['J8', 'L8'].Merge(xlAutomatic);
  Lc_Sheet.Range['J8', 'L8'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
  Lc_Sheet.Range['A8', 'L8'].Cells.RowHeight := 21;
  Lc_Sheet.Range['A1', 'L8'].VerticalAlignment := integer(xlCenter);

  // Cabeçalho 9º Linha e linha 10º
  Lc_Sheet.Range['A9', 'A10'].Select;
  Lc_Sheet.Range['A9', 'A10'].Activate;
  Lc_Sheet.Range['A9', 'A10'].MergeCells := True;
  Lc_Sheet.Range['A9', 'A10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['A9', 'A10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['A9', 'A10'].Font.Size := 10;
  Lc_Sheet.Range['A9', 'A10'].Font.Bold := True;
  Lc_Sheet.Range['A9', 'A10'].Font.Italic := True;
  Lc_Sheet.Range['A9', 'A10'].Value := 'Dia';
  Lc_Sheet.Range['A9', 'A10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['A9', 'A10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['B9', 'B10'].Select;
  Lc_Sheet.Range['B9', 'B10'].Activate;
  Lc_Sheet.Range['B9', 'B10'].MergeCells := True;
  Lc_Sheet.Range['B9', 'B10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['B9', 'B10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['B9', 'B10'].Font.Size := 10;
  Lc_Sheet.Range['B9', 'B10'].Font.Bold := True;
  Lc_Sheet.Range['B9', 'B10'].Value := 'Ordem de Serviço - OS';
  Lc_Sheet.Range['B9', 'B10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['B9', 'B10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['B9', 'B10'].WrapText := True;

  Lc_Sheet.Range['C9', 'C10'].Select;
  Lc_Sheet.Range['C9', 'C10'].Activate;
  Lc_Sheet.Range['C9', 'C10'].MergeCells := True;
  Lc_Sheet.Range['C9', 'C10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['C9', 'C10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['C9', 'C10'].Font.Size := 10;
  Lc_Sheet.Range['C9', 'C10'].Font.Bold := True;
  Lc_Sheet.Range['C9', 'C10'].Value := 'Número da Nota Fiscal';
  Lc_Sheet.Range['C9', 'C10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C9', 'C10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['C9', 'C10'].WrapText := True;

  Lc_Sheet.Range['D9', 'H9'].Select;
  Lc_Sheet.Range['D9', 'H9'].Activate;
  Lc_Sheet.Range['D9', 'H9'].MergeCells := True;
  Lc_Sheet.Range['D9', 'H9'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['D9', 'H9'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['D9', 'H9'].Font.Size := 10;
  Lc_Sheet.Range['D9', 'H9'].Font.Bold := True;
  Lc_Sheet.Range['D9', 'H9'].Font.Italic := True;
  Lc_Sheet.Range['D9', 'H9'].Value := 'Quantidade por tipo';
  Lc_Sheet.Range['D9', 'H9'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D9', 'H9'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D9', 'H9'].WrapText := True;

  Lc_Sheet.Range['D10', 'D10'].Select;
  Lc_Sheet.Range['D10', 'D10'].Activate;
  Lc_Sheet.Range['D10', 'D10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['D10', 'D10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['D10', 'D10'].Font.Size := 10;
  Lc_Sheet.Range['D10', 'D10'].Font.Bold := True;
  Lc_Sheet.Range['D10', 'D10'].Value := 'BC';
  Lc_Sheet.Range['D10', 'D10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['D10', 'D10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['E10', 'E10'].Select;
  Lc_Sheet.Range['E10', 'E10'].Activate;
  Lc_Sheet.Range['E10', 'E10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['E10', 'E10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['E10', 'E10'].Font.Size := 10;
  Lc_Sheet.Range['E10', 'E10'].Font.Bold := True;
  Lc_Sheet.Range['E10', 'E10'].Value := 'ABC';
  Lc_Sheet.Range['E10', 'E10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['E10', 'E10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['F10', 'F10'].Select;
  Lc_Sheet.Range['F10', 'F10'].Activate;
  Lc_Sheet.Range['F10', 'F10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['F10', 'F10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['F10', 'F10'].Font.Size := 10;
  Lc_Sheet.Range['F10', 'F10'].Font.Bold := True;
  Lc_Sheet.Range['F10', 'F10'].Value := 'CO2';
  Lc_Sheet.Range['F10', 'F10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['F10', 'F10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['G10', 'G10'].Select;
  Lc_Sheet.Range['G10', 'G10'].Activate;
  Lc_Sheet.Range['G10', 'G10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['G10', 'G10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['G10', 'G10'].Font.Size := 10;
  Lc_Sheet.Range['G10', 'G10'].Font.Bold := True;
  Lc_Sheet.Range['G10', 'G10'].Value := 'AP';
  Lc_Sheet.Range['G10', 'G10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['G10', 'G10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['H10', 'H10'].Select;
  Lc_Sheet.Range['H10', 'H10'].Activate;
  Lc_Sheet.Range['H10', 'H10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['H10', 'H10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['H10', 'H10'].Font.Size := 10;
  Lc_Sheet.Range['H10', 'H10'].Font.Bold := True;
  Lc_Sheet.Range['H10', 'H10'].Value := 'EM';
  Lc_Sheet.Range['H10', 'H10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['H10', 'H10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['I9', 'I10'].Select;
  Lc_Sheet.Range['I9', 'I10'].Activate;
  Lc_Sheet.Range['I9', 'I10'].MergeCells := True;
  Lc_Sheet.Range['I9', 'I10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['I9', 'I10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['I9', 'I10'].Font.Size := 10;
  Lc_Sheet.Range['I9', 'I10'].Font.Bold := True;
  Lc_Sheet.Range['I9', 'I10'].MergeCells := True;
  Lc_Sheet.Range['I9', 'I10'].Value := 'Total selos OS';
  Lc_Sheet.Range['I9', 'I10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['I9', 'I10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['I9', 'I10'].WrapText := True;

  Lc_Sheet.Range['J9', 'K9'].Select;
  Lc_Sheet.Range['J9', 'K9'].Activate;
  Lc_Sheet.Range['J9', 'K9'].MergeCells := True;
  Lc_Sheet.Range['J9', 'K9'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J9', 'J9'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['J9', 'J9'].Font.Size := 10;
  Lc_Sheet.Range['J9', 'J9'].Font.Bold := True;
  Lc_Sheet.Range['J9', 'J9'].Value := 'Nº sequencial do Selo';
  Lc_Sheet.Range['J9', 'J9'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['J9', 'J9'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['J9', 'J9'].WrapText := True;

  Lc_Sheet.Range['J10', 'J10'].Select;
  Lc_Sheet.Range['J10', 'J10'].Activate;
  Lc_Sheet.Range['J10', 'J10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['J10', 'J10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['J10', 'J10'].Font.Size := 10;
  Lc_Sheet.Range['J10', 'J10'].Font.Bold := True;
  Lc_Sheet.Range['J10', 'J10'].Value := 'Inicial';
  Lc_Sheet.Range['J10', 'J10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['J10', 'J10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['K10', 'K10'].Select;
  Lc_Sheet.Range['K10', 'K10'].Activate;
  Lc_Sheet.Range['K10', 'K10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['K10', 'K10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['K10', 'K10'].Font.Size := 10;
  Lc_Sheet.Range['K10', 'K10'].Font.Bold := True;
  Lc_Sheet.Range['K10', 'K10'].Value := 'Final';
  Lc_Sheet.Range['K10', 'K10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['K10', 'K10'].HorizontalAlignment := integer(xlCenter);

  Lc_Sheet.Range['L9', 'L10'].Select;
  Lc_Sheet.Range['L9', 'L10'].Activate;
  Lc_Sheet.Range['L9', 'L10'].MergeCells := True;
  Lc_Sheet.Range['L9', 'L10'].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));

  Lc_Sheet.Range['L9', 'L10'].Font.Name := 'Times New Roman';
  Lc_Sheet.Range['L9', 'L10'].Font.Size := 10;
  Lc_Sheet.Range['L9', 'L10'].Font.Bold := True;
  Lc_Sheet.Range['L9', 'L10'].Value := 'Total por Nº Seq';
  Lc_Sheet.Range['L9', 'L10'].VerticalAlignment := integer(xlCenter);
  Lc_Sheet.Range['L9', 'L10'].HorizontalAlignment := integer(xlCenter);
  Lc_Sheet.Range['L9', 'L10'].WrapText := True;

  Lc_Sheet.Range['A9', 'L9'].Cells.RowHeight := 21;
  Lc_Sheet.Range['A10','L10'].Cells.RowHeight := 21;
  //Finaliza a primeira etapa
  Pc_Progresso.Progress := 4;
  Pc_Acompanhamento.Caption := 'Inicia a consulta das Ordens de Serviço...';
  Pc_Acompanhamento.Update;


  with Lc_Qry_Ordem do
  Begin
    Active := False;
    SQL.Clear;
    if Pc_TipoData = 'OS' then
    Begin
      SQL.Add('SELECT ORS_CODIGO, ORS_DATA DATA, ORS_CODPED, ORS_NUMERO, ORS_NR_MANUTENCAO, '''' NFL_NUMERO, MIN(CAST(MNT_SELO AS INTEGER)) EXT_INICIO, MAX(CAST(MNT_SELO AS INTEGER)) EXT_FINAL '+
              'FROM tb_ext_ordem_servico '+
              '  inner join tb_ext_manutencao '+
              '  ON (tb_ext_manutencao.mnt_codors = tb_ext_ordem_servico.ors_CODIGO ) '+
              '  inner join tb_ext_resultado '+
              '  ON (tb_ext_resultado.ers_codors = tb_ext_ordem_servico.ors_CODIGO ) '+
              'WHERE (ORS_CODENM > 2) AND (MNT_SELO <> '''') '+
              'AND (ORS_DT_ENCERRAMENTO BETWEEN :DATAINI AND :DATAFIM) '+
              '  and (tb_ext_resultado.ers_resultado = ''S'') '+
              'GROUP BY 1,2,3,4,5 '+
              'ORDER BY 5,6');
    end
    else
    Begin
      SQL.Add('SELECT ORS_CODIGO, NFL_DT_EMISSAO DATA, ORS_CODPED, ORS_NUMERO, ORS_NR_MANUTENCAO, NFL_NUMERO, MIN(CAST(MNT_SELO AS INTEGER)) EXT_INICIO, MAX(CAST(MNT_SELO AS INTEGER)) EXT_FINAL '+
              'FROM tb_nota_fiscal '+
              '  INNER JOIN tb_ext_ordem_servico '+
              '  on (tb_ext_ordem_servico.ors_codped = tb_nota_fiscal.nfl_codped) '+
              '  inner join tb_ext_manutencao '+
              '  ON (tb_ext_manutencao.mnt_codors = tb_ext_ordem_servico.ors_CODIGO ) '+
              '  inner join tb_ext_resultado '+
              '  ON (tb_ext_resultado.ers_codors = tb_ext_ordem_servico.ors_CODIGO ) '+
              'WHERE (ORS_CODENM > 2) AND (MNT_SELO <> '''') '+
              'AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) '+
              '  and (tb_ext_resultado.ers_resultado = ''S'') '+
              'GROUP BY 1,2,3,4,5 '+
              'ORDER BY 5,6');
    end;
    //Passagem de Parametros
    ParamByName('DATAINI').AsDate := Pc_DataIni;
    ParamByName('DATAFIM').AsDate := Pc_DataFIm;
    Active := True;
    FetchAll;
    First;
    Lc_Linha := 11;
    Pc_Progresso.Progress := 0;
    Pc_Progresso.MinValue := 1;
    Pc_Progresso.MaxValue := RecordCount;
    Pc_Progresso.Update;
    //CRia Query para auxiliar função
    Lc_Qry_Aux  :=TSTQuery.Create(nil);
    Lc_Qry_Aux.Database := Dm.IBD_Gestao;
    Lc_Qry_Aux.Transaction := DM.IB_Transacao;
    LC_Qry_Aux.ForcedRefresh := True;
    LC_Qry_Aux.CachedUpdates := True;
    while not Eof do
    begin
      //Atualiza Status
      Pc_Progresso.Progress :=Pc_Progresso.Progress + 1;
      Pc_Acompanhamento.Caption := 'Gerando dados da Manutenção ' + StrZero(FieldByName('ORS_NR_MANUTENCAO').AsFloat,6,0);
      Pc_Acompanhamento.Update;


      // Dia
      Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Texto := Copy(FieldByName('DATA').AsAnsiString,1,2);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
      // OS
      Lc_StrCell1 := 'B' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Texto := StrZero(FieldByName('ORS_NR_MANUTENCAO').AsFloat,6,0);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value := Lc_Texto;
      // NÚMERO DA NOTA
      Lc_StrCell1 := 'C' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);

      if Pc_TipoData = 'OS' then
      Begin
        Fc_BuscaNumeroNota(LC_Qry_Aux,FieldByName('ORS_CODPED').AsInteger);
        Lc_Texto := LC_Qry_Aux.FieldByName('NFL_NUMERO').AsAnsiString;
        if (Lc_Texto = '') then
        Begin
          Fc_BuscaNumeroNotaServico(LC_Qry_Aux,FieldByName('ORS_CODPED').AsInteger);
          Lc_Texto := LC_Qry_Aux.FieldByName('NFS_NUMERO').AsAnsiString;
        End;
      end
      else
      Begin
        IF TRIM(FieldByName('NFL_NUMERO').AsAnsiString) = '' then
        Begin
          Fc_BuscaNumeroNotaServico(LC_Qry_Aux,FieldByName('ORS_CODPED').AsInteger);
          Lc_Texto := LC_Qry_Aux.FieldByName('NFS_NUMERO').AsAnsiString;
        end
        else
        Begin
          Lc_Texto := FieldByName('NFL_NUMERO').AsAnsiString;
        End;
      end;

      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 :=  ''''+Lc_Texto;

      // Tipo Extintor (BC)
      Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := Fc_QtdeExintorTipoInmetro(LC_Qry_Aux,'BC',FieldByName('ORS_NUMERO').AsAnsiString);

      // Tipo Extintor (ABC)
      Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := Fc_QtdeExintorTipoInmetro(LC_Qry_Aux,'ABC',FieldByName('ORS_NUMERO').AsAnsiString);

      // Tipo Extintor (CO2)
      Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := Fc_QtdeExintorTipoInmetro(LC_Qry_Aux,'CO2',FieldByName('ORS_NUMERO').AsAnsiString);

      // Tipo Extintor (AP)
      Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := Fc_QtdeExintorTipoInmetro(LC_Qry_Aux,'AP',FieldByName('ORS_NUMERO').AsAnsiString);

      // Tipo Extintor (EM)
      Lc_StrCell1 := 'H' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := Fc_QtdeExintorTipoInmetro(LC_Qry_Aux,'EM',FieldByName('ORS_NUMERO').AsAnsiString);

      // Total de selos (BC)+(ABC)+(CO2)+(AP)+(EM)
      Lc_StrCell1 := 'I' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(RC[-5]:RC[-1])';

      // Nº Selo Inicial
      Lc_StrCell1 := 'J' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := FieldByName('EXT_INICIO').AsAnsiString;

      // Nº Selo Final
      Lc_StrCell1 := 'K' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := FieldByName('EXT_FINAL').AsAnsiString;

      // TOTAL POR Nº
      Lc_StrCell1 := 'L' + IntToStr(Lc_Linha);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
      Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].FormulaR1C1 := '=RC[-1]-RC[-2]+1';

      Next;
      Inc(Lc_Linha);
    end;

    Lc_StrCell1 := 'L' + IntToStr(Lc_Linha-1);
    Lc_Sheet.Range['A11', Lc_StrCell1].Select;
    Lc_Sheet.Range['A11', Lc_StrCell1].Activate;
    Lc_Sheet.Range['A11', Lc_StrCell1].RowHeight := 18.25;

    //TOTALIZADOR

    // DESCRIÇÃO DO TOTALIZADOR)
    Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Value2 := 'Total de selos por tipo de extintor';

    // Tipo Extintor (BC)
    Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // Tipo Extintor (ABC)
    Lc_StrCell1 := 'E' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // Tipo Extintor (CO2)
    Lc_StrCell1 := 'F' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // Tipo Extintor (AP)
    Lc_StrCell1 := 'G' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // Tipo Extintor (EM)
    Lc_StrCell1 := 'H' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // Total de selos (BC)+(ABC)+(CO2)+(AP)+(EM)
    Lc_StrCell1 := 'I' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';

    // TOTAL POR Nº
    Lc_StrCell1 := 'L' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].FormulaR1C1 := '=SUM(R[-'+ IntToStr(Lc_Linha-11) +']C:R[-1]C)';
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].RowHeight := 18.25;

    // DESCRIÇÃO DO TOTALIZADOR
    Inc(Lc_Linha);
    Lc_StrCell1 := 'A' + IntToStr(Lc_Linha);
    Lc_StrCell2 := 'C' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Select;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Activate;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell2].Merge(xlAutomatic);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := 'Total geral de selos utilizados';
    // DESCRIÇÃO DO TOTALIZADOR
    Lc_StrCell1 := 'D' + IntToStr(Lc_Linha);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, 'I'+IntToStr(Lc_Linha)].MergeCells := True;
    Lc_Sheet.Range[Lc_StrCell1, 'I'+IntToStr(Lc_Linha)].BorderAround(Integer(bssingle), Integer(xlMedium), Integer(xlAutomatic), Integer(xlAutomatic));
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].VerticalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].HorizontalAlignment := integer(xlCenter);
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].RowHeight := 18.25;
    Lc_Sheet.Range[Lc_StrCell1, Lc_StrCell1].Value2 := '=SUM(R[-1]C:R[-1]C[4])';

    Lc_Excel.Visible := true;
    end;
  Pc_Acompanhamento.Visible := False;
  Pc_Acompanhamento.Visible := False;
  Pc_Acompanhamento.Update;
  //Fecha e destroy a Query auxiliar
  LC_Qry_Aux.Close;
  LC_Qry_Aux.DisposeOf;
  Lc_Qry_Ordem.Close;
  Lc_Qry_Ordem.DisposeOf;
end;


Function Fc_MostraFonesDisponiveis(Fc_Fone,Fc_Celular,Fc_Comercial,Fc_Portaria,Fc_Fax:String):String;
Begin
  Result := '';
  if trim(Fc_fone)<>'' then
    Result := fc_MascaraFone(Fc_fone);

  if trim(Fc_Celular)<>'' then
    Begin
    if Trim(Result)= '' then
      Result := fc_MascaraFone(Fc_Celular)
    else
      Result := Result + ' | ' + fc_MascaraFone(Fc_Celular);
    end;

  if trim(Fc_Comercial)<>'' then
    Begin
    if Trim(Result)= '' then
      Result := fc_MascaraFone(Fc_Comercial)
    else
      Result := Result + ' | ' + fc_MascaraFone(Fc_Comercial);
    end;

  if trim(Fc_Portaria)<>'' then
    Begin
    if Trim(Result)= '' then
      Result := fc_MascaraFone(Fc_Portaria)
    else
      Result := Result + ' | ' + fc_MascaraFone(Fc_Portaria);
    end;

  if trim(Fc_Fax)<>'' then
    Begin
    if Trim(Result)= '' then
      Result := fc_MascaraFone(Fc_Fax)
    else
      Result := Result + ' | ' + fc_MascaraFone(Fc_Fax);
    end;
end;

procedure Pc_AtualizaVencimentoInspecao(Fc_Cd_Extintor:Integer; Pc_Novo:String);
Var
  Lc_Qry:TSTQuery;
  Lc_Upt:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;

    if (Pc_Novo = 'S') then
    Begin
      SQL.Add('select EXT_CODIGO,MAX(IPC_DATA)IPC_DATA, MAX(IPC_DT_VENC) IPC_DT_VENC '+
              'FROM tb_extintor '+
              '  INNER JOIN tb_ext_inspecao '+
              '  ON (tb_ext_inspecao.IPC_CODEXT = tb_extintor.EXT_CODIGO) '+
              'WHERE tb_ext_inspecao.IPC_CODORS = 0 and EXT_CODIGO=:EXT_CODIGO '+
              'GROUP BY 1');
    end
    else
    Begin
    SQL.Add('select EXT_CODIGO,MAX(IPC_DATA)IPC_DATA, MAX(IPC_DT_VENC) IPC_DT_VENC '+
            'FROM tb_extintor '+
            '  INNER JOIN tb_ext_inspecao '+
            '  ON (tb_ext_inspecao.IPC_CODEXT = tb_extintor.EXT_CODIGO) '+
            '  left outer JOIN tb_ext_ordem_servico '+
            '  ON (tb_ext_ordem_servico.ORS_CODIGO = tb_ext_inspecao.ipc_codors) '+
            'WHERE tb_ext_ordem_servico.ors_dt_encerramento is not null and EXT_CODIGO=:EXT_CODIGO '+
            'GROUP BY EXT_CODIGO ');
    end;
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
    if (recordCount >0) then
      Begin
      Lc_Upt := TSTQuery.Create(nil);
      Lc_Upt.Database := DM.IBD_Gestao;
      Lc_Upt.Transaction := DM.IB_Transacao;
      Lc_Upt.ForcedRefresh := True;
      Lc_Upt.CachedUpdates := True;
      Lc_Upt.Active := False;
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      Lc_Upt.SQL.Clear;
      Lc_Upt.SQL.Add('UPDATE OR INSERT INTO TB_EXT_VENCIMENTO (EXT_CODIGO,IPC_DATA,IPC_DT_VENC) '+
                     'VALUES (:EXT_CODIGO,:IPC_DATA,:IPC_DT_VENC) '+
                     'MATCHING (EXT_CODIGO)');
      Lc_Upt.ParamByName('IPC_DATA').AsAnsiString := FieldByName('IPC_DATA').AsAnsiString;
      Lc_Upt.ParamByName('IPC_DT_VENC').AsAnsiString := FieldByName('IPC_DT_VENC').AsAnsiString;
      Lc_Upt.ParamByName('EXT_CODIGO').AsAnsiString := FieldByName('EXT_CODIGO').AsAnsiString;
      Lc_Upt.ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

procedure Pc_AtualizaVencimentoEnsaio(Fc_Cd_Extintor:Integer; Pc_Novo:String);
Var
  Lc_Qry:TSTQuery;
  Lc_Upt:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    if (Pc_Novo = 'S') then
    Begin
      SQL.Add('select EXT_CODIGO,MAX(MNT_DT_ULT_ENSAIO)MNT_DT_ULT_ENSAIO, MAX(MNT_DT_VENC_ENSAIO) MNT_DT_VENC_ENSAIO '+
              'FROM tb_extintor '+
              '  INNER JOIN tb_ext_manutencao '+
              '  ON (tb_ext_manutencao.MNT_CODEXT = tb_extintor.EXT_CODIGO) '+
              'WHERE tb_ext_manutencao.mnt_CODORS = 0 and EXT_CODIGO=:EXT_CODIGO and MNT_DT_VENC_ENSAIO is not null '+
              'GROUP BY 1');
    end
    else
    Begin
      SQL.Add('select EXT_CODIGO,MAX(MNT_DT_ULT_ENSAIO)MNT_DT_ULT_ENSAIO, MAX(MNT_DT_VENC_ENSAIO) MNT_DT_VENC_ENSAIO '+
              'FROM tb_extintor '+
              '  INNER JOIN tb_ext_manutencao '+
              '  ON (tb_ext_manutencao.MNT_CODEXT = tb_extintor.EXT_CODIGO) '+
              '  left outer JOIN tb_ext_ordem_servico '+
              '  ON (tb_ext_ordem_servico.ORS_CODIGO = tb_ext_manutencao.mnt_codors) '+
              'WHERE tb_ext_ordem_servico.ors_dt_encerramento is not null and EXT_CODIGO=:EXT_CODIGO '+
              'GROUP BY EXT_CODIGO ');
    end;
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
    if (recordCount >0) then
      Begin
      Lc_Upt := TSTQuery.Create(nil);
      Lc_Upt.Database := DM.IBD_Gestao;
      Lc_Upt.Transaction := DM.IB_Transacao;
      Lc_Upt.ForcedRefresh := True;
      Lc_Upt.CachedUpdates := True;
      Lc_Upt.Active := False;
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      Lc_Upt.SQL.Clear;
      Lc_Upt.SQL.Add('UPDATE OR INSERT INTO TB_EXT_VENCIMENTO (EXT_CODIGO,MNT_DT_ULT_ENSAIO,MNT_DT_VENC_ENSAIO ) '+
                     'VALUES (:EXT_CODIGO,:MNT_DT_ULT_ENSAIO,:MNT_DT_VENC_ENSAIO)'+
                     'MATCHING (EXT_CODIGO)');
      Lc_Upt.ParamByName('MNT_DT_ULT_ENSAIO').AsAnsiString := FieldByName('MNT_DT_ULT_ENSAIO').AsAnsiString;
      Lc_Upt.ParamByName('MNT_DT_VENC_ENSAIO').AsAnsiString := FieldByName('MNT_DT_VENC_ENSAIO').AsAnsiString;
      Lc_Upt.ParamByName('EXT_CODIGO').AsAnsiString := FieldByName('EXT_CODIGO').AsAnsiString;
      Lc_Upt.ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

procedure Pc_AtualizaVencimentoCarga(Fc_Cd_Extintor:Integer; Pc_Novo:String);
Var
  Lc_Qry:TSTQuery;
  Lc_Upt:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    if (Pc_Novo = 'S') then
    Begin
      SQL.Add('select EXT_CODIGO,MAX(MNT_DT_CARGA)MNT_DT_CARGA, MAX(MNT_DT_VENC_CARGA) MNT_DT_VENC_CARGA '+
              'FROM tb_extintor '+
              '  INNER JOIN tb_ext_manutencao '+
              '  ON (tb_ext_manutencao.MNT_CODEXT = tb_extintor.EXT_CODIGO) '+
              'WHERE tb_ext_manutencao.mnt_CODORS = 0 and EXT_CODIGO=:EXT_CODIGO  '+
              'GROUP BY 1');
    end
    else
    Begin
    SQL.Add('select EXT_CODIGO,MAX(MNT_DT_CARGA)MNT_DT_CARGA, MAX(MNT_DT_VENC_CARGA) MNT_DT_VENC_CARGA '+
            'FROM tb_extintor '+
            '  INNER JOIN tb_ext_manutencao '+
            '  ON (tb_ext_manutencao.MNT_CODEXT = tb_extintor.EXT_CODIGO) '+
            '  left outer JOIN tb_ext_ordem_servico '+
            '  ON (tb_ext_ordem_servico.ORS_CODIGO = tb_ext_manutencao.mnt_codors) '+
            'WHERE tb_ext_ordem_servico.ors_dt_encerramento is not null and EXT_CODIGO=:EXT_CODIGO '+
            'GROUP BY EXT_CODIGO ');
    end;
    ParamByName('EXT_CODIGO').AsInteger := Fc_Cd_Extintor;
    Active := True;
    FetchAll;
    if (recordCount >0) then
      Begin
      Lc_Upt := TSTQuery.Create(nil);
      Lc_Upt.Database := DM.IBD_Gestao;
      Lc_Upt.Transaction := DM.IB_Transacao;
      Lc_Upt.ForcedRefresh := True;
      Lc_Upt.CachedUpdates := True;
      Lc_Upt.Active := False;
      if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
      Lc_Upt.SQL.Clear;
      Lc_Upt.SQL.Add('UPDATE OR INSERT INTO TB_EXT_VENCIMENTO (EXT_CODIGO,MNT_DT_CARGA,MNT_DT_VENC_CARGA) '+
                     'VALUES(:EXT_CODIGO,:MNT_DT_CARGA,:MNT_DT_VENC_CARGA) '+
                     'MATCHING (EXT_CODIGO)');
      Lc_Upt.ParamByName('MNT_DT_CARGA').AsAnsiString := FieldByName('MNT_DT_CARGA').AsAnsiString;
      Lc_Upt.ParamByName('MNT_DT_VENC_CARGA').AsAnsiString := FieldByName('MNT_DT_VENC_CARGA').AsAnsiString;
      Lc_Upt.ParamByName('EXT_CODIGO').AsAnsiString := FieldByName('EXT_CODIGO').AsAnsiString;
      Lc_Upt.ExecSQL;
      if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
      end;
    end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

procedure Pc_AtualizaVencimentos(Pc_cd_Ordem:Integer);
Var
  Lc_Qry:TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(nil);
  with Lc_Qry do
    Begin
    Lc_Qry.Database := DM.IBD_Gestao;
    Lc_Qry.Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    //Apaga o resultado
    Active := False;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    SQL.Clear;
    SQL.Add('Select EXT_CODIGO,EXT_NOVO '+
            'from tb_ext_inspecao '+
            '   INNER JOIN tb_ext_manutencao '+
            '   ON (tb_ext_manutencao.mnt_codors = tb_ext_inspecao.IPC_CODORS) and (mnt_codext = ipc_codext) '+
            '   INNER JOIN tb_ext_resultado '+
            '   ON (tb_ext_resultado.ers_codors = tb_ext_inspecao.IPC_CODORS) and (ers_codext = ipc_codext) '+
            '   inner join tb_ext_ordem_servico '+
            '   on (ORS_CODIGO = IPC_CODORS) '+
            '   INNER JOIN TB_EXTINTOR tb_extintor '+
            '   ON (tb_extintor.EXT_CODIGO = tb_ext_resultado.ERS_CODEXT) '+
            'WHERE ORS_CODIGO =:ORS_CODIGO '+
            'ORDER BY EXT_CODIGO');
    ParamByName('ORS_CODIGO').AsInteger := Pc_cd_Ordem;
    Active := true;
    first;
    while not eof do
    Begin
      Pc_AtualizaVencimentoInspecao(FieldByName('EXT_CODIGO').asInteger,FieldByName('EXT_NOVO').AsAnsiString);
      Pc_AtualizaVencimentoEnsaio(FieldByName('EXT_CODIGO').asInteger,FieldByName('EXT_NOVO').AsAnsiString);
      Pc_AtualizaVencimentoCarga(FieldByName('EXT_CODIGO').asInteger,FieldByName('EXT_NOVO').AsAnsiString);
      next;
    end;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  end;
  Lc_Qry.Close;
  Lc_Qry.DisposeOf;
end;

end.
