unit RN_BoletoEletronico;

interface

uses
   SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
   Forms, Dialogs, StdCtrls, ComCtrls, Spin, Grids, Inifiles, StrUtils,
   Mask, System.Math, ExtCtrls, STQuery, Windows, Variants, DBCtrls, DBGrids, DB, Buttons,
   STDataSet, IBTable, STStoredProc, Printers,STDatabase,
   jpeg, Menus, QRCtrls, QuickRpt, OleCtrls, SHDocVw, QEdit_Setes,
   Typinfo, un_nf, uN_pRINCIPAL, Registry, dbclient, UN_Produtos,Gauges,un_padrao,Winsock,
   Un_caixa,ACBrdevice,FavoritoButtons, ShellApi,ACBrBoletoConversao,
   ACBrBase, ACBrBoleto, ACBrUtil, ACBrBoletoFCFortesFr,UN_DM,Un_sistema;


  procedure Pc_PreenhceDadosCedente(Pc_Banco:Integer;
                                    Pc_Agencia:String;
                                    Pc_AgenciaDv:String;
                                    Pc_ContaCorrente:String;
                                    Pc_ContaCorrenteDV:String;
                                    Pc_CodigoCedente:String;
                                    Pc_VariacaoCarteira : String;
                                    Pc_CodigoTransmissao:String);
  procedure Pc_IncluirBoleto( Pc_CodigoBanco : String;
                              Pc_Dt_Vencimento : TDate;
                              Pc_Dt_Documento : TDate;
                              Pc_NumeroDocumento : String;
                              Pc_EspecieDoc : String;
                              Pc_Aceite : String;
                              Pc_Dt_Processamento : TDateTime;
                              Pc_NossoNumero : String;
                              Pc_Carteira : String;
                              Pc_VL_Documento : Real;
                              Pc_NomeSacado : String;
                              Pc_CNPJ_CPF : String;
                              Pc_Logradouro : String;
                              Pc_Nr_Logradouro : String;
                              Pc_Bairro : String;
                              PC_Cidade : String;
                              Pc_Uf : String;
                              PC_Cep : String;
                              PC_Local_Pagamento : String;
                              Pc_Dt_Desconto : String;
                              Pc_VL_Desconto : Real;
                              Pc_Tx_Multa : Real;
                              Pc_VL_Tx_Juros : Real;
                              Pc_VL_Tx_Mora : Real;
                              Pc_Vl_Mora_Min : Real;
                              Pc_Dias_Protesto : Integer;
                              Pc_TipoDiaProtesto : String;
                              Pc_Dt_Protesto : String;

                              Pc_Dias_Negativacao : Integer;
                              Pc_Negativacao : String;

                              Pc_Mensagem : String;
                              Pc_Instrucao_1 : String;
                              Pc_Instrucao_2 : String;
                              CodigoQuitacao :Integer;
                              Pc_Print:boolean);

  Function Fc_Gerar_Boleto_Sem_Registro(Pc_cd_Quitacao:Integer):boolean;
  procedure Pc_BaixarLogoBanco(Pc_Numero:String);
  function Fc_VerificaCarteiraCobranca:TStringList;
  procedure Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
  procedure Pc_ConfiguraComponenteBoleto(Pc_Nr_Banco:String);
  function Fc_GeraNumeroRemessa(Pc_Carteira:Integer):Integer;

  procedure Pc_ProcessoBaixaBoleto(Pc_Qry : TSTQuery; Pc_Cd_Boleto:Integer;Pc_Cd_Liquidacao,PC_LiquidacaoDescricao:String);
  function NotasReferenciadas(CodigoQuitacao:Integer):String;
  function PedidosReferenciados(CodigoQuitacao:Integer):String;

implementation

uses RN_Financeiro,  Un_Regra_Negocio;

procedure Pc_PreenhceDadosCedente(Pc_Banco:Integer;
                                  Pc_Agencia:String;
                                  Pc_AgenciaDv:String;
                                  Pc_ContaCorrente:String;
                                  Pc_ContaCorrenteDV:String;
                                  Pc_CodigoCedente:String;
                                  Pc_VariacaoCarteira : String;
                                  Pc_CodigoTransmissao:String);
Begin
  Pc_AtivaEstabelecimento();
  with Fr_Principal.Boleto.Cedente do
  Begin
    Agencia := Trim(Pc_Agencia);
    AgenciaDigito :=  Trim(Pc_AgenciaDv);
    Conta := Trim(Pc_ContaCorrente);
    ContaDigito := Trim(Pc_ContaCorrenteDV);
    Convenio := Trim(Pc_CodigoCedente);
    CodigoCedente := Trim(Pc_CodigoCedente);
    CodigoTransmissao := Trim(Pc_CodigoTransmissao);

    CNPJCPF :=  DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
    Nome := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsString;
    Logradouro := DM.Qr_Estabelecimento.FieldByName('END_ENDER').AsString;
    NumeroRes := DM.Qr_Estabelecimento.FieldByName('END_NUMERO').AsString;
    Complemento := DM.Qr_Estabelecimento.FieldByName('END_COMPLEM').AsString;
    Bairro := DM.Qr_Estabelecimento.FieldByName('END_BAIRRO').AsString;
    cep := DM.Qr_Estabelecimento.FieldByName('END_CEP').AsString;
    Cidade :=  DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString;
    ResponEmissao := tbCliEmite;
    TipoInscricao := pJuridica;
    UF := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
    Modalidade := Trim(Pc_VariacaoCarteira);
  end;
