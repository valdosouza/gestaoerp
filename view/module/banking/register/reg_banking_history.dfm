inherited RegBankingHistory: TRegBankingHistory
  Caption = 'Cadastro de Hist'#243'rico Bancario'
  ClientHeight = 129
  ClientWidth = 641
  ExplicitWidth = 647
  ExplicitHeight = 178
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 65
    Width = 641
    ExplicitTop = 65
    ExplicitWidth = 641
    inherited SB_Inserir: TSpeedButton
      Left = 14
      ExplicitLeft = 14
    end
    inherited SB_Alterar: TSpeedButton
      Left = 118
      ExplicitLeft = 118
    end
    inherited SB_Excluir: TSpeedButton
      Left = 222
      ExplicitLeft = 222
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 430
      ExplicitLeft = 430
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 534
      ExplicitLeft = 534
    end
    inherited SB_Gravar: TSpeedButton
      Left = 326
      ExplicitLeft = 326
    end
  end
  inherited pnl_fundo: TPanel
    Width = 641
    Height = 65
    ExplicitWidth = 641
    ExplicitHeight = 65
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
      Left = 59
      Top = 25
      Width = 573
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
  inherited Menu: TMainMenu
    Left = 48
    Top = 72
  end
end
