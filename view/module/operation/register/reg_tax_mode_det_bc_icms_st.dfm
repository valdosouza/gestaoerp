inherited RegTaxModeDetBcIcmsSt: TRegTaxModeDetBcIcmsSt
  Caption = 'Cadastro da Determina'#231#227'o da Base de Calculo - ICMS - ST'
  ClientHeight = 192
  ClientWidth = 567
  ExplicitWidth = 579
  ExplicitHeight = 255
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 128
    Width = 567
    ExplicitTop = 119
    ExplicitWidth = 561
    inherited SB_Inserir: TSpeedButton
      Left = 6
      Width = 95
      ExplicitLeft = -8
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      Width = 89
      ExplicitLeft = 83
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Excluir: TSpeedButton
      Left = 194
      Width = 89
      ExplicitLeft = 174
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 376
      Width = 89
      ExplicitLeft = 356
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      Width = 95
      ExplicitLeft = 460
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Gravar: TSpeedButton
      Left = 285
      Width = 89
      ExplicitLeft = 265
      ExplicitTop = 5
      ExplicitWidth = 89
    end
  end
  inherited pnl_fundo: TPanel
    Width = 567
    Height = 128
    ExplicitWidth = 561
    ExplicitHeight = 119
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 563
      Height = 124
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 557
      ExplicitHeight = 115
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
        Left = 8
        Top = 49
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
        Left = 95
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
        Width = 81
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
        Left = 8
        Top = 64
        Width = 541
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Grupo: TEdit
        Left = 95
        Top = 24
        Width = 454
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited Menu: TMainMenu
    Top = 48
  end
end
