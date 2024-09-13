inherited SeaCoating: TSeaCoating
  Caption = 'Pesquisa de Revestimento dos Produtos'
  ClientHeight = 287
  ClientWidth = 604
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 620
  ExplicitHeight = 346
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 55
    Width = 598
    Height = 229
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 63
    ExplicitWidth = 598
    ExplicitHeight = 221
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 594
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 502
      Height = 211
    end
    inherited pnl_pesq_right: TPanel
      Left = 504
      Height = 211
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 504
      ExplicitHeight = 203
      inherited Sb_Sair_0: TSpeedButton
        Top = 156
        Height = 52
        ExplicitLeft = 3
        ExplicitTop = 181
        ExplicitWidth = 86
        ExplicitHeight = 52
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 102
        Height = 51
        ExplicitLeft = 3
        ExplicitTop = 118
        ExplicitWidth = 86
        ExplicitHeight = 51
      end
      inherited SB_Buscar: TSpeedButton
        Top = 49
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 55
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -3
        Height = 49
        ExplicitLeft = 3
        ExplicitTop = -8
        ExplicitWidth = 86
        ExplicitHeight = 49
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 598
    Height = 46
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 598
    ExplicitHeight = 46
    object L_BuscaDescricao: TLabel
      Left = 4
      Top = 1
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
    object E_BuscaDescricao: TEdit
      Left = 2
      Top = 17
      Width = 579
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
