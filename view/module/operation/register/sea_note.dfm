inherited SeaNote: TSeaNote
  Caption = 'Pesquisa de Observa'#231#245'es'
  ClientHeight = 307
  ClientWidth = 571
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 583
  ExplicitHeight = 370
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 565
    Height = 225
    ExplicitWidth = 861
    ExplicitHeight = 371
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 561
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 469
      Height = 207
    end
    inherited pnl_pesq_right: TPanel
      Left = 471
      Height = 207
      ExplicitLeft = 767
      ExplicitHeight = 353
      inherited Sb_Sair_0: TSpeedButton
        Top = 155
        Height = 49
        ExplicitLeft = 3
        ExplicitTop = 200
        ExplicitWidth = 86
        ExplicitHeight = 49
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 102
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 136
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Buscar: TSpeedButton
        Top = 48
        Height = 51
        ExplicitLeft = 3
        ExplicitTop = 72
        ExplicitWidth = 86
        ExplicitHeight = 51
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 1
        Height = 44
        ExplicitLeft = 3
        ExplicitTop = 16
        ExplicitWidth = 86
        ExplicitHeight = 44
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 565
    Height = 70
    ExplicitWidth = 565
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 561
      Height = 65
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
        Left = 55
        Top = 32
        Width = 497
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
        Width = 46
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