end;


  procedure Pc_IncluirBoleto( Pc_CodigoBanco : String;
                              Pc_Dt_Vencimento : TDate;
                              Pc_Dt_Documento : TDate;
                              Pc_NumeroDocumento : String;
                              Pc_EspecieDoc : String;
                              Pc_Aceite : String;
                              Pc_Dt_Processamento : TDateTime;
                              Pc_NossoNumero : String;
                              Pc_Carteira : String;
                              Pc_VL_Documento : Real;
                              Pc_NomeSacado : String;
                              Pc_CNPJ_CPF : String;
                              Pc_Logradouro : String;
                              Pc_Nr_Logradouro : String;
                              Pc_Bairro : String;
                              PC_Cidade : String;
                              Pc_Uf : String;
                              PC_Cep : String;
                              PC_Local_Pagamento : String;
                              Pc_Dt_Desconto : String;
                              Pc_VL_Desconto : Real;
                              Pc_Tx_Multa : Real;
                              Pc_VL_Tx_Juros : Real;
                              Pc_VL_Tx_Mora : Real;
                              Pc_Vl_Mora_Min : Real;
                              Pc_Dias_Protesto : Integer;
                              Pc_TipoDiaProtesto : String;
                              Pc_Dt_Protesto : String;

                              Pc_Dias_Negativacao : Integer;
                              Pc_Negativacao : String;

                              Pc_Mensagem : String;
                              Pc_Instrucao_1 : String;
                              Pc_Instrucao_2 : String;
                              CodigoQuitacao :Integer;
                              Pc_Print:boolean);
var
  Lc_Titulo : TACBrTitulo;
  LcReferencia : String;
