inherited SeaOperInterface: TSeaOperInterface
  Caption = 'Pesquisa de Opera'#231#227'o de Interfaces'
  ClientHeight = 309
  ClientWidth = 573
  ExplicitWidth = 585
  ExplicitHeight = 372
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 567
    Height = 235
    ExplicitTop = 71
    ExplicitWidth = 561
    ExplicitHeight = 226
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 563
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 471
      Height = 217
    end
    inherited pnl_pesq_right: TPanel
      Left = 473
      Height = 217
      ExplicitLeft = 467
      ExplicitHeight = 208
      inherited Sb_Sair_0: TSpeedButton
        Top = 158
        Height = 56
        ExplicitLeft = 3
        ExplicitTop = 185
        ExplicitWidth = 86
        ExplicitHeight = 56
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 108
        Height = 47
        ExplicitLeft = 3
        ExplicitTop = 122
        ExplicitWidth = 86
        ExplicitHeight = 47
      end
      inherited SB_Buscar: TSpeedButton
        Top = 57
        Height = 48
        ExplicitLeft = 3
        ExplicitTop = 73
        ExplicitWidth = 86
        ExplicitHeight = 48
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 1
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = -4
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 567
    Height = 62
    ExplicitWidth = 561
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 563
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
      ExplicitWidth = 557
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
      object L_BuscaCodigo: TLabel
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
