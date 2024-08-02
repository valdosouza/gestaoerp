inherited SeaTaxIcmsSn: TSeaTaxIcmsSn
  Caption = 'Pesquisa de Situa'#231#227'o do Simples Nacional '
  ClientHeight = 320
  ClientWidth = 569
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 581
  ExplicitHeight = 383
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 563
    Height = 246
    ExplicitTop = 71
    ExplicitWidth = 861
    ExplicitHeight = 410
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 559
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 467
      Height = 228
    end
    inherited pnl_pesq_right: TPanel
      Left = 469
      Height = 228
      ExplicitLeft = 767
      ExplicitHeight = 392
      inherited Sb_Sair_0: TSpeedButton
        Top = 170
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 176
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 112
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 113
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 54
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 50
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -4
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = -13
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 563
    Height = 62
    ExplicitWidth = 861
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 559
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
      ExplicitLeft = 370
      ExplicitTop = 34
      ExplicitWidth = 863
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
