unit UN_Sistema;

//{$R-,Q-} //Switches para desabilitar a chegagem de overflow e de range
           //Para a função de criptografia. Não apagar!

interface

uses
    UN_MSG,  Datasnap.DBClient,ControllerBase,UnFunctions, UN_DM,QEdit_Setes,
    System.Threading, ControllerGeral, ControllerCtrlIcmsST, STTransaction,
    ControllerCtrlEstoque, Classes, Vcl.Forms,RN_Permissao,RN_Cliente,
  STDatabase, QuickRpt, Vcl.Grids, Vcl.Mask, SHDocVw, Winapi.Windows,
  Vcl.Controls, Vcl.ComCtrls, STQuery, Vcl.DBGrids, Vcl.Samples.Gauges,
  UITypes, Vcl.StdCtrls, AnsiStrings, IniFiles, RN_Financeiro,
  SysUtils, QRCtrls, Vcl.Imaging.jpeg, Vcl.Graphics, TypInfo,FireDAC.Stan.Param,
  Vcl.Dialogs, Data.DB, System.Math, ACBrUtil,Un_stored_procedures,
  Vcl.OleCtrls, Variants, Vcl.Printers, Winapi.ShellAPI, Vcl.ExtCtrls,
  Winapi.WinInet, IdHTTP, Registry, ControllerPreco,ControllerProduto,
  IdRawBase, IdRawClient, IdIcmpClient, IdSSLOpenSSL, Vcl.Imaging.GIFImg, main;

{--------------------------------------}
  type TCFG_Grid = Record
    LbNome: String;
    Largura: Integer;
    Posicao: Integer;
    Visible: String;
  end;



type
  TStringArray = array of Integer;


function LeProp(Comp: TComponent; const PropName: string): string;
procedure Pc_AtribuiProp(Pc_Comp: TComponent; const PropName: string; Val: string);
function Fc_AchaComponente(Fc_Nome: string; Lc_F: TForm): TComponent;
procedure Pc_Conecta(Pc_Caminho: string);
function Fc_Marca_data_pesquisa:Boolean;
procedure Pc_MontaEstado;
function Fc_MostraAniver(): Boolean;
Function Fc_VerificaDuplicacaoCheque(Fc_Cd_Cheque:Integer;Fc_Banco,Fc_Agencia,Fc_Conta,Fc_Nr_cheque:String):Boolean;
function Fc_ConverteData(Fc_Data: string; PC_Tipo: Integer): string;
function CompletaStringCom(Texto, Inc: string; nTamRetorno: Integer; lPosicao: Boolean): string;
function Fc_MascaraPrazo(Pc_Parcela: Integer): string;
function Fc_UltimoCaixa(): TDate;
function Fc_PegaLetraColuna(Fc_Numero: Integer): string;
function Fc_Generator(pc_Gen: string;pc_NomeTabela:String;Pc_campo : String): Integer;

//function Fc_Ultimo_Generator(pc_Gen: string;pc_NomeTabela:String): Integer;
procedure Pc_Cab_Relatorio(Pc_Quick: TCustomQuickRep);
procedure Pc_Cab_Report(Pc_Cabeca: TQrBand);

procedure Pc_CopiarArquivo(const Pc_Origem, Pc_Destino: string;Pc_Barra:TGauge);
function EncryptSTR(const InString: string; StartKey, MultKey, AddKey: Integer): string;
function DecryptSTR(const InString: string; StartKey, MultKey, AddKey: Integer): string;
function Fc_Ext3(Parte: string): string;
function Fc_Extenso(Valor: double): string;
function TestaCgc(xCGC: string): Boolean;
function TestaCpf(xCPF: string): Boolean;
function fc_IsInteger(Pc_String: string): boolean;
function fc_MascaraFone(pc_Fone: string): string;
function tbKeyIsDown(const Key: integer): boolean;
function Fc_Tb_Geral(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: string): string;
function Fc_Tb_Geral_Detalhe(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: String): TStringList;
function fc_MascaraCNPJ(Pc_CNPJ: string): string;
function fc_MascaraCPF(Pc_CPF: string): string;
procedure PC_ApagarLinha(Pc_Grade: TStringGrid; pc_NumItens, Pc_Linha: integer); //Posição da Linhaj>

function Fc_GeraCod_BAixa: Integer;
function Fc_Aq_Geral(Fc_TipoOper: string; Fc_Secao: string; Fc_CHave: string; Fc_Valor: string): string;
procedure Pc_Prod_Inativo(Pc_Codpro: Integer; Pc_Periodo: TDate);

procedure Pc_Aniversario(Pc_Data:String);
function Fc_CodProdComplementar: integer;
procedure Pc_Define_CasasDecimais;
procedure Pc_LimpaRelatorioMemoria;
procedure Pc_LimpaQrPreviweMemoria;
procedure Pc_LimpaFormSemNome;
procedure Pc_Calendario(Pc_Campo: TMaskedit; Pc_Form: TForm);
function fc_LogUser: string;
function Fc_tela_Executando(Pc_Nome_Tela:Pchar):boolean;




function BuscaTroca(Text, Busca, Troca: string): string;

function UCWord(texto: string): string;
function lowerAcento(c: char): char;
function upperAcento(c: char): char;
function Fc_PegaNumSeries(Pc_Cd_Produto, Pc_Cd_Item: Integer; Pc_Tipo: String): Integer;

function Fc_MascaraCep(Pc_Cep: String): String;
{---------------------------------------}
{Novas funções para o Sistema}
{E}

{F}
function Fc_Vl_custo(Pc_cd_Itens : Integer; Pc_cd_Nota:Integer):Real;
function Fc_Vl_Sub_trib(fc_Cd_Pedido : Integer):Real;

function Fc_VerificaCepEmpresa(fc_Cep,Fc_CNPJCPF: string):Integer;
function Fc_Vl_Icms(fc_Cd_Pedido : Integer):Real;
{G}

{H}


function Fc_GeraNumeroNota(): Integer;
procedure Pc_AtualizarPreco(Pc_cd_Nota: Integer);

procedure Pc_AtualizarPrecoManual(Pc_cd_Pedido: Integer);
function  Fc_Valida_Itens_QtdMIn(Pc_cd_Prod, PC_cd_Preco: Integer):Double;
function Fc_LimitedeCredito(Pc_cd_cli:Integer):Real;
function Fc_CreditoLiberado(Pc_cd_cli:Integer):boolean;

procedure Pc_ApagaItensCotacao(Pc_Cd_Item: Integer);
Function Pc_BarraProgresso(Lc_Inicio : string;Pc_Form:Tform; Pc_Parent: TWinControl; Pc_Tamanho : Integer; Pc_Texto:String):TGauge;
function Fc_TotalBrutoPedido(Pc_Cd_Pedido: Integer): real;

procedure Pc_Limpa_Impostos_Pedidos(Pc_cd_Itens:Integer);


function Fc_ColocaVirgula(Fc_Valor : string):String;
procedure Pc_SetTaskBar(Pc_Tela:TForm;Visible: Boolean);
function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;


function Fc_VerificaFormularioDisponivel(Fc_Form:String):boolean;
function FC_Pesquisa_Palavra_Texto(fc_Palavra:String;Pc_Texto:TRichEdit):Integer;
procedure Pc_AjustaICMSTSTRetido;
procedure Pc_AuditoriaEstoqueDuplicados;
procedure Pc_VerificaDesativacaoProdutos;
procedure Pc_Define_FormatoRegional;
procedure Pc_Define_DecimalSeparator(Dec,Thou:char);

procedure Pc_Excluir_Orcamentos;



Function Fc_HistoricoFinanceiro(Fc_Tipo:Integer; Fc_Cd_Empresa:Integer):String;
function Pc_Pintar_Grid_Ordenar(Lc_Grid: TDBGrid; Column: TColumn): boolean;


function Fc_VerificaNumeroNota(Pc_Tipo:String;Pc_cd_Empresa:Integer; Lc_Num_nota:string): boolean;
procedure Pc_DefineEmpresa;
procedure Pc_Deleta_Linha_Grid(Pc_strGrid :TStringGrid ; Pc_Linha:Integer) ;
procedure Pc_Deleta_Coluna_Grid(Pc_strGrid :TStringGrid ; Pc_Coluna:Integer) ;
procedure Pc_ControleBloqueioCliente(Pc_cd_cli:Integer;Pc_Situacao:String);
function Fc_VerificaBloqueioCliente(Pc_cd_cli:Integer):Boolean;
function Fc_SaldoCLiente(Pc_cd_cli:Integer):double;
function Fc_Verifica_Cadastro_Cliente(Fc_cd_Cliente : Integer):Boolean;
function Fc_Valida_SaldoExcedido(Fc_Vl_Ped:Double;Pc_cd_cli:Integer):Boolean;

function Pc_NomeCliente(Fc_Codigo: Integer): String;


function Fc_GeraNumeroCotacao(Fc_Data:TDate;Fc_Cd_Cotacao:Integer;Fc_Numero:String): String;
procedure Pc_ListarColaborador;

Function Fc_AchaEndereco(Fc_Cod_Pedido: Integer): String;
procedure Pc_Filtra_CFOP(Pc_Sentido: String; Pc_Alcada: String);
procedure Pc_ApagaContato(Pc_Cd_Contato: Integer);
procedure Pc_ApagaFichaCadastral(Pc_Cd_Ficha: Integer);
procedure Pc_ApagaFrete(Pc_Cd_frete: Integer);
//Funções para Copiar produtos e apagar as dependecias quando precisar

PROCEDURE Pc_Copia_ProdServico(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);


