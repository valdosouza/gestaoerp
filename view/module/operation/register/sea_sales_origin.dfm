inherited SeaSalesOrigin: TSeaSalesOrigin
  Caption = 'Pesquisa de Origem da Venda'
  ClientHeight = 314
  ClientWidth = 565
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 581
  ExplicitHeight = 373
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 559
    Height = 240
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 71
    ExplicitWidth = 559
    ExplicitHeight = 240
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 555
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 463
      Height = 222
    end
    inherited pnl_pesq_right: TPanel
      Left = 465
      Height = 222
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 465
      ExplicitHeight = 222
      inherited Sb_Sair_0: TSpeedButton
        Top = 159
        ExplicitTop = 159
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 107
        Height = 49
        ExplicitLeft = 3
        ExplicitTop = 112
        ExplicitWidth = 86
        ExplicitHeight = 49
      end
      inherited SB_Buscar: TSpeedButton
        Top = 51
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = 60
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -12
        ExplicitTop = -12
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 559
    Height = 62
    Alignment = taLeftJustify
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 8
    ExplicitWidth = 559
    ExplicitHeight = 62
    object L_BuscaDescricao: TLabel
      Left = 62
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
      Left = 62
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
  inherited MnuBase: TMainMenu
    Left = 360
    Top = 16
  end
end
