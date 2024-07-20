unit ControllerBoletoBancario;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,tblCartao,
      Un_sistema,Un_Regra_Negocio, tblBoletoBancario ,ACBrBoleto,
       Generics.Collections, ControllerContaBancaria,ControllerBoletoEletronico,
      ACBrBoletoFCFortesFr, ACBrBoletoConversao, ControllerFinanceiro,
      ControllerEspecieDoc,ControllerCarteiraCobranca, ControllerCliente,
      ControllerBanco;

Type
  TListaBoletoEletronico = TObjectList<TBoletoBancario>;
  TControllerBoletoBancario = Class(TControllerBase)
    Lista : TListaBoletoEletronico;
  private
    FNumeroBanco: Integer;
    FEstabelecimento: Integer;
    FCodigoNota: Integer;
    FImprimir: Boolean;
    procedure PreenhceDadosCedente;
    procedure setFEstabelecimento(const Value: Integer);

    procedure setFCodigoNota(const Value: Integer);
    procedure AddboletoComponente;
    procedure setFImprimir(const Value: Boolean);
    function NotasReferenciadas(CodigoQuitacao:Integer):String;
    function PedidosReferenciados(CodigoQuitacao:Integer):String;

  public
    Registro : TBoletoBancario;
    ContaCorrente : TControllerContaBancaria;
    Banco : TControllerBanco;
    Config : TControllerBoletoEletronico;
    Financeiro : TControllerFinanceiro;
    Boleto: TACBrBoleto;
    BoletoFortes: TACBrBoletoFCFortes;
    EspecieDocumento : TControllerEspecieDoc;
    CarteiraCobranca : TControllerCarteiraCobranca;
    Cliente : TControllerCliente;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure getById;
    procedure getByCodigoQuitacao;
    function salva:boolean;
    function insere:boolean;
    procedure AlteraVencimentoValor;
    procedure salvaRemessa;
    procedure Clear;
    function VerificaExistenciaContaCorrente:boolean;
    function VerificaExistenciaCarteiraCobranca:Boolean;
    function CarregaDadosGeral:boolean;
    procedure ConfiguraComponente;
    procedure CarregaComponente;


    property Estabelecimento :Integer read FEstabelecimento write setFEstabelecimento;
    property CodigoNota : Integer read FCodigoNota write setFCodigoNota;
    property Imprimir : Boolean read FImprimir write setFImprimir;
    Function GerarPDF:String;
    function GeraEmail:String;
  End;

implementation

{ TControllerBoletoBancario }

uses Un_DM, RN_BoletoEletronico,RN_Mailing;

procedure TControllerBoletoBancario.CarregaComponente;
var
  Lc_Titulo    : TACBrTitulo;
  I : Integer;
begin
  Boleto.ListadeBoletos.Clear;
  for I := 0 to Financeiro.Lista.count -1 do
  BEgin
    Financeiro.ClonarObj(Financeiro.Lista[I],Financeiro.Registro);
    Registro.CodigoQuitacao := Financeiro.registro.CodigoQuitacao;
    getByCodigoQuitacao;
    AddboletoComponente;
  End;
end;