PROCEDURE Pc_Copia_ProdComposicao(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Copia_ProdAVIAMENTO(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Copia_ProdMaoObra(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Copia_ProdBordado(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Copia_ProdEstampa(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Copia_Prod_TbPreco(Pc_cd_Prod_novo:Integer;Pc_cd_Prod_Ant:Integer);

PROCEDURE Pc_Apaga_Produto(Pc_cd_Produto:Integer);

function Fc_HabilitaPermissao(Fc_Menu, Fc_Tipo, Fc_Situacao: String): Boolean;
//Processo de Cancelamento de Faturamento
procedure Pc_ApagaMovimFinanceiro(Pc_cd_nota:Integer);


procedure Pc_ApagaComissaoFaturamento(Pc_cd_Pedido:Integer);
procedure Pc_ApagaImpostos(Pc_cd_nota:Integer);

procedure Pc_ApagaRetornoNFE(Pc_cd_nota:Integer);
procedure Pc_ApagaVendedor(Pc_cd_Pedido:Integer);
procedure Pc_Apaga_conserto(Pc_cd_Pedido:Integer);
procedure Pc_ApagaObservacao(Pc_cd_nota:Integer);

Function Fc_Preenche_Transportadora(Fc_Cd_Empresa :Integer):Integer;
fUNCtION Fc_Obs_Empresa(Fc_Cd_Empresa:integer):string;
Function Fc_TamanhoArquivo(const FileName: string): integer;
procedure Pc_Define_Impressora_Qrpt(Pc_Qrpt:TQuickRep);
Procedure Pc_Excluir_Extintores(Pc_Cd_Pedido:Integer);

procedure Pc_Atualiza_Custo_venda(Pc_cd_nota:Integer);
procedure Pc_Del_Lin_Grid(Pc_strGrid: TStringGrid; Pc_Linha: Integer;Pc_ColRef:Integer);
function Fc_VerificaProxy():boolean;
Procedure Pc_InsereAltPreco(Pc_CodProd:integer;Pc_Valor_Anterior:double;Pc_Valor_Atual:double;Pc_CodEstoque:Integer;
                            Pc_CodTabelaPreco:integer);
Procedure Pc_Executar_Arquivo(F: String);
Function Fc_PingConectadoSetes():Boolean;



procedure Pc_ProcesoAguarde(Pc_Tela:TForm;Pc_Tipo:String);
procedure Pc_ProcesoAguarde20(Pc_Tela:TForm;Pc_Panel:TPanel;Pc_Tipo:String);
procedure Fc_ChamaTelaVideoTreinamento(Pc_cd_Interface,Pc_Numero,Link:String);
procedure Pc_BaixarArquivosSite(Pc_Dir,Pc_Arquivo, Pc_Dir_Local:String);
  procedure Pc_SSL2_TLS1;
  procedure Pc_SSL2_TLS1_NFSE;
  procedure DeletaIECache;
  Function Fc_ArredondamentoModCinco(Numero:Extended):REal;

  procedure FormVehicleOS(CodigoCotacao,CodigoPedido,CodigoEmpresa:Integer);
  procedure FormVehicleCheckList(CodigoCotacao,CodigoPedido:Integer);
  procedure ZebraArgoxElginImprimeDiretoPorta(Conteudo : String);

  function Fc_Parcelamento(Fc_Tipo:String;Qr_Pedido:TSTQuery):String;
  function existTabela(Tabela: String): Boolean;
  function existTabelaCampoDominio(Tabela,Campo,Dominio: String): Boolean;
  function GetMaxCodigo(FcTabela:String;FcCampo:String):Integer;
  procedure AjustaGenerators(FcGEnerator:String;Sequencia:Integer);

  procedure SetMainForm(NovoMainForm: TForm);

var
  //Verifica se continua a executar o sistema
  Gb_exec_Aplication : boolean;

  //Data de Criação
  Gb_data_Criacao : String;

  Gb_Cd_Crt: Integer;
  Gb_Cd_Pesquisa : integer;
  GB_NM_Empresa: string;
  Gb_Estados: array[1..27] of string;
  Gb_Ult_codigo: Integer;

  //Controle de Projeto da Setes
  //Código de cliente no Cadastro da Setes
  Gb_Cd_Cliente_Setes : Integer;
  //Codigo do Projeto utilizado na Setes
  Gb_Cd_Projeto_setes : Integer;
  Gb_Handle : hwnd;
  //codigo do Estoque Atual
   Gb_Estoque: Integer;
   GB_ProdCompartilha: Boolean;
   gb_site : string;
   Gb_Cd_Wsr : Integer;
   gb_webservice : string;
   gb_Web_Path_img : String;
   gb_CNPJ : string;

   //Variaveis do Proxy
   Gb_Pxy_Path  : String;
   Gb_Pxy_Porta : Integer;
   Gb_Pxy_User   : String;
   Gb_pxy_Pws   : String;

   //Formato Casas Desimais
   Gb_Casa_Dec_Venda : String;
   Gb_Casa_Dec_Compra : String;
   // Inventario
   Gb_Inventario: Integer;

  //Abre Tela de Aniversário
   Gb_Aniver: Boolean;



  //Licença
  Gb_Serial_HD : String;

  //Pedidos e Produtos
   Gb_Codigo: Char;

  //Placa
   Gb_Placa: Boolean;
  //BAckup

  //Conexão
   GbPathExe: string;
   Gb_PathBD: string;
   Gb_db: string;

  //Cores no Foco
   Gb_CorEntra: TColor;
   Gb_CorSai: TColor;

   //Vareiveis para a internet
   Gb_Inet : word;
   Gb_ftp_User: string;
   Gb_ftp_Pws: string;
   Gb_ftp_Path: string;
   Gb_Dir_Img: string;
   GB_buscaProduto: String;

   //controle de Venda e financeiro
   Gb_SaldoVencido : Boolean;
   Gb_Terminal : Integer;


pROCEDURE Pc_MaoObra_Bordado(pc_operacao:String; Pc_Cd_ICT:Integer);
pROCEDURE Pc_MaoObra_Estamparia(pc_operacao:String; Pc_Cd_ICT:Integer);
procedure Pc_Exclui_fichaTecnica(Pc_Cd_ICT:Integer);
function Fc_CentralizaTexto(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
Function Fc_RetornaNomeCampo(Fc_NomeTabela:String):String;
function Fc_Estado(Fc_CodEmp: Integer; Fc_Tipo: String): Integer;
Procedure Pc_ControlaNumero(Pc_ddb_numero:TEdit_setes;Pc_TipoPedido:String);
function Fc_Qt_ItensNota(): Integer;
function Fc_ValidaNumeroPedido(Fc_CodigoPedido:Integer;Fc_NumeroPedido:integer; FC_TipoPedido:integer):Boolean;
function Fc_ValidaNumeroOrcamento(Fc_CodigoOrcamento:Integer;Fc_NumeroOrcamento:integer):Boolean;
function Fc_PegaEmail(Fc_Codigo: Integer): string;

function Fc_ValidaParcelamento(Fc_Cod_Pedido:Integer;Fc_Vl_pedido:Double):Boolean;
function Fc_BuscaCidade(Pc_Cd_Empresa: Integer): String;
function Fc_BuscaEstado(Fc_Cd_Empresa: Integer): Integer;

procedure Pc_InfoRevendaVeiculos(Pc_Lista: TMemo;Pc_Cd_Pedido:integer);

procedure Pc_Insere_Arq_Banco(Pc_Path : String;
                              Pc_File: String;
                              Pc_Tipo: Integer;
                              Pc_Formato: String;
                              Pc_Cd_Vinculo: Integer);

procedure Pc_Salva_Arq_Disco(Pc_Tipo: Integer;
                             Pc_Formato: String;
                             Pc_Cd_Vinculo: Integer;
                             Pc_Arq_Caminho: String);

procedure Pc_CodLote(
   Pc_Operacao: string;
   pc_LOT_CODIGO:integer;
   PC_LOT_DATA:TDate;
   PC_LOT_NUMERO:STRING;
   Pc_LOT_CODITF:INTEGER;
   PC_LOT_DT_VENCIMENTO:tDATE;
   PC_LOT_QTD_E:double;
   PC_LOT_QTD_S:double);


procedure Pc_Atualiza_Vend_Excluido(Pc_cd_vendedor:Integer);



implementation

uses Un_Regra_Negocio, ControllerVehicleOs,  ControllerTabelaPreco;


const

   Centenas: array[1..9] of string[12] = ('CEM', 'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS',
      'QUINHENTOS', 'SEISCENTOS', 'SETECENTOS',
      'OITOCENTOS', 'NOVECENTOS');
   Dezenas: array[2..9] of string[10] = ('VINTE', 'TRINTA', 'QUARENTA', 'CINQUENTA',
      'SESSENTA', 'SETENTA', 'OITENTA', 'NOVENTA');
   Dez: array[0..9] of string[10] = ('DEZ', 'ONZE', 'DOZE', 'TREZE', 'QUATORZE',
      'QUINZE', 'DEZESSEIS', 'DEZESSETE',
      'DEZOITO', 'DEZENOVE');
   Unidades: array[1..9] of string[10] = ('UM', 'DOIS', 'TRES', 'QUATRO', 'CINCO',
      'SEIS', 'SETE', 'OITO', 'NOVE');
   MoedaSingular = 'REAL';
   MoedaPlural = 'REAIS';
   CentSingular = 'CENTAVO';
   CentPlural = 'CENTAVOS';
   Zero = 'ZERO';

function UCWord(texto: string): string;
var
   i: Integer;
   strResult: string;
   toUpper: Boolean;
begin

   strResult := '';

   for i := 1 to Length(texto) do
   begin

      toUpper := ((i = 1) or
         (texto[i - 1] in [#13, ' ', '.', ':', '!', '?', ';', ',']));

      if toUpper then
      begin
         strResult := strResult + UpperCase(upperAcento(texto[i]));
      end
      else
      begin
         strResult := strResult + LowerCase(lowerAcento(texto[i]));
      end;
   end;

   strResult := StringReplace(strResult, ' da ', ' da ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' de ', ' de ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' do ', ' do ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' e ', ' e ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' o ', ' o ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' as ', ' as ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' os ', ' os ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' em ', ' em ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' das ', ' das ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' dos ', ' dos ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' para ', ' para ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' c/ ', ' c/ ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' c/', ' c/', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' p/ ', ' p/ ', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' p/', ' p/', [rfReplaceAll, rfIgnoreCase]);
   strResult := StringReplace(strResult, ' p/', ' p/', [rfReplaceAll, rfIgnoreCase]);

   result := strResult;

end;

function lowerAcento(c: char): char;
begin
   case c of
      'Á': c := 'á';
      'À': c := 'à';
      'Ã': c := 'ã';
      'Â': c := 'â';
      'É': c := 'é';
      'È': c := 'è';
      'Ê': c := 'ê';
      'Í': c := 'í';
      'Ó': c := 'ó';
      'Ö': c := 'ö';
      'Õ': c := 'õ';
      'Ô': c := 'ô';
      'Ú': c := 'ú';
      'Ù': c := 'ù';
      'Û': c := 'û';
      'Ü': c := 'ü';
      'Ç': c := 'ç';
   end;

   Result := c;
end;

function upperAcento(c: char): char;
begin
   case c of
      'á': c := 'Á';
      'à': c := 'À';
      'ã': c := 'Ã';
      'â': c := 'Â';
      'é': c := 'É';
      'è': c := 'È';
      'ê': c := 'Ê';
      'ó': c := 'Ó';
      'ö': c := 'Ö';
      'õ': c := 'Õ';
      'ô': c := 'Ô';
      'ú': c := 'Ú';
      'ù': c := 'Ù';
      'û': c := 'Û';
      'ü': c := 'Ü';
      'ç': c := 'Ç';
   end;
   Result := c;
end;

procedure Pc_Conecta(Pc_Caminho: string);
var
   Lc_Arq_Ini: TIniFile;
   vlr: string;
   Lc_ServFB : String;
   Lc_PortFB : String;
   Lc_PathFB : String;
   Lc_CNPJ : String;
begin
  DM.IBD_Gestao.Connected := False;
  DM.IBD_Gestao.LoginPrompt := False;
  // Abre arquivo de configuracao
  //env-1866685.jelastic.saveincloud.net/11578:/opt/firebird/data/125194580001_30/IBGCOM.FDB
  Lc_Arq_Ini := TIniFile.Create(Pc_Caminho);
  if (Uppercase(Pc_Caminho) = Uppercase('C:\windows\wingnsys.ini')) then
  Begin
    vlr:=Lc_Arq_Ini.ReadString('Path', 'Reconectar', '');
    if (vlr = 'N') then
    Begin
      Pc_Conecta(GbPathExe + 'Config.INI');
      Lc_Arq_Ini.disposeOf;
      exit;
    end;
  end;
  //Caminho do Banco de Dados
  Gb_PathBd := LeftStr(GbPathExe, (Length(GbPathExe) - 4));
  Gb_PathBd := Gb_PathBd + 'DataBase\Ibgcom.Fdb';
  if Lc_Arq_Ini.SectionExists('PATH_ONLINE') then
  Begin
    DM.IBD_Gestao.Params.Clear;
    DM.IBD_Gestao.Params.Values['User_Name']:='SYSDBA';
    DM.IBD_Gestao.Params.Values['Password']:='6lQ3kAZJBLLmxYih4uS9';
    DM.IBD_Gestao.Params.Values['lc_ctype']:='WIN1252';

    Lc_ServFB := Lc_Arq_Ini.ReadString('PATH_ONLINE', 'SERVFB', 'env-1866685.jelastic.saveincloud.net');
    Lc_PortFB := Lc_Arq_Ini.ReadString('PATH_ONLINE', 'PORTA', '11578');
    Lc_CNPJ   := Lc_Arq_Ini.ReadString('PATH_ONLINE', 'CNPJ', '0');
    Lc_PathFB := concat('/opt/firebird/data/',Lc_CNPJ,'/IBGCOM.FDB');
    Gb_PathBD := concat(Lc_ServFB,'/',Lc_PortFB,':',Lc_PathFB);
  end
  else
  Begin
    DM.IBD_Gestao.Params.Clear;
    DM.IBD_Gestao.Params.Values['User_Name']:='SYSDBA';
    DM.IBD_Gestao.Params.Values['Password']:='masterkey';
    DM.IBD_Gestao.Params.Values['lc_ctype']:='WIN1252';

    if Lc_Arq_Ini.SectionExists('PATH') then
     begin
      Gb_PathBD := Lc_Arq_Ini.ReadString('Path', 'Database', Gb_PathBD);
    end
    else
    begin
      Lc_Arq_Ini.WriteString('Path', 'Database', Gb_PathBd);
    end;
  end;
  Lc_Arq_Ini.disposeOf;
  Try
    DM.IBD_Gestao.DatabaseName := Gb_PathBD;
    DM.IBD_Gestao.Connected := true;
  Except
      Pc_Conecta(GbPathExe + 'Config.INI');
  end;
end;

procedure Pc_MontaEstado;
begin
   Gb_Estados[1] := 'AC';
   Gb_Estados[2] := 'AL';
   Gb_Estados[3] := 'AM';
   Gb_Estados[4] := 'AP';
   Gb_Estados[5] := 'BA';
   Gb_Estados[6] := 'CE';
   Gb_Estados[7] := 'DF';
   Gb_Estados[8] := 'ES';
   Gb_Estados[9] := 'GO';
   Gb_Estados[10] := 'MA';
   Gb_Estados[11] := 'MG';
   Gb_Estados[12] := 'MS';
   Gb_Estados[13] := 'MT';
   Gb_Estados[14] := 'PA';
   Gb_Estados[15] := 'PB';
   Gb_Estados[16] := 'PE';
   Gb_Estados[17] := 'PI';
   Gb_Estados[18] := 'PR';
   Gb_Estados[19] := 'RJ';
   Gb_Estados[20] := 'RN';
   Gb_Estados[21] := 'RO';
   Gb_Estados[22] := 'RR';
   Gb_Estados[23] := 'RS';
   Gb_Estados[24] := 'SC';
   Gb_Estados[25] := 'SE';
   Gb_Estados[26] := 'SP';
   Gb_Estados[27] := 'TO';
end;

function Fc_MostraAniver(): Boolean;
var
   Lc_Hoje: string;
   Lc_AtivaTela: string;
   Lc_TelaHoje: string;
begin
  Pc_Define_FormatoRegional;
  Lc_AtivaTela := Fc_Aq_Geral('L', 'ANIVER', 'GRL_P_ANIV_TELA', 'S');
  if Lc_AtivaTela = 'N' then
  begin
    Result := False;
    exit;
  end
  else
  begin
    Lc_Hoje := Fc_Aq_Geral('L', 'ANIVER', 'HOJE', 'S');
    Lc_TelaHoje := Fc_Aq_Geral('L', 'ANIVER', 'TELAHOJE', 'S');
    if Lc_Hoje = DateToStr(Date) then
      begin
      if (Lc_TelaHoje = 'S') then
        Result := True
      else
        Result := False;
      end
    else
      Result := True
   end;

end;


function Fc_ConverteData(Fc_data: string; Pc_Tipo: Integer): string;
var
   Lc_Dia: string;
   Lc_Mes: string;
   Lc_Ano: string;
begin
   case PC_Tipo of
      1:
         begin
            Lc_Dia := Copy(Fc_Data, 9, 2);
            Lc_Mes := Copy(Fc_Data, 6, 2);
            Lc_Ano := Copy(Fc_Data, 1, 4);
            Result := Lc_Dia + '/' + Lc_Mes + '/' + Lc_Ano;
         end;
      2:
         begin
            Lc_Dia := Copy(Fc_Data, 1, 2);
            Lc_Mes := Copy(Fc_Data, 4, 2);
            Lc_Ano := Copy(Fc_Data, 7, 4);
            Result := Lc_Ano + '-' + Lc_Mes + '-' + Lc_Dia;
         end;
   end;
end;

function CompletaStringCom(Texto, Inc: string; nTamRetorno: Integer;
   lPosicao: Boolean): string;
var
   i, j: Integer;
   Retorno: string;
begin
   i := nTamRetorno - Length(Texto);

   Retorno := '';
   if i > 0 then
   begin
      for j := 1 to i do
         Retorno := Retorno + Inc;
      if lPosicao then
         Retorno := Retorno + Texto
      else
         Retorno := Texto + Retorno;
   end
   else
      Retorno := Texto;

   Result := Retorno;
end;

function Fc_MascaraPrazo(Pc_Parcela: Integer): string;
var
   Lc_I: Integer;
   Lc_Mascara: string;
begin
   if Pc_Parcela = 0 then
   begin
      Lc_Mascara := 'A VISTA';
   end
   else
   begin
      for Lc_I := 1 to Pc_Parcela do
      begin
         if LC_I <> Pc_Parcela then
         begin
            Lc_Mascara := Lc_Mascara + '000/';
         end
         else
         begin
            Lc_Mascara := Lc_Mascara + '000;1;_';
         end;
      end;
   end;
   Result := Lc_Mascara;

end;

function Fc_UltimoCaixa(): TDate;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT MAX(MVF_DATA) AS ULT_CAIXA FROM TB_MOVIM_FINANCEIRO WHERE (MVF_CODCTB = 0 )');
      Active := True;
      FetchAll;
      if FieldByName('ULT_CAIXA').AsInteger = 0 then
        Result := Date
      else
        Result := FieldByName('ULT_CAIXA').AsDateTime;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_PegaLetraColuna(Fc_Numero: Integer): string;
begin
   if Fc_Numero < 1 then
   begin
      Result := 'A';
   end
   else
   begin
      if Fc_Numero > 256 then
      begin
         Result := 'IV'
      end
      else
      begin
         if Fc_Numero > 26 then
         begin
            case Fc_Numero of
               27..52:
                  begin
                     Result := 'A' + Chr(64 + (Fc_Numero - (26 * 1)));
                  end;
               53..78:
                  begin
                     Result := 'B' + Chr(64 + (Fc_Numero - (26 * 2)));
                  end;
               79..104:
                  begin
                     Result := 'C' + Chr(64 + (Fc_Numero - (26 * 3)));
                  end;
               105..130:
                  begin
                     Result := 'D' + Chr(64 + (Fc_Numero - (26 * 4)));
                  end;
               131..156:
                  begin
                     Result := 'E' + Chr(64 + (Fc_Numero - (26 * 5)));
                  end;
               157..182:
                  begin
                     Result := 'F' + Chr(64 + (Fc_Numero - (26 * 6)));
                  end;
               183..208:
                  begin
                     Result := 'G' + Chr(64 + (Fc_Numero - (26 * 7)));
                  end;
               209..234:
                  begin
                     Result := 'H' + Chr(64 + (Fc_Numero - (26 * 8)));
                  end;
               235..256:
                  begin
                     Result := 'I' + Chr(64 + (Fc_Numero - (26 * 9)));
                  end;

            end;
         end
         else
         begin
            Result := Chr(64 + Fc_Numero);
         end;
      end;
   end;
end;

function Fc_Generator(pc_Gen: string;pc_NomeTabela:String;Pc_campo : String): Integer;
var
   Lc_SqlTxt: string;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  {Para operações críticas em que não podemos gravar no momento em gera o numero não informar a Tabela
   A tabela deve ser informado para cadastros menos importantes para tentar aproveitar os numeros}
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
     CachedUpdates := true;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'SELECT GEN_ID(' + pc_Gen + ',1) FROM RDB$DATABASE';
      SQL.Add(Lc_SqlTxt);
      Active := True;
      ApplyUpdates;
      IF fieldbyname('GEN_ID').AsInteger < 1 THEN
        Result:=1
      ELSE
      Result := fieldbyname('GEN_ID').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_Cab_Relatorio(Pc_Quick: TCustomQuickRep);
var
  Ex_NomeEmpresa: TQRLabel;
  Ex_Cnpj: TQRLabel;
  Ex_Endereco: TQRLabel;
  Ex_Bairro: TQRLabel;
  Ex_Fone_email: TQRLabel;
  Ex_Logo: TQRImage;
  Ex_site: TQRLabel;
  LcLogo : TJpegImage;
  i :integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_altura_Linnha : Integer;
begin
  for i := Pc_Quick.ComponentCount-1 downto 0 do
  Begin
    if ( Pc_Quick.Components[i].ClassName <>'TQRImage' ) then
      Pc_Quick.Components[i].DisposeOf;
  end;

  Ex_Logo := TQRImage.Create(Pc_Quick);
  Ex_Logo.Visible := TRUE;
  Ex_Logo.Parent := Pc_Quick;
  Ex_Logo.Top := 40;
  Ex_Logo.Left := 43;
  Ex_Logo.AutoSize := False;
  Ex_Logo.Height := 91;
  Ex_Logo.Width := 127;
  Ex_Logo.Stretch := True;
  Ex_Logo.Center := True;
  Fc_BuscaImagemEmpresa(Ex_Logo.Picture, 'LOGO');
  if NOT (LcLogo = nil) then
    Ex_Logo.Picture.Graphic := lclOGO;

  Lc_altura_Linnha := 15;

  Ex_NomeEmpresa := TQRLabel.Create(Pc_Quick);
  Ex_NomeEmpresa.Visible := TRUE;
  Ex_NomeEmpresa.Parent := Pc_Quick;
  Ex_NomeEmpresa.Font.Style := [fsBold];
  Ex_NomeEmpresa.Top := 43;
  Ex_NomeEmpresa.Left := 175;

  Ex_Cnpj := TQRLabel.Create(Pc_Quick);
  Ex_Cnpj.Visible := TRUE;
  Ex_Cnpj.Parent := Pc_Quick;
  Ex_Cnpj.Font.Style := [fsBold];
  Ex_Cnpj.Top := Ex_NomeEmpresa.Top + Lc_altura_Linnha;
  Ex_Cnpj.Left := 175;

  Ex_Endereco := TQRLabel.Create(Pc_Quick);
  Ex_Endereco.Visible := TRUE;
  Ex_Endereco.Parent := Pc_Quick;
  Ex_Endereco.Top := Ex_Cnpj.Top + Lc_altura_Linnha;
  Ex_Endereco.Left := 175;

  Ex_Bairro := TQRLabel.Create(Pc_Quick);
  Ex_Bairro.Visible := TRUE;
  Ex_Bairro.Parent := Pc_Quick;
  Ex_Bairro.Top := Ex_Endereco.Top + Lc_altura_Linnha;
  Ex_Bairro.Left := 175;

  Ex_Fone_email := TQRLabel.Create(Pc_Quick);
  Ex_Fone_email.Visible := TRUE;
  Ex_Fone_email.Parent := Pc_Quick;
  Ex_Fone_email.Top := Ex_Bairro.Top + Lc_altura_Linnha;
  Ex_Fone_email.Left := 175;

  Pc_Quick.Height := 130;
  Pc_Quick.Repaint;
  Ex_site := TQRLabel.Create(Pc_Quick);
  Ex_site.Visible := TRUE;
  Ex_site.Parent := Pc_Quick;
  Ex_site.Top := Ex_Fone_email.Top + 18;
  Ex_site.Left := 175;

  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' SELECT EMP_FANTASIA, EMP_CNPJ, END_ENDER, END_NUMERO, END_BAIRRO, CDD_DESCRICAO, '+
                ' UFE_SIGLA, END_FONE, END_FAX, EMP_SITE,EMP_EMAIL,END_PRINCIPAL,END_COMPLEM '+
                'FROM TB_EMPRESA tb_empresa '+
                ' INNER JOIN TB_ENDERECO tb_endereco '+
                '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
                ' INNER JOIN TB_CIDADE tb_cidade '+
                '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)   '+
                ' INNER JOIN TB_UF tb_uf '+
                '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                'WHERE (EMP_TIPO = 0)   '+
                ' AND  EMP_CODIGO = :EMP_CODIGO ');

      ParamByName('EMP_CODIGO').AsInteger:= Gb_CodMha;
      Active:=True;
      First;
      Locate('END_PRINCIPAL','S',[]);

      Ex_NomeEmpresa.Caption  := fieldbyname('EMP_FANTASIA').AsString;
      Ex_Cnpj.Caption         := fc_MascaraCNPJ(fieldbyname('EMP_CNPJ').AsString);
      Ex_Endereco.Caption     := fieldbyname('END_ENDER').AsString + ', '+ fieldbyname('END_NUMERO').AsString;
      Ex_Bairro.Caption       := fieldbyname('END_BAIRRO').AsString + ' - ' +
      fieldbyname('CDD_DESCRICAO').AsString + ' - ' +
      fieldbyname('UFE_SIGLA').AsString;
      Ex_Fone_email.Caption := 'Fone : ' + fc_MascaraFone(fieldbyname('END_FONE').AsString);
      if Length(fieldbyname('EMP_SITE').AsString) > 0 then
      begin
        Ex_site.Caption := fieldbyname('EMP_SITE').AsString + ' - ' + fieldbyname('EMP_EMAIL').AsString;
      end
      else
      Begin
        Ex_site.Caption := fieldbyname('EMP_EMAIL').AsString;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_Cab_Report(Pc_Cabeca: TQrBand);
var
  Ex_NomeEmpresa: TQRLabel;
  Ex_Endereco: TQRLabel;
  Ex_Bairro: TQRLabel;
  Ex_Fone_email: TQRLabel;
  Ex_Logo: TQRImage;
  Ex_site: TQRLabel;
  LcLogo : TJpegImage;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Ex_Logo := TQRImage.Create(Pc_Cabeca);
  Ex_Logo.Visible := TRUE;
  Ex_Logo.Parent := Pc_Cabeca;
  Ex_Logo.Top := 40;
  Ex_Logo.Left := 43;
  Ex_Logo.AutoSize := False;
  Ex_Logo.Height := 73;
  Ex_Logo.Width := 127;
  Ex_Logo.Stretch := True;
  Ex_Logo.Center := True;
  Fc_BuscaImagemEmpresa(Ex_Logo.Picture, 'LOGO');
  if NOT (LcLogo = nil) then
    Ex_Logo.Picture.Graphic := lclOGO;

  Ex_NomeEmpresa := TQRLabel.Create(Pc_Cabeca);
  Ex_NomeEmpresa.Visible := TRUE;
  Ex_NomeEmpresa.Parent := Pc_Cabeca;
  Ex_NomeEmpresa.Font.Style := [fsBold];
  Ex_NomeEmpresa.Top := 43;
  Ex_NomeEmpresa.Left := 175;

  Ex_Endereco := TQRLabel.Create(Pc_Cabeca);
  Ex_Endereco.Visible := TRUE;
  Ex_Endereco.Parent := Pc_Cabeca;
  Ex_Endereco.Top := 61;
  Ex_Endereco.Left := 175;

  Ex_Bairro := TQRLabel.Create(Pc_Cabeca);
  Ex_Bairro.Visible := TRUE;
  Ex_Bairro.Parent := Pc_Cabeca;
  Ex_Bairro.Top := 78;
  Ex_Bairro.Left := 175;

  Ex_Fone_email := TQRLabel.Create(Pc_Cabeca);
  Ex_Fone_email.Visible := TRUE;
  Ex_Fone_email.Parent := Pc_Cabeca;
  Ex_Fone_email.Top := 97;
  Ex_Fone_email.Left := 175;

  Ex_site := TQRLabel.Create(Pc_Cabeca);
  Ex_site.Visible := TRUE;
  Ex_site.Parent := Pc_Cabeca;
  Ex_site.Top := 116;
  Ex_site.Left := 175;
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' SELECT EMP_FANTASIA, END_ENDER, END_NUMERO, END_BAIRRO, CDD_DESCRICAO, '+
                ' UFE_SIGLA, END_FONE, END_FAX, EMP_SITE,EMP_EMAIL,END_PRINCIPAL,END_COMPLEM '+
                'FROM TB_EMPRESA tb_empresa '+
                ' INNER JOIN TB_ENDERECO tb_endereco '+
                '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
                ' INNER JOIN TB_CIDADE tb_cidade '+
                '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)   '+
                ' INNER JOIN TB_UF tb_uf '+
                '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
                'WHERE (EMP_TIPO = 0)   '+
                ' AND  EMP_CODIGO = :EMP_CODIGO ');

      ParamByName('EMP_CODIGO').AsInteger:= Gb_CodMha;
      Active:=True;
      First;
      Locate('END_PRINCIPAL','S',[]);

      Ex_NomeEmpresa.Caption  := fieldbyname('EMP_FANTASIA').AsString;
      Ex_Endereco.Caption     := fieldbyname('END_ENDER').AsString + ', '+fieldbyname('END_NUMERO').AsString;
      Ex_Bairro.Caption       := fieldbyname('END_BAIRRO').AsString + ' - ' +
                                 fieldbyname('CDD_DESCRICAO').AsString + ' - ' +
                                 fieldbyname('UFE_SIGLA').AsString;

      Ex_Fone_email.Caption := 'Fone :' + fc_MascaraFone(fieldbyname('END_FONE').AsString) + ' / ' + fc_MascaraFone(fieldbyname('END_FAX').AsString);

      Ex_site.Caption := fieldbyname('EMP_SITE').AsString + ' - ' + fieldbyname('EMP_EMAIL').AsString;

    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_CopiarArquivo(const Pc_Origem, Pc_Destino: string; Pc_Barra:TGauge);
var
  ArquivoOrigem, ArquivoDestino: file of byte;
  Buffer: array[0..4096] of char;
  NumRead: integer;
  FileLength: longint;
begin
//  TTask.Create(
//  procedure
//  begin
    try
      { Abre o arquivo arquivo selecionado }
      AssignFile(ArquivoOrigem, Pc_Origem);
      reset(ArquivoOrigem);
      { Cria um arquivo na pasta selecionada }
      AssignFile(ArquivoDestino, Pc_Destino);
      rewrite(ArquivoDestino);
      { Pega o tamanho do arquivo }
      FileLength := FileSize(ArquivoOrigem);
      Pc_Barra.MinValue := 0;
      { O Max do progress bar Ã© igual o tamanho do arquivo }
      Pc_Barra.MaxValue := FileLength;
      Pc_Barra.Progress := 0;
      while FileLength > 0 do
      begin
        { LÃª um pedaÃ§o do arquivo de origem }
        BlockRead(ArquivoOrigem, Buffer[0], SizeOf(Buffer), NumRead);
        { Muda o valor da variÃ¡vel tamanho do arquivo retirando o pedaÃ§o copiado }
        FileLength := FileLength - NumRead;
        { Escreve no arquivo de destino o pedaÃ§o lido do arquivo de origem }
        BlockWrite(ArquivoDestino, Buffer[0], NumRead);
        { Muda a posiÃ§Ã£o do progress bar }
//        TThread.Synchronize(TThread.CurrentThread,
//        procedure
//        begin
          Pc_Barra.Progress := Pc_Barra.Progress + NumRead;
          Application.ProcessMessages;
//        end);
      end;
      { Fecha os 2 arquivos: origem e destino }
      CloseFile(ArquivoOrigem);
      CloseFile(ArquivoDestino);

    except
      { Caso ocorra um erro, exibe a mensagem }
      on e:exception do
        raise Exception.create('Erro ao efetuar a copia do arquivo:' + e.Message);
    end;
    { Zera o progress bar }
///  end);
end;

{$R-}{$Q-}

function EncryptSTR(const InString: string; StartKey, MultKey, AddKey: Integer): string;
var I: Byte;
begin
   Result := '';
   for I := 1 to Length(InString) do
   begin
      Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
      StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
   end;
end;

function DecryptSTR(const InString: string; StartKey, MultKey, AddKey: Integer): string;
var I: Byte;
begin
   Result := '';
   for I := 1 to Length(InString) do
   begin
      Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
      StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
   end;
end;
{$R+}{$Q+}



function Fc_Ext3(Parte: string): string;
var
   Base: string;
   digito: integer;
begin
   Base := '';
   digito := StrToInt(Parte[1]);
   if digito = 0 then
      Base := ''
   else
      Base := Centenas[digito];
   if (digito = 1) and (Parte > '100') then
      Base := 'CENTO';
   Digito := StrToInt(Parte[2]);
   if digito = 1 then
   begin
      Digito := StrToInt(Parte[3]);
      if Base <> '' then
         Base := Base + ' E ';
      Base := Base + Dez[Digito];
   end
   else
   begin
      if (Base <> '') and (Digito > 0) then
         Base := Base + ' E ';
      if Digito > 1 then
         Base := Base + Dezenas[digito];
      Digito := StrToInt(Parte[3]);
      if Digito > 0 then
      begin
         if Base <> '' then
            Base := Base + ' E ';
         Base := Base + Unidades[Digito];
      end;
   end;
   Result := Base;
end;

function Fc_Extenso;
var
   ComoTexto: string;
   Parte: string;
begin
   Result := '';
   ComoTexto := FloatToStrF(Abs(Valor), ffFixed, 18, 2);
// Acrescenta zeros a esquerda ate 12 digitos
   while length(ComoTexto) < 15 do
      Insert('0', ComoTexto, 1);
// Retira caracteres a esquerda para o máximo de 12 digitos
   while length(ComoTexto) > 15 do
      delete(ComoTexto, 1, 1);

// Calcula os bilhões
   Parte := Fc_Ext3(copy(ComoTexto, 1, 3));
   if StrToInt(copy(ComoTexto, 1, 3)) = 1 then
      Parte := Parte + ' BILHAO'
   else if Parte <> '' then
      Parte := Parte + ' BILHOES';
   Result := Parte;

// Calcula os nilhões
   Parte := Fc_Ext3(copy(ComoTexto, 4, 3));
   if Parte <> '' then
   begin
      if Result <> '' then
         Result := Result + ', ';
      if StrToInt(copy(ComoTexto, 4, 3)) = 1 then
         Parte := Parte + ' MILHAO'
      else
         Parte := Parte + ' MILHOES';
      Result := Result + Parte;
   end;

// Calcula os nilhares
   Parte := Fc_Ext3(copy(ComoTexto, 7, 3));
   if Parte <> '' then
   begin
      if Result <> '' then
         Result := Result + ', ';
      Parte := Parte + ' MIL';
      Result := Result + Parte;
   end;

// Calcula as unidades
   Parte := Fc_Ext3(copy(ComoTexto, 10, 3));
   if Parte <> '' then
   begin
      if Result <> '' then
         if Frac(Valor) = 0 then
            Result := Result + ' E '
         else
            Result := Result + ', ';
      Result := Result + Parte;
   end;

// Acrescenta o texto da moeda
   if Int(Valor) = 1 then
      Parte := ' ' + MoedaSingular
   else
      Parte := ' ' + MoedaPlural;
   if copy(ComoTexto, 7, 6) = '000000' then
      Parte := 'DE ' + MoedaPlural;
   Result := Result + Parte;

// Se o valor for zero, limpa o resultado
   if int(Valor) = 0 then
      Result := '';

//Calcula os centavos
   Parte := Fc_Ext3('0' + copy(ComoTexto, 14, 2));
   if Parte <> '' then
   begin
      if Result <> '' then
         Result := Result + ' E ';
      if Parte = Unidades[1] then
         Parte := Parte + ' ' + CentSingular
      else
         Parte := Parte + ' ' + CentPlural;
      Result := Result + Parte;
   end;

// Se o valor for zero, assume a constante ZERO
   if Valor = 0 then
      Result := Zero;
end;



function TestaCgc(xCGC: string): Boolean;
{Testa se o CGC é válido ou não}
var
   d1, d4, xx, nCount, fator, resto, digito1, digito2: Integer;
   Check: string;
begin

  if (Fc_Tb_Geral('L','GRL_G_VALIDA_CPF_CNPJ','') = 'N') then
    Begin
    Result := True;
    Exit;
    end;


 if (xCGC = '11111111111111') or (xCGC = '22222222222222') or (xCGC = '33333333333333') or (xCGC = '44444444444444') or
    (xCGC = '55555555555555') or (xCGC = '66666666666666') or (xCGC = '77777777777777') or (xCGC = '88888888888888') or
    (xCGC = '99999999999999') OR  (TRIM(xCGC) = '') or (xCGC = '00000000000000')then
     begin
     Result := False;
     Exit;
     end;

   d1 := 0;
   d4 := 0;
   xx := 1;
   for nCount := 1 to Length(xCGC) - 2 do
   begin
      if Pos(Copy(xCGC, nCount, 1), '/-.') = 0 then
      begin
         if xx < 5 then
         begin
            fator := 6 - xx;
         end
         else
         begin
            fator := 14 - xx;
         end;
         d1 := d1 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         if xx < 6 then
         begin
            fator := 7 - xx;
         end
         else
         begin
            fator := 15 - xx;
         end;
         d4 := d4 + StrToInt(Copy(xCGC, nCount, 1)) * fator;
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;

   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCGC, succ(length(xCGC) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

function TestaCpf(xCPF: string): Boolean;
{Testa se o CPF é válido ou não}
var
   d1, d4, xx, nCount, resto, digito1, digito2: Integer;
   Check: string;
begin
  if (Fc_Tb_Geral('L','GRL_G_VALIDA_CPF_CNPJ','') = 'N') then
  Begin
    Result := True;
    Exit;
  end;

  if (xCPF = '11111111111') or (xCPF = '22222222222') or (xCPF = '33333333333') or (xCPF = '44444444444') or
    (xCPF = '55555555555') or (xCPF = '66666666666') or (xCPF = '77777777777') or (xCPF = '88888888888') or
    (xCPF = '99999999999') OR  (TRIM(xCPF) = '')or (xCPF = '00000000000') then
  begin
    Result := False;
    Exit;
  end;

   d1 := 0; d4 := 0; xx := 1;
   for nCount := 1 to Length(xCPF) - 2 do
   begin
      if Pos(Copy(xCPF, nCount, 1), '/-.') = 0 then
      begin
         d1 := d1 + (11 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         d4 := d4 + (12 - xx) * StrToInt(Copy(xCPF, nCount, 1));
         xx := xx + 1;
      end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
      digito1 := 0;
   end
   else
   begin
      digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
   begin
      digito2 := 0;
   end
   else
   begin
      digito2 := 11 - resto;
   end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCPF, succ(length(xCPF) - 2), 2) then
   begin
      Result := False;
   end
   else
   begin
      Result := True;
   end;
end;

function Fc_Aq_Geral(Fc_TipoOper: string; Fc_Secao: string; Fc_CHave: string; fc_Valor: string): string;
var
   ArquivoIni: TIniFile;
   Lc_NameArq: string;
begin
  Result := '';
  Lc_NameArq := GbPathExe + 'CONFIG.INI';
  ArquivoIni := TIniFile.Create(Lc_NameArq);
  if Fc_TipoOper = 'L' then
  begin
    if ArquivoIni.SectionExists(Fc_Secao) then
    begin
      Result := ArquivoIni.ReadString(Fc_Secao, Fc_CHave, fc_Valor);
      if Result = '' then
        Result := fc_Valor;
      ArquivoIni.DisposeOf;
      exit;
    end
    else
    begin
      ArquivoIni.WriteString(Fc_Secao, Fc_CHave, Fc_Valor);
      Result := Fc_Valor;
      ArquivoIni.DisposeOf;
    end;
  end
  else
  begin
    ArquivoIni.WriteString(Fc_Secao, Fc_CHave, Fc_Valor);
    Result := Fc_Valor;
    ArquivoIni.DisposeOf;
  end;

end;


function fc_MascaraFone(pc_Fone: string): string;
var
  Lc_Text : String;
begin
  Lc_Text := RemoveCaracterInformado(pc_Fone, ['(',')',' ','-','-']);
  if (Copy(Lc_Text,1,4) = '0800')OR (Copy(Lc_Text,1,4) = '0300') then
  Begin//0800-41-1910
    case Length(Lc_Text) of
      5..6:Result   := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2);
      7..10:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2) + '-' + Copy(Lc_Text,7,4);
      11:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,3) + '-' + Copy(Lc_Text,8,4);
    else
      Result := Lc_Text;
    end;
  end
  else
  Begin
    case Length(Lc_Text) of
      5..8:   Begin
                case Length(Lc_Text) of
                  5:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,1);
                  6:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,2);
                  7:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,3);
                  8:Result := Copy(Lc_Text,1,4) + '-' + Copy(Lc_Text,5,4);
                end;
              end;
      9:      Begin
                Result := Copy(Lc_Text,1,5) + '-' + Copy(Lc_Text,6,4);
              end;
      10..11: Begin
                case Length(Lc_Text) of
                  10:Result := '(' + Copy(Lc_Text,1,2) + ') ' + Copy(Lc_Text,3,4) + '-' + Copy(Lc_Text,7,4);
                  11:Result := '(' + Copy(Lc_Text,1,2) + ') ' + Copy(Lc_Text,3,5) + '-' + Copy(Lc_Text,8,4);
                end;
             end;
    end;
  end;

end;

function Fc_AchaComponente(Fc_Nome: string; Lc_F: TForm): TComponent;
var
   Lc_I: integer;
   Lc_C: TComponent;
begin
   Result := nil;
  // Converte nome para maiúscula
   Fc_Nome := UpperCase(Fc_Nome);
  // Varre o formulário à procura do componente
   for Lc_I := 0 to Lc_F.ComponentCount - 1 do
   begin
      Lc_C := Lc_F.Components[Lc_I];
    // O nome está correto?
      if UpperCase(Lc_C.Name) = Fc_Nome then
      begin
      // Retorna o componente
         Result := Lc_C;
      // Sai do loop
         exit;
      end;
   end;
end;

// Atibui propriedade ao componente, dado seu valor como string

procedure Pc_AtribuiProp(Pc_Comp: TComponent; const PropName: string; Val: string);
var
   Lc_PInfo: PPropInfo;
begin
  // Pega  informações de tipo da propriedade
   Lc_PInfo := GetPropInfo(PC_Comp.ClassInfo, PropName);
  // Achou?
   if Lc_PInfo <> nil then
   begin
    // Trata conforme o tipo
      case Lc_PInfo^.Proptype^.Kind of
         tkInteger: SetOrdProp(Pc_Comp, Lc_PInfo, StrToInt(Val));
         tkChar, tkWChar: SetOrdProp(pc_Comp, Lc_PInfo, ord(Val[1]));
         tkEnumeration: SetOrdProp(Pc_Comp, Lc_PInfo, GetEnumValue(Lc_PInfo^.PropType^, Val));
         tkFloat: SetFloatProp(Pc_Comp, Lc_PInfo, StrToFloatDef(Val,0));
         tkString, tkLString, tkWString: SetStrProp(Pc_Comp, Lc_PInfo, Val);
         tkVariant: SetVariantProp(PC_Comp, Lc_PInfo, Val);
         tkInt64: SetInt64Prop(Pc_Comp, Lc_PInfo, StrToInt64(Val));
      else
         ShowMessage('Este tipo não é suportado por este programa');
      end;
   end
   else
      ShowMessage('Propriedade não achada');
end;

// Lê valor da propriedade do componente

function LeProp(Comp: TComponent; const PropName: string): string;
var
   PInfo: PPropInfo;
begin
   Result := '';
// Pega informações de tipo da propriedade
   PInfo := GetPropInfo(Comp.ClassInfo, PropName);
// Achou?
   if PInfo <> nil then
   begin
// Trata conforme o tipo
      case PInfo^.Proptype^.Kind of
         tkInteger: Result := IntToStr(GetOrdProp(Comp, PInfo));
         tkChar, tkWChar: Result := char(GetOrdProp(Comp, PInfo));
         tkEnumeration: Result := GetEnumName(PInfo^.PropType^, GetOrdProp(Comp, PInfo));
         tkFloat: Result := FloatToStr(GetFloatProp(Comp, PInfo));
         tkString, tkLString, tkWString: Result := GetStrProp(Comp, PInfo);
         tkVariant: GetVariantProp(Comp, PInfo);
         tkInt64: Result := IntToStr(GetInt64Prop(Comp, PInfo));
      else
         ShowMessage('Este tipo não é suportado por este programa');
      end;
   end
   else
      ShowMessage('Propriedade não achada');
end;

function Fc_Tb_Geral(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: string): string;
Var
  Lc_Geral : TControllerGeral;
  Lc_Codmha : Integer;
begin
  Try
    Lc_Geral := TControllerGeral.Create(nil);
    if Fc_CAmpo = 'CD_CLIENTE_SETES' then
      Lc_Codmha := 0
    else
      Lc_Codmha := 1;

    with Lc_Geral do
    Begin
      Registro.Campo := Fc_CAmpo;
      Registro.Conteudo := Fc_Conteudo;
      Registro.CodigoEstabelecimento := Lc_Codmha;
      if Fc_Tipo = 'G' then
      Begin
        salva;
      End
      else
      Begin
        getById;
        if not exist then
        Begin
          Registro.Campo := Fc_CAmpo;
          Registro.Conteudo := Fc_Conteudo;
          Registro.CodigoEstabelecimento := Lc_Codmha;
         salva;
        end;
      End;
      Result := Registro.Conteudo;
    End;
  Finally
    Lc_Geral.DisposeOF
  End;
end;

function Fc_Tb_Geral_Detalhe(Fc_Tipo: char; Fc_CAmpo: string; Fc_Conteudo: String): TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_Texto: TMemoryStream;
  LcBase : TControllerBase;
begin
  try
    Lc_Texto := TMemoryStream.Create;
    Result := TStringList.Create();
    LcBase := TControllerBase.create(nil);
    Lc_Qry :=  LcBase.GeraQuery;
    if (Fc_Tipo = 'L') then
    Begin
      with Lc_Qry do
      Begin
        SQL.Add('SELECT GRL_DETALHES '+
                'FROM TB_GERAL '+
                'WHERE GRL_CAMPO =:GRL_CAMPO AND GRL_CODMHA =:GRL_CODMHA');
        ParamByName('GRL_CAMPO').AsString := Fc_CAmpo;
        ParamByName('GRL_CODMHA').AsInteger := Gb_CodMha;
        Active := True;
        Lc_Texto.LoadFromStream(CreateBlobStream(FieldByName('GRL_DETALHES'), bmRead));
        Result.LoadFromStream(Lc_Texto);
      end;
    end
    else
    Begin
      with Lc_Qry do
      Begin
        SQL.Add('UPDATE OR INSERT INTO TB_GERAL( '+
                '  GRL_CODIGO, '+
                '  GRL_CAMPO, '+
                '  GRL_DETALHES, '+
                '  GRL_CODMHA) '+
                'VALUES( '+
                '  :GRL_CODIGO, '+
                '  :GRL_CAMPO, '+
                '  :GRL_DETALHES, '+
                '  :GRL_CODMHA) '+
                ' MATCHING (GRL_CAMPO) ');
        ParamByName('GRL_CODIGO').AsInteger := Fc_Generator('GN_GERAL','','GRL_CODIGO');
        ParamByName('GRL_CAMPO').AsString := Fc_CAmpo;
        ParamByName('GRL_DETALHES').AsString := Fc_Conteudo;
        ParamByName('GRL_CODMHA').AsInteger := Gb_CodMha;
        ExecSQL;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function tbKeyIsDown(const Key: integer): boolean;
begin
   Result := GetKeyState(Key) and 128 > 0;
end;

function fc_IsInteger(Pc_String: string): boolean;
var
   Lc_Letra: array[1..25] of Char;
   lc_I, Lc_J: Integer;
begin
  Result := true;
   Lc_Letra[1] := 'A'; Lc_Letra[13] := 'M';
   Lc_Letra[2] := 'B'; Lc_Letra[14] := 'N';
   Lc_Letra[3] := 'C'; Lc_Letra[15] := 'O';
   Lc_Letra[4] := 'D'; Lc_Letra[16] := 'P';
   Lc_Letra[5] := 'E'; Lc_Letra[17] := 'Q';
   Lc_Letra[6] := 'F'; Lc_Letra[18] := 'R';
   Lc_Letra[7] := 'G'; Lc_Letra[19] := 'S';
   Lc_Letra[8] := 'H'; Lc_Letra[20] := 'T';
   Lc_Letra[9] := 'I'; Lc_Letra[21] := 'U';
   Lc_Letra[10] := 'J'; Lc_Letra[22] := 'V';
   Lc_Letra[11] := 'K'; Lc_Letra[23] := 'X';
   Lc_Letra[12] := 'L'; Lc_Letra[24] := 'Z';

   for Lc_J := 1 to Length(pc_string) do
      for Lc_I := 1 to 24 do
         if Pc_String[lc_J] = Lc_Letra[lc_I] then
         begin
            Result := true;
            exit;
         end
         else
            Result := False;
end;

function fc_MascaraCPF(Pc_CPF: string): string;
var
   Lc_CPF: string;
begin
   if Length(Pc_CPF) > 0 then
   begin
      Lc_CPF := Copy(Pc_CPF, 1, 3) + '.' +
         Copy(Pc_CPF, 4, 3) + '.' +
         Copy(Pc_CPF, 7, 3) + '-' +
         Copy(Pc_CPF, 10, 2);
      Result := Lc_CPF;
   end
   else
      Result := '';

end;

function fc_MascaraCNPJ(Pc_CNPJ: string): string;
var
   Lc_CNPJ: string;
begin
   if Length(Pc_CNPJ) > 0 then
   begin
      Lc_CNPJ := Copy(Pc_CNPJ, 1, 2) + '.' +
         Copy(Pc_CNPJ, 3, 3) + '.' +
         Copy(Pc_CNPJ, 6, 3) + '/' +
         Copy(Pc_CNPJ, 9, 4) + '-' +
         Copy(Pc_CNPJ, 13, 2);
      Result := Lc_CNPJ;
   end
   else
      Result := '';
end;

procedure PC_ApagarLinha(pc_Grade: TStringGrid; pc_NumItens, Pc_Linha: integer); //Posição da Linha
var
   Lc_Grade: array of array of string;
   lc_I, lc_J: Integer;
   lc_Linha: integer;
begin
   lc_Linha := 0;
   SetLength(Lc_Grade, Pc_Grade.rowCount - 1, Pc_Grade.ColCount);
   for lc_I := 1 to pc_NumItens do
   begin
      if lc_I <> Pc_Linha then
      begin
         for lc_J := 0 to Pc_Grade.ColCount - 1 do
            Lc_Grade[lc_Linha, lc_J] := Pc_Grade.Cells[lc_j, lc_I];
         lc_Linha := lc_Linha + 1;
      end;
   end;
   for lc_I := 1 to Pc_Grade.RowCount - 1 do
      for lc_J := 0 to Pc_Grade.ColCount - 1 do
         pc_Grade.Cells[lc_J, lc_I] := '';

   Pc_Grade.RowCount := 2;
   for lc_I := 1 to lc_Linha do
   begin
      Pc_Grade.RowCount := lc_I + 1;
      for lc_J := 0 to Pc_Grade.ColCount - 1 do
         pc_Grade.Cells[lc_J, lc_I] := lc_Grade[lc_I - 1, lc_j];
   end;
end;


function Fc_GeraCod_BAixa: Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT GEN_ID(GN_COD_BAIXA,1) FROM RDB$DATABASE');
      Active := True;
      Result := fieldbyname('GEN_ID').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_Prod_Inativo(Pc_Codpro: Integer; Pc_Periodo: TDate);
var
  Lc_SqlTxt: string;
  Lc_Data : TDAte;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Lc_Data := Date;
  if not (Pc_Periodo = Lc_Data) then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        Lc_SqlTxt := 'SELECT ITF_CODPRO ' +
                     'FROM TB_ITENS_NFL tb_itens_nfl ' +
                     '  INNER JOIN TB_PEDIDO tb_pedido ' +
                     '  ON (tb_pedido.PED_CODIGO = tb_itens_nfl.ITF_CODPED) ' +
                     'WHERE (ITF_CODPRO=:ITF_CODPRO) AND (PED_DATA>:PED_DATA) ';
        SQL.Add(Lc_SqlTxt);
        ParamByName('ITF_CODPRO').AsInteger := Pc_Codpro;
        ParamByName('PED_DATA').AsDate := Pc_Periodo;
        Active := true;
        FetchAll;
        if RecordCount = 0 then
        begin
          MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                         'Não há registro de movimentação deste produto.' + EOLN +
                         'verificado desde o dia ' + DateToStr(Pc_Periodo) + ' até hoje.' + EOLN,
                         ['OK'], [bEscape], mpInformacao);
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  end;
end;

procedure Pc_AtualizarPrecoManual(Pc_cd_Pedido: Integer);
var
  Lc_SqlTxt: string;
  Lc_Qry : TSTQuery;
//  Lc_Form : TFr_Produtos;
  LcBase : TControllerBase;
Begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    try

      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with  Lc_Qry do
      Begin
        Lc_SqlTxt := 'SELECT ITF_CODIGO,ITF_CODPED,ITF_CODNFL,ITF_CODPRO, PRO_SUB_TRIB, PRO_CODIGOFAB, PRO_DESCRICAO,     '+
                     'ITF_QTDE,ITF_VL_CUSTO,ITF_VL_UNIT,ITF_AQ_COM,MED_ABREVIATURA,PRO_VL_CUSTO,ITF_AQ_DESC, ITF_VL_DESC, '+
                     'ITF_AQ_IPI, ITF_AQ_ICMS, ITF_CODEST, ITF_CODTPR, ITF_ESTOQUE,  PRO_CODIGO '+
                     'FROM TB_ITENS_NFL Tb_itens_nfl '+
                     '  INNER JOIN TB_PEDIDO Tb_pedido ON  (Tb_itens_nfl.ITF_CODPED = Tb_pedido.PED_CODIGO) '+
                     '  INNER JOIN TB_PRODUTO Tb_produto  ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO) '+
                     '  inner JOIN tb_medida tb_medida ON tb_medida.med_codigo = tb_produto.pro_codmed '+
                     'WHERE (ITF_CODPED =:PED_CODIGO) ';
        SQL.Add(Lc_SqlTxt);
        Active := False;
        ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
        Active := true;
        FetchAll;


        while not Eof do
        begin
//          Try
//            Lc_Form := TFr_Produtos.Create(nil);
//            Lc_Form.Produto.Registro.Codigo :=  fieldbyname('PRO_CODIGO').AsInteger;
//            Lc_Form.ShowModal;
//          except
//            Lc_Form.disposeOf;
//          end;
          Next;
        end;
      end;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  end;
end;



procedure Pc_Aniversario(Pc_Data:String);
var
   Lc_Hoje: string;
   Lc_Aniver: string;
begin
   Lc_Aniver := Copy(Pc_Data, 1, 5);
   Lc_Hoje := Copy(DateToStr(Date), 1, 5);
   if Lc_Aniver = Lc_Hoje then
   begin
      MensagemPadrao('Mensagem ', 'A T E N Ç Ã O!.' + EOLN + EOLN +
         '        Parabenize o Cliente' + EOLN + EOLN +
         'Ele está completando aniversário hoje.' + EOLN,
         ['OK'], [bEscape], mpInformacao);
   end;
end;



procedure PC_MUDA_DATA(Sender: TObject; Pc_Campo: TMaskedit);
begin

end;

procedure Pc_Calendario(Pc_Campo: TMaskedit; Pc_Form: TForm);
var
   Lc_Campo: TDateTimePicker;
   LC_Data: TMaskEdit;

begin
   LC_Data := (Pc_Campo as TMaskedit);
   Lc_Campo := TDateTimePicker.create(Pc_Form);
   Lc_Campo.visible := false;
   Lc_Campo.parent := Pc_Form;
   Lc_Campo.left := LC_Data.Left;
   Lc_Campo.top := LC_Data.Top;
   Lc_Campo.Height := LC_Data.Height;
   Lc_Campo.Width := LC_Data.Width;
   Lc_Campo.visible := true;
end;

function fc_LogUser: string; //Declare Registry na clausula uses da unit
var Registro: TRegistry;
begin
   Registro := TRegistry.Create;
   Registro.RootKey := HKEY_LOCAL_MACHINE;
   if Registro.OpenKey('Network\Logon', false) then
      result := Registro.ReadString('username');
   Registro.disposeOf;
end;


function Fc_tela_Executando(Pc_Nome_Tela:Pchar):boolean;
var
    MutexHandle : THandle;
    function Fc_Verifica_Instacia: Boolean;
      begin
      result := false;
      if (MutexHandle <> 0) and (GetLastError = ERROR_ALREADY_EXISTS)  then
         result := true;
      end;
begin
  MutexHandle := CreateMutex(nil, True, Pc_Nome_Tela);
  if Fc_Verifica_Instacia then
    Result := true
  else
    Result := False;
end;

function BuscaTroca(Text, Busca, Troca: string): string;
var n: integer;
begin
   for n := 1 to length(Text) do
   begin
      if Copy(Text, n, 1) = Busca then
      begin
         Delete(Text, n, 1);
         Insert(Troca, Text, n);
      end;
   end;
   Result := Text;
end;

{-------------------------------------}
{Novas funções para o Sistema}


function Fc_GeraNumeroNota(): Integer;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
          'select max(nfe_nota_fim) Ult_NF ',
          'from tb_retorno_nfe ',
          'where nfe_codmha = :cod_empresa '
      ));
      ParamByName('cod_empresa').AsInteger := Gb_CodMha;
      Active := True;
      First;
      IF StrToIntDef(FieldByName('Ult_NF').asString,0) = 0 THEN
       Result :=1
      else
       Result := StrToIntDef(FieldByName('Ult_NF').AsString,0) + 1;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


