inherited RegVehicleModel: TRegVehicleModel
  Caption = 'Cadastro de Modelo'
  ClientHeight = 122
  ClientWidth = 463
  ExplicitWidth = 475
  ExplicitHeight = 185
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 58
    Width = 463
    ExplicitTop = 49
    ExplicitWidth = 457
    inherited SB_Inserir: TSpeedButton
      Left = -4
      Width = 86
      ExplicitLeft = -53
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Alterar: TSpeedButton
      Left = 84
      Width = 74
      ExplicitLeft = 31
      ExplicitTop = 5
      ExplicitWidth = 74
    end
    inherited SB_Excluir: TSpeedButton
      Left = 160
      Width = 78
      ExplicitLeft = 115
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 311
      Width = 77
      ExplicitLeft = 316
      ExplicitTop = 5
      ExplicitWidth = 77
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 390
      Width = 68
      ExplicitLeft = 373
      ExplicitTop = 5
      ExplicitWidth = 68
    end
    inherited SB_Gravar: TSpeedButton
      Left = 240
      Width = 69
      ExplicitLeft = 252
      ExplicitTop = 5
      ExplicitWidth = 69
    end
  end
  inherited pnl_fundo: TPanel
    Width = 463
    Height = 58
    ExplicitWidth = 457
    ExplicitHeight = 49
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 463
    Height = 58
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitWidth = 457
    ExplicitHeight = 49
    object L_Descricao: TLabel
      Left = 53
      Top = 5
      Width = 79
      Height = 14
      Caption = 'Nome do Modelo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Codigo: TLabel
      Left = 5
      Top = 5
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
    object E_Codigo: TEdit
      Left = 5
      Top = 21
      Width = 45
      Height = 22
      Color = clMenu
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
      Left = 52
      Top = 21
      Width = 401
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
end