begin
  Lc_Titulo := Fr_Principal.Boleto.CriarTituloNaLista;
  with Lc_Titulo do
  begin
    Vencimento        := Pc_Dt_Vencimento;
    //Data da Multa utilizada pelo Itau (caso Clara Lua) mas s� � utilizada quando opercentual � maior que zero
    DataMulta         := Pc_Dt_Vencimento;
    DataDocumento     := Pc_Dt_Documento;
    NumeroDocumento   := Pc_NumeroDocumento;
    EspecieDoc        := Pc_EspecieDoc;
    if Pc_Aceite = 'S' then
      Aceite := atSim
    else
      Aceite := atNao;
    DataProcessamento := Now;
    Carteira          := Pc_Carteira;
    NossoNumero       := Pc_NossoNumero;
    ValorDocumento    := Pc_VL_Documento;
    Sacado.NomeSacado := Pc_NomeSacado;
    if Length(Pc_CNPJ_CPF) = 11 then
      Sacado.Pessoa := pFisica
    else
      Sacado.Pessoa := pJuridica;
    Sacado.CNPJCPF    := Pc_CNPJ_CPF;
    Sacado.Logradouro := Pc_Logradouro;
    Sacado.Numero     := Pc_Nr_Logradouro;
    Sacado.Bairro     := Pc_Bairro;
    Sacado.Cidade     := PC_Cidade;
    Sacado.UF         := Pc_Uf;
    Sacado.CEP        := PC_Cep;
    LocalPagamento    := PC_Local_Pagamento;
    if CodigoQuitacao > 0 then
    Begin
      LcReferencia := '';
      LcReferencia :=  NotasReferenciadas(CodigoQuitacao);
      if LcReferencia = '' then
        LcReferencia :=  PedidosReferenciados(CodigoQuitacao);
      if LcReferencia <> '' then
        Mensagem.Append(LcReferencia);
    End;
    if (Pc_VL_Desconto > 0) then
    Begin
      ValorDesconto := Pc_VL_Desconto;
      if Trim(Pc_Dt_Desconto)<>'' then
      Begin
        DataAbatimento    := StrToDate(Pc_Dt_Desconto);
        Mensagem.Append('Conceder desconto de ' + FormatCurr('R$ #,##0.00',ValorDesconto)+
                        ' para pagamento até ' + Pc_Dt_Desconto);
      end
      else
      Begin
        DataAbatimento    := Pc_Dt_Vencimento - 5;
        Mensagem.Append('Conceder desconto de ' + FormatCurr('R$ #,##0.00',ValorDesconto));
      end;
    end;

    IF (Pc_Tx_Multa > 0) then
    Begin
      PercentualMulta := Pc_Tx_Multa;
      Mensagem.Append('Apos Vencimento Multa de R$ ' + FloatToStrF((Pc_VL_Documento * Pc_Tx_Multa)/100,ffFixed,10,2));
    end;

    IF (Pc_VL_Tx_Juros > 0) then
    begin
      ValorMoraJuros :=  ( Pc_VL_Documento * ( Pc_VL_Tx_Juros / 30) ) / 100;
      DataMoraJuros := Pc_Dt_Vencimento + 1;
      Mensagem.Append('Apos Vencimento juros de R$ ' + FloatToStrF(ValorMoraJuros,ffFixed,10,2)+ ' ao dia.')
    end;

    IF (Pc_VL_Tx_Mora > 0) then
    begin

      Mensagem.Append('Apos Vencimento mora de R$ ' + FloatToStrF((Pc_VL_Documento * Pc_VL_Tx_Mora) / 100,ffFixed,10,2)+ ' ao dia.');
    end;

    IF Pc_Vl_Mora_Min > 0 then
    Begin
      Mensagem.Append('Mora Mínima de R$ ' + FloatToStrF(Pc_Vl_Mora_Min,ffFixed,10,2));
    end;

    if (Pc_Dias_Protesto > 0) then
    Begin
      DataProtesto  := StrToDate(Pc_Dt_Protesto);
      if ( Pc_TipoDiaProtesto = 'C' ) then
      Begin
        CASE StrToIntDef(Pc_CodigoBanco,341) of
           33:Mensagem.Append('Sujeito a protesto Apos ' + IntToStr(Pc_Dias_Protesto) + ' dias do vencimento.'  );
          else
            Mensagem.Append('Protestar Apos ' + IntToStr(Pc_Dias_Protesto) + ' dias corridos do vencimento.'  );
          end;
      End;
      if ( Pc_TipoDiaProtesto = 'U' ) then
      BEgin
        CASE StrToIntDef(Pc_CodigoBanco,341) of
           33:Mensagem.Append('Sujeito a protesto Apos ' + IntToStr(Pc_Dias_Protesto) + ' dias do vencimento.'  );
          else
            Mensagem.Append('Protestar Apos ' + IntToStr(Pc_Dias_Protesto) + ' dias uteis do vencimento.'  );
          end;
      End;

    End
    else
    Begin
      DataProtesto  := 0;
      //Quando n�o prostestar baixar e devolver em 30 dias
      DataBaixa := Vencimento + 30;
    End;

    if (Pc_Negativacao = 'Sim') then
    Begin
      DataNegativacao := Pc_Dt_Vencimento + Pc_Dias_Negativacao;
      DiasDeNegativacao := Pc_Dias_Negativacao;
      OrgaoNegativador := '';
      TipoDiasNegativacao := TACBrTipoDiasIntrucao(1);

      CASE StrToIntDef(Pc_CodigoBanco,341) of
         748:Mensagem.Append('Sujeito a negativacao Apos ' + IntToStr(Pc_Dias_Negativacao) + ' dias do vencimento.'  );
      end;

    End
    else
    Begin
      DataNegativacao  := 0;
      DiasDeNegativacao := 0;
    End;



    OcorrenciaOriginal.Tipo := toRemessaRegistrar;
    if Pc_Print then
    Begin
      Mensagem.Append(Pc_Mensagem);
      Instrucao1        := padL(trim(Pc_Instrucao_1),2);
      Instrucao2        := padL(trim(Pc_Instrucao_2),2);
    End;
    Fr_Principal.Boleto.AdicionarMensagensPadroes(Lc_Titulo,Mensagem);
  end;
end;

Function Fc_Gerar_Boleto_Sem_Registro(Pc_cd_Quitacao:Integer):boolean;
var
  Lc_Titulo : TACBrTitulo;

  Lc_Vl_Boleto : Real;
  Lc_Vl_MoraMinima: Real;
  Lc_Vl_Mora: Real;
  Lc_Calcula: Real;
  Lc_Qry : TSTQuery;
  Lc_VL_Aux : REal;
  Lc_Tx_Multa : REal;
