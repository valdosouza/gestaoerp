inherited SeaKindProfit: TSeaKindProfit
  Caption = 'Pesquisa de Tipo de Item na Lucratividade'
  ClientHeight = 337
  ClientWidth = 572
  ExplicitWidth = 584
  ExplicitHeight = 400
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 566
    Height = 263
    ExplicitTop = 71
    ExplicitWidth = 560
    ExplicitHeight = 254
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 562
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 470
      Height = 245
    end
    inherited pnl_pesq_right: TPanel
      Left = 472
      Height = 245
      ExplicitLeft = 466
      ExplicitHeight = 236
      inherited Sb_Sair_0: TSpeedButton
        Top = 182
        ExplicitTop = 182
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 119
        ExplicitTop = 119
      end
      inherited SB_Buscar: TSpeedButton
        Top = 56
        ExplicitTop = 56
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -7
        ExplicitTop = -7
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 566
    Height = 62
    ExplicitWidth = 560
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 562
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
      ExplicitWidth = 556
      object L_Descricao: TLabel
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
