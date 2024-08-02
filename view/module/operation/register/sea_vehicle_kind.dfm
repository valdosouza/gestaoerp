inherited SeaVehicleKind: TSeaVehicleKind
  Caption = 'Pesquisa de Tipos de Veiculos'
  ClientHeight = 339
  ClientWidth = 570
  ExplicitWidth = 582
  ExplicitHeight = 402
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 564
    Height = 265
    ExplicitTop = 71
    ExplicitWidth = 558
    ExplicitHeight = 256
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 560
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 468
      Height = 247
    end
    inherited pnl_pesq_right: TPanel
      Left = 470
      Height = 247
      ExplicitLeft = 464
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
    Width = 564
    Height = 62
    ExplicitWidth = 558
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 560
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
      ExplicitWidth = 554
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
        TabOrder = 0
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
        TabOrder = 1
      end
    end
  end
end
