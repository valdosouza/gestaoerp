inherited SeaCollaborator: TSeaCollaborator
  Caption = 'Pesquisa de Colaborador'
  ClientWidth = 663
  ExplicitWidth = 675
  ExplicitHeight = 561
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 136
    Width = 657
    Height = 359
    ExplicitTop = 136
    ExplicitWidth = 651
    ExplicitHeight = 350
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 653
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 561
      Height = 341
    end
    inherited pnl_pesq_right: TPanel
      Left = 563
      Height = 341
      ExplicitLeft = 557
      ExplicitHeight = 332
      inherited Sb_Sair_0: TSpeedButton
        Top = 278
        ExplicitTop = 279
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 215
        ExplicitTop = 216
      end
      inherited SB_Buscar: TSpeedButton
        Top = 152
        ExplicitTop = 153
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 89
        ExplicitTop = 90
      end
      object Chbx_Demitidos: TCheckBox
        Left = 12
        Top = 11
        Width = 80
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Demitidos'
        TabOrder = 0
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 657
    Height = 127
    ExplicitWidth = 651
    ExplicitHeight = 127
    object GroupBox1: TGroupBox
      Left = 2
      Top = 52
      Width = 653
      Height = 59
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 647
      object Lb_CPF: TLabel
        Left = 8
        Top = 16
        Width = 24
        Height = 14
        Caption = 'C.P.F'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Nome: TLabel
        Left = 127
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Nome '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Cargo: TLabel
        Left = 390
        Top = 16
        Width = 29
        Height = 14
        Caption = 'Cargo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCPF: TEdit
        Left = 5
        Top = 32
        Width = 116
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_BuscaNome: TEdit
        Left = 121
        Top = 32
        Width = 266
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_BuscaCargo: TEdit
        Left = 387
        Top = 32
        Width = 254
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object Grb_MnhaEmpresa: TGroupBox
      Left = 2
      Top = 2
      Width = 653
      Height = 50
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 647
      DesignSize = (
        653
        50)
      object chbx_Empresas: TCheckBox
        Left = 7
        Top = 8
        Width = 165
        Height = 14
        Caption = 'Selecionar todas as Empresas'
        TabOrder = 0
      end
      object Dblcb_Mha_Empresa: TComboBox
        Left = 5
        Top = 24
        Width = 639
        Height = 22
        Anchors = [akLeft, akRight]
        TabOrder = 1
        ExplicitWidth = 633
      end
    end
  end
end