Begin
  Try
    Result := TRue;
    Lc_Qry := TSTQuery.Create(Application);
    with Lc_Qry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := true;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT '+
              'BLT_DT_VENCIMENTO, '+
              'BLT_DATA, '+
              'BLT_CODQTC, '+
              'BLT_VALOR, '+
              'BLT_VL_TARIFA, '+
              'BLT_NUMERO, '+
              'CTR_NUMERO, '+
              'BLE_TX_MORA, '+
              'BLE_VL_MORA_MIN, '+
              'BLE_LOCALPAG, '+
              'BLE_CONVENIO, '+
              'BLE_COD_TRANS, '+
              'BLE_VAR_CART, '+
              'BLE_TX_JUROS,'+
              'BLE_TX_MULTA, '+
              'BLE_LEIAUTE, '+
              'contabancaria.CTB_AGENCIA, '+
              'cedente.EMP_CODIGO CED_CODIGO, '+
              'cedente.EMP_NOME CED_NOME, '+
              'banco.EMP_NUMBCO BCO_NUMERO, '+
              'CTB_AGENCIA,'+
              'CTB_AG_DV, '+
              'CTB_CONTA, '+
              'CTB_CC_DV, '+
              'BLE_INSTR_1, '+
              'BLE_INSTR_2, '+
              'BLE_INSTRUCOES, '+
              'sacado.EMP_NOME SAC_NOME, '+
              'sacado.EMP_CNPJ SAC_CNPJ, '+
              'endereco.END_ENDER SAC_ENDER, '+
              'endereco.END_NUMERO SAC_NUMERO, '+
              'endereco.END_BAIRRO SAC_BAIRRO, '+
              'endereco.END_CEP SAC_CEP, '+
              'UF.UFE_SIGLA SAC_UF, '+
              'cidade.CDD_DESCRICAO SAC_CIDADE,  '+
              'EPD_SIGLA, '+
              'BLE_POSTO_BENEF '+
              'FROM TB_BOLETO boleto '+
              '  INNER JOIN tb_boleto_eletronico boleto_eletronico '+
              '  ON(boleto_eletronico.ble_codigo = boleto.BLT_CODBLE) '+
              '  INNER JOIN TB_CARTEIRA_COBRANCA  carteira_cobranca '+
              '  ON (carteira_cobranca.ctr_codigo = boleto_eletronico.ble_codctr) '+
              '  INNER JOIN TB_ESPECIE_DOC tb_especie_doc '+
              '  ON (tb_especie_doc.EPD_CODIGO = boleto_eletronico.BLE_CODEPD) '+
              '  INNER JOIN TB_CONTABANCARIA contabancaria '+
              '  ON (boleto.BLT_CODCTB = contabancaria.ctb_codigo) '+
              '  INNER JOIN tb_empresa cedente '+
              '  ON (cedente.EMP_CODIGO = contabancaria.CTB_CODMHA) '+
              '  INNER JOIN TB_EMPRESA banco '+
              '  ON (banco.EMP_CODIGO = contabancaria.CTB_CODBCO ) '+
              '  INNER JOIN TB_EMPRESA sacado '+
              '  ON (sacado.EMP_CODIGO =  boleto.BLT_CODEMP ) '+
              '  INNER JOIN TB_ENDERECO endereco '+
              '  ON (endereco.END_CODEMP = sacado.EMP_CODIGO) '+
              '  INNER JOIN TB_CIDADE cidade '+
              '  ON (cidade.CDD_CODIGO = endereco.END_CODCDD) '+
              '  INNER JOIN TB_UF uf '+
              '  ON (uf.UFE_CODIGO = endereco.END_CODUFE) '+
              'WHERE (endereco.END_PRINCIPAL = ''S'') AND boleto.BLT_CODQTC =:BLT_CODQTC ');
      ParamByName('BLT_CODQTC').AsInteger := Pc_cd_Quitacao;
      Active := True;
      with Fr_Principal.Boleto do
      Begin
        Pc_PreenhceDadosCedente(StrToIntDef(FieldByname('BCO_NUMERO').AsString,341),
                                FieldByName('CTB_AGENCIA').AsString,
                                FieldByName('CTB_AG_DV').AsString,
                                FieldByName('CTB_CONTA').AsString,
                                FieldByName('CTB_CC_DV').AsString,
                                FieldByName('BLE_CONVENIO').AsString,
                                FieldByName('BLE_VAR_CART').AsString,
                                FieldByName('BLE_COD_TRANS').AsString);

      CASE StrToIntDef(FieldByname('BCO_NUMERO').AsString,341) of
          1:Begin
            Banco.TipoCobranca := cobBancoDoBrasil;
            Banco.TamanhoMaximoNossoNum := 10;
            end;
         33:Begin
            Banco.TipoCobranca := cobSantander;
            Banco.TamanhoMaximoNossoNum := 12;
            end;
        104:Begin
            //SIGCB
            Banco.TipoCobranca := cobCaixaEconomica;
            //Banco.TipoCobranca :=  cobCaixaSicob;
            Banco.TamanhoMaximoNossoNum := 15;
            end;
        237:Begin
            Banco.TipoCobranca := cobBradesco;
            Banco.TamanhoMaximoNossoNum := 11;
            end;
        399:Begin
            Banco.TipoCobranca := cobHSBC;
            Banco.TamanhoMaximoNossoNum := 13;            
            end;
        748:Begin
              Banco.TipoCobranca := cobSicred;
              Banco.TamanhoMaximoNossoNum := 13;
              with Cedente do
              Begin
                //CodigoCedente :=  Trim(FieldByname('BLE_CONVENIO').AsString);
                AgenciaDigito :=  Trim(FieldByname('BLE_POSTO_BENEF').AsString);
              end;
             End;
        756:Begin
              Banco.TipoCobranca := cobBancoob;
              Banco.TamanhoMaximoNossoNum := 13;
              with Cedente do
              Begin
                AgenciaDigito :=  Trim(FieldByname('BLE_POSTO_BENEF').AsString);
              end;
          End;
        else
          Begin
          Banco.TipoCobranca := cobItau;
          Banco.TamanhoMaximoNossoNum := 8;
          end;
        end;
        Lc_Titulo := Fr_Principal.Boleto.CriarTituloNaLista;
        case FieldByName('BLE_LEIAUTE').AsInteger of
          0: ACBrBoletoFC.LayOut := lPadrao;
          1: ACBrBoletoFC.LayOut := lCarne;
          2: ACBrBoletoFC.LayOut := lFatura;
          3: ACBrBoletoFC.LayOut := lPadraoEntrega;
        end;
      end;
      with Lc_Titulo do
      begin

        Vencimento        := FieldByName('BLT_DT_VENCIMENTO').AsDateTime;
        DataDocumento     := FieldByName('BLT_DATA').AsDateTime;
        NumeroDocumento   := FieldByName('BLT_NUMERO').AsString;
        EspecieDoc        := 'DM';
        Aceite := atNao;
        DataProcessamento := Now;

        CASE StrToIntDef(FieldByname('BCO_NUMERO').AsString,341) of
            1:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
              end;
           33:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
              end;
          104:Begin
                Carteira := 'SR';
              end;
          237:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
              end;
          399:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
              end;
          748:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
                with Fr_Principal.Boleto.Cedente do
                Begin
                  AgenciaDigito :=  Trim(FieldByname('BLE_POSTO_BENEF').AsString);
                end;
              end;
          756:Begin
                Carteira := FieldByName('CTR_NUMERO').AsString;
                with Fr_Principal.Boleto.Cedente do
                Begin
                  AgenciaDigito :=  Trim(FieldByname('BLE_POSTO_BENEF').AsString);
                end;
                End;
            else
            Begin
            Carteira := FieldByName('CTR_NUMERO').AsString;
            end;
          end;
        //Foi colocado o nosso numero depois da Carteira opr exigencia do Banco do Brasil
        //Verificar se n�o dar� prolbema em outros bancos.....
        NossoNumero       := FieldByName('BLT_NUMERO').AsString;
        ValorDocumento    := FieldByName('BLT_VALOR').AsFloat + FieldByName('BLT_VL_TARIFA').AsFloat;
        Sacado.NomeSacado := FieldByname('SAC_NOME').AsString;
        Sacado.CNPJCPF    := FieldByname('SAC_CNPJ').AsString;
        Sacado.Logradouro := FieldByname('SAC_ENDER').AsString;
        Sacado.Numero     := FieldByname('SAC_NUMERO').AsString;
        Sacado.Bairro     := FieldByname('SAC_BAIRRO').AsString;
        Sacado.Cidade     := FieldByname('SAC_CIDADE').AsString;
        Sacado.UF         := FieldByname('SAC_UF').AsString;
        Sacado.CEP        := FieldByname('SAC_CEP').AsString;
        LocalPagamento    := FieldByname('BLE_LOCALPAG').AsString;

        //Juros de Mora
        if ((Lc_Vl_MoraMinima > Lc_Vl_Mora) or (Lc_Vl_Mora = 0)) then
          Lc_VL_Aux := Lc_Vl_MoraMinima
        else
          Lc_VL_Aux := Lc_Vl_Mora;
        if (Lc_VL_Aux > 0) then
        Begin
          if ( Fr_Principal.Boleto.Banco.TipoCobranca = cobItau ) then
            ValorMoraJuros :=  Lc_VL_Aux / 30
          else
            ValorMoraJuros    := Lc_VL_Aux;
          DataMoraJuros     := DataDocumento + 1;
        end;


        OcorrenciaOriginal.Tipo := toRemessaRegistrar;
        Instrucao1        := FieldByname('BLE_INSTR_1').AsString;
        Instrucao2        := FieldByname('BLE_INSTR_2').AsString;
        Mensagem.Clear;
        Mensagem.Text := FieldByname('BLE_INSTRUCOES').AsString;
        if (FieldByName('BLT_VL_TARIFA').AsFloat > 0) then
          Mensagem.Add('Valor da Tarifa de emiss�o R$ ' + FloatToStrF(FieldByName('BLT_VL_TARIFA').AsFloat,ffFixed,10,2));
        if (FieldByName('BLE_TX_JUROS').AsFloat > 0) then
          Mensagem.Add('Cobran�a de '+ FloatToStrF(FieldByName('BLE_TX_JUROS').AsFloat,ffFixed,10,2) + '% Juros ao M�s ');
        if (FieldByName('BLE_TX_MORA').AsFloat > 0) then
          Mensagem.Add('Cobran�a de '+ FloatToStrF(FieldByName('BLE_TX_MORA').AsFloat,ffFixed,10,2) + '% de Mora ao dia ');
        if (FieldByName('BLE_VL_MORA_MIN').AsFloat > 0) then
          Mensagem.Add('Cobran�a de Mora M�nima no valor de  '+ FloatToStrF(FieldByName('BLE_VL_MORA_MIN').AsFloat,ffFixed,10,2));
        Lc_Tx_Multa := (FieldByName('BLE_TX_MULTA').AsFloat / 100);
        if (Lc_Tx_Multa > 0) then
        begin
          Lc_VL_Aux := FieldByName('BLT_VALOR').AsFloat;
          Lc_VL_Aux := (Lc_VL_Aux * Lc_Tx_Multa);
          Mensagem.Add('Valor da Multa Apos o vencimento de  '+ FloatToStrF(Lc_VL_Aux,ffFixed,10,2));
        end;
        Fr_Principal.Boleto.AdicionarMensagensPadroes(Lc_Titulo,Mensagem);
      end;
    end;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  except
    Result := False;
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  end;
end;

