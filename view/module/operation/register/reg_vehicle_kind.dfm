inherited RegVehicleKind: TRegVehicleKind
  Caption = 'Cadastro de Tipos de Veiculos'
  ClientHeight = 165
  ClientWidth = 562
  ExplicitWidth = 574
  ExplicitHeight = 228
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 101
    Width = 562
    ExplicitTop = 92
    ExplicitWidth = 556
    inherited SB_Inserir: TSpeedButton
      Left = 3
      ExplicitLeft = -65
    end
    inherited SB_Alterar: TSpeedButton
      Left = 107
      Width = 86
      ExplicitLeft = 91
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Excluir: TSpeedButton
      Left = 195
      Width = 86
      ExplicitLeft = 179
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 371
      Width = 82
      ExplicitLeft = 351
      ExplicitTop = 5
      ExplicitWidth = 82
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 455
      ExplicitLeft = 455
    end
    inherited SB_Gravar: TSpeedButton
      Left = 283
      Width = 86
      ExplicitLeft = 267
      ExplicitTop = 5
      ExplicitWidth = 86
    end
  end
  inherited pnl_fundo: TPanel
    Width = 562
    Height = 101
    ExplicitWidth = 556
    ExplicitHeight = 92
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 558
      Height = 97
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 552
      ExplicitHeight = 88
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
        Left = 60
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
        Left = 57
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
