inherited SeaBusiness: TSeaBusiness
  Caption = 'Pesquisa de Neg'#243'cios'
  ClientHeight = 331
  ClientWidth = 573
  ExplicitWidth = 585
  ExplicitHeight = 394
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 567
    Height = 257
    ExplicitTop = 71
    ExplicitWidth = 561
    ExplicitHeight = 248
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 563
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 471
      Height = 239
    end
    inherited pnl_pesq_right: TPanel
      Left = 473
      Height = 239
      ExplicitLeft = 467
      ExplicitHeight = 230
      inherited Sb_Sair_0: TSpeedButton
        Top = 176
        ExplicitTop = 176
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 113
        ExplicitTop = 113
      end
      inherited SB_Buscar: TSpeedButton
        Top = 50
        ExplicitTop = 50
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -13
        ExplicitTop = -13
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
        Left = 57
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
        Left = 57
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
