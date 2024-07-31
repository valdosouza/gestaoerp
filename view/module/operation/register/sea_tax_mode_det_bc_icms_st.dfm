inherited SeaTaxModeDetBcIcmsSt: TSeaTaxModeDetBcIcmsSt
  Caption = 'Pesquisa da Determina'#231#227'o da Base de Calculo - ICMS - ST'
  ClientHeight = 317
  ClientWidth = 567
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 579
  ExplicitHeight = 380
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 561
    Height = 243
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 557
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 465
      Height = 225
    end
    inherited pnl_pesq_right: TPanel
      Left = 467
      Height = 225
      inherited Sb_Sair_0: TSpeedButton
        Top = 167
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 175
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 109
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 112
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 51
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 49
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -7
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = -14
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 561
    Height = 62
    ExplicitWidth = 561
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 557
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
