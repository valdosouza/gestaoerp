unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, un_base;

type
  TFrMain = class(TFr_Base)
    MnuOper: TMainMenu;
    MnuArqOpe: TMenuItem;
    MnuArqClienteoOper: TMenuItem;
    CientesemProspeco1: TMenuItem;
    MnuArqFornOper: TMenuItem;
    MnuArqTranspOper: TMenuItem;
    Representada1: TMenuItem;
    Contatos1: TMenuItem;
    MnuRamodeAtividade: TMenuItem;
    N17: TMenuItem;
    Cidades1: TMenuItem;
    Estados1: TMenuItem;
    N13: TMenuItem;
    MnuArqCadSrvOper: TMenuItem;
    ipoVeculo1: TMenuItem;
    MarcasModelos1: TMenuItem;
    Veculos1: TMenuItem;
    N24: TMenuItem;
    AgenteExtintor2: TMenuItem;
    Ensaiador1: TMenuItem;
    ipoExtintor1: TMenuItem;
    MotivoCondenaoReprovao1: TMenuItem;
    NvelManunteo1: TMenuItem;
    Extintores1: TMenuItem;
    Selos1: TMenuItem;
    N19: TMenuItem;
    Boto1: TMenuItem;
    Medidas1: TMenuItem;
    Embalagens1: TMenuItem;
    Marcas1: TMenuItem;
    MnuArqGpPdOper: TMenuItem;
    MnuArqCadProdOper: TMenuItem;
    TabelasdePreco: TMenuItem;
    Estoques1: TMenuItem;
    N16: TMenuItem;
    Cardpio1: TMenuItem;
    N1: TMenuItem;
    Equipamentos1: TMenuItem;
    N45: TMenuItem;
    Pets1: TMenuItem;
    N48: TMenuItem;
    Contratos1: TMenuItem;
    N50: TMenuItem;
    ributao1: TMenuItem;
    Observao1: TMenuItem;
    Situao1: TMenuItem;
    OrigemdaVenda1: TMenuItem;
    OrigemdoCliente1: TMenuItem;
    N31: TMenuItem;
    MnuArqSairOper: TMenuItem;
    MnuModOper: TMenuItem;
    MnuModFinOper: TMenuItem;
    MnuModBancoOper: TMenuItem;
    MnuModAnalOper: TMenuItem;
    Pessoal1: TMenuItem;
    MnuTafOper: TMenuItem;
    ImportarXMLdaNFe1: TMenuItem;
    N26: TMenuItem;
    ransformao1: TMenuItem;
    AjustaPreo1: TMenuItem;
    Promoes1: TMenuItem;
    N6: TMenuItem;
    EstoqueManual1: TMenuItem;
    InventrioManual1: TMenuItem;
    InventrioAutomtico1: TMenuItem;
    N9: TMenuItem;
    MnuTafTrfOper: TMenuItem;
    ConsultaConserto1: TMenuItem;
    N3: TMenuItem;
    Buffet1: TMenuItem;
    Pizzaria1: TMenuItem;
    PrVendaBalco1: TMenuItem;
    N37: TMenuItem;
    Frente1: TMenuItem;
    Retaguarda1: TMenuItem;
    RetaguardaWEB1: TMenuItem;
    Comanda1: TMenuItem;
    Consignao1: TMenuItem;
    MnuTafAjtEstOper: TMenuItem;
    MnuTafCpaOper: TMenuItem;
    MnuTafOVSOper: TMenuItem;
    PedidodeVendaLojaVirtual1: TMenuItem;
    PedidodeVendaRemoto1: TMenuItem;
    Controledelotes1: TMenuItem;
    ControledeSries1: TMenuItem;
    N30: TMenuItem;
    NotasFiscaisConsumidor1: TMenuItem;
    NotasFiscaisdeServio1: TMenuItem;
    ControleSequenciaNotas1: TMenuItem;
    N28: TMenuItem;
    ManutenoVeculos1: TMenuItem;
    N38: TMenuItem;
    ManuteoFrotaPrpria1: TMenuItem;
    N52: TMenuItem;
    OrdemdeSerioExtintores1: TMenuItem;
    EnsariodeFuncionamento1: TMenuItem;
    N20: TMenuItem;
    Despacho1: TMenuItem;
    Conferncia1: TMenuItem;
    AssistnciaTcnica1: TMenuItem;
    CRMClientes1: TMenuItem;
    MalaDiretaemail1: TMenuItem;
    N11: TMenuItem;
    nalisemovimentaoprodutos1: TMenuItem;
    ControleEstpqueZerado1: TMenuItem;
    AnlisedeNegcios1: TMenuItem;
    N39: TMenuItem;
    OrdensdeProduo1: TMenuItem;
    ManifestodeFrete1: TMenuItem;
    N43: TMenuItem;
    AgendaSalo1: TMenuItem;
    N44: TMenuItem;
    ControleBasedeTroca1: TMenuItem;
    N46: TMenuItem;
    ManutenoEletrnicos1: TMenuItem;
    N47: TMenuItem;
    AtendimetoPet1: TMenuItem;
    N49: TMenuItem;
    Moveleiro1: TMenuItem;
    N51: TMenuItem;
    Grfica1: TMenuItem;
    MnuRelOper: TMenuItem;
    MnuRelClienteOper: TMenuItem;
    EtiquetasMalaDireta1: TMenuItem;
    N27: TMenuItem;
    Extintores2: TMenuItem;
    AgenteExtintor1: TMenuItem;
    VencimentoExtintores1: TMenuItem;
    ResumoSelos1: TMenuItem;
    N34: TMenuItem;
    MnuRelProdOper: TMenuItem;
    EtiquetasProdutos1: TMenuItem;
    N12: TMenuItem;
    Ajustes1: TMenuItem;
    MnuRelVdaOper: TMenuItem;
    MnuRelCpaOper: TMenuItem;
    N25: TMenuItem;
    Produo1: TMenuItem;
    MapaProduo1: TMenuItem;
    N32: TMenuItem;
    Notas1: TMenuItem;
    Oramento1: TMenuItem;
    OrdemdeServio1: TMenuItem;
    MnuRelMpCrgOper: TMenuItem;
    N4: TMenuItem;
    Fechamento1: TMenuItem;
    MnuAjdOper: TMenuItem;
    MnuMhaEmpOper: TMenuItem;
    LojaVirtual1: TMenuItem;
    N40: TMenuItem;
    Contabilidade1: TMenuItem;
    NotaFiscalEletrnica1: TMenuItem;
    Venda1: TMenuItem;
    Servico1: TMenuItem;
    Sintegra1: TMenuItem;
    EFDPISCOFINS1: TMenuItem;
    SPEDFiscal1: TMenuItem;
    N35: TMenuItem;
    MnuAjdManuUsuOper: TMenuItem;
    Perfil2: TMenuItem;
    Interface1: TMenuItem;
    Perfil1: TMenuItem;
    MnuAjdTrShaOper: TMenuItem;
    N36: TMenuItem;
    Impressoras1: TMenuItem;
    N41: TMenuItem;
    MnuAjdCfgNFOper: TMenuItem;
    Configuraes1: TMenuItem;
    Ifood1: TMenuItem;
    WhatsApp1: TMenuItem;
    ConfiguraesLocais1: TMenuItem;
    N42: TMenuItem;
    Aniversariantes1: TMenuItem;
    LogPedidos1: TMenuItem;
    LogOramento1: TMenuItem;
    LogdeOperaes1: TMenuItem;
    N7: TMenuItem;
    MnuAjdManuBkpOper: TMenuItem;
    Sincronia1: TMenuItem;
    CpiaBDados1: TMenuItem;
    Atualizao1: TMenuItem;
    readeTestes1: TMenuItem;
    Desenvolvimento1: TMenuItem;
    ConectaBanco1: TMenuItem;
    N18: TMenuItem;
    AlteraesnoSistema1: TMenuItem;
    Voltaraversoanterior1: TMenuItem;
    BaixarAtualizador1: TMenuItem;
    MnuAjdSobreOper: TMenuItem;
    ListaTerminais: TMenuItem;
    MenuOperMenuFiscal: TMenuItem;
    MnuFin: TMainMenu;
    MnuArqFin: TMenuItem;
    MnuArqFPagtoFin: TMenuItem;
    Prazos1: TMenuItem;
    NaturezaCFOP1: TMenuItem;
    MnuArqPlCtaFin: TMenuItem;
    N2: TMenuItem;
    MnuArqSairFin: TMenuItem;
    MnuModFin: TMenuItem;
    MnuModOpeFin: TMenuItem;
    MnuModBanFin: TMenuItem;
    MnuModAnalFin: TMenuItem;
    Pessoal2: TMenuItem;
    MnuTafFin: TMenuItem;
    MnuTafManuDupFin: TMenuItem;
    FichaFinCliente1: TMenuItem;
    DescontarDuplicata1: TMenuItem;
    ControledeBoletos1: TMenuItem;
    N14: TMenuItem;
    MnuTafManuPagFin: TMenuItem;
    FichaFinanceiraFornecedor1: TMenuItem;
    N8: TMenuItem;
    MnuTafCtrlChqFin: TMenuItem;
    N29: TMenuItem;
    MnuTafLanCxaFin: TMenuItem;
    BaixaporLote1: TMenuItem;
    N33: TMenuItem;
    FechametoFinanceiro1: TMenuItem;
    MnuRelFin: TMenuItem;
    MnuRelCtaRbrFin: TMenuItem;
    MnuRelCtrlChqFin: TMenuItem;
    N10: TMenuItem;
    MnuRelCtaPgrFin: TMenuItem;
    MnuRelLanCxaFin: TMenuItem;
    Gerencial1: TMenuItem;
    N23: TMenuItem;
    FluxodeCaixa1: TMenuItem;
    Duplicatas1: TMenuItem;
    Lucratividade1: TMenuItem;
    MenuFinMenuFiscal: TMenuItem;
    MnuBco: TMainMenu;
    MnuArqBco: TMenuItem;
    MnuArqBancoBco: TMenuItem;
    MnuArqContaBco: TMenuItem;
    MnuArqHistBco: TMenuItem;
    CartoEletrnico1: TMenuItem;
    BoletoEletronico1: TMenuItem;
    N5: TMenuItem;
    MnuArqSairBco: TMenuItem;
    MnuModBco: TMenuItem;
    MnuModFinBco: TMenuItem;
    MnuModOperBco: TMenuItem;
    MnuModAnalBco: TMenuItem;
    Pessoal3: TMenuItem;
    MnuTafBco: TMenuItem;
    MnuTafLacBco: TMenuItem;
    MnuRelBco: TMenuItem;
    MnuRelLancBco: TMenuItem;
    MnuRelExtrato: TMenuItem;
    MenuBcoMenuFiscal: TMenuItem;
    MnuPsl: TMainMenu;
    MnuPslArquivo: TMenuItem;
    MnuPslArqColaborador: TMenuItem;
    MnuPslArqCargo: TMenuItem;
    MenuItem4: TMenuItem;
    MnuPslArqSair: TMenuItem;
    MnuPslModulos: TMenuItem;
    MnuPslFinanceiro: TMenuItem;
    MnuPslOperacao: TMenuItem;
    MnuPslBancario: TMenuItem;
    MnuPslTarefas: TMenuItem;
    MnuPslTarFolhaPagamento: TMenuItem;
    MnuPslTarManutencaoComissao: TMenuItem;
    MnuPslTarVales: TMenuItem;
    MnuPslRelatorios: TMenuItem;
    MnuPslRelColaborador: TMenuItem;
    MenuItem19: TMenuItem;
    MnuPslRelComissao: TMenuItem;
    MnuPslRelVales: TMenuItem;
    MenuPslMenuFiscal: TMenuItem;
    MnuPslArqUsuario: TMenuItem;
    procedure MnuModOpeFinClick(Sender: TObject);
    procedure MnuModOperBcoClick(Sender: TObject);
    procedure MnuPslOperacaoClick(Sender: TObject);
    procedure MnuModBancoOperClick(Sender: TObject);
    procedure MnuModBanFinClick(Sender: TObject);
    procedure MnuPslBancarioClick(Sender: TObject);
    procedure MnuModFinOperClick(Sender: TObject);
    procedure MnuModFinBcoClick(Sender: TObject);
    procedure MnuPslFinanceiroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pessoal1Click(Sender: TObject);
    procedure Pessoal2Click(Sender: TObject);
    procedure Pessoal3Click(Sender: TObject);
    procedure MnuPslArqCargoClick(Sender: TObject);
    procedure MnuPslArqUsuarioClick(Sender: TObject);
  private
    procedure MenuOperacao;
    procedure MenuBanco;
    procedure MenuFinanceiro;
    procedure MenuPessoal;

    procedure InitVariable;
  public
    { Public declarations }
  end;