procedure Pc_AtualizarPreco(Pc_cd_Nota: Integer);
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   LcListaPrecoFixo : TStringList;
   LcAtualizaPrecoFixo : Boolean;
   Lc_TabPreco :TControllerTabelaPreco;
   I : Integer;
begin
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Deseja atualizar o preço venda no Cadastro?.' + EOLN + EOLN +
                     'Confirmar a atualização ?',
                     ['Sim', 'Não'], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
  begin
    try
      Lc_TabPreco := TControllerTabelaPreco.create(nil);
      LcListaPrecoFixo := TStringList.create;
      //Componente que gera a lista de produtos
      Lc_Qry := Lc_TabPreco.GeraQuery;
      if Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','C') = 'C' then
        Lc_SqlTxt := 'SELECT PRO_VL_CUSTO VALOR, ITF_CODPRO,FIXED_RATE,PRO_CODIGO, PRO_DESCRICAO '
      else
        Lc_SqlTxt := 'SELECT PRO_VL_CUSTOMED VALOR, ITF_CODPRO,FIXED_RATE,PRO_CODIGO, PRO_DESCRICAO ';
      Lc_SqlTxt := Lc_SqlTxt +
                   'FROM  TB_NOTA_FISCAL tb_nota_fiscal ' +
                   '  INNER JOIN TB_ITENS_NFL tb_itens_nfl ' +
                   '  ON (tb_itens_nfl.ITF_CODNFL = tb_nota_fiscal.NFL_CODIGO) ' +
                   '  INNER JOIN TB_PRODUTO tb_produto ' +
                   '  ON (tb_produto.PRO_CODIGO = tb_itens_nfl.ITF_CODPRO) ' +
                   'WHERE (NFL_CODIGO=:NFL_CODIGO) ';
      Lc_Qry.SQL.Add(Lc_SqlTxt);
      Lc_Qry.Active := False;
      Lc_Qry.ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      Lc_Qry.Active := True;
      Lc_Qry.FetchAll;
      Lc_Qry.First;
      //Inicia o Looping para veriricar quem tem preco fixo
      LcListaPrecoFixo.Clear;
      LcListaPrecoFixo.Text :='';
      while not Lc_Qry.Eof do
      begin
        if Lc_Qry.FieldByName('FIXED_RATE').AsString = 'S' then
          LcListaPrecoFixo.Add(concat(Lc_Qry.FieldByName('PRO_CODIGO').AsString,' - ',Lc_Qry.FieldByName('PRO_DESCRICAO').AsString));
        Lc_Qry.Next;
      end;
      LcAtualizaPrecoFixo := False;
      if (Length(LcListaPrecoFixo.Text) >0 ) and (LcListaPrecoFixo.Count >0) then
      Begin
        if (MensagemPadrao('Mensagem de Confirmação',
                           'Os produtos abaixo estão regitrados como preço fixo.' + EOLN +
                           'Você deseja inclui-los na lista para atualização automática.'  + EOLN +
                           LcListaPrecoFixo.Text + EOLN  + EOLN +
                           'Confirmar a inclusão para atualização?',
                           ['Não', 'Sim'], [bEscape, bNormal], mpConfirmacao, clBlue) = mrBotao2) then
        Begin
          LcAtualizaPrecoFixo := True;
        end;
      END;
      Lc_TabPreco.getList;
      for I := 0 to Lc_TabPreco.Lista.count - 1 do
      Begin
        Lc_Qry.Active := False;
        Lc_Qry.ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
        Lc_Qry.Active := True;
        Lc_Qry.FetchAll;
        Lc_Qry.First;
        //Inicia o Looping de Atualização
        while not Lc_Qry.Eof do
        begin
          if (Lc_Qry.FieldByName('FIXED_RATE').AsString <> 'S') or LcAtualizaPrecoFixo then
          Begin
            Lc_TabPreco.Preco.clear;
            Lc_TabPreco.Preco.Registro.Codigo         := 0;
            Lc_TabPreco.Preco.Registro.CodigoTabela   := Lc_TabPreco.Lista[I].Codigo;
            Lc_TabPreco.Preco.Registro.CodigoProduto  := Lc_Qry.FieldByname('ITF_CODPRO').AsInteger;
            Lc_TabPreco.Preco.getByTabelaProduto;
            if ( ( Lc_TabPreco.Registro.MargemPrioritaria = 'S' ) or (Lc_TabPreco.Preco.Registro.MargemLucro = 0) ) then
            BEgin
              if ( Lc_TabPreco.Registro.MargemLucro > 0) then
              Begin
                Lc_TabPreco.Preco.Registro.Valor          := Fc_CalcularPrecoPelaMargemLucro(Lc_Qry.FieldByName('VALOR').AsFloat,
                                                                                   Lc_TabPreco.Lista[I].MargemLucro,
                                                                                   Lc_TabPreco.Lista[I].CasaDecimal );
                Lc_TabPreco.Preco.Registro.MargemLucro    := Lc_TabPreco.Lista[I].MargemLucro;
              end;
            end
            else
            Begin
              if Lc_TabPreco.Preco.Registro.MargemLucro > 0 then
              Begin
                Lc_TabPreco.Preco.Registro.Valor          := Fc_CalcularPrecoPelaMargemLucro(Lc_Qry.FieldByName('VALOR').AsFloat,
                                                                                   Lc_TabPreco.Preco.Registro.MargemLucro,
                                                                                   Lc_TabPreco.Lista[I].CasaDecimal);
              end;
            end;
            Lc_TabPreco.Preco.update;
          end;
          Lc_Qry.Next;
        end;
      end;
    finally
      Lc_TabPreco.FinalizaQuery(Lc_Qry);
      Lc_TabPreco.DisposeOf;
    end;
  end;
end;

procedure Pc_ApagaContato(Pc_Cd_Contato: Integer);
var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'DELETE FROM TB_Contato WHERE (CTO_CODIGO=:CTO_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CTO_CODIGO').AsInteger := Pc_Cd_Contato;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_ApagaFichaCadastral(Pc_Cd_Ficha: Integer);
var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'DELETE FROM TB_FICHA_CADASTRAL WHERE (FCT_CODIGO=:FCT_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FCT_CODIGO').AsInteger := Pc_Cd_Ficha;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_ApagaFrete(Pc_Cd_frete: Integer);
var
  Lc_SqlTxt : String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'DELETE FROM TB_frete WHERE (FRT_CODIGO=:FRT_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('FRT_CODIGO').AsInteger := Pc_Cd_frete;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_TotalBrutoPedido(Pc_Cd_Pedido: Integer): real;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_valor: Real;
   LcBase : TControllerBase;
begin
    //Cria a Consulta
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT ITF_CODIGO, ITF_VL_UNIT, ITF_QTDE ' +
        'FROM TB_ITENS_NFL ' +
        'WHERE (ITF_CODPED=:ITF_CODPED) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODPED').AsInteger := Pc_Cd_Pedido;
      Active := True;
      FetchAll;
      First;
      Lc_valor := 0;
      while not Lc_Qry.Eof do
      begin
        Lc_valor := Lc_valor + (FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat);
        Next;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
    Result := Lc_valor;
  end;
end;
{------------------------------------}
{G}



function Fc_Vl_custo(Pc_cd_Itens : Integer; Pc_cd_Nota:Integer):Real;
var
   Lc_Qry: TSTQuery;
   Lc_Resultado :real;
   LcBase : TControllerBase;
begin
  try
    Lc_Resultado := 0;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT SUM((ICM_VL_ST)) AS ICM_SUBTOTAL ' +
              'FROM TB_ITENS_ICMS ' +
              'WHERE (ICM_CODNFL=:ICM_CODNFL) AND (ICM_CODITF=:ICM_CODITF)');
      ParamByName('ICM_CODNFL').AsInteger := Pc_cd_Nota;
      ParamByName('ICM_CODITF').AsInteger := Pc_cd_Itens;
      Active := True;
      Lc_Resultado := Lc_Resultado + FieldByName('ICM_SUBTOTAL').AsFloat;

      //Valor do IPI
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT SUM(IPI_VL_IPI) AS IPI_SUBTOTAL ' +
              'FROM TB_ITENS_IPI ' +
              'WHERE (IPI_CODNFL=:IPI_CODNFL) and (IPI_CODITF=:IPI_CODITF)');
      ParamByName('IPI_CODNFL').AsInteger := Pc_cd_Nota;
      ParamByName('IPI_CODITF').AsInteger := Pc_cd_Itens;
      Active := True;
      Lc_Resultado := Lc_Resultado + FieldByName('IPI_SUBTOTAL').AsFloat;
      Result := Lc_Resultado;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


function Fc_Vl_Sub_trib(fc_Cd_Pedido : Integer):Real;
var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT  SUM(ITF_QTDE * ITF_VL_UNIT) AS ITF_VL_TOTAL  '+
                   ' FROM TB_PEDIDO pedido '+
                   '   INNER JOIN TB_ITENS_NFL itens '+
                   '   ON (itens.ITF_CODPED = pedido.PED_CODIGO) '+
                   '   INNER JOIN TB_PRODUTO produto '+
                   '   ON (produto.PRO_CODIGO = itens.ITF_CODPRO) '+
                   'WHERE ITF_CODPED =:ITF_CODPED AND (PRO_SUB_TRIB = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODPED').AsInteger := fc_Cd_Pedido;
      Active := True;
      Result := FieldByName('ITF_VL_TOTAL').AsFloat;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_Vl_Icms(fc_Cd_Pedido : Integer):Real;
var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT  SUM(ITF_QTDE * ITF_VL_UNIT) AS ITF_VL_TOTAL  '+
                   ' FROM TB_PEDIDO pedido '+
                   '   INNER JOIN TB_ITENS_NFL itens '+
                   '   ON (itens.ITF_CODPED = pedido.PED_CODIGO) '+
                   '   INNER JOIN TB_PRODUTO produto '+
                   '   ON (produto.PRO_CODIGO = itens.ITF_CODPRO) '+
                   'WHERE ITF_CODPED =:ITF_CODPED ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODPED').AsInteger := fc_Cd_Pedido;
      Active := True;
      Result := FieldByName('ITF_VL_TOTAL').AsFloat;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


