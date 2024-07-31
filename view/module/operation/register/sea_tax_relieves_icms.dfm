inherited SeaTaxRelievesIcms: TSeaTaxRelievesIcms
  Caption = 'Pesquisa do Motivo da Desonera'#231#227'o'
  ClientHeight = 332
  ClientWidth = 570
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 582
  ExplicitHeight = 395
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 564
    Height = 258
    ExplicitHeight = 380
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 560
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 468
      Height = 240
    end
    inherited pnl_pesq_right: TPanel
      Left = 470
      Height = 240
      ExplicitHeight = 362
      inherited Sb_Sair_0: TSpeedButton
        Top = 177
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 114
      end
      inherited SB_Buscar: TSpeedButton
        Top = 51
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -12
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 564
    Height = 62
    ExplicitWidth = 564
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
      ExplicitLeft = 4
      ExplicitTop = 10
      ExplicitWidth = 869
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
