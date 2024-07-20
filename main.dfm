inherited FrMain: TFrMain
  Caption = 'Sistema de Gest'#227'o Empresarial'
  ClientHeight = 587
  ClientWidth = 1199
  Menu = MnuPsl
  ExplicitWidth = 1205
  ExplicitHeight = 636
  PixelsPerInch = 96
  TextHeight = 13
  inherited Menu: TMainMenu
    Left = 24
    Top = 16
  end
  object MnuOper: TMainMenu
    Left = 104
    Top = 18
    object MnuArqOpe: TMenuItem
      Caption = '&Arquivo'
      Hint = 'Cadastros em Geral'
      object MnuArqClienteoOper: TMenuItem
        Caption = '&Clientes'
      end
      object CientesemProspeco1: TMenuItem
        Caption = 'Clientes em Prospec'#231#227'o'
      end
      object MnuArqFornOper: TMenuItem
        Caption = '&Fornecedores'
      end
      object MnuArqTranspOper: TMenuItem
        Caption = 'Transportadora'
      end
      object Representada1: TMenuItem
        Caption = 'Representada'
      end
      object Contatos1: TMenuItem
        Caption = 'Contatos'
      end
      object MnuRamodeAtividade: TMenuItem
        Caption = 'Ramo de Atividade'
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object Cidades1: TMenuItem
        Caption = 'Ci&dades'
      end
      object Estados1: TMenuItem
        Caption = '&Estados'
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MnuArqCadSrvOper: TMenuItem
        Caption = 'Cadastro &Servi'#231'os'
      end
      object ipoVeculo1: TMenuItem
        Caption = 'Tipo Ve'#237'culo'
      end
      object MarcasModelos1: TMenuItem
        Caption = 'Marcas/Modelos'
      end
      object Veculos1: TMenuItem
        Caption = 'Ve'#237'culos'
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object AgenteExtintor2: TMenuItem
        Caption = 'Agente Extintor'
      end
      object Ensaiador1: TMenuItem
        Caption = 'Ensaiador'
      end
      object ipoExtintor1: TMenuItem
        Caption = 'Tipo Extintor'
      end
      object MotivoCondenaoReprovao1: TMenuItem
        Caption = 'Motivo Condena'#231#227'o/Reprova'#231#227'o'
        OnClick = MotivoCondenaoReprovao1Click
      end
      object NvelManunteo1: TMenuItem
        Caption = 'N'#237'vel Manuten'#231#227'o'
      end
      object Extintores1: TMenuItem
        Caption = 'Extintores'
      end
      object Selos1: TMenuItem
        Caption = 'Selos'
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Boto1: TMenuItem
        Caption = 'Bot'#227'o'
      end
      object Medidas1: TMenuItem
        Caption = 'Medidas'
      end
      object Embalagens1: TMenuItem
        Caption = 'Embalagens'
      end
      object Marcas1: TMenuItem
        Caption = 'Marcas'
      end
      object MnuArqGpPdOper: TMenuItem
        Caption = '&Grupos e SubGrupos'
      end
      object MnuArqCadProdOper: TMenuItem
        Caption = 'Cadastro &Produtos'
      end
      object TabelasdePreco: TMenuItem
        Caption = 'Tabelas de Pre'#231'o'
      end
      object Estoques1: TMenuItem
        Caption = 'Estoques'
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Cardpio1: TMenuItem
        Caption = 'Card'#225'pio'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Equipamentos1: TMenuItem
        Caption = 'Equipamentos'
      end
      object N45: TMenuItem
        Caption = '-'
      end
      object Pets1: TMenuItem
        Caption = 'Pets'
      end
      object N48: TMenuItem
        Caption = '-'
      end
      object Contratos1: TMenuItem
        Caption = 'Contratos'
      end
      object N50: TMenuItem
        Caption = '-'
      end
      object ributao1: TMenuItem
        Caption = 'Tributa'#231#227'o'
      end
      object Observao1: TMenuItem
        Caption = 'Observa'#231#227'o'
      end
      object Situao1: TMenuItem
        Caption = 'Situa'#231#245'es'
      end
      object OrigemdaVenda1: TMenuItem
        Caption = 'Origem da Venda'
      end
      object OrigemdoCliente1: TMenuItem
        Caption = 'Origem do Cliente'
      end
      object N31: TMenuItem
        Caption = '-'
      end
      object MnuArqSairOper: TMenuItem
        Caption = '&Sair'
      end
    end
    object MnuModOper: TMenuItem
      Caption = '&M'#243'dulos'
      Hint = 'Transite entre os M'#243'dulos'
      object MnuModFinOper: TMenuItem
        Caption = '&Financeiro'
        OnClick = MnuModFinOperClick
      end
      object MnuModBancoOper: TMenuItem
        Caption = '&Banc'#225'rio'
        OnClick = MnuModBancoOperClick
      end
      object MnuModAnalOper: TMenuItem
        Caption = 'Analise'
        Visible = False
      end
      object Pessoal1: TMenuItem
        Caption = 'Pessoal'
        OnClick = Pessoal1Click
      end
    end
    object MnuTafOper: TMenuItem
      Caption = '&Tarefas'
      Hint = 'Atividades para Este M'#243'dulo'
      object ImportarXMLdaNFe1: TMenuItem
        Caption = 'Importar XML da NF-e'
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object MnuRecibo: TMenuItem
        Caption = 'Recibo'
        OnClick = MnuReciboClick
      end
      object AjustaPreo1: TMenuItem
        Caption = 'Ajusta Pre'#231'o'
      end
      object Promoes1: TMenuItem
        Caption = 'Promo'#231#245'es'
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object EstoqueManual1: TMenuItem
        Caption = 'Estoque Manual'
      end
      object InventrioManual1: TMenuItem
        Caption = 'Invent'#225'rio Manual'
      end
      object InventrioAutomtico1: TMenuItem
        Caption = 'Invent'#225'rio Autom'#225'tico'
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MnuTafTrfOper: TMenuItem
        Caption = 'Or'#231'amento'
      end
      object ConsultaConserto1: TMenuItem
        Caption = 'Consulta Conserto'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Buffet1: TMenuItem
        Caption = 'Buffet'
      end
      object Pizzaria1: TMenuItem
        Caption = 'Pizzaria'
      end
      object PrVendaBalco1: TMenuItem
        Caption = 'Pr'#233'-Venda Balc'#227'o'
      end
      object N37: TMenuItem
        Caption = '-'
      end
      object Frente1: TMenuItem
        Caption = 'Frente de Caixa'
      end
      object Retaguarda1: TMenuItem
        Caption = 'Retaguarda'
      end
      object RetaguardaWEB1: TMenuItem
        Caption = 'Retaguarda WEB'
      end
      object Comanda1: TMenuItem
        Caption = 'Comanda'
      end
      object Consignao1: TMenuItem
        Caption = 'Consigna'#231#227'o'
      end
      object MnuTafAjtEstOper: TMenuItem
        Caption = '&Ajuste do Estoque'
      end
      object MnuTafCpaOper: TMenuItem
        Caption = 'Pedido de Compra'
      end
      object MnuTafOVSOper: TMenuItem
        Caption = '&Pedido de Venda'
      end
      object PedidodeVendaLojaVirtual1: TMenuItem
        Caption = 'Pedido de Venda Loja Virtual'
      end
      object PedidodeVendaRemoto1: TMenuItem
        Caption = 'Pedido de Venda Remoto'
      end
      object Controledelotes1: TMenuItem
        Caption = 'Controle de lotes'
      end
      object ControledeSries1: TMenuItem
        Caption = 'Controle de S'#233'ries'
      end
      object N30: TMenuItem
        Caption = '-'
      end
      object NotasFiscaisConsumidor1: TMenuItem
        Caption = 'Notas Fiscais de Produtos'
      end
      object NotasFiscaisdeServio1: TMenuItem
        Caption = 'Notas Fiscais de Servi'#231'o'
      end
      object ControleSequenciaNotas1: TMenuItem
        Caption = 'Controle Sequencia Notas'
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object ManutenoVeculos1: TMenuItem
        Caption = 'Manuten'#231#227'o Ve'#237'culos'
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object ManuteoFrotaPrpria1: TMenuItem
        Caption = 'Manute'#231#227'o Frota Pr'#243'pria'
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object OrdemdeSerioExtintores1: TMenuItem
        Caption = 'Manuten'#231#227'o Extintores'
      end
      object EnsariodeFuncionamento1: TMenuItem
        Caption = 'Ensaio de Funcionamento'
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Despacho1: TMenuItem
        Caption = 'Despacho de Mercadorias'
      end
      object Conferncia1: TMenuItem
        Caption = 'Confer'#234'ncia'
      end
      object AssistnciaTcnica1: TMenuItem
        Caption = 'Assist'#234'ncia T'#233'cnica'
      end
      object CRMClientes1: TMenuItem
        Caption = 'CRM - Clientes'
      end
      object MalaDiretaemail1: TMenuItem
        Caption = 'Mala Direta - e-mail'
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object nalisemovimentaoprodutos1: TMenuItem
        Caption = 'An'#225'lise movimenta'#231#227'o produtos'
      end
      object ControleEstpqueZerado1: TMenuItem
        Caption = 'Controle estoque zerado'
      end
      object AnlisedeNegcios1: TMenuItem
        Caption = 'An'#225'lise de Neg'#243'cios'
      end
      object N39: TMenuItem
        Caption = '-'
      end
      object OrdensdeProduo1: TMenuItem
        Caption = 'Ordens de Produ'#231#227'o'
      end
      object ManifestodeFrete1: TMenuItem
        Caption = 'Manifesto de Frete'
      end
      object N43: TMenuItem
        Caption = '-'
      end
      object AgendaSalo1: TMenuItem
        Caption = 'Agendamentos'
      end
      object N44: TMenuItem
        Caption = '-'
      end
      object ControleBasedeTroca1: TMenuItem
        Caption = 'Controle Base de Troca'
      end
      object N46: TMenuItem
        Caption = '-'
      end
      object ManutenoEletrnicos1: TMenuItem
        Caption = 'Manuten'#231#227'o Eletr'#244'nicos'
      end
      object N47: TMenuItem
        Caption = '-'
      end
      object AtendimetoPet1: TMenuItem
        Caption = 'Atendimeto Pet'
      end
      object N49: TMenuItem
        Caption = '-'
      end
      object Moveleiro1: TMenuItem
        Caption = 'Moveleiro'
      end
      object N51: TMenuItem
        Caption = '-'
      end
      object Grfica1: TMenuItem
        Caption = 'Gr'#225'fica'
      end
    end
    object MnuRelOper: TMenuItem
      Caption = '&Relat'#243'rios'
      object MnuRelClienteOper: TMenuItem
        Caption = 'Empresas'
      end
      object EtiquetasMalaDireta1: TMenuItem
        Caption = 'Etiquetas Mala Direta'
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object Extintores2: TMenuItem
        Caption = 'Extintores'
      end
      object AgenteExtintor1: TMenuItem
        Caption = 'Agente Extintor'
      end
      object VencimentoExtintores1: TMenuItem
        Caption = 'Vencimento Extintores'
      end
      object ResumoSelos1: TMenuItem
        Caption = 'Resumo/Selos'
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object MnuRelProdOper: TMenuItem
        Caption = 'Produtos'
      end
      object EtiquetasProdutos1: TMenuItem
        Caption = 'Etiquetas Produtos'
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Ajustes1: TMenuItem
        Caption = 'Ajustes'
      end
      object MnuRelVdaOper: TMenuItem
        Caption = 'Vendas'
      end
      object MnuRelCpaOper: TMenuItem
        Caption = 'Compras'
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Produo1: TMenuItem
        Caption = 'Produ'#231#227'o'
      end
      object MapaProduo1: TMenuItem
        Caption = 'Mapa Produ'#231#227'o'
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object Notas1: TMenuItem
        Caption = 'Notas'
      end
      object Oramento1: TMenuItem
        Caption = 'Or'#231'amento'
      end
      object OrdemdeServio1: TMenuItem
        Caption = 'Ordem de Servi'#231'o'
      end
      object MnuRelMpCrgOper: TMenuItem
        Caption = 'Mapa Carregamento'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Fechamento1: TMenuItem
        Caption = 'Fechamento'
      end
    end
    object MnuAjdOper: TMenuItem
      Caption = 'A&dministra'#231#227'o'
      object MnuMhaEmpOper: TMenuItem
        Caption = 'Minha Empresa'
      end
      object LojaVirtual1: TMenuItem
        Caption = 'Loja Virtual'
        OnClick = LojaVirtual1Click
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object Compromissos1: TMenuItem
        Caption = 'Compromissos'
        OnClick = Compromissos1Click
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Contabilidade1: TMenuItem
        Caption = 'Contabilidade'
      end
      object NotaFiscalEletrnica1: TMenuItem
        Caption = 'Nota Fiscal Eletr'#244'nica'
        object Venda1: TMenuItem
          Caption = 'Venda'
        end
        object Servico1: TMenuItem
          Caption = 'Servico'
        end
      end
      object Sintegra1: TMenuItem
        Caption = 'Sintegra'
      end
      object EFDPISCOFINS1: TMenuItem
        Caption = 'SPED-Pis/Cofins'
      end
      object SPEDFiscal1: TMenuItem
        Caption = 'SPED-Fiscal'
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object MnuAjdManuUsuOper: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = MnuAjdManuUsuOperClick
      end
      object Perfil2: TMenuItem
        Caption = 'Perfil do Usu'#225'rio'
      end
      object Interface1: TMenuItem
        Caption = 'Interface'
      end
      object Perfil1: TMenuItem
        Caption = 'Opera'#231#227'o da Interface'
      end
      object MnuAjdTrShaOper: TMenuItem
        Caption = 'Troca de Senha'
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object Impressoras1: TMenuItem
        Caption = 'Impressoras'
        OnClick = Impressoras1Click
      end
      object N41: TMenuItem
        Caption = '-'
      end
      object MnuAjdCfgNFOper: TMenuItem
        Caption = 'Configura'#231#245'es'
        object Configuraes1: TMenuItem
          Caption = 'Geral'
        end
        object Ifood1: TMenuItem
          Caption = 'Ifood'
        end
        object WhatsApp1: TMenuItem
          Caption = 'WhatsApp'
        end
      end
      object ConfiguraesLocais1: TMenuItem
        Caption = 'Configura'#231#245'es Locais'
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object Aniversariantes1: TMenuItem
        Caption = 'Aniversariantes'
      end
      object LogPedidos1: TMenuItem
        Caption = 'Log Pedidos'
      end
      object LogOramento1: TMenuItem
        Caption = 'Log Or'#231'amentos'
      end
      object LogdeOperaes1: TMenuItem
        Caption = 'Log de Opera'#231#245'es'
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MnuAjdManuBkpOper: TMenuItem
        Caption = 'Backup'
      end
      object Sincronia1: TMenuItem
        Caption = 'Sincronia'
      end
      object CpiaBDados1: TMenuItem
        Caption = 'Copia Banco de Dados'
      end
      object Atualizao1: TMenuItem
        Caption = 'Atualiza'#231#227'o'
      end
      object readeTestes1: TMenuItem
        Caption = #193'rea de Testes'
      end
      object Desenvolvimento1: TMenuItem
        Caption = 'Desenvolvimento'
      end
      object ConectaBanco1: TMenuItem
        Caption = 'Conecta Banco'
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object AlteraesnoSistema1: TMenuItem
        Caption = 'Altera'#231#245'es no Sistema'
      end
      object Voltaraversoanterior1: TMenuItem
        Caption = 'Voltar a vers'#227'o anterior'
      end
      object BaixarAtualizador1: TMenuItem
        Caption = 'Baixar Atualizador'
      end
      object MnuAjdSobreOper: TMenuItem
        Caption = 'Sobre'
      end
      object ListaTerminais: TMenuItem
        Caption = 'Lista Terminais'
      end
    end
    object MenuOperMenuFiscal: TMenuItem
      Caption = '| Menu Fiscal - Ctrl + F6 |'
      ShortCut = 16501
    end
  end
  object MnuFin: TMainMenu
    Left = 164
    Top = 18
    object MnuArqFin: TMenuItem
      Caption = '&Arquivo'
      object MnuArqFPagtoFin: TMenuItem
        Caption = 'Formas de Pagto'
      end
      object Prazos1: TMenuItem
        Caption = 'Prazos'
      end
      object NaturezaCFOP1: TMenuItem
        Caption = 'Natureza CFOP'
      end
      object MnuArqPlCtaFin: TMenuItem
        Caption = '&Plano de Contas'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MnuArqSairFin: TMenuItem
        Caption = '&Sair'
      end
    end
    object MnuModFin: TMenuItem
      Caption = '&M'#243'dulos'
      Hint = 'Transite entre os M'#243'dulos'
      object MnuModOpeFin: TMenuItem
        Caption = '&Opera'#231#227'o'
        OnClick = MnuModOpeFinClick
      end
      object MnuModBanFin: TMenuItem
        Caption = '&Banc'#225'rio'
        OnClick = MnuModBanFinClick
      end
      object MnuModAnalFin: TMenuItem
        Caption = 'An'#225'lise'
        Visible = False
      end
      object Pessoal2: TMenuItem
        Caption = 'Pessoal'
        OnClick = Pessoal2Click
      end
    end
    object MnuTafFin: TMenuItem
      Caption = '&Tarefas'
      Hint = 'Atividades para Este M'#243'dulo'
      object MnuTafManuDupFin: TMenuItem
        Caption = 'Contas a Receber'
      end
      object FichaFinCliente1: TMenuItem
        Caption = 'Ficha Financeira Cliente'
      end
      object DescontarDuplicata1: TMenuItem
        Caption = 'Descontar Duplicata'
      end
      object ControledeBoletos1: TMenuItem
        Caption = 'Controle de Boletos'
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object MnuTafManuPagFin: TMenuItem
        Caption = 'Contas a Pagar'
      end
      object FichaFinanceiraFornecedor1: TMenuItem
        Caption = 'Ficha Financeira Fornecedor'
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MnuTafCtrlChqFin: TMenuItem
        Caption = 'Controle de Cheques'
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object MnuTafLanCxaFin: TMenuItem
        Caption = '&Lan'#231'amento Caixa'
      end
      object BaixaporLote1: TMenuItem
        Caption = 'Baixa por Lote'
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object FechametoFinanceiro1: TMenuItem
        Caption = 'Fechamento Financeiro'
      end
    end
    object MnuRelFin: TMenuItem
      Caption = '&Relat'#243'rios'
      object MnuRelCtaRbrFin: TMenuItem
        Caption = 'Contas a Receber'
      end
      object MnuRelCtrlChqFin: TMenuItem
        Caption = 'Controle Cheques'
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MnuRelCtaPgrFin: TMenuItem
        Caption = 'Contas a Pagar'
      end
      object MnuRelLanCxaFin: TMenuItem
        Caption = 'Lan'#231'amentos Caixa'
      end
      object Gerencial1: TMenuItem
        Caption = 'Gerencial'
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object FluxodeCaixa1: TMenuItem
        Caption = 'Fluxo de Caixa'
      end
      object Duplicatas1: TMenuItem
        Caption = 'Duplicatas'
      end
      object Lucratividade1: TMenuItem
        Caption = 'Lucratividade'
      end
    end
    object MenuFinMenuFiscal: TMenuItem
      Caption = '| Menu Fiscal - Ctrl + F6 |'
      ShortCut = 16501
    end
  end
  object MnuBco: TMainMenu
    Left = 224
    Top = 26
    object MnuArqBco: TMenuItem
      Caption = '&Arquivo'
      object MnuArqBancoBco: TMenuItem
        Caption = '&Bancos'
      end
      object MnuArqContaBco: TMenuItem
        Caption = 'Con&tas'
      end
      object MnuArqHistBco: TMenuItem
        Caption = '&Hist'#243'ricos'
        OnClick = MnuArqHistBcoClick
      end
      object CartoEletrnico1: TMenuItem
        Caption = 'Cart'#227'o Eletr'#244'nico'
        OnClick = CartoEletrnico1Click
      end
      object CarteiradeCobrana1: TMenuItem
        Caption = 'Carteira de Cobran'#231'a'
        OnClick = CarteiradeCobrana1Click
      end
      object BoletoEletronico1: TMenuItem
        Caption = 'Boleto Eletr'#244'nico'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MnuArqSairBco: TMenuItem
        Caption = '&Sair'
      end
    end
    object MnuModBco: TMenuItem
      Caption = '&M'#243'dulos'
      Hint = 'Transite entre os M'#243'dulos'
      object MnuModFinBco: TMenuItem
        Caption = '&Financeiro'
        OnClick = MnuModFinBcoClick
      end
      object MnuModOperBco: TMenuItem
        Caption = '&Opera'#231#227'o'
        OnClick = MnuModOperBcoClick
      end
      object MnuModAnalBco: TMenuItem
        Caption = 'An'#225'lise'
        Visible = False
      end
      object Pessoal3: TMenuItem
        Caption = 'Pessoal'
        OnClick = Pessoal3Click
      end
    end
    object MnuTafBco: TMenuItem
      Caption = '&Tarefas'
      Hint = 'Atividades para Este M'#243'dulo'
      object MnuTafLacBco: TMenuItem
        Caption = '&Lan'#231'amentos'
      end
    end
    object MnuRelBco: TMenuItem
      Caption = '&Relat'#243'rios'
      object MnuRelLancBco: TMenuItem
        Caption = '&Lan'#231'amentos'
      end
      object MnuRelExtrato: TMenuItem
        Caption = 'Extrato'
      end
    end
    object MenuBcoMenuFiscal: TMenuItem
      Caption = '| Menu Fiscal - Ctrl + F6 |'
      ShortCut = 16501
    end
  end
  object MnuPsl: TMainMenu
    Left = 288
    Top = 26
    object MnuPslArquivo: TMenuItem
      Caption = '&Arquivo'
      object MnuPslArqColaborador: TMenuItem
        Caption = 'Colaborador'
      end
      object MnuPslArqCargo: TMenuItem
        Caption = 'Cargos'
        OnClick = MnuPslArqCargoClick
      end
      object MenuItem4: TMenuItem
        Caption = '-'
      end
      object MnuPslArqSair: TMenuItem
        Caption = '&Sair'
      end
    end
    object MnuPslModulos: TMenuItem
      Caption = '&M'#243'dulos'
      Hint = 'Transite entre os M'#243'dulos'
      object MnuPslFinanceiro: TMenuItem
        Caption = '&Financeiro'
        Visible = False
        OnClick = MnuPslFinanceiroClick
      end
      object MnuPslOperacao: TMenuItem
        Caption = '&Opera'#231#227'o'
        Visible = False
        OnClick = MnuPslOperacaoClick
      end
      object MnuPslBancario: TMenuItem
        Caption = 'Banc'#225'rio'
        Visible = False
        OnClick = MnuPslBancarioClick
      end
    end
    object MnuPslTarefas: TMenuItem
      Caption = '&Tarefas'
      Hint = 'Atividades para Este M'#243'dulo'
      object MnuPslTarFolhaPagamento: TMenuItem
        Caption = '&Folha de Pagamento'
      end
      object MnuPslTarManutencaoComissao: TMenuItem
        Caption = 'Manuten'#231#227'o &Comiss'#245'es'
      end
      object MnuPslTarVales: TMenuItem
        Caption = 'Vales'
      end
    end
    object MnuPslRelatorios: TMenuItem
      Caption = '&Relat'#243'rios'
      object MnuPslRelColaborador: TMenuItem
        Caption = 'Colaborador'
      end
      object MenuItem19: TMenuItem
        Caption = '-'
      end
      object MnuPslRelComissao: TMenuItem
        Caption = 'Comiss'#245'es'
      end
      object MnuPslRelVales: TMenuItem
        Caption = 'Vales'
      end
    end
    object MenuPslMenuFiscal: TMenuItem
      Caption = '| Menu Fiscal - Ctrl + F6 |'
      ShortCut = 16501
    end
  end
end