procedure Pc_Limpa_Impostos_Pedidos(Pc_cd_Itens:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
BEgin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_ICMS '+
                   ' WHERE ICM_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do II
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_II '+
                   ' WHERE IIP_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do PIS
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_PIS '+
                   ' WHERE PIS_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do IPI
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_IPI '+
                   ' WHERE IPI_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do COFINS
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_CFS '+
                   ' WHERE CFS_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;
      //Cancela o lancamento do ISSQN
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_ISSQN '+
                   ' WHERE ISS_CODITF =:ITF_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('ITF_CODIGO').AsInteger := Pc_cd_Itens;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_ColocaVirgula(Fc_Valor : string):String;
Var
    Lc_Valor : String;
begin
  Lc_Valor := Fc_Valor;
  case Length(Lc_Valor) of
    0:begin
      Lc_Valor := '0,00';
    end;
    1:begin
      Lc_Valor := '0,0' + Lc_Valor;
    end;
    2:begin
      Lc_Valor := '0,' + Lc_Valor;
    end;
  else
    begin
      Lc_Valor := Copy(Lc_Valor,1,(Length(Lc_Valor)-2)) + ',' + Copy(Lc_Valor,(Length(Lc_Valor)-1),(Length(Lc_Valor)));
    end;
  end;
  Result := Lc_Valor;
end;

procedure Pc_SetTaskBar(Pc_Tela:TForm;Visible: Boolean);
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
begin
  StrPCopy(@wndClass[0],'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  If Visible then
  Begin
    ShowWindow(wndHandle, SW_HIDE);
    with Pc_Tela do
    begin
      Left        := 0;
      Top         := 0;
      Height      := Screen.Height;
      Width       := Screen.Width;
    end;
  end
  else
  Begin
    ShowWindow(wndHandle, SW_RESTORE);
    with Pc_Tela do
    begin
      Left        := 0;
      Top         := 0;
      Height      := Screen.Height -40;
      Width       := Screen.Width;
    end;
  end;
end;




function FC_Pesquisa_Palavra_Texto(fc_Palavra:String;Pc_Texto:TRichEdit):Integer;
var
  Lc_Texto : String;
  Lc_TamanhoSelecao :Integer;
  Lc_pTexto :PChar;
begin
  Result := 0;
  //Pesquisar em texto
  Lc_Texto := UpperCase(Pc_Texto.Text);
  fc_Palavra := UpperCase(fc_Palavra);
  Lc_TamanhoSelecao := Length(Fc_Palavra);
  Lc_pTexto := PChar(Lc_Texto);
  pc_Texto.Lines.BeginUpdate;
  while not (Lc_pTexto = nil)  do
  begin
    Lc_pTexto := AnsiStrPos(Lc_pTexto, pChar(Fc_Palavra));
    pc_Texto.SelStart := Integer(Lc_pTexto) - Integer(Lc_Texto);
    pc_Texto.SelLength := Lc_TamanhoSelecao;
    Inc(Lc_pTexto, Lc_TamanhoSelecao);
    Inc(Result);
  end;
  pc_Texto.Lines.EndUpdate;
  pc_Texto.SelStart := 0;

end;

function Fc_VerificaFormularioDisponivel(Fc_Form:String):boolean;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
BEgin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT IFC_CODIGO '+
                     'FROM TB_INTERFACE '+
                     'WHERE (IFC_FR_NAME = :IFC_FR_NAME) and (IFC_SISTEMA = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('IFC_FR_NAME').AsString := Fc_Form;
      Active := True;
      FetchAll;
      if IsEmpty then
        Result := False
      else
        Result := True;
      end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


procedure Pc_Excluir_Orcamentos;
Var
  Lc_dias : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
Begin
  if (Fc_Tb_Geral('L','ORC_G_CTRL_EXC_ATIVADO','N') = 'S') then
  Begin
    Lc_dias := StrToIntDef(Fc_Tb_Geral('L','ORC_G_CTRL_EXCLUSAO',''),0);
    if (Lc_dias > 0) then
    BEgin
      try
        LcBase := TControllerBase.create(nil);
        Lc_Qry := LcBase.GeraQuery;
        with Lc_Qry do
        Begin
          SQL.Add('DELETE FROM TB_COTACAO WHERE CTC_DATA <:CTC_DATA');
          ParamByName('CTC_DATA').AsString := DateToStr(Date - Lc_dias);
          ExecSQL;
        end;
      finally
        LcBase.FinalizaQuery(Lc_Qry);
        LcBase.DisposeOf;
      end;
    end;
  end;
end;

procedure Pc_AjustaICMSTSTRetido;
Var
  LcCtrl : TControllerCtrlIcmsST;
  LcThread : TThread;
Begin
  LcThread  :=TThread.CreateAnonymousThread(
    procedure
    begin
      Try
        LcCtrl := TControllerCtrlIcmsST.Create(nil);
        LcCtrl.AjustaLegado;
      Finally
        LcCtrl.DisposeOf;
        LcThread.Terminate;
      End;
    end
  );
  LcThread.FreeOnTerminate := True;
  LcThread.start();
End;

procedure Pc_AuditoriaEstoqueDuplicados;
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Del : TSTQuery;
  LcCtrl : TControllerCtrlEstoque;
  LcBase : TControllerBase;
  LcThread : TThread;
Begin
  LcThread  := TThread.CreateAnonymousThread(
    procedure
    begin
    try
      LcBase := TControllerBase.create(nil);
      LcCtrl := TControllerCtrlEstoque.Create(nil);
      Lc_Qry := LcBase.GeraQuery;
      Lc_Qry.sql.Add(concat(
                  ' SELECT CE.cet_item_ctrl, COUNT(CE.cet_item_ctrl) ',
                  ' FROM TB_PRODUTO PR ',
                  '    INNER JOIN tb_ctrl_estoque CE ',
                  '   ON (CE.cet_codpro = PR.pro_codigo) ',
                  '   INNER JOIN TB_ITENS_NFL I ',
                  '   ON (I.itf_codigo = CE.cet_item_ctrl) and (I.itf_codped = CE.cet_controle) ',
                  '   INNER JOIN TB_PEDIDO PE ',
                  '   ON (PE.ped_codigo = I.itf_codped) ',
                  ' WHERE PR.pro_composicao = ''1'' ',
                  ' AND PR.pro_ativo = ''S'' ',
                  ' AND CE.cet_item_ctrl > 0 ',
                  ' AND ce.cet_codets = 1 ',
                  ' AND I.itf_oper= ''V'' ',
                  ' and ce.cet_vinculo = ''P'' ',
                  ' AND PED_DATA >= ''08/01/2018'' ',
                  ' AND PED_TIPO  =1 ',
                  ' GROUP by 1 ',
                  ' having  COUNT(CE.cet_item_ctrl) > 1 '
        ));

      Lc_Qry_Del := LcBase.GeraQuery;
      Lc_Qry_Del.SQL.Add('delete from tb_ctrl_estoque where CET_ITEM_CTRL =:CET_ITEM_CTRL;');

      Lc_Qry.Active := True;
      Lc_Qry.First;
      while not Lc_Qry.eof do
      Begin
        if not Lc_Qry_Del.Transaction.InTransaction then Lc_Qry_Del.Transaction.StartTransaction;
        Lc_Qry_Del.Active := False;
        Lc_Qry_Del.ParamByName('cet_item_ctrl').AsInteger := Lc_Qry.FieldByName('cet_item_ctrl').AsInteger;
        Lc_Qry_Del.ExecSQL;
        if Lc_Qry_Del.Transaction.InTransaction then Lc_Qry_Del.Transaction.Commit;
        Lc_Qry.next;
      End;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.FinalizaQuery(Lc_Qry_Del);
      LcBase.DisposeOf;
      LcThread.Terminate;
    end;
  end
  );
  LcThread.FreeOnTerminate := True;
  LcThread.start();

End;


procedure Pc_VerificaDesativacaoProdutos;
Var
  Lc_Ultima_Data : TDate;
  Lc_dias : Integer;
  LC_DATA_sTR : sTRING;
  Lc_Qry_Des: TSTQuery;
  Lc_SqlTxt: string;
  LcProduto : TControllerProduto;
Begin
  //Se na configuração na aba produto estiver marcado para destivar
  if (Fc_Tb_Geral('L','PRO_DESATIVA','N')='S') then
  Begin
    Pc_Define_FormatoRegional;
    Lc_dias  := StrToIntDef(Fc_Tb_Geral('L','PRO_P_INATIVIDADE','0'),0);
    Lc_Ultima_Data  := StrToDateDef(Fc_Tb_Geral('L','PRO_DATA_DESATIVA',DateToStr(Date-1)),Date-1);
    //Redefnie a ultima data caso ela seja maior que a data atual...problema classico de alteração de data do pc
    if ( Lc_Ultima_Data > Date) then Lc_Ultima_Data := Date - Lc_dias;
    if ( Lc_Ultima_Data < Date) then
    Begin
      try
        LcProduto := TControllerProduto.create(nil);
        LcProduto.Estoque.Registro.Estabelecimento := Gb_CodMha;
        LcProduto.Estoque.getbyMain;
        if LcProduto.Estoque.exist then
        Begin
          //Cria a dos produtos que vão ser desativados
          Lc_Qry_Des := LcProduto.GeraQuery;
          Lc_SqlTxt := 'SELECT DISTINCT PRO_CODIGO '+
                       'FROM tb_produto '+
                       '   INNER JOIN tb_estoque '+
                       '   ON (tb_estoque.est_codpro = tb_produto.pro_codigo) '+
                       'WHERE (PRO_ATIVO = ''S'') '+
                       '  AND (EST_QTDE =0) '+
                       '  and (EST_CODETS =:EST_CODETS) '+
                       '  and (PRO_TIPO <> ''S'') '+
                       '  and (PRO_CODIGO NOT IN ( '+
                       'SELECT DISTINCT ITF_CODPRO '+
                       'FROM tb_itens_nfl '+
                       '   INNER JOIN tb_nota_fiscal '+
                       '   ON (tb_nota_fiscal.nfl_codigo = tb_itens_nfl.itf_codnfl)'+
                       'WHERE (NFL_DT_EMISSAO BETWEEN :DATAINICIAL AND :DATAFINAL) AND (NFL_DT_EMISSAO >= :ULTIMADATA)  )) ';
          Lc_Qry_Des.SQL.Add(Lc_SqlTxt);
          Lc_Qry_Des.ParamByName('EST_CODETS').AsInteger := LcProduto.Estoque.Registro.Codigo;
          //o 7 na conta abaixa vai deslocar o periodo pulando uma semana antes da operação...evita desativar produtos novos não usados na ultima semana
          Lc_Qry_Des.ParamByName('DATAINICIAL').AsDate := (Date - (Lc_dias+7));
          Lc_Qry_Des.ParamByName('DATAFINAL').AsDate := (Date - 7);
          Lc_Qry_Des.ParamByName('ULTIMADATA').AsDate := Lc_Ultima_Data;
          LC_DATA_sTR := DateToStr((Date - Lc_dias));
          Lc_Qry_Des.Active := True;
          Lc_Qry_Des.FetchAll;
          Lc_Qry_Des.First;
          while not Lc_Qry_Des.Eof do
          Begin
            LcProduto.Registro.Codigo := Lc_Qry_Des.FieldByName('PRO_CODIGO').AsInteger;
            LcProduto.Registro.Ativo := 'N';
            LcProduto.Ativa;
            Lc_Qry_Des.Next;
          end;
        end;
        Pc_Define_FormatoRegional;
        Fc_Tb_Geral('G','PRO_DATA_DESATIVA',DateToStr(Date));
      finally
        LcProduto.FinalizaQuery(Lc_Qry_Des);
        LcProduto.DisposeOf;
      end;
    End;
  end;
end;

procedure Pc_Define_FormatoRegional;
begin
  SysUtils.FormatSettings.DecimalSeparator    := ',';
  SysUtils.FormatSettings.ThousandSeparator   := '.';
  SysUtils.FormatSettings.CurrencyDecimals    := 2;
  SysUtils.FormatSettings.DateSeparator       := '/';
  SysUtils.FormatSettings.ShortDateFormat     := 'dd/mm/yyyy';
  SysUtils.FormatSettings.LongDateFormat      := 'dd/mm/yyyy';
  SysUtils.FormatSettings.TimeSeparator       := ':';
  SysUtils.FormatSettings.TimeAMString        := 'AM';
  SysUtils.FormatSettings.TimePMString        := 'PM';
  SysUtils.FormatSettings.ShortTimeFormat     := 'hh:nn';
  SysUtils.FormatSettings.LongTimeFormat      := 'hh:nn:ss';
  SysUtils.FormatSettings.CurrencyString      := 'R$';
end;

procedure Pc_Define_DecimalSeparator(Dec,Thou:Char);
begin
  SysUtils.FormatSettings.DecimalSeparator    := Dec;
  SysUtils.FormatSettings.ThousandSeparator   := Thou;
end;


Function Fc_HistoricoFinanceiro(Fc_Tipo:Integer; Fc_Cd_Empresa:Integer):String;
Var
  Lc_TExto : String;
  Lc_Valor : Real;
Begin
  case Fc_Tipo of
    1:Begin //Cheque Devedor
      Lc_Valor := Fc_SaldoChequeDevolvido(Fc_Cd_Empresa);
      if Lc_Valor > 0 then
        Result :=  ' Cheque(s) Devolvido(s) : ' + FloatToStrF(Lc_Valor,ffFixed, 10, 2)
      else
        Result := ''; 
      end;
    2:Begin //Cheque Pre-Datado
      Lc_Valor := Fc_SaldoChequePreDatado(Fc_Cd_Empresa);
      if Lc_Valor > 0 then
        Result :=  ' Cheque(s) PreDatado(s) : ' + FloatToStrF(Lc_Valor,ffFixed, 10, 2)
      else
        Result := '';
      end;
    3:Begin //Saldo Devedor
      Lc_Valor :=Fc_SaldoDevedorCliente(Fc_Cd_Empresa);
      if Lc_Valor > 0 then
        Result :=   ' Saldo Devedor : ' + FloatToStrF(Lc_Valor,ffFixed, 10, 2)
      else
        Result := '';
      end;
  end;
end;


function Pc_Pintar_Grid_Ordenar(Lc_Grid: TDBGrid; Column: TColumn): boolean;
var
  Lc_IdxOrder :Integer;
  Lc_IdxAsc :Integer;
  Lc_IdxDesc :Integer;
  Lc_Campo : String;
begin
  with Lc_Grid.DataSource.DataSet as TSTQuery do
  begin
    Lc_Campo := Column.FieldName;

    Lc_IdxOrder := Pos('ORDER BY ', UpperCase(SQL.Text));

    if Lc_IdxOrder > 0 then
    begin
      Lc_IdxAsc  := Pos(' ASC ', UpperCase(SQL.Text));
      Lc_IdxDesc := Pos(' DESC ', UpperCase(SQL.Text));

      SQL.Text := Copy(SQL.Text, 1, Lc_IdxOrder -1);
      SQL.Text := SQL.Text +'ORDER BY '+ Lc_Campo;

      if (Lc_IdxAsc = 0) and (Lc_IdxDesc = 0) then
        SQL.Text := SQL.Text +' ASC '
      else
        if (Lc_IdxAsc > 0) and (Lc_IdxDesc = 0) then
          SQL.Text := SQL.Text +' DESC '
        else
        if (Lc_IdxAsc = 0) and (Lc_IdxDesc > 0) then
          SQL.Text := SQL.Text +' ASC '
    end
    else
    Begin
      SQL.Text := SQL.Text +'ORDER BY '+ Lc_Campo + ' ASC ';
    End;
    Close;
    TRY
      Open;
    except
      Close;
    end;
  end;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Color := clBtnFace;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Font.Color := clWindowText;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Font.Style := [];
  Lc_Grid.Tag := Column.Index;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Color := clRed; //$800000;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Font.Color := clWhite;
  Lc_Grid.Columns[Lc_Grid.Tag].Title.Font.Style := [fsBold];
end;

//Verifica se existe um numero de nota - Retorna Verdadeiro se encontrar
function Fc_VerificaNumeroNota(Pc_Tipo:String;Pc_cd_Empresa:Integer; Lc_Num_nota:String): boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_num_int : integer;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if Pc_Tipo = 'P' then
      Begin
        SQL.Clear;
        SQL.Add('select  * '+
                'from tb_retorno_nfe '+
                'where nfe_nota_fim = :nfl_numero '+
                ' and (NFE_CODMHA =:NFE_CODMHA)');
        ParamByName('nfl_numero').AsString := StrZero(StrToFloatDef(Lc_Num_nota,0),6,0);
        ParamByName('NFE_CODMHA').AsInteger := Gb_CodMha;
        Open;
        FetchAll;
        RecordCount;
      end
      else
      Begin
        IF (Fc_Tb_Geral('L','CPA_G_CTRL_NUM_NOTA','') = 'S') then
        Begin
          SQL.Clear;
          SQL.Add('select  * from tb_nota_fiscal '+
                         'where nfl_numero = :nfl_numero'+
                         ' and nfl_codemp =:nfl_codemp '+
                       ' and (nfl_codmha =:nfl_codmha) '+
                       ' and (nfl_tipo =:nfl_tipo)' );

          Lc_num_int := StrToIntDef(Lc_Num_nota,0);
          if Lc_num_int > 0 then
            ParamByName('nfl_numero').AsString := StrZero(Lc_num_int,6,0)
          else
            ParamByName('nfl_numero').AsString := Lc_Num_nota;

          ParamByName('nfl_codemp').AsInteger := Pc_cd_Empresa;
          ParamByName('nfl_codmha').AsInteger := Gb_CodMha;
          ParamByName('nfl_tipo').AsString := 'EE';
          Open;
          FetchAll;
        end
        else
        Begin
          Result := False;
          exit;
        end;
      end;
      if NOT Lc_Qry.IsEmpty then
        Result:= true
      else
        Result:=false;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_DefineEmpresa;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   Lc_Operacao: string;
   LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT EMP_CODIGO ' +
            'FROM  TB_EMPRESA ' +
            'WHERE (EMP_TIPO =''0'') ';

      SQL.Add(Lc_SqlTxt);
      Active := True;
      Gb_CodMha := FieldByname('EMP_CODIGO').AsInteger;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_Deleta_Linha_Grid(Pc_strGrid :TStringGrid ; Pc_Linha:Integer) ;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Linha : Integer;
begin
  Lc_Linha := 0;
  SetLength(Lc_Lista,Pc_strGrid.RowCount - 1,Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados

  for Lc_I := 1 to Pc_strGrid.RowCount-1 do
    Begin
    if Lc_I <> Pc_Linha then
      Begin
      Lc_Linha := Lc_Linha + 1;
      for Lc_J := 1 to Pc_strGrid.ColCount-1 do
        Lc_Lista[Lc_Linha,Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
      end;
    end;

  //Limpa a Matriz antes de incluir a diferenca
  For Lc_I :=1 to Pc_strGrid.RowCount - 1 do
    For Lc_J := 1 to Pc_strGrid.ColCount - 1 do
      Pc_strGrid.Cells[Lc_J, Lc_I] := '';

  Pc_strGrid.RowCount := 2;

  //Grava novamente os dados que não foram marcados e que estão na matriz
  if (Lc_Linha > 0) then
    Begin
    for Lc_I := 1 to Lc_Linha do
      Begin
      Pc_strGrid.RowCount := Lc_I+1;
      for Lc_J := 1 to Pc_strGrid.ColCount-1 do
        Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I,Lc_J];
      end;
    end;
end;

procedure Pc_Deleta_Coluna_Grid(Pc_strGrid :TStringGrid ; Pc_Coluna:Integer) ;
Var
  Lc_I, Lc_J : Integer;
  Lc_Lista : Array of Array of string;
  Lc_Linha : Integer;
  Lc_Coluna : Integer;
begin
  Lc_Linha := Pc_strGrid.RowCount;
  Lc_Coluna := 0;
  SetLength(Lc_Lista,Pc_strGrid.RowCount,Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados

  for Lc_I := 0 to Pc_strGrid.RowCount -1 do
    Begin
    Lc_Coluna := 0;
    for Lc_J := 0 to Pc_strGrid.ColCount -1 do
      if Lc_J <> Pc_Coluna then
        Begin
        Lc_Lista[Lc_I,Lc_Coluna ] := Pc_strGrid.Cells[Lc_J, Lc_I];
        Lc_Coluna := Lc_Coluna + 1;        
        end;
    end;
  //Limpa a Matriz antes de incluir a diferenca
  For Lc_I :=0 to Pc_strGrid.RowCount - 1 do
    For Lc_J := 0 to Pc_strGrid.ColCount - 1 do
      Pc_strGrid.Cells[Lc_J, Lc_I] := '';

  Pc_strGrid.colCount := Pc_strGrid.colCount - 1;

  //Grava novamente os dados que não foram marcados e que estão na matriz
  for Lc_I := 0 to Lc_Linha -1 do
    Begin
    Pc_strGrid.RowCount := Lc_I+1;
    for Lc_J := 0 to Pc_strGrid.ColCount-1 do
      Begin
      if Lc_Lista[Lc_I,Lc_J] <> '' then
        Begin
        Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I,Lc_J];
        end;
      end;
    end;
end;

Function Fc_Valida_Itens_QtdMIn(Pc_cd_Prod, PC_cd_Preco: Integer):Double;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
   LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := ' SELECT  PRC_QT_MIN '+
                  ' FROM TB_TABELA_PRECO '+
                  ' INNER JOIN TB_PRECO  ON (PRC_CODTPR = TPR_CODIGO) '+
                  ' WHERE PRC_CODPRO=:PRO_CODIGO '+
                  ' and TPR_CODIGO =:TPR_CODIGO '+
                  ' AND ( TPR_ATIVA = ''S'') ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PRO_CODIGO').AsInteger := Pc_cd_Prod;
      ParamByName('TPR_CODIGO').AsInteger := PC_cd_Preco;
      Active := true;
      Result:= fieldbyname('PRC_QT_MIN').AsFloat;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_LimitedeCredito(Pc_cd_cli:Integer):Real;
var
  Lc_Qry: TSTQuery;
  LC_emp_STCRED, Lc_SqlTxt: string;
  lc_emp_vlrcred,lc_vl_saldo:Double;
  LcBase : TControllerBase;
Begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_SqlTxt := ' select emp_vl_cred from tb_empresa '+
                 ' where emp_codigo = :emp_codigo  ';
    Lc_Qry.SQL.Add(Lc_SqlTxt);
    Lc_Qry.ParamByName('emp_codigo').AsInteger := Pc_cd_cli;
    Lc_Qry.Active := true;
    Result := Lc_Qry.fieldbyname('emp_vl_cred').AsFloat;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_CreditoLiberado(Pc_cd_cli:Integer):boolean;
var
  Lc_Qry: TSTQuery;
  LC_emp_STCRED,lc_MSG, Lc_SqlTxt: string;
  LcBase : TControllerBase;
Begin
  try
    Result:=false;
    lc_MSG:='';
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := ' select EMP_STCRED from tb_empresa '+
                   ' where emp_codigo = :emp_codigo ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('emp_codigo').AsInteger := Pc_cd_cli;
      Active := true;
      LC_emp_STCRED:= (fieldbyname('EMP_STCRED').AsString);
      if LC_emp_STCRED = 'B' then
      begin
        Result:=false;
        lc_MSG  :='Cliente esta com Status Bloqueado';
        MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                        lc_MSG+EOLN,
                      ['OK'],[bEscape],mpErro);
      end
      else
      Begin
        Result:=True;
      end;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_VerificaBloqueioCliente(Pc_cd_cli:Integer):Boolean;
var
  LC_emp_STCRED,lc_MSG,Lc_SqlTxt: string;
  lc_emp_vlrcred,lc_vl_saldo:Double;
  Lc_Qry : TSTQuery;
  LcResultado : Boolean;
  LcBase : TControllerBase;
Begin
  try
    Result := false;
    lc_MSG:='';
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if not Fc_CreditoLiberado(Pc_cd_cli) then
      begin
        Result := True;
      end;

      if not result then
      Begin
        SQL.Clear;
        if (Fc_Tb_Geral('L','FIN_G_BLOQ_ATRASO','') = 'S') then
        Begin
          Lc_SqlTxt := 'SELECT FIN_VL_PARCELA, FIN_DT_VENCIMENTO '+
                       ' FROM TB_FINANCEIRO tb_financeiro '+
                       ' WHERE (FIN_BAIXA = ''N'') AND (FIN_CODEMP=:emp_codigo) AND '+
                       '((FIN_TIPO = ''RA'') or (FIN_TIPO = ''RM'')) and (FIN_OPERACAO = ''C'') '+
                       ' and FIN_DT_VENCIMENTO  < :FIN_DT_VENCIMENTO ';
          SQL.Clear;
          SQL.Add(Lc_SqlTxt);
          ParamByName('emp_codigo').AsInteger := Pc_cd_cli;
          ParamByName('FIN_DT_VENCIMENTO').AsDate := Now;
          Active:=true;
          FetchAll;
          if (NOT IsEmpty) then    //AQUI POSSUI PENDENCIA EXISTE ATRASO
          begin
            Result:=True;
            lc_MSG:=' Cliente foi Bloqueado pois há Vencimentos em atraso!';
            Pc_ControleBloqueioCliente(Pc_cd_cli,'B');
            MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                            lc_MSG+EOLN,
                          ['OK'],[bEscape],mpErro);
          end;
        end;

        if not Result then        
        Begin
          if (Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'S')then
          Begin
            Lc_SqlTxt := ' select emp_vl_cred, EMP_STCRED from tb_empresa '+
                         ' where emp_codigo = :emp_codigo ';
            SQL.Clear;
            SQL.Add(Lc_SqlTxt);
            ParamByName('emp_codigo').AsInteger := Pc_cd_cli;
            Active := true;
            lc_emp_vlrcred:= (fieldbyname('emp_vl_cred').AsFloat);
            lc_vl_saldo:= Fc_SaldoCLiente(Pc_cd_cli);
            if (lc_vl_saldo>lc_emp_vlrcred) then
            begin
              Result:=True;
              lc_MSG:='O cliente excedeu seu limite em R$:' +FormatFloat('#,##0.00',(lc_vl_saldo - lc_emp_vlrcred )) ;
              MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                             lc_MSG+EOLN,
                             ['OK'],[bEscape],mpErro);
              Pc_ControleBloqueioCliente(Pc_cd_cli,'B');
            end;
          end;
        End;
      End;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_ControleBloqueioCliente(Pc_cd_cli:Integer;Pc_Situacao:String);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' update tb_empresa set '+
                      ' emp_stcred = :emp_stcred  '+
                      ' where emp_codigo = :emp_codigo  ');
      ParamByName('emp_stcred').AsString:= Pc_Situacao;
      ParamByName('emp_codigo').AsInteger:= Pc_cd_cli;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_Verifica_Cadastro_Cliente(Fc_cd_Cliente : Integer):Boolean;