function TControllerBoletoBancario.CarregaDadosGeral:boolean;
begin
  Result := False;
  //Financeiro
  Financeiro.Registro.CodigoNota := FCodigoNota;
  Financeiro.getlistBoleto;
  if Financeiro.Lista.Count > 0 then
  Begin
    Financeiro.ClonarObj(Financeiro.Lista[0],Financeiro.Registro);
    //Boleto Bancario
    Registro.CodigoQuitacao := Financeiro.Registro.CodigoQuitacao;
    getByCodigoQuitacao;
    //Conta Corrente
    ContaCorrente.Registro.Codigo := Registro.CodigoContaCorrente;
    ContaCorrente.getById;
    //BAnco
    FNumeroBanco := Banco.getNumber(ContaCorrente.Registro.CodigoBanco);
    //Configurações
    Config.Registro.Codigo := Registro.CodigoBoletoEletronica;
    Config.Registro.Codctb := Registro.CodigoContaCorrente;
    Config.getByKey;
    //Cliente
    Cliente.Empresa.Registro.Codigo := Financeiro.Registro.CodigoEmpresa;
    Cliente.Empresa.getAllBykey;

    if not DirectoryExists(GbPathexe + 'imagem\') then
      CreateDir(GbPathexe + 'imagem\');
    BoletoFortes.DirLogo := GbPathexe + '\imagem\';
    BoletoFortes.MargemEsquerda := 5;
    if not FileExists(GbPathexe + 'imagem\'+StrZero(FNumeroBanco,3,0)+'.bmp') then
      Pc_BaixarLogoBanco(StrZero(Boleto.Banco.Numero,3,0));
    Result := True;
  End;
end;

procedure TControllerBoletoBancario.Clear;
begin
  clearObj(Registro);
end;

procedure TControllerBoletoBancario.ConfiguraComponente;
var
  Lc_Vl_Boleto : Real;
  Lc_Vl_MoraMinima: Real;
  Lc_Vl_Mora: Real;
  Lc_Calcula: Real;
  Lc_Qry : TSTQuery;
  Lc_VL_Aux : REal;
  Lc_Tx_Multa : REal;
Begin
  with Boleto do
  Begin
    ACBrBoletoFC.SoftwareHouse := 'Setes - Gestão Computacional';
    if (Config.Registro.LayRemessa ='c240') then
      LayoutRemessa := c240
    else
      LayoutRemessa := c400;
    DirArqRemessa := Config.Registro.PathArquivos;
    Banco.TamanhoMaximoNossoNum := Banco.BancoClass.TamanhoMaximoNossoNum;
    PreenhceDadosCedente;


    case Config.Registro.Leiaute of
      0:ACBrBoletoFC.LayOut := lPadrao;
      1:ACBrBoletoFC.LayOut := lCarne;
      2:ACBrBoletoFC.LayOut := lFatura;
      3:ACBrBoletoFC.LayOut := lPadraoEntrega;
    end;
  end;
end;

constructor TControllerBoletoBancario.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBoletoBancario.Create;
  Lista := TListaBoletoEletronico.create;
  ContaCorrente := TControllerContaBancaria.Create(Self);
  Config := TControllerBoletoEletronico.Create(Self);
  Boleto  := TACBrBoleto.Create(Self);
  BoletoFortes := TACBrBoletoFCFortes.Create(Self);
  BoletoFortes.ACBrBoleto := boleto;
  Financeiro := TControllerFinanceiro.Create(Self);
  EspecieDocumento := TControllerEspecieDoc.Create(Self);
  CarteiraCobranca := TControllerCarteiraCobranca.Create(Self);
  Cliente := TControllerCliente.Create(Self);
  Banco := TControllerBanco.Create(Self);

end;

destructor TControllerBoletoBancario.Destroy;
begin
  Banco.DisposeOf;
  Cliente.DisposeOf;
  CarteiraCobranca.DisposeOf;
  EspecieDocumento.DisposeOf;
  Financeiro.DisposeOf;
  Boleto.DisposeOf;
  BoletoFortes.DisposeOf;
  Config.DisposeOf;
  ContaCorrente.DisposeOf;
  FreeAndNil(Lista);
  Registro.DisposeOf;
  inherited;
end;

function TControllerBoletoBancario.GeraEmail: String;
Var
  Lc_Qry : TSTQuery;
  Lc_Referencia : String;
Begin
  if (Registro.CodigoQuitacao > 0 ) then
  Begin
    Lc_Qry := GeraQuery;
    Try
      Lc_Referencia := NotasReferenciadas(Registro.CodigoQuitacao);
      with Lc_Qry  do
      Begin
        sql.Add('SELECT DISTINCT NFL_NUMERO '+
                'FROM tb_nota_fiscal n '+
                '  INNER JOIN TB_FINANCEIRO f '+
                '  ON (f.fin_codnfl = n.nfl_codigo) '+
                'where ( n.nfl_numero is not null) '+
                ' and  ( n.nfl_numero <> '''') '+
                ' and  ( f.fin_codqtc > 0) '+
                ' and  ( f.fin_codqtc = :FIN_CODQTC) ');
        ParamByName('FIN_CODQTC').AsInteger := Registro.CodigoQuitacao;
        Active := True;
        First;
        Lc_Referencia := '';
        while not eof do
        Begin
          if bof then
            Lc_Referencia := 'Referente a(s) nota(s): ' + FieldByName('NFL_NUMERO').AsString
          else
            Lc_Referencia := Lc_Referencia + ' / ' + FieldByName('NFL_NUMERO').AsString;
          next;
        End;
      End;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
  //Criar o Html
  Result := '<html> '+
            '<head> '+
            '  <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"> '+
            '</head> '+
            '<body> ';
  //Cabeçalho do Email
  Result := Result +
            '<table width="100%" border="0" cellpadding="0" cellspacing="0"> '+
            '   <tr> '+
            '     <td>Olá ' + Cliente.Empresa.Endereco.Registro.Contato + '</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td>&nbsp;</td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> Segue em anexo o boleto bancário para pagamento. </td> '+
            '   </tr> '+
            '   <tr> '+
            '     <td> Favor retornar este e-mail com a confirmação de recebimento do boleto. </td> '+
            '   </tr> ';
  if Trim(Lc_Referencia) <> '' then
  Begin
    Result := Result +
              '   <tr> '+
              '     <td>&nbsp;</td> '+
              '   </tr> '+
              '   <tr> '+
              '     <td> ' + Lc_Referencia + '</td> '+
              '   </tr> ';
  End;
  Result := Result +
            '   <tr> '+
            '     <td>&nbsp;</td> '+
            '   </tr> ';
  //Rodape
  Result := Result +
            '</tbody> '+
            '</table> '+
            '<BR> '+
            '<BR> '+
            '<BR> '+
            Fc_GeraAssinaturaEmail +
            '</body> '+
            '</html> ';
end;

function TControllerBoletoBancario.GerarPDF: String;
Var
  Lc_Arquivo : String;
begin
  Lc_Arquivo := GbPathexe + 'temp\' + Registro.Numero + '.pdf';
  BoletoFortes.Filtro := fiPDF;
  BoletoFortes.MostrarPreview := False;
  BoletoFortes.MostrarSetup := False;
  BoletoFortes.MostrarPreview := False;
  BoletoFortes.NomeArquivo := Lc_Arquivo;
  Boleto.GerarPDF;
  Result := Lc_Arquivo;
end;

procedure TControllerBoletoBancario.AddboletoComponente;
var
  Lc_Titulo : TACBrTitulo;
  LcReferencia : String;
begin
  Lc_Titulo := Boleto.CriarTituloNaLista;
  with Lc_Titulo do
  begin
    Vencimento        := Registro.DataVencimento;
    //Data da Multa utilizada pelo Itau (caso Clara Lua) mas s� � utilizada quando opercentual � maior que zero
    DataMulta         := Registro.DataVencimento;
    DataDocumento     := Registro.Data;
    NumeroDocumento   := Registro.Numero;
    EspecieDoc        := EspecieDocumento.Registro.Sigla;
    if Registro.Aceite = 'S' then
      Aceite := atSim
    else
      Aceite := atNao;
    DataProcessamento := Now;

    CarteiraCobranca.Registro.Codigo := Config.Registro.CodigoCarteira;
    CarteiraCobranca.getByKey;
    Carteira          := CarteiraCobranca.Registro.Numero;
    NossoNumero       := Registro.NossoNumero;
    ValorDocumento    := Registro.Valor;
    Sacado.NomeSacado := Cliente.Empresa.Registro.NomeRazaoSocial;
    if Length(Cliente.Empresa.Registro.CpfCNPJ) = 11 then
      Sacado.Pessoa := pFisica
    else
      Sacado.Pessoa := pJuridica;
    Sacado.CNPJCPF    := Cliente.Empresa.Registro.CpfCNPJ;
    Sacado.Logradouro := Cliente.Empresa.Endereco.Registro.Logradouro;
    Sacado.Numero     := Cliente.Empresa.Endereco.Registro.NumeroPredial;
    Sacado.Bairro     := Cliente.Empresa.Endereco.Registro.Bairro;
    Sacado.Cidade     := Cliente.Empresa.Endereco.Cidade.Registro.Descricao;
    Sacado.UF         := Cliente.Empresa.Endereco.Uf.Registro.Sigla;
    Sacado.CEP        := Cliente.Empresa.Endereco.Registro.Cep;
    LocalPagamento    := Config.Registro.Instr1;
    if Registro.CodigoQuitacao > 0 then
    Begin
      LcReferencia := '';
      LcReferencia :=  NotasReferenciadas(Registro.CodigoQuitacao);
      if LcReferencia = '' then
        LcReferencia :=  PedidosReferenciados(Registro.CodigoQuitacao);
      if LcReferencia <> '' then
        Mensagem.Append(LcReferencia);
    End;
    if (registro.ValorDesconto > 0) then
    Begin
      ValorDesconto := registro.ValorDesconto;
      if Trim(DateToStr(registro.DataDescVencimento) )<>'' then
      Begin
        DataAbatimento    := registro.DataDescVencimento;
        Mensagem.Append('Conceder desconto de ' + FormatCurr('R$ #,##0.00',ValorDesconto)+
                        ' para pagamento até ' + FloattoStrF(registro.ValorDesconto,ffFixed,2,10) );
      end
      else
      Begin
        DataAbatimento    := registro.DataVencimento - 5;
        Mensagem.Append('Conceder desconto de ' + FormatCurr('R$ #,##0.00',Registro.ValorDesconto));
      end;
    end;

    IF ( registro.TaxaMulta > 0) then
    Begin
      PercentualMulta := registro.TaxaMulta;
      Mensagem.Append('Apos Vencimento Multa de R$ ' + FloatToStrF((Registro.Valor * registro.TaxaMulta)/100,ffFixed,10,2));
    end;

    IF ( Registro.TaxaJuros > 0) then
    begin
      ValorMoraJuros :=  ( Registro.Valor * ( Registro.TaxaJuros / 30) ) / 100;
      DataMoraJuros := Registro.DataVencimento + 1;
      Mensagem.Append('Apos Vencimento juros de R$ ' + FloatToStrF(ValorMoraJuros,ffFixed,10,2)+ ' ao dia.')
    end;

    IF (Registro.TaxaMora > 0) then
    begin
      Mensagem.Append('Apos Vencimento mora de R$ ' + FloatToStrF((Registro.Valor * Registro.TaxaMora) / 100,ffFixed,10,2)+ ' ao dia.');
    end;

    IF Registro.ValorMora > 0 then
    Begin
      Mensagem.Append('Mora Minima de R$ ' + FloatToStrF(Registro.ValorMora,ffFixed,10,2));
    end;

    if (Registro.DiasProtesto > 0) then
    Begin
      DataProtesto  := Registro.DataProtesto;
      if ( Registro.TipoDiaProtesto = 'C' ) then
      Begin
        CASE FNumeroBanco of
           33:Mensagem.Append('Sujeito a protesto Apos ' + IntToStr(Registro.DiasProtesto) + ' dias do vencimento.'  );
          else
            Mensagem.Append('Protestar Apos ' + IntToStr(Registro.DiasProtesto) + ' dias corridos do vencimento.'  );
          end;
      End;
      if ( Registro.TipoDiaProtesto = 'U' ) then
      BEgin
        CASE FNumeroBanco of
           33:Mensagem.Append('Sujeito a protesto Apos ' + IntToStr(Registro.DiasProtesto) + ' dias do vencimento.'  );
          else
            Mensagem.Append('Protestar Apos ' + IntToStr(Registro.DiasProtesto) + ' dias �teis do vencimento.'  );
          end;
      End;
    End
    else
    Begin
      DataProtesto  := 0;
      //Quando n�o prostestar baixar e devolver em 30 dias
      DataBaixa := Vencimento + 30;
    End;

    if (config.Registro.Negativacao = 'Sim') then
    Begin
      DataNegativacao := Registro.DataVencimento + Registro.DiasNegativacao;
      DiasDeNegativacao := Registro.DiasNegativacao;
      OrgaoNegativador := '';
      TipoDiasNegativacao := TACBrTipoDiasIntrucao(1);
      CASE FNumeroBanco of
         748:Mensagem.Append('Sujeito a negativacao Apos ' + IntToStr(Registro.DiasNegativacao) + ' dias do vencimento.'  );
      end;
    End
    else
    Begin
      DataNegativacao  := 0;
      DiasDeNegativacao := 0;
    End;

    OcorrenciaOriginal.Tipo := toRemessaRegistrar;
    if FImprimir then
    Begin
      Mensagem.Append(Registro.Instrucao);
      Instrucao1        := padL(trim(Config.Registro.Instr1),2);
      Instrucao2        := padL(trim(Config.Registro.Instr2),2);
    End;
    Boleto.AdicionarMensagensPadroes(Lc_Titulo,Mensagem);
  end;

end;

procedure TControllerBoletoBancario.AlteraVencimentoValor;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_VL_PARCELA =:FIN_VL_PARCELA,'+
              'FIN_DT_VENCIMENTO=:FIN_DT_VENCIMENTO '+
              'WHERE FIN_CODIGO =:FIN_CODIGO ');
      FieldByName('FIN_VL_PARCELA').AsFloat := Registro.Valor;
      FieldByName('FIN_DT_VENCIMENTO').AsDateTime := Registro.DataVencimento;
      FieldByName('FIN_CODIGO').AsFloat := Registro.Codigo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerBoletoBancario.getByCodigoQuitacao;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry  do
    Begin
      sql.Add('SELECT * '+
              'FROM tb_BOLETO_BANCARIO '+
              'where BLT_CODQTC =:BLT_CODQTC ');

      ParamByName('BLT_CODQTC').AsInteger := Registro.CodigoQuitacao;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerBoletoBancario.getById;
begin
  _getByKey(Registro);
end;

function TControllerBoletoBancario.insere: boolean;
begin
  Registro.Codigo := Generator('GN_BOLETO_BANCARIO');
  InsertObj(Registro);
end;

function TControllerBoletoBancario.NotasReferenciadas(
  CodigoQuitacao: Integer): String;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry  do
    Begin
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
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerBoletoBancario.PreenhceDadosCedente;
begin
  Pc_AtivaEstabelecimento();
  with Boleto do
  Begin
    Cedente.Agencia := Trim(ContaCorrente.registro.Agencia);
    Cedente.AgenciaDigito :=  Trim(ContaCorrente.registro.DigitoAgencia);
    //Precisa definir o numero do banco antes de preencher o cedente
    CASE FNumeroBanco of
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
            Cedente.AgenciaDigito := Trim(Config.Registro.PostoBenef);
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

      Cedente.Conta := Trim(ContaCorrente.registro.Conta);
      Cedente.ContaDigito := Trim(ContaCorrente.registro.DigitoContaCorrente);
      Cedente.Convenio := Trim(config.Registro.Convenio);
      Cedente.CodigoCedente := Trim(config.Registro.Convenio);
      Cedente.CodigoTransmissao := Trim(config.Registro.CodTrans);

      Cedente.CNPJCPF :=  DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString;
      Cedente.Nome := DM.Qr_Estabelecimento.FieldByName('EMP_NOME').AsString;
      Cedente.Logradouro := DM.Qr_Estabelecimento.FieldByName('END_ENDER').AsString;
      Cedente.NumeroRes := DM.Qr_Estabelecimento.FieldByName('END_NUMERO').AsString;
      Cedente.Complemento := DM.Qr_Estabelecimento.FieldByName('END_COMPLEM').AsString;
      Cedente.Bairro := DM.Qr_Estabelecimento.FieldByName('END_BAIRRO').AsString;
      Cedente.cep := DM.Qr_Estabelecimento.FieldByName('END_CEP').AsString;
      Cedente.Cidade :=  DM.Qr_Estabelecimento.FieldByName('CDD_DESCRICAO').AsString;
      Cedente.ResponEmissao := tbCliEmite;
      Cedente.TipoInscricao := pJuridica;
      Cedente.UF := DM.Qr_Estabelecimento.FieldByName('UFE_SIGLA').AsString;
      Cedente.Modalidade := config.Registro.VarCart.ToString;
  end;

end;

function TControllerBoletoBancario.PedidosReferenciados(
  CodigoQuitacao: Integer): String;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry  do
    Begin
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
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerBoletoBancario.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerBoletoBancario.salvaRemessa;
Var
  Lc_Qry : TSTQuery;
  Lc_I : Integer;
  LcReg : TBoletoBancario;
Begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    BEgin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_BOLETO_BANCARIO  SET '+
              'BLT_NR_REMESSA =:BLT_NR_REMESSA, '+
              'BLT_MSG_RETORNO =:BLT_MSG_RETORNO '+
              'WHERE (BLT_CODIGO =:BLT_CODIGO) ');

      For Lc_I := 0 to Lista.Count -1 do
      Begin
        LcReg := TBoletoBancario.Create;
        LcReg := Lista[LC_I];
        Close;
        ParamByName('BLT_NR_REMESSA').AsInteger := LcReg.NumeroRemessa;
        ParamByName('BLT_CODIGO').AsInteger     := LcReg.Codigo;
        ParamByName('BLT_MSG_RETORNO').AsString := LcReg.MensagemRetorno;
        ExecSQL;
      end;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerBoletoBancario.setFCodigoNota(const Value: Integer);
begin
  FCodigoNota := Value;
end;

procedure TControllerBoletoBancario.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TControllerBoletoBancario.setFImprimir(const Value: Boolean);
begin
  FImprimir := Value;
end;


function TControllerBoletoBancario.VerificaExistenciaCarteiraCobranca: Boolean;
begin
  Result := true;
  Config.getFirst;
  if not Config.exist then
  Begin
    Result := False;
  End;
end;

function TControllerBoletoBancario.VerificaExistenciaContaCorrente: boolean;
begin
  Result := true;
  ContaCorrente.getList;
  if ContaCorrente.Lista.Count = 0 then
  Begin
    Result := False;
  End;

end;

end.