var
  FrMain: TFrMain;
  GB_NM_Empresa : String;
  Gb_CodMha : Integer;
  Gb_Nivel : Integer;
  Gb_Cd_Usuario : Integer;
  GB_Nm_Usuario : String;
  Gb_Senha : String;
  Gb_Cd_Vendedor : Integer;
  Gb_Liberado : Boolean;
  Gb_DataCaixa : TDateTime;
  Gb_PAF_NFE_e : Boolean;

implementation

{$R *.dfm}

uses un_dm, sea_job_position, sea_users;

{ TForm1 }

procedure TFrMain.MnuPslArqCargoClick(Sender: TObject);
Var
  Lc_form : TSeaJobPosition;
begin
  Try
    Lc_form := TSeaJobPosition.Create(Self);
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

procedure TFrMain.MnuPslArqUsuarioClick(Sender: TObject);
begin
  with TSeaUsers.Create(Self) do
  Try
    ShowModal;
  Finally
    Free;
  End;
end;

procedure TFrMain.MnuPslBancarioClick(Sender: TObject);
begin
  MenuBanco
end;

procedure TFrMain.MnuPslFinanceiroClick(Sender: TObject);
begin
  MenuFinanceiro;
end;

procedure TFrMain.MnuPslOperacaoClick(Sender: TObject);
begin
  MenuOperacao;
