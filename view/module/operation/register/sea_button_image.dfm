inherited SeaButtonImage: TSeaButtonImage
  Caption = 'Pesquisa de Bot'#227'o'
  ClientHeight = 286
  ClientWidth = 653
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 669
  ExplicitHeight = 345
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 647
    Height = 212
    StyleElements = [seFont, seClient, seBorder]
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 643
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 551
      Height = 194
    end
    inherited pnl_pesq_right: TPanel
      Left = 553
      Height = 194
      StyleElements = [seFont, seClient, seBorder]
      inherited Sb_Sair_0: TSpeedButton
        Top = 141
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 180
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 88
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 117
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Buscar: TSpeedButton
        Top = 35
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 54
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -18
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = -9
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 647
    Height = 62
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 62
    object L_buscaCodigo: TLabel
      Left = 10
      Top = 16
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_BuscaDescricao: TLabel
      Left = 90
      Top = 16
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
      Left = 7
      Top = 32
      Width = 77
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
    object E_BuscaDescricao: TEdit
      Left = 90
      Top = 32
      Width = 548
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
  end
end
