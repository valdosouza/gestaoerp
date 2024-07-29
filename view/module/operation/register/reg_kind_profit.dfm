inherited RegKindProfit: TRegKindProfit
  Caption = 'Cadastro de Tipo de Item na Lucratividade'
  ClientHeight = 179
  ClientWidth = 568
  ExplicitWidth = 580
  ExplicitHeight = 242
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 115
    Width = 568
    ExplicitTop = 106
    ExplicitWidth = 562
    inherited SB_Inserir: TSpeedButton
      Left = -5
      ExplicitLeft = -5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      Width = 94
      ExplicitLeft = 107
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 195
      Width = 94
      ExplicitLeft = 187
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 383
      Width = 88
      ExplicitLeft = 369
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 473
      Width = 90
      ExplicitLeft = 461
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Gravar: TSpeedButton
      Left = 291
      Width = 90
      ExplicitLeft = 279
      ExplicitTop = 5
      ExplicitWidth = 90
    end
  end
  inherited pnl_fundo: TPanel
    Width = 568
    Height = 115
    ExplicitWidth = 562
    ExplicitHeight = 106
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 564
      Height = 111
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 558
      ExplicitHeight = 102
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
        Left = 57
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
  end
end