VAR
  lc_qry:TSTQuery;
  lc_msg,lc_txt:String;
  LcBase : TControllerBase;
Begin
  try
    lc_msg:='';
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      lc_txt:= ' select tb_empresa.emp_codvdor,tb_endereco.end_cep from tb_empresa '+
               ' inner join tb_endereco tb_endereco on tb_endereco.end_codemp = tb_empresa.emp_codigo '+
               ' where  tb_empresa.emp_codigo =:emp_codigo ';
      SQL.Add(lc_txt);
      ParamByName('emp_codigo').AsInteger:=Fc_cd_Cliente;
      Active:=true;
      Result:=true;
      if (fieldbyname('emp_codvdor').IsNull) or ((fieldbyname('emp_codvdor').AsInteger)=0) then
      begin
        lc_msg:='Este Cliente não possui Vendedor.';
        Result:=false;
      end
      else
      Begin
        if fieldbyname('end_cep').AsString = '' then
        begin
          lc_msg:='Este Cliente esta sem CEP.';
          Result:=false;
        end;
        if not Result then //nao verdadeiro - cliente incompleto
        Begin
          if (MensagemPadrao('Mensagem de Confirmação',
                             lc_msg+EOLN+
                             'Visualizar o Cadastro agora?',
                             ['Sim','Não'],[bNormal,bEscape],mpConfirmacao,clRed) = mrBotao1) then
          begin
            Fc_AbreTelaCliente(Fc_cd_Cliente);
          end
          else
          Begin
            Result:=true;
          end;
        end;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_SaldoCLiente(Pc_cd_cli:Integer):double;
var
   lc_vlr_devedor,lc_vlr_credor:Real;
Begin
  Result := 0;
  Result := Result + Fc_SaldoDevedorCLiente(Pc_cd_cli);
  Result := Result + Fc_SaldoChequePredatado(Pc_cd_cli);
  Result := Result - Fc_SaldoCredorCliente(Pc_cd_cli);
end;

function Fc_Valida_SaldoExcedido(Fc_Vl_Ped:Double;Pc_cd_cli:Integer):Boolean;
var
  lc_emp_vlrcred,lc_total:Double;
Begin
  Result:=true;
  if (Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'N')then
    Exit;

  lc_total:=   Fc_LimitedeCredito(Pc_cd_cli) - (Fc_SaldoCLiente(Pc_cd_cli) +  Fc_Vl_Ped);
  if lc_total < 0  then
  begin
    Result:=false;
    MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   ' O cliente excedeu o limite em R$:' +FormatFloat('#,##0.00',lc_total * (-1))+EOLN,
                   ['OK'],[bEscape],mpErro);
    exit;
  end;
end;

pROCEDURE Pc_MaoObra_Bordado(pc_operacao:String; Pc_Cd_ICT:Integer);
VAR
  lc_qry:TSTQuery;
  Lc_Cd_Ficha:Integer;
  LC_TXT:String;
  Lc_Subtotal,LC_VL_UNIT,LC_cs_unit,lc_tx_par:Double;
  LcBase : TControllerBase;
begin
  try
    LC_VL_UNIT:=0;
    LC_cs_unit:=0;
    lc_tx_par:=0;
    Lc_Subtotal:=0;
    LcBase := TControllerBase.create(nil);
    lc_qry:= LcBase.GeraQuery;
    LC_TXT:=' select FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,FTC_CODIGO  '+
            ' FROM TB_FICHA_TECNICA TB_FICHA_TECNICA '+
            ' where FTC_CODICT = :FTC_CODICT '+
            ' AND FTC_TIPO = ''B'' ';
    lc_qry.SQL.Add(LC_TXT);
    lc_qry.ParamByName('FTC_CODICT').AsInteger:=Pc_Cd_ICT;
    lc_qry.Open;
    lc_qry.FetchAll;
    if lc_qry.IsEmpty then
      exit;
    lc_qry.First;
    while not lc_qry.Eof do
    begin
      LC_VL_UNIT:=LC_VL_UNIT+lc_qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      LC_cs_unit:=LC_cs_unit+lc_qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      Lc_Subtotal := Lc_Subtotal + (lc_qry.FieldByName('FTC_VL_UNIT').AsFloat * lc_qry.FieldByName('FTC_CS_UNIT').AsFloat );
      lc_qry.Next;
    end;
    Lc_Vl_Unit := (Lc_Subtotal / Lc_Cs_Unit);

    Lc_Cd_Ficha:=lc_qry.fieldbyname('FTC_CODIGO').AsInteger;
    Pc_Fr_FichaTecnica(pc_operacao,
                        Lc_Cd_Ficha,
                        'O',
                        Pc_Cd_ICT,
                         0,
                         0,
                         'BORDADO',
                         'UND',
                          LC_VL_UNIT,
                          LC_cs_unit,
                          lc_tx_par,
                          0);
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

end;

pROCEDURE Pc_MaoObra_Estamparia(pc_operacao:String; Pc_Cd_ICT:Integer);
VAR
  Lc_Qry:TSTQuery;
  LC_TXT:String;
  Lc_Cd_Ficha:Integer;
  Lc_Subtotal,LC_VL_UNIT,LC_cs_unit,lc_tx_par:Double;
  LcBase : TControllerBase;
begin
  try
    LC_VL_UNIT:=0;
    LC_cs_unit:=0;
    Lc_Subtotal:=0;
    LcBase := TControllerBase.create(nil);
    Lc_Qry:= LcBase.GeraQuery;
    LC_TXT:=' select FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,FTC_CODIGO  '+
            ' FROM TB_FICHA_TECNICA TB_FICHA_TECNICA        '+
            ' where                                         '+
            ' FTC_CODICT = :FTC_CODICT                      '+
            ' AND FTC_TIPO = ''E''                          ';
    Lc_Qry.SQL.Add(LC_TXT);
    Lc_Qry.ParamByName('FTC_CODICT').AsInteger:=Pc_Cd_ICT;
    Lc_Qry.Open;
    Lc_Qry.FetchAll;
    if Lc_Qry.IsEmpty then
      exit;
    Lc_Qry.First;
    IF Lc_Qry.IsEmpty THEN
      exit;
    while not Lc_Qry.Eof do
    begin
      LC_VL_UNIT:=LC_VL_UNIT+Lc_Qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      LC_cs_unit:=LC_cs_unit+Lc_Qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      Lc_Subtotal := Lc_Subtotal + (Lc_Qry.FieldByName('FTC_VL_UNIT').AsFloat * Lc_Qry.FieldByName('FTC_CS_UNIT').AsFloat );
      Lc_Qry.Next;
    end;
    Lc_Vl_Unit := (Lc_Subtotal / Lc_Cs_Unit);

    Lc_Cd_Ficha:=Lc_Qry.fieldbyname('FTC_CODIGO').AsInteger;
    Pc_Fr_FichaTecnica(pc_operacao,
                        Lc_Cd_Ficha,
                        'S',
                        Pc_Cd_ICT,
                         0,
                         0,
                         'Estamparia',
                         'UND',
                          LC_VL_UNIT,
                          LC_cs_unit,
                          lc_tx_par
                          ,0);
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

end;

procedure Pc_Exclui_fichaTecnica(Pc_Cd_ICT:Integer);
var
  Lc_Qry:TSTQuery;
  LC_TXT:String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry:= LcBase.GeraQuery;
    LC_TXT :='  delete fROM TB_FICHA_TECNICA '+
             ' where                         '+
             ' FTC_CODICT = :FTC_CODICT      '+
             '         and FTC_CODICT > 0          ';
    Lc_Qry.SQL.Add(LC_TXT);
    Lc_Qry.ParamByName('FTC_CODICT').AsInteger:=Pc_Cd_ICT;
    Lc_Qry.ExecSQL;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

end;

function Fc_CentralizaTexto(Fc_Texto:String; fc_Coluna:Integer;Fc_Extra:String):String;
Var
  Lc_I : Integer;
  Lc_Final : Real;
  Lc_string : String;
Begin
  //Nome da Empresa a ser impresso no cupom
  Lc_string := Fc_Texto;
  Lc_Final := ((fc_coluna -Length(Lc_string))/2) - 2;
  Lc_string := '';
  For Lc_I := 1 to Floor(Lc_Final) do
    Lc_string := Lc_string + Fc_Extra;
  Lc_string := Lc_string + ' ' + Fc_Texto + ' ';
  For Lc_I := 1 to (fc_coluna-Length(Lc_string)) do
      Lc_string := Lc_string + Fc_Extra;
  Result := Lc_string;
end;

Function Fc_RetornaNomeCampo(Fc_NomeTabela:String):String;
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Txt:=' SELECT A.RDB$TRIGGER_NAME FROM RDB$CHECK_CONSTRAINTS A                           '+
              ' INNER JOIN RDB$RELATION_CONSTRAINTS B                                            '+
              ' ON (A.RDB$CONSTRAINT_NAME = B.RDB$CONSTRAINT_NAME)                               '+
              ' WHERE B.RDB$RELATION_NAME = :Nome_tabela AND A.RDB$TRIGGER_NAME LIKE ''%CODIGO%'' ';
      SQL.Add(Lc_TXT);
      ParamByName('Nome_tabela').AsString:= Fc_NomeTabela;
      Active:=True;
      Result:= TRIM(Lc_Qry.FieldByName('RDB$TRIGGER_NAME').asstring);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Procedure Pc_ControlaNumero(Pc_ddb_numero: TEdit_Setes; Pc_TipoPedido:String);
begin
  if (Fc_Tb_Geral('L',Pc_TipoPedido,'S') = 'S') then
    BEGIN
    Pc_ddb_numero.ReadOnly := False;
    Pc_ddb_numero.TabStop := True;
    END
  else
    begin
    Pc_ddb_numero.ReadOnly := True;
    Pc_ddb_numero.TabStop := False;
    end;
end;

function Fc_Qt_ItensNota(): Integer;
begin
  //Numero de Itens
      Result := StrToIntDef(Fc_Tb_Geral('L' ,'GRL_G_NUM_ITEN_NFE',''),0);
end;

function Fc_ValidaNumeroPedido(Fc_CodigoPedido:Integer;Fc_NumeroPedido:integer; FC_TipoPedido:integer):Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
Begin
  try
    //Cria componente para selecionar
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_SqlTxt := ' select PED_NUMERO '+
                 'from TB_PEDIDO '+
                 '  LEFT OUTER JOIN TB_NOTA_FISCAL '+
                 '  ON (NFL_CODPED = PED_CODIGO) '+
                 ' where '+
                 ' PED_NUMERO =:PED_NUMERO '+
                 ' AND PED_CODMHA =:PED_CODMHA '+
                 ' AND ((NFL_STATUS <> ''C'') OR (NFL_STATUS IS NULL)  ) '+
                 ' AND PED_CODIGO <>:PED_CODIGO '+
                 ' AND PED_TIPO = :PED_TIPO ';// 1 -tipo venda 2 - compra - 3 ajuste
    Lc_Qry.SQL.Add(Lc_SqlTxt);
    Lc_Qry.ParamByName('PED_CODIGO').AsInteger:=Fc_CodigoPedido;
    Lc_Qry.ParamByName('PED_NUMERO').AsInteger:=Fc_NumeroPedido;
    Lc_Qry.ParamByName('PED_CODMHA').AsInteger:=Gb_CodMha;
    Lc_Qry.ParamByName('PED_TIPO').AsInteger:=FC_TipoPedido;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    if Lc_Qry.IsEmpty then
    Begin
      Result:= true
    end
    else
    Begin
      Result:=false;
      MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                     'Número do Pedido já foi usado.' + EOLN +
                     'Verifique o Número do Pedido.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    END;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_ValidaNumeroOrcamento(Fc_CodigoOrcamento:Integer;Fc_NumeroOrcamento:integer):Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
Begin
  Try
    //Cria componente para selecionar
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_SqlTxt := ' SELECT * FROM TB_COTACAO        '+
                 ' where                           '+
                 ' CTC_CODIGO<>:CTC_COTACAO        '+
                 ' AND CTC_NUMERO =:CTC_NUMERO     '+
                 ' AND CTC_CODMHA =:CTC_CODMHA     ';
    Lc_Qry.SQL.Add(Lc_SqlTxt);
    Lc_Qry.ParamByName('CTC_COTACAO').AsInteger:=Fc_CodigoOrcamento;
    Lc_Qry.ParamByName('CTC_NUMERO').AsInteger:=Fc_NumeroOrcamento;
    Lc_Qry.ParamByName('CTC_CODMHA').AsInteger:=Gb_CodMha;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    if Lc_Qry.IsEmpty then
      Result:= true
    else
    BEGIN
      Result:=false;
      MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                     'Número do Orçamento já foi usado.' + EOLN +
                     'Verifique o Número do Orçamento.' + EOLN,
                     ['OK'], [bEscape], mpErro);
    END;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_PegaEmail(Fc_Codigo: Integer): string;
var
  Lc_qry: TSTQuery;
  Lc_Sql: string;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Sql := 'SELECT EMP_CODIGO, EMP_EMAIL FROM TB_EMPRESA '+
              'WHERE EMP_CODIGO=:EMP_CODIGO ';
    Lc_Qry.SQL.Add(Lc_Sql);
    Lc_Qry.ParamByName('EMP_CODIGO').AsInteger := Fc_Codigo;
    Lc_Qry.Active := True;
    Result := Lc_qry.FieldByName('EMP_EMAIL').AsString;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_ApagaItensCotacao(Pc_Cd_Item: Integer);
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  try
    //Cria a Consulta
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_SqlTxt := 'DELETE FROM TB_ITENS_CTC WHERE (ICT_CODIGO=:ICT_CODIGO) ';
    Lc_Qry.SQL.Add(Lc_SqlTxt);
    Lc_Qry.ParamByName('ICT_CODIGO').AsInteger := Pc_Cd_Item;
    Lc_Qry.ExecSQL;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

Function Pc_BarraProgresso(Lc_Inicio : string;Pc_Form:Tform; Pc_Parent: TWinControl; Pc_Tamanho : Integer; Pc_Texto:String):TGauge;
Begin
  Result := TGauge.Create(nil);
  Result.Parent :=  Pc_Parent;
  Result.Align := alClient;
  Result.Kind := gkHorizontalBar;
  Result.ShowHint := True;
  Result.Hint := Pc_Texto;
  Result.Visible := True;
  Result.MinValue := 1;
  IF Pc_Tamanho > 0 THEN
  Begin
    Result.MinValue := 1;
    Result.MaxValue := Pc_Tamanho;
  End;
end;



function Pc_NomeCliente(Fc_Codigo: Integer): String;
var
  Lc_SQL: String;
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SQL := 'SELECT EMP_CODIGO, EMP_NOME FROM TB_EMPRESA '+
                'WHERE EMP_CODIGO=:EMP_CODIGO';
      SQL.Add(Lc_SQL);
      ParamByName('EMP_CODIGO').AsInteger := Fc_Codigo;
      Active := True;
      if RecordCount > 0 then
      begin
        Result := FieldByName('EMP_NOME').AsString;
      end
      else
      begin
        ShowMessage('Cliente não encontrado..!!!');
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function Fc_GeraNumeroCotacao(Fc_Data:TDate;Fc_Cd_Cotacao:Integer;Fc_Numero:String): String;
var
  Lc_Qry: TSTQuery;
  Lc_Sql: String;
  Lc_Codigo: Integer;
  Lc_Ano: string;
  Lc_Ano_Numero : String;
  Lc_Alterar : boolean;
  LcBase : TControllerBase;
