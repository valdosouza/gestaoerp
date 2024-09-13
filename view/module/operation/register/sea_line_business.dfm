inherited SeaLineBusiness: TSeaLineBusiness
  Caption = 'Pesquisa de Ramo de Atividade'
  ClientHeight = 281
  ClientWidth = 586
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 602
  ExplicitHeight = 340
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 61
    Width = 580
    Height = 217
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 61
    ExplicitWidth = 580
    ExplicitHeight = 217
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 576
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 484
      Height = 199
    end
    inherited pnl_pesq_right: TPanel
      Left = 486
      Height = 199
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 486
      ExplicitHeight = 199
      inherited Sb_Sair_0: TSpeedButton
        Top = 152
        Height = 44
        ExplicitLeft = 3
        ExplicitTop = 232
        ExplicitWidth = 86
        ExplicitHeight = 44
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 104
        Height = 45
        ExplicitLeft = 3
        ExplicitTop = 168
        ExplicitWidth = 86
        ExplicitHeight = 45
      end
      inherited SB_Buscar: TSpeedButton
        Top = 55
        Height = 46
        ExplicitLeft = 3
        ExplicitTop = 104
        ExplicitWidth = 86
        ExplicitHeight = 46
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 5
        Height = 47
        ExplicitLeft = 3
        ExplicitTop = 40
        ExplicitWidth = 86
        ExplicitHeight = 47
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 580
    Height = 52
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 580
    ExplicitHeight = 52
    object L_BuscaCodigo: TLabel
      Left = 10
      Top = 2
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
      Left = 65
      Top = 2
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
    object E_BuscaDescricao: TEdit
      Left = 65
      Top = 16
      Width = 492
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
    object E_BuscaCodigo: TEdit
      Left = 10
      Top = 16
      Width = 49
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
  inherited MnuBase: TMainMenu
    Left = 216
  end
end
