inherited RegSalesOrigin: TRegSalesOrigin
  Caption = 'Cadastro de Origem da Venda'
  ClientHeight = 130
  ClientWidth = 566
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 582
  ExplicitHeight = 189
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 66
    Width = 566
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 90
    ExplicitWidth = 566
    inherited SB_Inserir: TSpeedButton
      Left = 11
      Width = 90
      ExplicitLeft = -1
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      Width = 84
      ExplicitLeft = 85
      ExplicitTop = 5
      ExplicitWidth = 84
    end
    inherited SB_Excluir: TSpeedButton
      Left = 189
      ExplicitLeft = 189
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 397
      Width = 81
      ExplicitLeft = 376
      ExplicitTop = 5
      ExplicitWidth = 81
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 480
      Width = 81
      ExplicitLeft = 480
      ExplicitTop = 5
      ExplicitWidth = 81
    end
    inherited SB_Gravar: TSpeedButton
      Left = 293
      ExplicitLeft = 293
    end
  end
  inherited pnl_fundo: TPanel
    Width = 566
    Height = 66
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 566
    ExplicitHeight = 90
    object L_Codigo: TLabel
      Left = 11
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
      Left = 63
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
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 63
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
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 440
    Top = 16
  end
end