begin
  Try
    Lc_Alterar := False;
    Lc_Ano := IntToStr(Fc_Year(Fc_Data));
    if Length(Fc_Numero) > 0 then
    Begin
      Lc_Ano_Numero := Copy(Fc_Numero,Length(Fc_Numero)-1,2);
      Lc_Alterar := (Lc_Ano_Numero <> Copy(Lc_Ano,3,2));
    end;

    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Sql := 'SELECT MAX(CTC_NUMERO) '+
                'FROM TB_COTACAO '+
                'WHERE (CTC_DATA>=:CTC_DATA) AND (CTC_TIPO=:CTC_TIPO)';
      SQL.Add(Lc_Sql);
      ParamByName('CTC_DATA').AsString := '01/01/' + Lc_ano;
      ParamByName('CTC_TIPO').AsString := '0';
      Active := True;
      ApplyUpdates;
      //Próximos Números
      Result := Copy(FieldByName('MAX').AsString, 7, 4);
      Lc_Codigo := StrToIntDef(Result, 0) + 1;
      Result := 'ORC - ' + StrZero(Lc_Codigo, 4, 0) + '/' + Copy(Lc_Ano, 3, 2);


      {
      if not Lc_Transacao.InTransaction then Lc_Transacao.StartTransaction;
      Lc_Sql:= ' update tb_cotacao '+
               ' set CTC_NUMERO =:CTC_NUMERO '+
               ' where CTC_CODIGO = :CTC_CODIGO '+
               ' AND CTC_CODMHA = :CTC_CODMHA  ';
      SQL.Clear;
      SQL.Add(Lc_Sql);
      ParamByName('CTC_NUMERO').Value:= Result;
      ParamByName('CTC_CODIGO').AsInteger:= Fc_Cd_Cotacao;
      ParamByName('CTC_CODMHA').AsInteger:= Gb_CodMha;
      ExecSQL;
      if lc_transacao.inTransaction then lc_transacao.Commit;
      }
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_ListarColaborador;
begin
  dm.Qr_Colaborador.Active:=false;
  dm.Qr_Colaborador.SQL.Clear;
  if (Fc_Tb_Geral('L','PES_G_COMPARTILHA','S') = 'S') then
  begin
    dm.Qr_Colaborador.SQL.Add(' SELECT * FROM TB_COLABORADOR   '+
                              ' WHERE (CLB_DEMISSAO IS NULL)   '+
                              ' or (CLB_DEMISSAO = '''')      '+
                              'Order By CLB_NOME               ');
  end
  else
  begin
    dm.Qr_Colaborador.SQL.Add(' SELECT * FROM TB_COLABORADOR   '+
                              ' WHERE (CLB_DEMISSAO IS NULL)   '+
                              '  and clb_codmha = :clb_codmha  '+
                              'Order By CLB_NOME               ');
    DM.Qr_Colaborador.ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
  end;
    dm.Qr_Colaborador.Active:=true;
    dm.Qr_Colaborador.FetchAll;
end;


function Fc_ValidaParcelamento(Fc_Cod_Pedido:Integer;Fc_Vl_pedido:Double):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    Result:=true;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.ADD('SELECT SUM(PAR_VALOR) PAR_VL_TOTAL '+
              'FROM TB_PARCELAMENTO               '+
              'WHERE (PAR_CODPED>0) AND (PAR_CODPED=:PAR_CODPED)');
      PARAMBYNAME('PAR_CODPED').ASINTEGER :=Fc_Cod_Pedido;
      ACTIVE := TRUE;
      FETCHALL;
      if (RecordCount > 0) then
      Begin
        IF (FieldByName('PAR_VL_TOTAL').AsFloat <> Fc_Vl_pedido) AND
           (FieldByName('PAR_VL_TOTAL').AsFloat >0) THEN
        BEGIN
          MensagemPadrao('MENSAGEM DE ERRO','A T E N Ç Ã O!.'+EOLN+EOLN+
                         'O Valor do Pedido não confere com Valor do Parcelamento.'+EOLN+
                         'Refaça o parcelamento.'+EOLN,
                         ['OK'],[BESCAPE],MPERRO);
          Result := FALSE;
        end;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;



function Fc_BuscaCidade(Pc_Cd_Empresa: Integer): String;
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Txt := 'SELECT CDD_DESCRICAO FROM TB_ENDERECO EDD '+
                '   INNER JOIN TB_CIDADE CDD               '+
                '   ON (CDD.CDD_CODIGO = EDD.END_CODCDD)   '+
                'WHERE EDD.END_PRINCIPAL =:TIPO            '+
                '  AND EDD.END_CODEMP =:EMPRESA            ';
      SQL.Add(Lc_Txt);
      ParamByName('TIPO').AsString := 'S';
      ParamByName('EMPRESA').AsInteger := Pc_Cd_Empresa;
      Active := True;

      Result := FieldByName('CDD_DESCRICAO').AsString;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaEstado(Fc_Cd_Empresa: Integer): Integer;
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_Txt := 'SELECT UFE_CODIGO, UFE_SIGLA FROM TB_ENDERECO EDD '+
                '  INNER JOIN TB_UF UFE                            '+
                '  ON (UFE.UFE_CODIGO = EDD.END_CODUFE)            '+
                'WHERE EDD.END_PRINCIPAL =:TIPO                    '+
                '  AND EDD.END_CODEMP =:EMPRESA                    ';
      SQL.Add(Lc_Txt);
      ParamByName('TIPO').AsString := 'S';
      ParamByName('EMPRESA').AsInteger := Fc_Cd_Empresa;
      Active := True;
      Result := FieldByName('UFE_CODIGO').AsInteger;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_Filtra_CFOP(Pc_Sentido: String; Pc_Alcada: String);
var
  Lc_SQLTxt: String;
begin
  with DM.Qr_Filtra_CFOP do
  Begin
    if Transaction.InTransaction then Transaction.Commit;
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('NAT_SENTIDO').AsString := Pc_Sentido;
    ParamByName('NAT_ALCADA').AsString := Pc_Alcada;
    Active := True;
    FetchAll;
  End;
end;

Function Fc_AchaEndereco(Fc_Cod_Pedido: Integer): String;
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Txt := 'SELECT END_CODUFE, UFE_SIGLA '+
              'FROM TB_PEDIDO tb_pedido '+
              '   INNER JOIN TB_ENDERECO tb_endereco   '+
              '   ON (tb_endereco.END_CODEMP = tb_pedido.PED_CODEMP) '+
              '   INNER JOIN TB_UF tb_uf  '+
              '   ON (tb_endereco.END_CODUFE = tb_uf.UFE_CODIGO)     '+

              'WHERE (PED_CODIGO=:PED_CODIGO ) AND END_PRINCIPAL = ''S'' ';

    Lc_Qry.SQL.Add(Lc_Txt);
    Lc_Qry.ParamByName('PED_CODIGO').AsInteger := Fc_Cod_Pedido;
    Lc_Qry.Active := True;
    Lc_Qry.FetchAll;

    if Lc_Qry.FieldByName('UFE_SIGLA').AsString = 'EX' then
      Result := 'X'
    else
      if (Lc_Qry.FieldByName('END_CODUFE').AsInteger = Fc_Estado(Gb_CodMha,'S')) then
        Result := 'E'
      else
        Result := 'N';
  finally
    LcBase.FinalizaQuery(Lc_Qry);;
    LcBase.DisposeOf;
  end;
end;

function Fc_Estado(Fc_CodEmp: Integer; Fc_Tipo: String): Integer;
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'SELECT END_CODUFE '+
                   'FROM TB_ENDERECO '+
                   'WHERE (END_CODEMP=:EMP_CODIGO) AND (END_PRINCIPAL =:END_PRINCIPAL) ';

      SQL.Add(Lc_SqlTxt);
      ParamByName('EMP_CODIGO').AsInteger := Fc_CODEMP;
      ParamByName('END_PRINCIPAL').AsString := Fc_TIPO;
      Active := True;
      FetchAll;
      RecordCount;

      Result := FieldByName('END_CODUFE').AsInteger;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_Insere_Arq_Banco(Pc_Path : String;
                              Pc_File: String;
                              Pc_Tipo: Integer;
                              Pc_Formato: String;
                              Pc_Cd_Vinculo: Integer);
var
  Lc_Qry: TSTQuery;
  Lc_SQL: String;
  LcBase : TControllerBase;
BEGIN
  {
   1 - Arquivo de XML da Nota Fiscal Eletronica Própria
   2 - Arquivo de XML da Carta de Correção
   3 - Arquivo de XML da Nota Fiscal Eletrônica de Terceiros
   4 - Arquivo de XML da Nota Fiscal Consumidor Eletronica
   5 - Arquivo de XML do Recibo Provisorio de Serviço
   6 - Arquivo de XML da Nota Fiscal de Serviço eletronica
   7 - Arquivo de XML da MDFE
  }
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      //consulta se o arquivo existe
      Lc_SQL := 'UPDATE OR INSERT INTO TB_ARQUIVOS (ARQ_TIPO, ARQ_FORMATO, ARQ_CODVCL, ARQ_CONTEUDO) '+
                '             VALUES (:ARQ_TIPO, :ARQ_FORMATO, :ARQ_CODVCL, :ARQ_CONTEUDO) '+
                '           MATCHING (ARQ_TIPO, ARQ_FORMATO, ARQ_CODVCL )';
      SQL.add(Lc_Sql);
      Try
        if FileExists(Pc_Path + '\' + Pc_File) then
        begin
          ParamByName('ARQ_TIPO').AsInteger := Pc_Tipo;
          ParamByName('ARQ_FORMATO').AsString := Pc_Formato;
          ParamByName('ARQ_CODVCL').AsInteger := Pc_Cd_Vinculo;
          ParamByName('ARQ_CONTEUDO').LoadFromFile(Pc_Path + '\' + Pc_File,ftBlob);
          EXECSQL;
        end;
      Except
        on E:Exception do
          begin
          ShowMessage(E.Message);
          end;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_Salva_Arq_Disco(Pc_Tipo: Integer;
                                 Pc_Formato: String;
                                 Pc_Cd_Vinculo: Integer;
                                 Pc_Arq_Caminho: String);
var
  Lc_Qry: TSTQuery;
  Lc_SQL: String;
  LcBase : TControllerBase;
BEGIN
  {
   1 - Arquivo de XML da Nota Fiscal Eletronica Própria
   2 - Arquivo de XML da Carta de Correção
   3 - Arquivo de XML da Nota Fiscal Eletrônica de Terceiros
   4 - Arquivo de XML da Nota Fiscal Consumidor Eletronica
   5 - Arquivo de XML do Recibo Provisorio de Serviço
   6 - Arquivo de XML da Nota Fiscal de Serviço eletronica
   7 - Arquivo de XML da MFDE
  }
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SQL := 'SELECT  '+
                '       ARQ_TIPO, '+
                '       ARQ_FORMATO, '+
                '       ARQ_CODVCL, '+
                '       ARQ_CONTEUDO '+
                'FROM TB_ARQUIVOS '+
                'WHERE (ARQ_TIPO=:ARQ_TIPO) '+
                '  AND (ARQ_FORMATO=:ARQ_FORMATO)'+
                '  AND ((ARQ_CODVCL=:ARQ_CODVCL) '+
                '   OR (ARQ_CODVCL IS NULL)) ';
      SQL.Add(Lc_SQL);
      ParamByName('ARQ_TIPO').AsInteger := Pc_Tipo;
      ParamByName('ARQ_FORMATO').AsString := Pc_Formato;
      ParamByName('ARQ_CODVCL').AsInteger := Pc_Cd_Vinculo;
      Active := True;
      if RecordCount >0 then
      Begin
        Try
          (FieldByName('ARQ_CONTEUDO') as TBlobField).SaveToFile( Pc_Arq_Caminho);
        Except
          on E:Exception do
            begin
            ShowMessage(E.Message);
            end;
        end;
      end;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

function Fc_VerificaCepEmpresa(fc_Cep,Fc_CNPJCPF: string):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select END_CODIGO '+
                 'from tb_endereco    '+
                 '  INNER JOIN TB_EMPRESA '+
                 '  ON (EMP_CODIGO = END_CODEMP) '+
                 'WHERE ((END_CEP = :END_CEP) and (EMP_CNPJ =:EMP_CNPJ)) OR ' +
                 '      ((END_CEP = :END_CEP) and (END_CNPJ =:EMP_CNPJ)) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('EMP_CNPJ').AsString:= Fc_CNPJCPF;
      ParamByName('END_CEP').AsString:= fc_Cep;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
        Result:= FieldByName('END_CODIGO').AsInteger
      else
        Result:= 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function Fc_HabilitaPermissao(Fc_Menu, Fc_Tipo, Fc_Situacao: String): Boolean;
var
  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  Result := true;
  if (Gb_Nivel = 0) then
  Begin
    try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        //Verifica se é adminsitrador
        Lc_SqlTxt := 'SELECT DISTINCT                            '+
                     '   OPF.OPF_CODIGO,                         '+
                     '   OPF.OPF_DESCRICAO                       '+
                     'FROM TB_INTERFACE IFC                      '+
                     '   INNER JOIN TB_ITENS_IFC IIF             '+
                     '   ON (IIF.IIF_CODIFC = IFC.IFC_CODIGO)    '+
                     '   INNER JOIN TB_PERMISSAO PER             '+
                     '   ON (PER.PER_CODIIF = IIF.IIF_CODIGO)    '+
                     '   INNER JOIN TB_OPER_INTERFACE OPF        '+
                     '   ON (OPF.OPF_CODIGO = IIF.IIF_CODOPF)    '+
                     'WHERE (IFC_SISTEMA = ''S'')                '+
                     ' AND (PER.PER_CODUSU=:PER_CODUSU)          '+
                     ' AND OPF.OPF_DESCRICAO=:OPF_DESCRICAO      ';
        if Fc_Situacao = 'S' then Lc_SqlTxt := Lc_SqlTxt + '  AND ( (IFC.IFC_DESCRICAO=:IFC_DESCRICAO) OR (IFC.IFC_FR_NAME=:IFC_DESCRICAO) ) ';
        SQL.Add(Lc_SqlTxt);
        ParamByName('PER_CODUSU').AsInteger := Gb_Cd_Usuario;
        if Fc_Situacao = 'S' then ParamByName('IFC_DESCRICAO').AsString := Fc_Menu;
        ParamByName('OPF_DESCRICAO').AsString := Fc_Tipo;

        Active := True;
        FetchAll;
        if RecordCount > 0 then Result := True else Result := False;
      End;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  End;
end;



PROCEDURE Pc_Copia_ProdServico(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add(' insert into tb_prod_serv                 ');
    lc_qry_insere.SQL.Add(' (psi_codigo, psi_codpro, psi_codsrv)     ');
    lc_qry_insere.SQL.Add(' values                                   ');
    lc_qry_insere.SQL.Add(' (:psi_codigo, :psi_codpro, :psi_codsrv)  ');


    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add('  SELECT psi_codsrv FROM tb_prod_serv  ');
    Lc_Qry.SQL.Add(' WHERE                                 ');
    Lc_Qry.SQL.Add(' psi_codpro= :psi_codpro               ');
    Lc_Qry.ParamByName('psi_codpro').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;
      lc_qry_insere.active := False;
      lc_qry_insere.ParamByName('psi_codigo').AsInteger:=Fc_Generator('GN_PROD_SERV','TB_PROD_SERV','PSI_CODIGO');
      lc_qry_insere.ParamByName('psi_codpro').AsInteger:=Pc_cd_Prod_novo;
      lc_qry_insere.ParamByName('psi_codsrv').AsInteger:= Lc_Qry.fieldbyname('psi_codsrv').AsInteger;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  finally
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

END;

PROCEDURE Pc_Copia_ProdComposicao(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add(' insert into tb_prod_prod                                 ');
    lc_qry_insere.SQL.Add(' (ppd_codpro_m, ppd_codpro_d ,ppd_qtde)       ');
    lc_qry_insere.SQL.Add(' values                                                   ');
    lc_qry_insere.SQL.Add(' (:ppd_codpro_m, :ppd_codpro_d , :ppd_qtde)  ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT PRO_CODIGOFAB, PRO_DESCRICAO, PRO_VL_CUSTO, PPD_QTDE, PPD_CODPRO_D,  ');
    Lc_Qry.SQL.Add('(PPD_QTDE * PRO_VL_CUSTO) PPD_VL_TOTAL                                                   ');
    Lc_Qry.SQL.Add('FROM TB_PRODUTO tb_produto                                                               ');
    Lc_Qry.SQL.Add('  INNER JOIN TB_PROD_PROD tb_prod_prod                                                   ');
    Lc_Qry.SQL.Add('  ON (tb_prod_prod.PPD_CODPRO_D = tb_produto.PRO_CODIGO)                                 ');
    Lc_Qry.SQL.Add('WHERE PPD_CODPRO_M=:PRO_CODIGO                                                           ');
    Lc_Qry.ParamByName('PRO_CODIGO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      lc_qry_insere.Active := False;
      lc_qry_insere.ParamByName('ppd_codpro_m').AsInteger:=Pc_cd_Prod_novo;
      lc_qry_insere.ParamByName('ppd_codpro_d').AsInteger:= Lc_Qry.fieldbyname('PPD_CODPRO_D').AsInteger;
      lc_qry_insere.ParamByName('ppd_qtde').AsFloat:= Lc_Qry.fieldbyname('ppd_qtde').AsFloat;
      lc_qry_insere.ExecSQL;
      Lc_Qry.Next;
    end;
  finally
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


PROCEDURE Pc_Copia_ProdAVIAMENTO(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add('  insert into tb_ficha_tecnica                                         ');
    lc_qry_insere.SQL.Add('( FTC_CODIGO, FTC_CODICT,FTC_CODITF, FTC_TIPO,FTC_CODVCL,              ');
    lc_qry_insere.SQL.Add('  FTC_DESC_INSUMO,FTC_UND,FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,       ');
    lc_qry_insere.SQL.Add('  FTC_CODPRO)                                                          ');
    lc_qry_insere.SQL.Add('  values                                                               ');
    lc_qry_insere.SQL.Add('( :FTC_CODIGO, :FTC_CODICT,:FTC_CODITF, :FTC_TIPO,:FTC_CODVCL,         ');
    lc_qry_insere.SQL.Add('  :FTC_DESC_INSUMO,:FTC_UND,:FTC_VL_UNIT,:FTC_CS_UNIT,:FTC_TX_PARTIC,  ');
    lc_qry_insere.SQL.Add('  :FTC_CODPRO)                                                         ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT FTC_CODIGO, FTC_CODICT, FTC_CODITF, FTC_TIPO, FTC_CODVCL,       ');
    Lc_Qry.SQL.Add(' PRO_DESCRICAO, FTC_UND, PRO_VL_CUSTOMED,FTC_CS_UNIT,FTC_DESC_INSUMO,   ');
    Lc_Qry.SQL.Add(' FTC_VL_UNIT,FTC_TX_PARTIC,                                             ');
    Lc_Qry.SQL.Add(' (FTC_CS_UNIT * PRO_VL_CUSTOMED) FTC_VL_TOTAL                           ');
    Lc_Qry.SQL.Add(' FROM TB_FICHA_TECNICA tb_ficha_tecnica                                 ');
    Lc_Qry.SQL.Add('   INNER JOIN TB_PRODUTO tb_produto                                     ');
    Lc_Qry.SQL.Add('   ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)             ');
    Lc_Qry.SQL.Add(' where (FTC_CODPRO=:PRO_CODIGO)   AND (FTC_TIPO = ''A'')                ');
    Lc_Qry.ParamByName('PRO_CODIGO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;
      lc_qry_insere.Active := False;
      lc_qry_insere.ParamByName('FTC_CODIGO').AsInteger:=Fc_Generator('GN_FICHA_TECNICA','TB_FICHA_TECNICA','FTC_CODIGO');
      lc_qry_insere.ParamByName('FTC_CODICT').AsInteger:=Lc_Qry.fieldbyname('FTC_CODICT').AsInteger;
      lc_qry_insere.ParamByName('FTC_CODITF').AsInteger:=Lc_Qry.fieldbyname('FTC_CODITF').AsInteger;
      lc_qry_insere.ParamByName('FTC_TIPO').AsString:='A';
      lc_qry_insere.ParamByName('FTC_CODVCL').AsInteger:=Lc_Qry.fieldbyname('FTC_CODVCL').AsInteger;
      lc_qry_insere.ParamByName('FTC_DESC_INSUMO').AsString:=Lc_Qry.fieldbyname('FTC_DESC_INSUMO').AsString;
      lc_qry_insere.ParamByName('FTC_UND').AsString:=Lc_Qry.fieldbyname('FTC_UND').AsString;
      lc_qry_insere.ParamByName('FTC_VL_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_CS_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_TX_PARTIC').AsFloat:= Lc_Qry.fieldbyname('FTC_TX_PARTIC').AsFloat;
      lc_qry_insere.ParamByName('FTC_CODPRO').AsInteger:= Pc_cd_Prod_novo;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.DisposeOf;
  end;
end;


PROCEDURE Pc_Copia_ProdMaoObra(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add('  insert into tb_ficha_tecnica                                         ');
    lc_qry_insere.SQL.Add('( FTC_CODIGO, FTC_CODICT,FTC_CODITF, FTC_TIPO,FTC_CODVCL,              ');
    lc_qry_insere.SQL.Add('  FTC_DESC_INSUMO,FTC_UND,FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,       ');
    lc_qry_insere.SQL.Add('  FTC_CODPRO)                                                          ');
    lc_qry_insere.SQL.Add('  values                                                               ');
    lc_qry_insere.SQL.Add('( :FTC_CODIGO, :FTC_CODICT,:FTC_CODITF, :FTC_TIPO,:FTC_CODVCL,         ');
    lc_qry_insere.SQL.Add('  :FTC_DESC_INSUMO,:FTC_UND,:FTC_VL_UNIT,:FTC_CS_UNIT,:FTC_TX_PARTIC,  ');
    lc_qry_insere.SQL.Add('  :FTC_CODPRO)                                                         ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT FTC_CODIGO, FTC_CODICT, FTC_CODITF, FTC_TIPO, FTC_CODVCL,       ');
    Lc_Qry.SQL.Add(' PRO_DESCRICAO, FTC_UND, PRO_VL_CUSTOMED,FTC_CS_UNIT,FTC_DESC_INSUMO,   ');
    Lc_Qry.SQL.Add(' FTC_VL_UNIT,FTC_TX_PARTIC,                                             ');
    Lc_Qry.SQL.Add(' (FTC_CS_UNIT * PRO_VL_CUSTOMED) FTC_VL_TOTAL                           ');
    Lc_Qry.SQL.Add(' FROM TB_FICHA_TECNICA tb_ficha_tecnica                                 ');
    Lc_Qry.SQL.Add('   INNER JOIN TB_PRODUTO tb_produto                                     ');
    Lc_Qry.SQL.Add('   ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)             ');
    Lc_Qry.SQL.Add(' where (FTC_CODPRO=:PRO_CODIGO)   AND (FTC_TIPO = ''M'')                ');
    Lc_Qry.ParamByName('PRO_CODIGO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;
      lc_qry_insere.Active := False;
      lc_qry_insere.ParamByName('FTC_CODIGO').AsInteger:=Fc_Generator('GN_FICHA_TECNICA','TB_FICHA_TECNICA','FTC_CODIGO');
      lc_qry_insere.ParamByName('FTC_CODICT').AsInteger:=Lc_Qry.fieldbyname('FTC_CODICT').AsInteger;
      lc_qry_insere.ParamByName('FTC_CODITF').AsInteger:=Lc_Qry.fieldbyname('FTC_CODITF').AsInteger;
      lc_qry_insere.ParamByName('FTC_TIPO').AsString:='M';
      lc_qry_insere.ParamByName('FTC_CODVCL').AsInteger:=Lc_Qry.fieldbyname('FTC_CODVCL').AsInteger;
      lc_qry_insere.ParamByName('FTC_DESC_INSUMO').AsString:=Lc_Qry.fieldbyname('FTC_DESC_INSUMO').AsString;
      lc_qry_insere.ParamByName('FTC_UND').AsString:=Lc_Qry.fieldbyname('FTC_UND').AsString;
      lc_qry_insere.ParamByName('FTC_VL_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_CS_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_TX_PARTIC').AsFloat:= Lc_Qry.fieldbyname('FTC_TX_PARTIC').AsFloat;
      lc_qry_insere.ParamByName('FTC_CODPRO').AsInteger:= Pc_cd_Prod_novo;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.DisposeOf;
  End;
end;


PROCEDURE Pc_Copia_ProdbORDADO(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add('  insert into tb_ficha_tecnica                                         ');
    lc_qry_insere.SQL.Add('( FTC_CODIGO, FTC_CODICT,FTC_CODITF, FTC_TIPO,FTC_CODVCL,              ');
    lc_qry_insere.SQL.Add('  FTC_DESC_INSUMO,FTC_UND,FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,       ');
    lc_qry_insere.SQL.Add('  FTC_CODPRO)                                                          ');
    lc_qry_insere.SQL.Add('  values                                                               ');
    lc_qry_insere.SQL.Add('( :FTC_CODIGO, :FTC_CODICT,:FTC_CODITF, :FTC_TIPO,:FTC_CODVCL,         ');
    lc_qry_insere.SQL.Add('  :FTC_DESC_INSUMO,:FTC_UND,:FTC_VL_UNIT,:FTC_CS_UNIT,:FTC_TX_PARTIC,  ');
    lc_qry_insere.SQL.Add('  :FTC_CODPRO)                                                         ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT FTC_CODIGO, FTC_CODICT, FTC_CODITF, FTC_TIPO, FTC_CODVCL,       ');
    Lc_Qry.SQL.Add(' PRO_DESCRICAO, FTC_UND, PRO_VL_CUSTOMED,FTC_CS_UNIT,FTC_DESC_INSUMO,   ');
    Lc_Qry.SQL.Add(' FTC_VL_UNIT,FTC_TX_PARTIC,                                             ');
    Lc_Qry.SQL.Add(' (FTC_CS_UNIT * PRO_VL_CUSTOMED) FTC_VL_TOTAL                           ');
    Lc_Qry.SQL.Add(' FROM TB_FICHA_TECNICA tb_ficha_tecnica                                 ');
    Lc_Qry.SQL.Add('   INNER JOIN TB_PRODUTO tb_produto                                     ');
    Lc_Qry.SQL.Add('   ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)             ');
    Lc_Qry.SQL.Add(' where (FTC_CODPRO=:PRO_CODIGO)   AND (FTC_TIPO = ''B'')                ');
    Lc_Qry.ParamByName('PRO_CODIGO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;
      lc_qry_insere.Active := False;
      lc_qry_insere.ParamByName('FTC_CODIGO').AsInteger:=Fc_Generator('GN_FICHA_TECNICA','TB_FICHA_TECNICA','FTC_CODIGO');
      lc_qry_insere.ParamByName('FTC_CODICT').AsInteger:=Lc_Qry.fieldbyname('FTC_CODICT').AsInteger;
      lc_qry_insere.ParamByName('FTC_CODITF').AsInteger:=Lc_Qry.fieldbyname('FTC_CODITF').AsInteger;
      lc_qry_insere.ParamByName('FTC_TIPO').AsString:='B';
      lc_qry_insere.ParamByName('FTC_CODVCL').AsInteger:=Lc_Qry.fieldbyname('FTC_CODVCL').AsInteger;
      lc_qry_insere.ParamByName('FTC_DESC_INSUMO').AsString:=Lc_Qry.fieldbyname('FTC_DESC_INSUMO').AsString;
      lc_qry_insere.ParamByName('FTC_UND').AsString:=Lc_Qry.fieldbyname('FTC_UND').AsString;
      lc_qry_insere.ParamByName('FTC_VL_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_CS_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_TX_PARTIC').AsFloat:= Lc_Qry.fieldbyname('FTC_TX_PARTIC').AsFloat;
      lc_qry_insere.ParamByName('FTC_CODPRO').AsInteger:= Pc_cd_Prod_novo;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.DisposeOf;
  end;
end;


PROCEDURE Pc_Copia_ProdEstampa(Pc_cd_Prod_novo:Integer;Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;
    lc_qry_insere.SQL.Add('  insert into tb_ficha_tecnica                                         ');
    lc_qry_insere.SQL.Add('( FTC_CODIGO, FTC_CODICT,FTC_CODITF, FTC_TIPO,FTC_CODVCL,              ');
    lc_qry_insere.SQL.Add('  FTC_DESC_INSUMO,FTC_UND,FTC_VL_UNIT,FTC_CS_UNIT,FTC_TX_PARTIC,       ');
    lc_qry_insere.SQL.Add('  FTC_CODPRO)                                                          ');
    lc_qry_insere.SQL.Add('  values                                                               ');
    lc_qry_insere.SQL.Add('( :FTC_CODIGO, :FTC_CODICT,:FTC_CODITF, :FTC_TIPO,:FTC_CODVCL,         ');
    lc_qry_insere.SQL.Add('  :FTC_DESC_INSUMO,:FTC_UND,:FTC_VL_UNIT,:FTC_CS_UNIT,:FTC_TX_PARTIC,  ');
    lc_qry_insere.SQL.Add('  :FTC_CODPRO)                                                         ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT FTC_CODIGO, FTC_CODICT, FTC_CODITF, FTC_TIPO, FTC_CODVCL,       ');
    Lc_Qry.SQL.Add(' PRO_DESCRICAO, FTC_UND, PRO_VL_CUSTOMED,FTC_CS_UNIT,FTC_DESC_INSUMO,   ');
    Lc_Qry.SQL.Add(' FTC_VL_UNIT,FTC_TX_PARTIC,                                             ');
    Lc_Qry.SQL.Add(' (FTC_CS_UNIT * PRO_VL_CUSTOMED) FTC_VL_TOTAL                           ');
    Lc_Qry.SQL.Add(' FROM TB_FICHA_TECNICA tb_ficha_tecnica                                 ');
    Lc_Qry.SQL.Add('   INNER JOIN TB_PRODUTO tb_produto                                     ');
    Lc_Qry.SQL.Add('   ON (tb_produto.PRO_CODIGO = tb_ficha_tecnica.FTC_CODVCL)             ');
    Lc_Qry.SQL.Add(' where (FTC_CODPRO=:PRO_CODIGO)   AND (FTC_TIPO = ''E'')                ');
    Lc_Qry.ParamByName('PRO_CODIGO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;
      lc_qry_insere.Active := False;
      lc_qry_insere.ParamByName('FTC_CODIGO').AsInteger:=Fc_Generator('GN_FICHA_TECNICA','TB_FICHA_TECNICA','FTC_CODIGO');
      lc_qry_insere.ParamByName('FTC_CODICT').AsInteger:=Lc_Qry.fieldbyname('FTC_CODICT').AsInteger;
      lc_qry_insere.ParamByName('FTC_CODITF').AsInteger:=Lc_Qry.fieldbyname('FTC_CODITF').AsInteger;
      lc_qry_insere.ParamByName('FTC_TIPO').AsString:='E';
      lc_qry_insere.ParamByName('FTC_CODVCL').AsInteger:=Lc_Qry.fieldbyname('FTC_CODVCL').AsInteger;
      lc_qry_insere.ParamByName('FTC_DESC_INSUMO').AsString:=Lc_Qry.fieldbyname('FTC_DESC_INSUMO').AsString;
      lc_qry_insere.ParamByName('FTC_UND').AsString:=Lc_Qry.fieldbyname('FTC_UND').AsString;
      lc_qry_insere.ParamByName('FTC_VL_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_VL_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_CS_UNIT').AsFloat:= Lc_Qry.fieldbyname('FTC_CS_UNIT').AsFloat;
      lc_qry_insere.ParamByName('FTC_TX_PARTIC').AsFloat:= Lc_Qry.fieldbyname('FTC_TX_PARTIC').AsFloat;
      lc_qry_insere.ParamByName('FTC_CODPRO').AsInteger:= Pc_cd_Prod_novo;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.DisposeOf;
  End;
end;


PROCEDURE Pc_Copia_Prod_TbPreco(Pc_cd_Prod_novo,Pc_cd_Prod_Ant:Integer);
var
  lc_qry_insere,  Lc_Qry: TSTQuery;
  Lc_SqlTxt: string;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;

    lc_qry_insere := LcBase.GeraQuery;

    lc_qry_insere.Active := False;
    lc_qry_insere.SQL.Clear;

    lc_qry_insere.SQL.Add(' insert into tb_preco                                           ');
    lc_qry_insere.SQL.Add('(prc_codigo,prc_codtpr, prc_codpro,prc_vl_vda,prc_aq_com,       ');
    lc_qry_insere.SQL.Add('  prc_qt_min,prc_mar_lrc)                                       ');
    lc_qry_insere.SQL.Add(' values                                                         ');
    lc_qry_insere.SQL.Add('(:prc_codigo,:prc_codtpr, :prc_codpro,:prc_vl_vda,:prc_aq_com,  ');
    lc_qry_insere.SQL.Add('  :prc_qt_min,:prc_mar_lrc)                                     ');

    Lc_Qry.Active := False;
    Lc_Qry.SQL.Clear;
    Lc_Qry.SQL.Add(' SELECT PRC_CODTPR ,PRC_VL_VDA , PRC_AQ_COM,PRC_QT_MIN, PRC_MAR_LRC ');
    Lc_Qry.SQL.Add('FROM TB_PRECO                                                       ');
    Lc_Qry.SQL.Add('WHERE                                                               ');
    Lc_Qry.SQL.Add('PRC_CODPRO =:PRC_CODPRO                                             ');
    Lc_Qry.ParamByName('PRC_CODPRO').AsInteger:=Pc_cd_Prod_Ant;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    Lc_Qry.First;
    while not Lc_Qry.Eof do
    begin
      if not lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.StartTransaction;

      lc_qry_insere.ParamByName('prc_codigo').AsInteger:=Fc_Generator('GN_PRECO','TB_PRECO','PRC_CODIGO');
      lc_qry_insere.ParamByName('prc_codtpr').AsInteger:=Lc_Qry.fieldbyname('PRC_CODTPR').AsInteger;
      lc_qry_insere.ParamByName('prc_codpro').AsInteger:=Pc_cd_Prod_novo;
      lc_qry_insere.ParamByName('prc_vl_vda').AsFloat:= Lc_Qry.fieldbyname('prc_vl_vda').AsFloat;
      lc_qry_insere.ParamByName('prc_aq_com').AsFloat:= Lc_Qry.fieldbyname('prc_aq_com').AsFloat;
      lc_qry_insere.ParamByName('prc_qt_min').AsFloat:= Lc_Qry.fieldbyname('prc_qt_min').AsFloat;
      lc_qry_insere.ParamByName('prc_mar_lrc').AsFloat:= Lc_Qry.fieldbyname('prc_mar_lrc').AsFloat;
      lc_qry_insere.ExecSQL;
      if lc_qry_insere.Transaction.InTransaction then lc_qry_insere.Transaction.Commit;
      Lc_Qry.Next;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(lc_qry_insere);
    LcBase.DisposeOf;
  end;
end;


PROCEDURE Pc_Apaga_Produto(Pc_cd_Produto:Integer);
var
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('DELETE FROM TB_PRODUTO '+
              'WHERE PRO_CODIGO =:PRO_CODIGO    ');
      ParamByName('PRO_CODIGO').AsInteger:= Pc_cd_Produto;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_CodLote(
   Pc_Operacao: string;
   pc_LOT_CODIGO:integer;
   PC_LOT_DATA:TDate;
   PC_LOT_NUMERO:STRING;
   Pc_LOT_CODITF:INTEGER;
   PC_LOT_DT_VENCIMENTO:tDATE;
   PC_LOT_QTD_E:Double;
   PC_LOT_QTD_S:Double);
var
  Lc_Qry: TSTQuery;
  Lc_Txt: String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    if Pc_Operacao = 'I' then
    begin
      Lc_Txt:= ' insert into  tb_lote (LOT_CODIGO,LOT_DATA,LOT_NUMERO, LOT_CODITF,LOT_DT_VENCIMENTO,LOT_QTD_E,LOT_QTD_S) '+
               ' values(:LOT_CODIGO,:LOT_DATA,:LOT_NUMERO, :LOT_CODITF,:LOT_DT_VENCIMENTO,:LOT_QTD_E,:LOT_QTD_S)         ';
      Lc_Qry.SQL.Add(Lc_Txt);
      Lc_Qry.ParamByName('LOT_CODIGO').AsInteger := Fc_Generator('GN_LOTE','TB_LOTE','LOT_CODIGO');
      Lc_Qry.ParamByName('LOT_DATA').AsDate:=PC_LOT_DATA;
      Lc_Qry.ParamByName('LOT_NUMERO').AsString:= PC_LOT_NUMERO;
      Lc_Qry.ParamByName('LOT_CODITF').AsInteger:=Pc_LOT_CODITF;
      Lc_Qry.ParamByName('LOT_DT_VENCIMENTO').AsDate:=PC_LOT_DT_VENCIMENTO;
      Lc_Qry.ParamByName('LOT_QTD_E').AsFloat:=PC_LOT_QTD_E;
      Lc_Qry.ParamByName('LOT_QTD_S').AsFloat:=PC_LOT_QTD_S;
    end
    else
    if Pc_Operacao = 'A' then
    begin
      Lc_Txt:= ' update tb_lote set LOT_DATA= :LOT_DATA,LOT_NUMERO=:LOT_NUMERO,LOT_DT_VENCIMENTO=:LOT_DT_VENCIMENTO,  '+
               ' LOT_QTD_E=:LOT_QTD_E,LOT_QTD_S=:LOT_QTD_S                                                            '+
               ' where                                                                                                '+
               '     LOT_CODITF =:LOT_CODITF                                                                          '+
               ' and LOT_CODIGO =:LOT_CODIGO                                                                          ';
      Lc_Qry.SQL.Add(Lc_Txt);
      Lc_Qry.ParamByName('LOT_DATA').AsDate:=PC_LOT_DATA;
      Lc_Qry.ParamByName('LOT_NUMERO').AsString:= PC_LOT_NUMERO;
      Lc_Qry.ParamByName('LOT_CODITF').AsInteger:=Pc_LOT_CODITF;
      Lc_Qry.ParamByName('LOT_DT_VENCIMENTO').AsDate:=PC_LOT_DT_VENCIMENTO;
      Lc_Qry.ParamByName('LOT_QTD_E').AsFloat:=PC_LOT_QTD_E;
      Lc_Qry.ParamByName('LOT_QTD_S').AsFloat:=PC_LOT_QTD_S;
      Lc_Qry.ParamByName('LOT_CODIGO').AsInteger:=PC_LOT_CODIGO;
    end
    else
    begin
      Lc_Txt:= 'delete from tb_lote where LOT_CODITF =:LOT_CODITF and LOT_CODIGO =:LOT_CODIGO    ';
      Lc_Qry.SQL.Add(Lc_Txt);
      Lc_Qry.ParamByName('LOT_CODITF').AsInteger:=Pc_LOT_CODITF;
      Lc_Qry.ParamByName('LOT_CODIGO').AsInteger:=PC_LOT_CODIGO;
    end;
    Lc_Qry.ExecSQL;

  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;


function Fc_CodProdComplementar: integer;
var
 Lc_Qry, Lc_Qry_Insere:TSTQuery;
 lc_sql_txt:String;
 lc_cod_prod:Integer;
 LcBase : TControllerBase;
begin
  try
    lc_sql_txt:='';
    LcBase := TControllerBase.create(nil);
    Lc_Qry_Insere:= LcBase.GeraQuery;

    Lc_Qry := LcBase.GeraQuery;

    lc_sql_txt:= ' select * from tb_produto where pro_tipo =''I'' ';
    Lc_Qry.SQL.Add(lc_sql_txt);
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    if Lc_Qry.IsEmpty then
      begin
      lc_sql_txt:='';
      lc_sql_txt:=' insert into  tb_produto (PRO_CODIGO,PRO_DESCRICAO, PRO_TIPO,PRO_CODMED,PRO_CODIGOFAB,PRO_CODIGONCM) '+
                  'values (:PRO_CODIGO,:PRO_DESCRICAO, :PRO_TIPO,:PRO_CODMED,:PRO_CODIGOFAB,:PRO_CODIGONCM)             ';
      Lc_Qry_Insere.SQL.Clear;
      Lc_Qry_Insere.SQL.Add(lc_sql_txt);
      lc_cod_prod:= Fc_Generator('GN_PRODUTO','TB_PRODUTO','PRO_CODIGO');
      Lc_Qry_Insere.ParamByName('PRO_CODIGO').AsInteger:=  lc_cod_prod;
      Lc_Qry_Insere.ParamByName('PRO_DESCRICAO').AsString:= 'Nfe-Complementar';
      Lc_Qry_Insere.ParamByName('PRO_TIPO').AsString:= 'I';
      Lc_Qry_Insere.ParamByName('PRO_CODMED').AsInteger:= 1;
      Lc_Qry_Insere.ParamByName('PRO_CODIGOFAB').AsString:='Complementar';
      Lc_Qry_Insere.ParamByName('PRO_CODIGONCM').AsString:='99999999';
      Lc_Qry_Insere.ExecSQL;
      Result:= lc_cod_prod;
      end;
    Lc_Qry.Active:=false;
    Lc_Qry.Active:=true;
    Lc_Qry.FetchAll;
    if Lc_Qry.IsEmpty then
      Begin
      IF Lc_Qry.fieldbyname('PRO_CODIGONCM').AsString <> '99' THEN
        BEGIN
        Lc_Qry_Insere.Active:=FALSE;
        Lc_Qry_Insere.SQL.Clear;
        Lc_Qry_Insere.SQL.Add('  UPDATE tb_produto                ');
        Lc_Qry_Insere.SQL.Add(' SET                               ');
        Lc_Qry_Insere.SQL.Add(' pro_codigoncm= :pro_codigoncm     ');
        Lc_Qry_Insere.SQL.Add(' WHERE                             ');
        Lc_Qry_Insere.SQL.Add(' pro_codigo=:pro_codigo            ');
        Lc_Qry_Insere.ParamByName('pro_codigoncm').AsString:='99';
        Lc_Qry_Insere.ParamByName('pro_codigo').AsInteger:=  Lc_Qry.fieldbyname('pro_codigo').AsInteger;
        Lc_Qry_Insere.ExecSQL;
        if Lc_Qry_Insere.Transaction.InTransaction then Lc_Qry_Insere.Transaction.CommitRetaining;
        END;
      END;
      Result:= Lc_Qry.fieldbyname('pro_codigo').AsInteger;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_Qry_Insere);
    LcBase.DisposeOf;
  end;
end;



procedure Pc_InfoRevendaVeiculos(Pc_Lista: TMemo;Pc_Cd_Pedido:integer);
var
  Lc_I: Integer;
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
begin
  if(Fc_Tb_Geral('L','PRO_G_LABEL_PRO','')= 'S') then
  begin
    try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;

      Lc_Qry.SQL.Add('SELECT DISTINCT PRO_CODIGOFAB AS PRO_CHASSI,          '+
                     'PRO_CODIGOBAR AS PRO_PLACA, PRO_CODIGOFOR AS PRO_RENAVAN '+
                     '  FROM TB_ITENS_NFL ITF                               '+
                     '     INNER JOIN TB_PRODUTO PRO                        '+
                     '     ON (PRO.PRO_CODIGO = ITF.ITF_CODPRO)             '+
                     'WHERE ITF_CODPED=:ITF_CODPED                          ');
      Lc_Qry.ParamByName('ITF_CODPED').AsInteger := Pc_Cd_Pedido;
      Lc_Qry.Active := True;
      Lc_Qry.First;
      if Lc_Qry.RecordCount > 0 then
      begin
        if Lc_Qry.FieldByName('PRO_CHASSI').AsString <> '' then
          Pc_Lista.Lines.Add('  CHASSIS: '+Lc_Qry.FieldByName('PRO_CHASSI').AsString);

        if Lc_Qry.FieldByName('PRO_PLACA').AsString <> '' then
          Pc_Lista.Lines.Add('  PLACA: '+Lc_Qry.FieldByName('PRO_PLACA').AsString);

        if Lc_Qry.FieldByName('PRO_RENAVAN').AsString <> '' then
          Pc_Lista.Lines.Add('  RENAVAN: '+Lc_Qry.FieldByName('PRO_RENAVAN').AsString);
      end;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  end;
end;


//Processo de Cancelamento de Faturamento
procedure Pc_ApagaMovimFinanceiro(Pc_cd_nota:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_Qry_Del : TSTQuery;
  LcBase : TControllerBase;
begin
  {no cancelamento do Faturamento o sistema vai excluir o lancamento feito no caixa
  quando for um lancamento que foi feito direto da tela de Faturamento
  Situação igual a Destinada e Etapa como [P]révio e não baixado}
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    Lc_Qry_Del := LcBase.GeraQuery;
    Lc_Qry_Del.SQL.Add('DELETE FROM TB_MOVIM_FINANCEIRO '+
                       'WHERE ( MVF_CODQTC=:MVF_CODQTC) ');
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT FIN_CODQTC                 ',
                'FROM TB_FINANCEIRO                ',
                'WHERE (FIN_CODNFL=:FIN_CODNFL)    ',
                '  AND (FIN_SITUACAO =:FIN_SITUACAO) ',
                '  AND (FIN_ETAPA   =:FIN_ETAPA)   '
      ));
      ParamByName('FIN_CODNFL').AsInteger := Pc_cd_nota;
      ParamByName('FIN_SITUACAO').AsString := 'D';
      ParamByName('FIN_ETAPA').AsString := 'P';
      Active := True;
      FetchAll;
      First;
      //Retira o Lancamento do banco ou do caixa
      while not Eof do
      Begin
        Lc_Qry_Del.Active   := False;
        Lc_Qry_Del.ParamByName('MVF_CODQTC').AsInteger := FieldByName('FIN_CODQTC').AsInteger;
        Lc_Qry_Del.ExecSQL;
        Next;
      end;
    END;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_Qry_Del);
    LcBase.DisposeOf;
  end;
end;



procedure Pc_ApagaComissaoFaturamento(Pc_cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := 'DELETE '+
                 'FROM TB_COMISSAO '+
                 ' WHERE COM_CODPED =:PED_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;



procedure Pc_ApagaImpostos(Pc_cd_nota:Integer);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
BEgin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_ICMS '+
                   ' WHERE ICM_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do II
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_II '+
                   ' WHERE IIP_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do PIS
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_PIS '+
                   ' WHERE PIS_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do IPI
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_IPI '+
                   ' WHERE IPI_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;

      //Cancela o lancamento do COFINS
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_CFS '+
                   ' WHERE CFS_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;


      //Cancela o lancamento do ISSQN
      IF not Transaction.InTransaction THEN Transaction.StartTransaction;
      Active := False;
      SQL.Clear;
      Lc_SqlTxt := 'DELETE '+
                   'FROM TB_ITENS_ISSQN '+
                   ' WHERE ISS_CODNFL =:NFL_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_Nota;
      ExecSQL;
      IF Transaction.InTransaction THEN Transaction.Commit;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_ApagaRetornoNFE(Pc_cd_nota:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'DELETE ',
              'FROM TB_RETORNO_NFE ',
              ' WHERE (NFE_CODNFL =:NFE_CODNFL)'
      ));
      ParamByName('NFE_CODNFL').AsInteger := Pc_cd_nota;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

procedure Pc_ApagaVendedor(Pc_cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' delete from tb_vendedor   ',
                ' where                     ',
                ' ven_codped = :COD_PEDIDO  '
      ));
      ParamByName('COD_PEDIDO').AsInteger := Pc_cd_Pedido;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_Apaga_conserto(Pc_cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  LcModulo : String;
begin
  //Não pode estar usando o metodo novo de Manutenção de Eletronicos
  LcModulo := Fc_Tb_Geral('L','OSR_G_TIPO_MODULO','AUTO CENTER');
  if not (LcModulo = 'EQUIPAMENTOS ELETRÔNICOS' ) then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        //Verifica s há conserto
        SQL.Add(concat(
                     ' SELECT CST_CODPED                                       ',
                     ' FROM TB_CONSERTO tb_conserto                            ',
                     '   LEFT OUTER JOIN TB_EMPRESA tb_empresa                 ',
                     '   ON (tb_empresa.EMP_CODIGO = tb_conserto.CST_CODFOR)   ',
                     '   INNER JOIN TB_SITUACAO tb_situacao                    ',
                     '   ON (tb_situacao.SIT_CODIGO = tb_conserto.CST_CODSIT)  ',
                     ' WHERE (CST_CODPED=:PED_CODIGO)                          '
        ));
        Active := False;
        ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
        Active := True;
        FetchAll;
        First;
        if RecordCount > 0 then
        Begin
          //Deleta o Pedido para voltar a ser orçamento de Conserto
          Active := False;
          SQL.Clear;
          SQL.Add('DELETE FROM TB_PEDIDO WHERE (PED_CODIGO =:PED_CODIGO) ');
          ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
          ExecSQL;
          //Altera a situação do conserto para que possa ser finalizado
          //Deleta o Pedido para voltar a ser orçamento de Conserto
          Active := False;
          SQL.Clear;
          SQL.Add('UPDATE TB_CONSERTO SET CST_CODSIT = 9 WHERE (CST_CODPED=:PED_CODIGO) ');
          ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
          ExecSQL;
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  End;
end;

procedure Pc_ApagaObservacao(Pc_cd_nota:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' delete from tb_obs_Nfe   ',
                ' where OBN_CODNFL = :NFL_CODIGO  '
      ));
      ParamByName('NFL_CODIGO').AsInteger := Pc_Cd_Nota;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;




Function Fc_Preenche_Transportadora(Fc_Cd_Empresa:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT EMP_CODTRANSP FROM TB_EMPRESA WHERE EMP_CODIGO=:EMP_CODIGO ');
      ParamByName('EMP_CODIGO').AsInteger := Fc_cd_empresa;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByname('EMP_CODTRANSP').AsInteger
      else
        Result := 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_PegaNumSeries(Pc_Cd_Produto, Pc_Cd_Item: Integer; Pc_Tipo: String): Integer;
var
  Lc_Qry: TSTQuery;
  Sql_Txt: String;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Sql_Txt := 'SELECT SRP_CODIGO FROM TB_SERIE_PRODUTO '+
                 'WHERE (SRP_CODPRO=:SRP_CODPRO)          ';
      if Pc_Tipo = 'E' then
        Sql_Txt := Sql_Txt + '  AND (SRP_CODENT=:SRP_CODENT)          '
      else
        Sql_Txt := Sql_Txt + '  AND (SRP_CODSAI=:SRP_CODSAI)          ';
      SQL.Add(Sql_Txt);
      if Pc_Tipo = 'E' then
        ParamByName('SRP_CODENT').AsInteger := Pc_Cd_Item
      else
        ParamByName('SRP_CODSAI').AsInteger := Pc_Cd_Item;

      ParamByName('SRP_CODPRO').AsInteger := Pc_Cd_Produto;

      Active := True;
      FetchAll;

      if RecordCount > 0 then
        Result := RecordCount
      else
        Result := 0;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;


function Fc_MascaraCep(Pc_Cep: String): String;
var
  Lc_Cep: string;
begin
  if Length(pc_Cep) > 0 then
    begin
    Lc_Cep := Copy(pc_Cep, 1, 5) + '-' + Copy(pc_Cep, 6, 3);
    Result := Lc_Cep;
    end
  else
    Result := '';
end;
          




Function Fc_VerificaDuplicacaoCheque(Fc_Cd_Cheque:Integer;Fc_Banco,Fc_Agencia,Fc_Conta,Fc_Nr_cheque:String):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('Select chq_codigo from tb_cheques '+
              'where chq_nr_banco =:chq_nr_banco '+
              '  and chq_agencia  =:chq_agencia '+
              '  and chq_numero   =:chq_numero '+
              '  and CHQ_CONTA    =:CHQ_CONTA ');

      if Fc_Cd_Cheque > 0 then
        SQL.Add('and chq_codigo <> :chq_codigo          ');

      ParamByName('chq_nr_banco').AsString:= Fc_banco;
      ParamByName('chq_agencia').Asstring:= Fc_agencia;
      ParamByName('chq_numero').Asstring:= Fc_Nr_cheque;
      ParamByName('CHQ_CONTA').Asstring:= Fc_Conta;
      if Fc_Cd_Cheque > 0 then
        ParamByName('chq_codigo').AsInteger:= Fc_Cd_Cheque;

      active:=True;
      FetchAll;
      if IsEmpty then
        Result:= true
      else
      begin
        MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       ' Já existe cheque com esses dados no Banco de dados.' + EOLN +
                       ' Verifique Nr. Banco, Nr. Agência, Nr. Conta, e Nr. de Cheque.' + EOLN,
                       ['OK'], [bEscape], mpErro);
        Result:= false;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;end;

function Fc_Marca_data_pesquisa:Boolean;
begin
  if Fc_Tb_Geral('L','GRL_G_DT_PESQUISA','') = 'S' then
    Result:= true
  else
    Result:= false;
end;


fUNCtION Fc_Obs_Empresa(Fc_Cd_Empresa:integer):string;
var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result:='';
  IF Fc_Cd_Empresa > 0 THEN
  Begin
    try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('SELECT emp_observ FROM tb_empresa WHERE emp_codigo =:emp_codigo');
        ParamByName('emp_codigo').AsInteger:=Fc_Cd_Empresa;
        Active:=true;
        Result:= fieldbyname('emp_observ').AsString;
      End;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  End;
end;

function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;
Var
  Lc_Qry:TSTQuery;
  Lc_aux:String;
  LcBase : TControllerBase;
begin
  Try
    Result:=true;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select end_fone from tb_endereco where end_codigo =:end_codigo');
      ParamByName('end_codigo').AsInteger:= Fc_cd_endereco;
      Active:=True;
      Lc_Aux := TRim(fieldbyname('END_FONE').AsString);
      Lc_Aux := RemoveCaracterInformado(Lc_Aux, ['.',',','/','-','(',')',' ']);
      if(trim(Lc_Aux) <> '') and (Length(trim(Lc_Aux)) < 10) then
        Result:=false;
      end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_Atualiza_Vend_Excluido(Pc_cd_vendedor:Integer);
var
  Lc_qry :TSTQuery;
  LcBase : TControllerBase;
begin
  try
    //aqui pega todos os produtos da nota
    LcBase := TControllerBase.create(nil);
    Lc_qry := LcBase.GeraQuery;
    With Lc_qry do
    Begin
      SQL.Add(' update tb_empresa         ');
      SQL.Add(' set                       ');
      SQL.Add(' emp_codvdor =0            ');
      SQL.Add(' where                     ');
      SQL.Add(' emp_codvdor =:emp_codvdor ');
      ParamByName('emp_codvdor').AsInteger:=Pc_cd_vendedor;
      ExecSQL;
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_LimpaQrPreviweMemoria;
Var
  Lc_I : Integer;
  Lc_Nome : String;
Label
  Lc_Reinicia;
begin
Lc_Reinicia:
  for Lc_I := (Screen.FormCount-1) downto 0 do
  Begin
    Lc_Nome := Screen.Forms[Lc_I].Name;
    if Screen.Forms[Lc_I].ClassName = 'TQRStandardPreview' then
    Begin
      Screen.Forms[Lc_I].Destroy;
      goto Lc_Reinicia;
    end;
    if (Copy(Screen.Forms[Lc_I].ClassName,1,14) = 'QRProgressForm') then
    Begin
      Screen.Forms[Lc_I].Destroy;
      goto Lc_Reinicia;
    end;
  end;
end;

procedure Pc_LimpaRelatorioMemoria;
Var
  Lc_I : Integer;
Label
  Lc_Reinicia;
begin
Lc_Reinicia:
  for Lc_I :=0 to Screen.FormCount -1 do
  Begin
    if (copy(Screen.Forms[Lc_I].Name,1,3) = 'RL_')then
    Begin
      Screen.Forms[Lc_I].disposeOf;
      goto Lc_Reinicia;
      end;
  end;
end;

procedure Pc_LimpaFormSemNome;
Var
  Lc_I : Integer;
  Lc_Contador : Integer;
Label
  Lc_Reinicia;
begin
  Lc_Contador := 0;
Lc_Reinicia:
  if Lc_Contador <= 3 then
  Begin
    Lc_Contador :=Lc_Contador + 1;
    for Lc_I :=0 to Screen.FormCount -1 do
    Begin
      if (Screen.Forms[Lc_I].Name <> '') then
      Begin
        Screen.Forms[Lc_I].Release;
        goto Lc_Reinicia;
      end;
    end;
  end;
end;


procedure Pc_Define_CasasDecimais;
Begin
  //Define casas decimais para as vendas
  case StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_VENDA','0'),0) of
    0:Gb_Casa_Dec_Venda := '0.00';
    1:Gb_Casa_Dec_Venda := '0.000';
    2:Gb_Casa_Dec_Venda := '0.0000';
    3:Gb_Casa_Dec_Venda := '0.00000';
    4:Gb_Casa_Dec_Venda := '0.000000';
  end;

  //Define casas decimais para as Compras
  case StrToIntDef(Fc_Tb_Geral('L','PRO_CASA_DEC_COMPRA','0'),0) of
    0:Gb_Casa_Dec_Compra := '0.00';
    1:Gb_Casa_Dec_Compra := '0.000';
    2:Gb_Casa_Dec_Compra := '0.0000';
    3:Gb_Casa_Dec_Compra := '0.00000';
    4:Gb_Casa_Dec_Compra := '0.000000';
  end;
end;

Function Fc_TamanhoArquivo(const FileName: string): integer;
var
  SR: TSearchRec;
  I: integer;
begin
  I := FindFirst(FileName, faArchive, SR);
  try
    if I = 0 then
      Result := SR.Size
    else
      Result := -1;
  finally
//    free;
//    FindClose(SR);
  end;
end;

procedure Pc_Define_Impressora_Qrpt(Pc_Qrpt:TQuickRep);
begin
  Pc_Qrpt.ShowProgress := True;
  Pc_Qrpt.PrinterSettings.PrinterIndex := Printer.PrinterIndex;
  //Pc_Qrpt.PrinterSettings.ApplySettings(Pc_Qrpt.Printer);
end;

Procedure Pc_Excluir_Extintores(Pc_Cd_Pedido:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    //Esta proedure exclui todos os extintores relacionados a este pedido.
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('DELETE FROM TB_VENC_EXTINTOR WHERE (EXT_CODPED =:EXT_CODPED) AND (EXT_CODPED > 0) ');
      ParamByName('EXT_CODPED').AsInteger :=  Pc_Cd_Pedido;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_Atualiza_Custo_venda(Pc_cd_nota:Integer);
Var
  Lc_Mtz : array of array of String;
  Lc_I, Lc_Final : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT ITF_CODIGO, PRO_VL_CUSTOMED,PRO_VL_CUSTO '+
                    'FROM TB_ITENS_NFL '+
                    '  INNER JOIN TB_PRODUTO '+
                    '  ON (TB_PRODUTO.PRO_CODIGO =TB_ITENS_NFL.ITF_CODPRO) '+
                    'WHERE ITF_CODNFL =:NFL_CODIGO ');
      ParamByName('NFL_CODIGO').AsInteger := Pc_cd_nota;
      Active := True;
      FetchAll;
      Lc_Final := RecordCount;
      SetLength(Lc_Mtz,2,lc_final);
      First;
      Lc_I := 0;
      //Guarda os dados em uma Matriz
      while not Eof do
      Begin
        Lc_Mtz[0,Lc_I] := FieldByName('ITF_CODIGO').AsString;
        IF (Fc_Tb_Geral('L','PRO_G_CUSTO_ATUAL_PRECO','C') = 'C') then
          Lc_Mtz[1,Lc_I] := FieldByName('PRO_VL_CUSTO').AsString
        else
          Lc_Mtz[1,Lc_I] := FieldByName('PRO_VL_CUSTOMED').AsString;
        inc(Lc_I);
        Next;
      end;

      //Cria o SQl de Atualização
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_ITENS_NFL SET       '+
              'ITF_VL_CUSTO =:ITF_VL_CUSTO   '+
              'WHERE ITF_CODIGO =:ITF_CODIGO ');
      for Lc_I := 0 to Lc_Final-1 do
      Begin
        Active := False;
        ParamByName('ITF_CODIGO').AsString := Lc_Mtz[0,Lc_I];
        ParamByName('ITF_VL_CUSTO').AsFloat := StrToFloatdef(Lc_Mtz[1,Lc_I],0);
        ExecSQL;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_Del_Lin_Grid(Pc_strGrid: TStringGrid; Pc_Linha: Integer;Pc_ColRef:Integer);
var
   Lc_I, Lc_J: Integer;
   Lc_Lista: array of array of string;
   Lc_Linha: Integer;
begin
  if Pc_strGrid.Cells[Pc_ColRef, Pc_Linha] = '' then
    exit;
  Lc_Linha := 0;
  SetLength(Lc_Lista, Pc_strGrid.RowCount-1, Pc_strGrid.ColCount);
  //Guarda os dados que não estão marcados
  for Lc_I := 1 to Pc_strGrid.RowCount do
  begin
    if Lc_I <> Pc_Linha then
    begin
      Lc_Linha := Lc_Linha + 1;
      for Lc_J := 0 to Pc_strGrid.ColCount - 1 do
        Lc_Lista[Lc_Linha, Lc_J] := Pc_strGrid.Cells[Lc_J, Lc_I];
    end;
  end;
  //Limpa a Matriz antes de incluir a diferenca
  for Lc_I := 0 to Pc_strGrid.RowCount - 1 do
    for Lc_J := 0 to Pc_strGrid.ColCount - 1 do
      Pc_strGrid.Cells[Lc_J, Lc_I] := '';

  Pc_strGrid.RowCount := 2;

  //Grava novamente os dados que não foram marcados e que estão na matriz
  if (Lc_Linha > 0) then
  begin
    for Lc_I := 1 to Lc_Linha do
    begin
      Pc_strGrid.RowCount := Lc_I + 1;
      for Lc_J := 0 to Pc_strGrid.ColCount - 1 do
        Pc_strGrid.Cells[Lc_J, Lc_I] := Lc_Lista[Lc_I, Lc_J];
    end;
  end;
end;


function Fc_VerificaProxy():boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select INT_CODIGO, '+
              ' INT_PXY_PATH,     '+
              ' INT_PXY_PORTA,    '+
              ' INT_PXY_USER,     '+
              ' INT_PXY_PWS       '+
              'from TB_INTERNET   '+
              'where (INT_PXY_PATH IS NOT NULL) AND (INT_PXY_PATH <> '''') AND INT_CODMHA=:INT_CODMHA ');
      ParamByName('INT_CODMHA').AsInteger := Gb_CodMha;
      Active := True;
      FetchAll;
      First;
      if RecordCount>0 then
      Begin
        Result := True;
        Gb_Pxy_Path    := FieldByName('INT_PXY_PATH').AsString;
        Gb_Pxy_Porta   := FieldByName('INT_PXY_PORTA').AsInteger;
        Gb_Pxy_User    := FieldByName('INT_PXY_USER').AsString;
        Gb_pxy_Pws     := FieldByName('INT_PXY_PWS').AsString;
        end
      else
      Begin
        Result := False;
        Gb_Pxy_Path    := '';
        Gb_Pxy_Porta   := 0;
        Gb_Pxy_User     := '';
        Gb_pxy_Pws     := '';
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


