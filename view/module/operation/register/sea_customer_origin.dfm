inherited SeaCustomerOrigin: TSeaCustomerOrigin
  Caption = 'Pesquisa de Origem de Clientes'
  ClientHeight = 272
  ClientWidth = 565
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 581
  ExplicitHeight = 331
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 559
    Height = 198
    StyleElements = [seFont, seClient, seBorder]
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 555
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 463
      Height = 180
    end
    inherited pnl_pesq_right: TPanel
      Left = 465
      Height = 180
      StyleElements = [seFont, seClient, seBorder]
      inherited Sb_Sair_0: TSpeedButton
        Top = 134
        Height = 43
        ExplicitLeft = 3
        ExplicitTop = 200
        ExplicitWidth = 86
        ExplicitHeight = 43
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 86
        Height = 45
        ExplicitLeft = 3
        ExplicitTop = 152
        ExplicitWidth = 86
        ExplicitHeight = 45
      end
      inherited SB_Buscar: TSpeedButton
        Top = 37
        Height = 46
        ExplicitLeft = 3
        ExplicitTop = 88
        ExplicitWidth = 86
        ExplicitHeight = 46
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -13
        Height = 47
        ExplicitLeft = 3
        ExplicitTop = 24
        ExplicitWidth = 86
        ExplicitHeight = 47
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 559
    Height = 62
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 559
    ExplicitHeight = 62
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
  end
end
