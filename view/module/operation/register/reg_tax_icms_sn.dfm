inherited RegTaxIcmsSn: TRegTaxIcmsSn
  Caption = 'Cadastro de Situa'#231#227'o do Simples Nacional '
  ClientHeight = 182
  ClientWidth = 553
  ExplicitWidth = 559
  ExplicitHeight = 226
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 118
    Width = 553
    ExplicitTop = 118
    ExplicitWidth = 553
    inherited SB_Inserir: TSpeedButton
      Left = 4
      ExplicitLeft = 4
    end
    inherited SB_Alterar: TSpeedButton
      Left = 108
      Width = 79
      ExplicitLeft = 106
      ExplicitTop = 5
      ExplicitWidth = 79
    end
    inherited SB_Excluir: TSpeedButton
      Left = 189
      Width = 91
      ExplicitLeft = 134
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 367
      Width = 83
      ExplicitLeft = 342
      ExplicitTop = 5
      ExplicitWidth = 83
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 452
      Width = 96
      ExplicitLeft = 457
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Gravar: TSpeedButton
      Left = 282
      Width = 83
      ExplicitLeft = 238
      ExplicitTop = 5
      ExplicitWidth = 83
    end
  end
  inherited pnl_fundo: TPanel
    Width = 553
    Height = 118
    ExplicitWidth = 553
    ExplicitHeight = 118
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 549
      Height = 114
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
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
        Left = 6
        Top = 48
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
      object L_Grupo: TLabel
        Left = 75
        Top = 8
        Width = 30
        Height = 14
        Caption = 'Grupo'
        FocusControl = E_Grupo
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
        Width = 61
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
        Left = 6
        Top = 64
        Width = 531
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 170
        ParentFont = False
        TabOrder = 2
      end
      object E_Grupo: TEdit
        Left = 75
        Top = 24
        Width = 462
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 80
    Top = 72
  end
end