Procedure Pc_InsereAltPreco(Pc_CodProd:integer;Pc_Valor_Anterior:double;Pc_Valor_Atual:double;Pc_CodEstoque:Integer;
                            Pc_CodTabelaPreco:integer);
var
  lc_qry :TSTQuery;
  Lc_Data : String;
  Lc_Time : String;
  LcBase : TControllerBase;
begin
  if (Pc_Valor_Anterior <> Pc_Valor_Atual) then
  Begin
    try
      LcBase := TControllerBase.create(nil);
      lc_qry:= LcBase.GeraQuery;
      with lc_qry do
      Begin
        SQL.Add(' insert into TB_ALTERA_PRECO '+
                '(APR_CODIGO,  APR_CODPRO,  APR_VL_ANTERIOR,  APR_VL_ATUAL,  APR_DATATIME,  APR_CODUSU,  APR_CODEST, APR_CODTPR) '+
                ' values '+
                '(:APR_CODIGO,:APR_CODPRO, :APR_VL_ANTERIOR, :APR_VL_ATUAL, :APR_DATATIME, :APR_CODUSU, :APR_CODEST,:APR_CODTPR) ');
        ParamByName('APR_CODIGO').AsInteger     :=  Fc_Generator('GN_ALTERA_PRECO','TB_ALTERA_PRECO','APR_CODIGO ');
        ParamByName('APR_CODPRO').AsInteger     :=  Pc_CodProd;
        ParamByName('APR_VL_ANTERIOR').AsFloat  :=  Pc_Valor_Anterior;
        ParamByName('APR_VL_ATUAL').AsFloat     :=  Pc_Valor_Atual;
        ParamByName('APR_DATATIME').asDateTime  := now;
        ParamByName('APR_CODUSU').AsInteger     :=  Gb_Cd_Usuario;
        ParamByName('APR_CODEST').AsInteger     :=  Pc_CodEstoque;
        ParamByName('APR_CODTPR').AsInteger     :=  Pc_CodTabelaPreco;
        ExecSQL;
      end;
    finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    end;
  end;
