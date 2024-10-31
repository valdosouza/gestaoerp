inherited RegCustomerOrigin: TRegCustomerOrigin
  Caption = 'Cadastro de Origem de Clientes'
  ClientHeight = 133
  ClientWidth = 559
  ExplicitWidth = 565
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 69
    Width = 559
    ExplicitTop = 69
    ExplicitWidth = 559
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 86
      ExplicitLeft = -13
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Alterar: TSpeedButton
      Left = 91
      Width = 84
      ExplicitLeft = 53
      ExplicitTop = 5
      ExplicitWidth = 84
    end
    inherited SB_Excluir: TSpeedButton
      Left = 177
      ExplicitLeft = 157
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 385
      Width = 85
      ExplicitLeft = 348
      ExplicitTop = 5
      ExplicitWidth = 85
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 472
      Width = 82
      ExplicitLeft = 472
      ExplicitTop = 5
      ExplicitWidth = 82
    end
    inherited SB_Gravar: TSpeedButton
      Left = 281
      ExplicitLeft = 281
    end
  end
  inherited pnl_fundo: TPanel
    Width = 559
    Height = 69
    ExplicitWidth = 559
    ExplicitHeight = 69
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
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 296
    Top = 16
  end
end