procedure Pc_BaixarLogoBanco(Pc_Numero:String);
begin
  if not FileExists(concat(GbPathExe + 'imagem\',Pc_Numero,'.bmp')) then
      Pc_BaixarArquivosSite('boleto/imagem',Pc_Numero + '.bmp','imagem\');
end;

procedure Pc_ImpressaoAutomaticaBoleto(Pc_cd_Pedido:Integer);
var
  lc_qry:TSTQuery;
  sql_txt:String;
  Lc_Lista:TStringList;
  Lc_Cd_Boleto : Integer;
  Lc_Cd_Conta  : Integer;
  Lc_Imprimir : Boolean;
begin
  //Verifica se a forma de pagamento � boleto
  try
    Lc_Lista := TStringList.Create;
    Lc_Lista := Fc_VerificaCarteiraCobranca;
    Lc_Cd_Boleto := StrToIntDef(Lc_Lista.Strings[0],0);
    Lc_Cd_Conta := StrToIntDef(Lc_Lista.Strings[1],0);
    if Lc_Cd_Boleto > 0 then
    Begin
      lc_qry := TSTQuery.Create(Application);
      with lc_qry do
      Begin
        Database:= DM.IBD_Gestao;
        Transaction:= DM.IB_Transacao;
        SQL.Clear;
        sql_txt:= ' select PED_NUMERO,PED_CODEMP,FIN_NR_PARCELA,FIN_VL_PARCELA,FIN_CODQTC,FIN_DT_VENCIMENTO '+
                  ' FROM TB_FINANCEIRO '+
                  ' INNER JOIN TB_PEDIDO '+
                  ' ON (PED_CODIGO = FIN_CODPED) '+
                  ' WHERE FIN_CODPED =:PED_CODIGO '+
                  'ORDER BY FIN_NUMERO ';
        SQL.Add(sql_txt);
        ParamByName('PED_CODIGO').AsInteger:= Pc_Cd_Pedido;
        Open;
        FetchAll;
        First;
        //Grava o Boleto;
        while not eof do
        Begin
          Pc_GravaBoleto(0,
                         FieldByName('PED_CODEMP').AsInteger,
                         FieldByName('PED_NUMERO').ASString + FieldByName('FIN_NR_PARCELA').ASString,
                         Date,
                         Lc_Cd_Conta,//               Pc_CODCTB
                         'N',//               Pc_DESCONTO
                         0,//               Pc_TX_DESCONTO
                         'N',
                         FieldByName('FIN_VL_PARCELA').ASFloat,
                         FieldByName('FIN_CODQTC').AsInteger,
                         0,//               Pc_VL_TARIFA:Real;
                         0,//               Pc_TX_MORA:Real;
                         Lc_Cd_Boleto, //   Pc_CODBLE
                         FieldByName('FIN_DT_VENCIMENTO').AsDateTime);
          Next;
        end;
        //Imprime o Boleto
        Lc_Imprimir := False;

        Fr_Principal.Boleto.ListadeBoletos.Clear;
        if not DirectoryExists(GbPathexe + 'imagem\') then
          CreateDir(GbPathexe + 'imagem\');
        Fr_Principal.Boleto.ACBrBoletoFC.DirLogo := GbPathexe + '\imagem\';
        Fr_Principal.Boleto.ACBrBoletoFC.Filtro := fiNenhum;
        Fr_Principal.Boleto.ACBrBoletoFC.NomeArquivo := '';
        if not FileExists(GbPathexe + 'imagem\'+StrZero(Fr_Principal.Boleto.Banco.Numero,3,0)+'.bmp') then
          Pc_BaixarLogoBanco(StrZero(Fr_Principal.Boleto.Banco.Numero,3,0));
        First;
        while not eof do
        Begin
          Lc_Imprimir := Fc_Gerar_Boleto_Sem_Registro(FieldByName('FIN_CODQTC').AsInteger);
          Next;
        end;
        if Lc_Imprimir then Fr_Principal.Boleto.Imprimir;
      end;
    end;
  finally
    FReeAndNil(Lc_Lista);
  end;
end;

procedure Pc_ConfiguraComponenteBoleto(Pc_Nr_Banco:String);
var
  Lc_Vl_Boleto : Real;
  Lc_Vl_MoraMinima: Real;
  Lc_Vl_Mora: Real;
  Lc_Calcula: Real;
  Lc_Qry : TSTQuery;
  Lc_VL_Aux : REal;
  Lc_Tx_Multa : REal;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT '+
            'CTR_NUMERO, '+
            'BLE_TX_MORA, '+
            'BLE_VL_MORA_MIN, '+
            'BLE_LOCALPAG, '+
            'BLE_CONVENIO, '+
            'BLE_COD_TRANS, '+
            'BLE_VAR_CART, '+
            'BLE_TX_JUROS, '+
            'BLE_TX_MULTA, '+
            'BLE_LEIAUTE, '+
            'BLE_LAY_REMESSA, '+
            'contabancaria.CTB_AGENCIA, '+
            'cedente.EMP_CODIGO CED_CODIGO, '+
            'cedente.EMP_NOME CED_NOME, '+
            'banco.EMP_NUMBCO BCO_NUMERO, '+
            'CTB_AGENCIA, '+
            'CTB_AG_DV, '+
            'CTB_CONTA, '+
            'CTB_CC_DV, '+
            'BLE_INSTR_1, '+
            'BLE_INSTR_2, '+
            'BLE_INSTRUCOES, '+
            'EPD_SIGLA, '+
            'BLE_PATH_ARQUIVOS, '+
            'BLE_POSTO_BENEF '+
            'FROM tb_boleto_eletronico boleto_eletronico '+
            '  INNER JOIN TB_CARTEIRA_COBRANCA  carteira_cobranca '+
            '  ON (carteira_cobranca.ctr_codigo = boleto_eletronico.ble_codctr) '+
            '  INNER JOIN TB_ESPECIE_DOC tb_especie_doc '+
            '  ON (tb_especie_doc.EPD_CODIGO = boleto_eletronico.BLE_CODEPD) '+
            '  INNER JOIN TB_CONTABANCARIA contabancaria '+
            '  ON (boleto_eletronico.BLe_CODCTB = contabancaria.ctb_codigo) '+
            '  INNER JOIN tb_empresa cedente '+
            '  ON (cedente.EMP_CODIGO = contabancaria.CTB_CODMHA) '+
            '  INNER JOIN TB_EMPRESA banco '+
            '  ON (banco.EMP_CODIGO = contabancaria.CTB_CODBCO ) '+
            'where banco.emp_numbco =:emp_numbco and CTB_CODMHA=:CTB_CODMHA ');
    ParamByName('emp_numbco').AsString := Pc_Nr_Banco;
    ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    with Fr_Principal.Boleto do
    Begin

      ACBrBoletoFC.SoftwareHouse := 'Setes - Gest�o Computacional';
      if (FieldByname('BLE_LAY_REMESSA').AsString ='c240') then
        LayoutRemessa := c240
      else
        LayoutRemessa := c400;
      DirArqRemessa := FieldByname('BLE_PATH_ARQUIVOS').AsString;
      Banco.TamanhoMaximoNossoNum := Banco.BancoClass.TamanhoMaximoNossoNum;
      //Define Digito da Agencia por que no sicredi vai outro valor;
      Cedente.AgenciaDigito := FieldByName('CTB_AG_DV').AsString;
      //Precisa definir o numero do banco antes de preencher o cedente
      CASE StrToIntDef(FieldByname('BCO_NUMERO').AsString,341) of
          1:Begin
              Banco.TipoCobranca := cobBancoDoBrasil;
            end;
         33:Begin
              Banco.TipoCobranca := cobSantander;
            end;
        104:Begin
              Banco.TipoCobranca :=  cobCaixaEconomica;
              //Banco.TipoCobranca :=  cobCaixaSicob;
              Banco.TamanhoMaximoNossoNum := 15;
            end;
        237:Begin
              Banco.TipoCobranca := cobBradesco;
              Banco.TamanhoMaximoNossoNum := 11;
            end;
        399:Begin
              Banco.TipoCobranca := cobHSBC;
            end;
        748:Begin
              Banco.TipoCobranca := cobSicred;
              Banco.TamanhoMaximoNossoNum := 13;
              //Cedente.CodigoCedente :=  Trim(FieldByname('BLE_CONVENIO').AsString);
              Cedente.AgenciaDigito := Trim(FieldByname('BLE_POSTO_BENEF').AsString);
            end;
        756:Begin
              Banco.TipoCobranca := cobBancoob;
              //Cedente.AgenciaDigito := Trim(FieldByname('BLE_POSTO_BENEF').AsString);
            end;
        else
          Begin
            Banco.TipoCobranca := cobItau;
          end;
        end;
      Pc_PreenhceDadosCedente(StrToIntDef(FieldByname('BCO_NUMERO').AsString,341),
                              FieldByName('CTB_AGENCIA').AsString,
                              Cedente.AgenciaDigito,
                              FieldByName('CTB_CONTA').AsString,
                              FieldByName('CTB_CC_DV').AsString,
                              FieldByName('BLE_CONVENIO').AsString,
                              FieldByName('BLE_VAR_CART').AsString,
                              FieldByName('BLE_COD_TRANS').AsString);


      case FieldByName('BLE_LEIAUTE').AsInteger of
        0:ACBrBoletoFC.LayOut := lPadrao;
        1:ACBrBoletoFC.LayOut := lCarne;
        2:ACBrBoletoFC.LayOut := lFatura;
        3:ACBrBoletoFC.LayOut := lPadraoEntrega;
      end;
    end;
  end;
end;

function Fc_GeraNumeroRemessa(Pc_Carteira:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  Result := 0;
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := true;
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT MAX(BLT_NR_REMESSA) NR_REMESSA '+
            'FROM TB_BOLETO_BANCARIO  '+
            '  INNER JOIN  tb_boleto_eletronico '+
            '  ON (tb_boleto_eletronico.BLE_CODIGO = tb_boleto_bancario.BLT_CODBLE) '+
            'WHERE (BLE_CODCTR =:BLE_CODCTR) ');
    ParamByName('BLE_CODCTR').AsInteger := Pc_Carteira;
    Active := True;
    FetchAll;
    First;

    Result := FieldByName('NR_REMESSA').AsInteger + 1
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function Fc_VerificaCarteiraCobranca():TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
Begin
  Try
    Lc_Qry := TSTQuery.Create(Application);
    Result := TStringList.Create;
    Result.Clear;
    with Lc_Qry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := true;
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT BLE_CODIGO,BLE_CODCTB '+
              'FROM tb_boleto_eletronico boleto_eletronico ');
      Active := True;
      FetchAll;
      First;
      Result.Add(FieldByName('BLE_CODIGO').AsString);
      Result.Add(FieldByName('BLE_CODCTB').AsString);
    end;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  End;
end;


procedure Pc_ProcessoBaixaBoleto(Pc_Qry : TSTQuery; Pc_Cd_Boleto:Integer;Pc_Cd_Liquidacao,PC_LiquidacaoDescricao:String);
Begin
  with Pc_Qry do
  Begin
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE TB_BOLETO_BANCARIO SET '+
            'BLT_STATUS = :BLT_STATUS, '+
            'BLT_MSG_RETORNO =:BLT_MSG_RETORNO '+
            'WHERE BLT_CODIGO=:BLT_CODIGO ');
    ParamByName('BLT_STATUS').AsString := Pc_Cd_Liquidacao;
    ParamByName('BLT_MSG_RETORNO').AsString := PC_LiquidacaoDescricao;
    ParamByName('BLT_CODIGO').AsInteger := Pc_Cd_Boleto;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
  end;
end;

function NotasReferenciadas(CodigoQuitacao: Integer): String;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry  do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      sql.Clear;
      sql.Add('SELECT DISTINCT NFL_NUMERO '+
              'FROM tb_nota_fiscal n '+
              '  INNER JOIN TB_FINANCEIRO f '+
              '  ON (f.fin_codnfl = n.nfl_codigo) '+
              'where ( n.nfl_numero is not null) '+
              ' and  ( n.nfl_numero <> '''') '+
              ' and  ( f.fin_codqtc > 0) '+
              ' and  ( f.fin_codqtc = :FIN_CODQTC) ');
      ParamByName('FIN_CODQTC').AsInteger := CodigoQuitacao;
      Active := True;
      First;
      Result := '';
      while not eof do
      Begin
        if bof then
          Result := 'Referente a(s) nota(s): ' + FieldByName('NFL_NUMERO').AsString
        else
          Result := Result + ' / ' + FieldByName('NFL_NUMERO').AsString;
        next;
      End;
    End;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
  End;
end;

function PedidosReferenciados(CodigoQuitacao:Integer):String;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := TSTQuery.Create(nil);
    with Lc_Qry  do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IB_Transacao;
      ForcedRefresh := True;
      sql.Clear;
      sql.Add('SELECT DISTINCT PED_NUMERO '+
              'FROM tb_pedido p '+
              '  INNER JOIN TB_FINANCEIRO f '+
              '  ON (f.fin_codped = p.ped_codigo) '+
              'where ( f.fin_codqtc = :FIN_CODQTC ) ');
      ParamByName('FIN_CODQTC').AsInteger := CodigoQuitacao;
      Active := True;
      First;
      Result := '';
      while not eof do
      Begin
        if bof then
          Result := 'Referente ao(s) Pedido(s): ' + FieldByName('PED_NUMERO').AsString
        else
          Result := Result + ' / ' + FieldByName('PED_NUMERO').AsString;
        next;
      End;
    End;
  Finally
    Lc_Qry.Close;
    Lc_Qry.DisposeOf;
  End;
end;

end.