end;


Procedure Pc_Executar_Arquivo(F: String);
var
  Lc_r: String;
  Lc_WResultado: Boolean;
begin
  case ShellExecute(HANDLE_FLAG_INHERIT, nil, PChar(F), nil, nil, SW_SHOWNORMAL) of
    ERROR_FILE_NOT_FOUND: Lc_r := 'The specified file was not found.';
    ERROR_PATH_NOT_FOUND: Lc_r := 'The specified path was not found.';
    ERROR_BAD_FORMAT: Lc_r := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED: Lc_r := 'Windows 95 only: The operating system denied access to the specified file.';
    SE_ERR_ASSOCINCOMPLETE: Lc_r := 'The filename association is incomplete or invalid.';
    SE_ERR_DDEBUSY: Lc_r := 'The DDE transaction could not be completed because other DDE transactions were being processed.';
    SE_ERR_DDEFAIL: Lc_r := 'The DDE transaction failed.';
    SE_ERR_DDETIMEOUT: Lc_r := 'The DDE transaction could not be completed because the request timed out.';
    SE_ERR_DLLNOTFOUND: Lc_r := 'Windows 95 only: The specified dynamic-link library was not found.';
    SE_ERR_NOASSOC: Lc_r := 'There is no application associated with the given filename extension.';
    SE_ERR_OOM: Lc_r := 'Windows 95 only: There was not enough memory to complete the operation.';
    SE_ERR_SHARE: Lc_r := 'A sharing violation occurred.';
    else
      Exit;
    end;
  ShowMessage(Lc_r);
end;

Function Fc_PingConectadoSetes():Boolean;
Var
  Lc_ICMP: TIdIcmpClient;
begin
  {O  ping não funciona em alguns pcs e ai compromete o envio de email, Caso da pipoteca que perdi muito tempo até descobrir}
  Result := True;
  exit;
  try
    Lc_ICMP := TIdIcmpClient.Create(nil);
    try
      Lc_ICMP.Host := '200.150.205.102';
      Lc_ICMP.Ping();
      Result := (Lc_ICMP.ReplyStatus.BytesReceived > 0);
    except
      on e:exception do
      Begin
        GeralogFile('Fc_PingConectadoSetes()',e.Message);
        Result := False;
      End;
    end;
  finally
    Lc_ICMP.disposeOf;
  end;
end;

procedure Pc_ProcesoAguarde(Pc_Tela:TForm;Pc_Tipo:String);
Var
  Lc_Painel : Tpanel;
  Lc_Imagem : TImage;
  Lc_I,Lc_J : Integer;
  Lc_Tela:TForm;
  Lc_Achou : Boolean;
  LcRand : String;
  //Lc_Aguarde : TProcessoAguarde;
Begin
  {
  if (Pc_Tipo = 'I') then
  Begin
    if Assigned(Fr_Principal.FAguarde) then
      Fr_Principal.FAguarde.stop;
    Fr_Principal.FAguarde := nil;
    Fr_Principal.FAguarde := TProcessoAguarde.Create(Pc_Tela,Fr_Principal.Img_Aguarde.Picture);
    Fr_Principal.FAguarde.Start;
  End
  else
  Begin
    if Assigned(Fr_Principal.FAguarde) then
      Lc_Aguarde.Stop;
  End;
  exit;
  }
  Lc_Achou := False;
  if (Pc_Tipo = 'I') then
  Begin
    LcRand := IntToStr(Random(10000));
    Lc_Painel := TPanel.Create(Pc_Tela);
    Lc_Painel.Name := concat('Pnl_ProceAguarde',LcRand) ;
    with Lc_Painel do
    Begin
      Visible := False;
      Parent := Pc_Tela;
      Caption := '';
      FullRepaint := True;
      ShowCaption := False;
      BorderWidth := 0;
      BevelInner := bvNone;
      BevelKind := bkNone;
      BevelOuter := bvNone;
      Height := 114;
      Width := 340;
      Top := -115;//trunc((Pc_Tela.Height - Lc_Painel.Height)/2);
      Left := trunc((Pc_Tela.Width - Lc_Painel.Width)/2);
    End;
    //Cria imagens
    Lc_Imagem := TImage.Create(Lc_Painel);
    Lc_Imagem.Name := concat('Img_ProceAguarde',LcRand) ;
    with Lc_Imagem do
    Begin
      Align := alClient;
      Parent := Lc_Painel;
      Transparent := True;
      Center := True;
      Top := 3;
      Left := 8;
      //Picture := Fr_Principal.Img_Aguarde.Picture;
      AutoSize := True;
    End;
    Lc_Painel.Visible := True;
    for Lc_I := 1 to 12 do
    Begin
      Lc_Painel.Top := -118 + (Lc_I * 10) ;
      Lc_Painel.Update;
    end;
    Pc_Tela.BringToFront;
    Lc_Imagem.Update;
  end
  else
  begin
    for Lc_I := 0 to Pc_Tela.ComponentCount - 1 do
    begin
      //Limpa Painel
      if (Pc_Tela.Components[Lc_I].ClassType = TPanel) then
      begin
        if (Copy(TPanel(Pc_Tela.Components[Lc_I]).Name,1,16) = 'Pnl_ProceAguarde') then
        begin
          for Lc_J := 0 to TPanel(Pc_Tela.Components[Lc_I]).ComponentCount - 1 do
          Begin
            if (TPanel(Pc_Tela.Components[Lc_I]).Components[Lc_J].ClassType = TImage) then
            Begin
              TImage(TPanel(Pc_Tela.Components[Lc_I]).Components[Lc_J]).DisposeOf;
              TPanel(Pc_Tela.Components[Lc_I]).disposeOf;
              Lc_Achou := True;
              Break;
            End;
          End;
        end;
      end;
      if Lc_Achou then Break;
    end;
  end;
end;

procedure Pc_ProcesoAguarde20(Pc_Tela:TForm;Pc_Panel:TPanel;Pc_Tipo:String);
Var
  Lc_Imagem : TImage;
  Lc_I,Lc_J : Integer;
Begin
  if (Pc_Tipo = 'I') then
  Begin
    with Pc_Panel do
    Begin
      Caption := '';
      FullRepaint := True;
      ShowCaption := False;
      BorderWidth := 0;
      BevelInner := bvNone;
      BevelKind := bkNone;
      BevelOuter := bvNone;
      Height := 114;
      Width := 340;
      Top := -115;//trunc((Pc_Tela.Height - Lc_Painel.Height)/2);
      Left := trunc((Pc_Tela.Width - Pc_Panel.Width)/2);
    End;
    //Cria imagens
    Lc_Imagem := TImage.Create(Pc_Panel);
    with Lc_Imagem do
    Begin
      Align := alClient;
      Parent := Pc_Panel;
      Transparent := True;
      Center := True;
      Top := 3;
      Left := 8;
      //Picture := Fr_Principal.Img_Aguarde.Picture;
      AutoSize := True;
    End;
    Pc_Panel.BringToFront;
    Pc_Panel.Visible := True;
    for Lc_I := 1 to 12 do
    Begin
      Pc_Panel.Top := -118 + (Lc_I * 10) ;
      Pc_Panel.Update;
    end;
    Pc_Tela.BringToFront;
  end
  else
  begin
    Pc_Panel.disposeOf;
  end;
end;
// Limpa cache do Internet Explorer
procedure DeletaIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
  GetMem(lpEntryInfo, dwEntrySize) ;
  if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize) ;
  if hCacheDir <> 0 then
  begin
    repeat
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName) ;
      FreeMem(lpEntryInfo, dwEntrySize) ;
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
      GetMem(lpEntryInfo, dwEntrySize) ;
      if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) ;
  end;
  FreeMem(lpEntryInfo, dwEntrySize) ;
  FindCloseUrlCache(hCacheDir) ;
end;


procedure Fc_ChamaTelaVideoTreinamento(Pc_cd_Interface,Pc_Numero,Link:String);
//Var
//  Lc_Form: TFr_VideoTreinamento;
Begin
//  Try
//    Lc_Form := TFr_VideoTreinamento.Create(nil);
//    Lc_Form.Top := Fr_Principal.Top + 50;
//    Lc_Form.Left := 1;
//    Lc_Form.Height := Fr_Principal.Height - 50;
//    Lc_Form.Width := Fr_Principal.Width - 8;// - 180;
//    Lc_Form.It_cd_Interface := Pc_cd_Interface;
//    Lc_Form.It_Numero := Pc_Numero;
//    Lc_Form.It_Link := Link;
//    Lc_Form.ShowModal;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;


procedure Pc_BaixarArquivosSite(Pc_Dir,Pc_Arquivo, Pc_Dir_Local:String);
var
  Lc_http_down : TidHttp;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Lc_DwnFile: TFileStream;
  Lc_files : TStringList;
  Lc_I: Integer;
  Lc_Arquivo : String;
  Lc_FileTxt:TextFile;
  Lc_linha:String;
begin
  try
    DeletaIECache;
    Lc_http_down := TidHttp.Create(nil);

    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(Lc_http_down);
    ssl.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
    // configure SSL as needed (TLS versions, certificates, etc)...
    Lc_http_down.IOHandler := SSL;
      //Verifica se tem proxy para baixar o arquivo
    Lc_http_down.ProxyParams.BasicAuthentication := Fc_VerificaProxy;
    Lc_http_down.ProxyParams.ProxyServer     := Gb_PXY_PATH;
    Lc_http_down.ProxyParams.ProxyPort       := Gb_PXY_PORTA;
    Lc_http_down.ProxyParams.ProxyUsername   := Gb_PXY_USER;
    Lc_http_down.ProxyParams.ProxyPassword   := Gb_PXY_PWS;
    //Baixa o Arquivo
    ForceDirectories(GbPathExe + Pc_Dir_Local);
    if Length(Trim(Pc_Dir_Local)) > 0  then
      Lc_DwnFile := TFileStream.Create(GbPathExe + Pc_Dir_Local + '\' + Pc_Arquivo, fmCreate) // local no hd e nome do arquivo com a extensão, onde vai salvar.
    else
      Lc_DwnFile := TFileStream.Create(GbPathExe + Pc_Arquivo, fmCreate); // local no hd e nome do arquivo com a extensão, onde vai salvar.

    try
      Lc_http_down.Get('https://www.setes.com.br/' + Pc_Dir + '/' + Pc_Arquivo, Lc_DwnFile); // fazendo o download do arquivo
    except
      if FileExists(GbPathExe + Pc_Dir_Local + '\' + Pc_Arquivo) then
        deletefile(PChar(GbPathExe + Pc_Dir_Local + '\' + Pc_Arquivo));
    end;
  finally
    FreeAndNil(Lc_DwnFile);
    FreeAndNil(Lc_http_down);
  end;
end;


procedure Pc_SSL2_TLS1;
var
  Lc_Registro: TRegistry;
begin
  //TESTANDO O EMAIL VAMOS DESABILITAR A CONFIGUIRAÇÃO
  EXIT;
  try
    //acertando opções da internet (revogados / SSL / TSL)
    //verificar revogação de certificados do servidor
    Lc_Registro := TRegistry.Create(KEY_WRITE);
    Lc_Registro.RootKey := HKEY_CURRENT_USER;
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('CertificateRevocation', 0);
    end;
    Lc_registro.CloseKey;

    //verificar se há certificados revogados do fornecedor
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing', true) then
    begin
      Lc_Registro.WriteInteger('State', 146944);
    end;
    Lc_registro.CloseKey;

    if StrToIntDef( Fc_Aq_Geral('L', 'NFE', 'NFE_SSLTLS','0'),0) = 1 then
    Begin
     //Usar SSL 3.0 / Usar TSL 1.0
      if Lc_Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
          Lc_Registro.WriteInteger('SecureProtocols', 2728);
//        Lc_Registro.WriteInteger('SecureProtocols', 2088);
//        Lc_Registro.WriteInteger('SecureProtocols', 160);
      end;
      Lc_Registro.CloseKey;
    End
    else
    Begin
      //Usar SSL 2.0 / Usar TSL 1.0
      if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
        Lc_Registro.WriteInteger('SecureProtocols', 136);
      end;
      Lc_registro.CloseKey;
    End;

    //força para IE não ficar trabalhando off line
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('GlobalUserOffline', 0);
    end;
  finally
    Lc_registro.CloseKey;
    FReeAndNil(Lc_registro);
  end;
end;


procedure Pc_SSL2_TLS1_NFSE;
var
  Lc_Registro: TRegistry;
begin
  //TESTANDO O EMAIL VAMOS DESABILITAR A CONFIGUIRAÇÃO
  EXIT;

  try
    //acertando opções da internet (revogados / SSL / TSL)
    //verificar revogação de certificados do servidor
    Lc_Registro := TRegistry.Create(KEY_WRITE);
    Lc_Registro.RootKey := HKEY_CURRENT_USER;
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('CertificateRevocation', 0);
    end;
    Lc_registro.CloseKey;

    //verificar se há certificados revogados do fornecedor
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing', true) then
    begin
      Lc_Registro.WriteInteger('State', 146944);
    end;
    Lc_registro.CloseKey;

    if StrToIntDef( Fc_Aq_Geral('L', 'NFS', 'NFS_SSLTLS','0'),0) = 1 then
    Begin
     //Usar SSL 3.0 / Usar TSL 1.0
      if Lc_Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
          Lc_Registro.WriteInteger('SecureProtocols', 2728);
//        Lc_Registro.WriteInteger('SecureProtocols', 2088);
//        Lc_Registro.WriteInteger('SecureProtocols', 160);
      end;
      Lc_Registro.CloseKey;
    End
    else
    Begin
      //Usar SSL 2.0 / Usar TSL 1.0
      if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
      begin
        Lc_Registro.WriteInteger('SecureProtocols', 136);
      end;
      Lc_registro.CloseKey;
    End;

    //força para IE não ficar trabalhando off line
    if Lc_registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings', true) then
    begin
      Lc_Registro.WriteInteger('GlobalUserOffline', 0);
    end;
  finally
    Lc_registro.CloseKey;
    FReeAndNil(Lc_registro);
  end;
end;


Function Fc_ArredondamentoModCinco(Numero:Extended):Real;
Var
  Lc_Calcular : Extended;
  I, D: Extended;
  Lc_Inteiro : Integer;
begin
  Lc_Calcular := Numero / 100;
  I := Int(Lc_Calcular); { I = 12,30->12,50 / 12,80-> 13,00 }
  D :=  StrToFloatDef( FloatToStrF( Frac(Lc_Calcular),ffFixed,2,2),0) ; { D = 0.30 }
  D := D * 100;
  Lc_Inteiro:= StrToIntDef( FloatToStrF(D,ffFixed,2,0),0);
  case Trunc(Lc_Inteiro) of
    1..49: Result := StrToFloatDef(FloatToStr(I) + '50',0);
    51..99: REsult := StrToFloatDef(FloatToStr(I+1) + '00',0);
  else
   REsult := Numero;
  end;
end;


procedure FormVehicleOS(CodigoCotacao,CodigoPedido,CodigoEmpresa:Integer);
//Var
//  Lc_Form : TFr_VehicleSo;
begin
//  TRy
//    Lc_Form := TFr_VehicleSo.Create(nil);
//    with Lc_Form do
//    begin
//      with OrdemServico do
//      Begin
//        Registro.CodigoEstabelecimento := Gb_Codmha;
//        Registro.CodigoCotacao := CodigoCotacao;
//        Registro.CodigoPedido := CodigoPedido;
//        with Vehicle do
//        Begin
//          Registro.CodigoEmpresa := CodigoEmpresa;
//        End;
//      End;
//      ShowModal;
//    End;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;

procedure FormVehicleCheckList(CodigoCotacao,CodigoPedido:Integer);
//Var
//  Lc_Form : TFr_VehicleCheckList;
begin
//  Try
//    Lc_Form := TFr_VehicleCheckList.Create(nil);
//    with Lc_Form do
//    Begin
//      It_Budget_id := codigoCotacao;
//      It_Order_id := CodigoPedido;
//      ShowModal;
//    End;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;

procedure ZebraArgoxElginImprimeDiretoPorta(Conteudo : String);
Var
  Arquivo : TextFile;
  Porta : String;
Begin
  Porta := Fc_Aq_Geral('L','IMPRESSAO','PORTAZEBRA','LPT1');
  AssignFile(Arquivo,Porta);
  Rewrite(Arquivo);
  Writeln(Arquivo,Conteudo);
  CloseFile(Arquivo);
End;


function Fc_Parcelamento(Fc_Tipo:String;Qr_Pedido:TSTQuery):String;
Var
  Lc_Nr_Parcelas : Integer;
  lc_Mtz_Prazo : Array of array of string;
  Lc_St_Parcela : String;
  Lc_Vl_Parcela : Real;
  Lc_I, Lc_J : Integer;
  Lc_Prazo : String;
  Lc_Qry: TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(' SELECT PAR_VALOR,PAR_DATA     ');
      SQL.Add(' FROM TB_PARCELAMENTO          ');
      SQL.Add(' WHERE PAR_CODPED=:PAR_CODPED  ');
      SQL.Add(' ORDER BY PAR_PARCELA          ');
      ParamByName('PAR_CODPED').AsInteger := Qr_Pedido.FieldByname('PED_CODIGO').asInteger;
      Active := True;
      FetchAll;

      if Lc_Qry.RecordCount = 0 then
      Begin
        Lc_Nr_Parcelas := StrToIntDef(Copy(Qr_Pedido.FieldByname('PED_PRAZO').AsAnsiString,1,3),0);
        if Lc_Nr_Parcelas = 0 then
        Begin
          SetLength(lc_Mtz_Prazo,2,1);
          lc_Mtz_Prazo[0,0] := Qr_Pedido.FieldByname('PED_DATA').AsAnsiString;
          lc_Mtz_Prazo[1,0] := FloatToStrF(Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsFloat,ffFixed,10,2);
        end
        else
        Begin
          SetLength(lc_Mtz_Prazo,2,Lc_Nr_Parcelas);
          For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
            For Lc_J := 0 to 1 do
              lc_Mtz_Prazo[Lc_J, Lc_I] := '';

          //Resolvemos o problema da Divisão e dizima periodica
          Lc_St_Parcela := FloatToStrF((Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsFloat / Lc_Nr_Parcelas),ffFixed,10,2);
          Lc_Vl_Parcela := StrToFloatDef(Lc_St_Parcela,1);

          For Lc_I := 0 to (Lc_Nr_Parcelas -1) do
          begin
            Lc_Prazo := Copy(Qr_Pedido.FieldByname('PED_PRAZO').AsAnsiString,7,(Length(Qr_Pedido.FieldByname('PED_PRAZO').AsAnsiString)-6));
            Lc_Prazo :=  Copy(Lc_Prazo,(((Lc_I) * 4)+1),3);
            if not (Lc_I = Lc_Nr_Parcelas) then
              lc_Mtz_Prazo[1,Lc_I] := Lc_St_Parcela
            else
              lc_Mtz_Prazo[1,Lc_I] := FloatToStrF((Qr_Pedido.FieldByname('PED_VL_PEDIDO').AsFloat -(Lc_Vl_Parcela * (Lc_Nr_Parcelas - 1))),ffFixed,10,2);
            lc_Mtz_Prazo[0,Lc_I] := copy(DateToStr(Qr_Pedido.FieldByname('PED_DATA').AsDateTime + StrToIntDef(Lc_Prazo,0)),1,5);
          end;
        end;
      end
      else
      Begin
        Lc_Nr_Parcelas := Lc_Qry.RecordCount;
        SetLength(lc_Mtz_Prazo,2,Lc_Nr_Parcelas);
        For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
          For Lc_J := 0 to 1 do
            lc_Mtz_Prazo[Lc_J, Lc_I] := '';
        Lc_I := 0;
        while not Lc_Qry.Eof do
        begin
          lc_Mtz_Prazo[0,Lc_I] := FloatToStrF(Lc_Qry.FieldByname('PAR_VALOR').AsFloat,ffFixed,10,2);
          lc_Mtz_Prazo[1,Lc_I] := copy(Lc_Qry.FieldByname('PAR_DATA').AsAnsiString,1,5);
          inc(Lc_I);
          Lc_Qry.Next;
        end;
      end;

      if (Fc_Tipo = 'O') then
      Begin
        {
        if Lc_Nr_Parcelas = 0 then
        Begin
          It_Observacao.Lines.Add('A VISTA');
          Lc_Prazo := 'A VISTA';
        end
        else
        Begin
          For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
          Begin
            if lc_Mtz_Prazo[1,Lc_I] <> '' then
            Begin
              if Lc_I = 0 then
              Begin
                It_Observacao.Lines.Add(Qr_Pedido.FieldByname('FPT_DESCRICAO').AsAnsiString);
                It_Observacao.Lines.Add(lc_Mtz_Prazo[0,Lc_I] + ' - ' + lc_Mtz_Prazo[1,Lc_I]);
              end
              else
                It_Observacao.Lines.Add(lc_Mtz_Prazo[0,Lc_I] + ' - ' + lc_Mtz_Prazo[1,Lc_I]);
            end;
          end;
        end;
        }
      end
      else
      Begin
        Lc_Prazo := 'A VISTA';
        For Lc_I := 0 to Lc_Nr_Parcelas - 1 do
        Begin
          if lc_Mtz_Prazo[0,Lc_I] <> '' then
          Begin
            if Lc_I = 0 then
              Lc_Prazo := lc_Mtz_Prazo[0,Lc_I] + '-' + lc_Mtz_Prazo[1,Lc_I]
            else
              Lc_Prazo := Lc_Prazo + ' | ' +lc_Mtz_Prazo[0,Lc_I] + '-' + lc_Mtz_Prazo[1,Lc_I];
          end;
        end;
        Result := Lc_Prazo + ' |' ;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function existTabela(Tabela: String): Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'select rdb$relation_name ',
                'from rdb$relations ',
                'where rdb$view_blr is null ',
                'and (rdb$system_flag is null or rdb$system_flag = 0) ',
                ' and (rdb$relation_name=:rdb$relation_name); '
        ));
      ParamByName('rdb$relation_name').AsString := Tabela;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function existTabelaCampoDominio(Tabela,Campo,Dominio: String): Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'SELECT RDB$FIELD_SOURCE ',
                'FROM  RDB$RELATION_FIELDS ',
                'WHERE ( RDB$FIELD_NAME = :RDB$FIELD_NAME)',
                'AND ( RDB$RELATION_NAME = :RDB$RELATION_NAME)',
                'AND RDB$FIELD_SOURCE = :RDB$FIELD_SOURCE'
        ));
      ParamByName('RDB$FIELD_NAME').AsString    := Tabela;
      ParamByName('RDB$RELATION_NAME').AsString := Campo;
      ParamByName('RDB$FIELD_SOURCE').AsString  := Dominio;
      Active := True;
      FetchAll;
      result := (recordCount > 0);
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


function GetMaxCodigo(FcTabela:String;FcCampo:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := 0;
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'SELECT MAX(',FcCampo,') ID ',
                'FROM ', FcTabela
      ));
      Active := True;
      Result := FieldByNAme('ID').AsInteger;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure AjustaGenerators(FcGEnerator:String;Sequencia:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat('ALTER SEQUENCE ' , FcGenerator , ' RESTART WITH ' , IntToStr(Sequencia)));
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
End;

procedure SetMainForm(NovoMainForm: TForm);
var
  TmpMain: ^TCustomForm;
begin
  TmpMain := @Application.Mainform;
  TmpMain^ := NovoMainForm;
end;

end.