end;

procedure TFrMain.Pessoal1Click(Sender: TObject);
begin
  MenuPessoal
end;

procedure TFrMain.Pessoal2Click(Sender: TObject);
begin
  MenuPessoal;
end;

procedure TFrMain.Pessoal3Click(Sender: TObject);
begin
  MenuPessoal;
end;

procedure TFrMain.MnuModBancoOperClick(Sender: TObject);
begin
  MenuBanco
end;

procedure TFrMain.MnuModBanFinClick(Sender: TObject);
begin
  MenuBanco
end;

procedure TFrMain.MnuModFinBcoClick(Sender: TObject);
begin
  MenuFinanceiro
end;

procedure TFrMain.MnuModFinOperClick(Sender: TObject);
begin
  MenuFinanceiro
end;

procedure TFrMain.MnuModOpeFinClick(Sender: TObject);
begin
  MenuOperacao;
end;

procedure TFrMain.MnuModOperBcoClick(Sender: TObject);
begin
  MenuOperacao;
end;

procedure TFrMain.FormShow(Sender: TObject);
begin
  InitVariable;
end;

procedure TFrMain.InitVariable;
begin
  MenuOperacao;
  GB_NM_Empresa := 'Teste';
  Gb_Nivel := 1;//Setado como 1 por que no sistema original passamos pelo autenticação para defini-lo
end;

procedure TFrMain.MenuBanco;
begin
  caption := 'Gestão Empresarial - Módulo Bancário - ' + GB_NM_Empresa;
  menu := MnuBco;
  hint := 'Módulo Bancário';

end;

procedure TFrMain.MenuFinanceiro;
begin
  caption := 'Gestão Empresarial - Módulo Financeiro - ' + GB_NM_Empresa;
  menu := MnuFin;
  hint := 'Módulo Financeiro';

end;

procedure TFrMain.MenuOperacao;
begin
  caption := 'Gestão Empresarial - Módulo De operação - ' + GB_NM_Empresa;
  menu := MnuOper;
  hint := 'Módulo de operação';

end;

procedure TFrMain.MenuPessoal;
begin
  caption := 'Gestão Empresarial - Módulo de Pessoal - ' + GB_NM_Empresa;
  menu := MnuPsl;
  hint := 'Módulo de Pessoal';

end;

end.
