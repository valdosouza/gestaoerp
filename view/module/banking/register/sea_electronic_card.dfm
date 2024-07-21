inherited SeaEletronicCard: TSeaEletronicCard
  Caption = 'Pesquisa de Cart'#245'es Eletronicos'
  ClientHeight = 339
  ClientWidth = 550
  ExplicitWidth = 556
  ExplicitHeight = 388
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 544
    Height = 265
    ExplicitTop = 71
    ExplicitWidth = 538
    ExplicitHeight = 256
    inherited DBG_Pesquisa: TDBGrid
      Width = 448
      Height = 247
    end
    inherited pnl_pesq_right: TPanel
      Left = 450
      Height = 247
      ExplicitLeft = 444
      ExplicitHeight = 238
      inherited Sb_Sair_0: TSpeedButton
        Top = 184
        ExplicitTop = 184
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 121
        ExplicitTop = 121
      end
      inherited SB_Buscar: TSpeedButton
        Top = 58
        ExplicitTop = 58
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -5
        ExplicitTop = -5
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 544
    Height = 62
    ExplicitWidth = 538
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 540
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
      ExplicitWidth = 534
      object Label28: TLabel
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
      object Label3: TLabel
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
        Left = 56
        Top = 32
        Width = 473
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
