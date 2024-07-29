inherited SeaProfile: TSeaProfile
  Caption = 'Pesquisa de Perfil'
  ClientHeight = 291
  ClientWidth = 574
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 586
  ExplicitHeight = 354
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 568
    Height = 217
    ExplicitWidth = 861
    ExplicitHeight = 371
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 564
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 472
      Height = 199
    end
    inherited pnl_pesq_right: TPanel
      Left = 474
      Height = 199
      ExplicitLeft = 767
      ExplicitHeight = 353
      inherited Sb_Sair_0: TSpeedButton
        Top = 148
        Height = 48
        ExplicitLeft = 3
        ExplicitTop = 185
        ExplicitWidth = 86
        ExplicitHeight = 48
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 98
        Height = 47
        ExplicitLeft = 3
        ExplicitTop = 122
        ExplicitWidth = 86
        ExplicitHeight = 47
      end
      inherited SB_Buscar: TSpeedButton
        Top = 49
        Height = 46
        ExplicitLeft = 3
        ExplicitTop = 59
        ExplicitWidth = 86
        ExplicitHeight = 46
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -7
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = -4
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 568
    Height = 62
    ExplicitWidth = 568
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 564
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
      ExplicitLeft = 4
      ExplicitTop = 10
      ExplicitWidth = 863
      object L_BuscaDescricao: TLabel
        Left = 59
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
      object L_Codigo: TLabel
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
      object E_BuscaDescricao: TEdit
        Left = 59
        Top = 32
        Width = 492
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
      object E_BuscaCodigo: TEdit
        Left = 7
        Top = 32
        Width = 49
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
    end
  end
end
