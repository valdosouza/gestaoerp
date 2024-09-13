inherited RegLineBusiness: TRegLineBusiness
  Caption = 'Cadastro de Ramo de Atividade'
  ClientHeight = 146
  ClientWidth = 564
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 580
  ExplicitHeight = 205
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 82
    Width = 564
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 82
    ExplicitWidth = 564
    inherited SB_Inserir: TSpeedButton
      Left = 0
      Width = 83
      ExplicitLeft = 30
      ExplicitTop = 5
      ExplicitWidth = 83
    end
    inherited SB_Alterar: TSpeedButton
      Left = 85
      ExplicitLeft = 85
    end
    inherited SB_Excluir: TSpeedButton
      Left = 189
      Width = 91
      ExplicitLeft = 182
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 375
      ExplicitLeft = 375
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 479
      Width = 80
      ExplicitLeft = 497
      ExplicitTop = 5
      ExplicitWidth = 80
    end
    inherited SB_Gravar: TSpeedButton
      Left = 282
      Width = 91
      ExplicitLeft = 286
      ExplicitTop = 5
      ExplicitWidth = 91
    end
  end
  inherited pnl_fundo: TPanel
    Width = 564
    Height = 82
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = -1
    ExplicitWidth = 564
    ExplicitHeight = 82
    object L_Codigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 58
      Top = 8
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 58
      Top = 24
      Width = 491
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 24
      Width = 49
      Height = 22
      Color = clScrollBar
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 368
  end
end
