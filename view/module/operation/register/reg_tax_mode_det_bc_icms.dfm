inherited RegTaxModeDetBcIcms: TRegTaxModeDetBcIcms
  Caption = 'Cadastro da Determina'#231#227'o da Base de Calculo - ICMS '
  ClientHeight = 189
  ClientWidth = 568
  ExplicitWidth = 580
  ExplicitHeight = 252
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 125
    Width = 568
    ExplicitTop = 116
    ExplicitWidth = 562
    inherited SB_Inserir: TSpeedButton
      Left = 7
      Width = 95
      ExplicitLeft = 12
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Alterar: TSpeedButton
      Left = 104
      Width = 89
      ExplicitLeft = 97
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Excluir: TSpeedButton
      Left = 195
      Width = 89
      ExplicitLeft = 188
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 377
      Width = 89
      ExplicitLeft = 370
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 468
      Width = 95
      ExplicitLeft = 473
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Gravar: TSpeedButton
      Left = 286
      Width = 89
      ExplicitLeft = 279
      ExplicitTop = 5
      ExplicitWidth = 89
    end
  end
  inherited pnl_fundo: TPanel
    Width = 568
    Height = 125
    ExplicitWidth = 562
    ExplicitHeight = 116
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 564
      Height = 121
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 558
      ExplicitHeight = 112
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
        Left = 7
        Top = 64
        Width = 542
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
        Left = 75
        Top = 24
        Width = 474
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
    Left = 112
    Top = 80
  end
end
