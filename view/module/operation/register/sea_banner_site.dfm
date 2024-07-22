inherited SeaBannerSite: TSeaBannerSite
  Caption = 'Pesquisa de Banner para Site'
  ClientHeight = 329
  ClientWidth = 790
  ExplicitWidth = 802
  ExplicitHeight = 392
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 784
    Height = 255
    ExplicitTop = 71
    ExplicitWidth = 778
    ExplicitHeight = 246
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 780
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 688
      Height = 237
    end
    inherited pnl_pesq_right: TPanel
      Left = 690
      Height = 237
      ExplicitLeft = 684
      ExplicitHeight = 228
      inherited Sb_Sair_0: TSpeedButton
        Top = 174
        ExplicitTop = 174
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 111
        ExplicitTop = 111
      end
      inherited SB_Buscar: TSpeedButton
        Top = 48
        ExplicitTop = 48
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -15
        ExplicitTop = -15
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 784
    Height = 62
    ExplicitWidth = 778
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 780
      Height = 61
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 774
      object Lb_Codigo: TLabel
        Left = 5
        Top = 17
        Width = 78
        Height = 14
        Caption = 'C'#243'digos Interno '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Descricao: TLabel
        Left = 157
        Top = 17
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCodigo: TEdit
        Left = 5
        Top = 32
        Width = 144
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
      object E_Busca_Produto: TEdit
        Left = 152
        Top = 32
        Width = 623
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 104
  end
end
