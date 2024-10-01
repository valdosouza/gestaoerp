inherited SeaTaxIcmsNr: TSeaTaxIcmsNr
  Caption = 'Pesquisa de Situa'#231#245'es Tribut'#225'rias'
  ClientHeight = 308
  ClientWidth = 571
  ExplicitWidth = 577
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 565
    Height = 234
    ExplicitTop = 71
    ExplicitWidth = 559
    ExplicitHeight = 230
    inherited DBG_Pesquisa: TDBGrid
      Width = 469
      Height = 216
    end
    inherited pnl_pesq_right: TPanel
      Left = 471
      Height = 216
      ExplicitLeft = 465
      ExplicitHeight = 212
      inherited Sb_Sair_0: TSpeedButton
        Top = 158
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 183
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 100
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 120
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 42
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 57
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -16
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = -6
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 565
    Height = 62
    ExplicitWidth = 559
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 561
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
      ExplicitWidth = 555
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
