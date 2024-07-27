inherited RegBusiness: TRegBusiness
  Caption = 'Cadastro de Neg'#243'cios'
  ClientHeight = 168
  ClientWidth = 570
  ExplicitWidth = 582
  ExplicitHeight = 231
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 104
    Width = 570
    ExplicitTop = 95
    ExplicitWidth = 564
    inherited SB_Inserir: TSpeedButton
      Left = -1
      Width = 96
      ExplicitLeft = -7
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Alterar: TSpeedButton
      Left = 97
      Width = 94
      ExplicitLeft = 75
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 193
      Width = 94
      ExplicitLeft = 171
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 385
      Width = 90
      ExplicitLeft = 359
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 477
      Width = 88
      ExplicitLeft = 463
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 289
      Width = 94
      ExplicitLeft = 267
      ExplicitTop = 5
      ExplicitWidth = 94
    end
  end
  inherited pnl_fundo: TPanel
    Width = 570
    Height = 104
    ExplicitWidth = 564
    ExplicitHeight = 95
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 566
      Height = 100
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 560
      ExplicitHeight = 91
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
      object ChBx_Exclusivo: TCheckBox
        Left = 9
        Top = 52
        Width = 283
        Height = 17
        Caption = 'N'#227'o mostrar este neg'#243'cio no relat'#243'rio de vendas geral'
        TabOrder = 2
      end
    end
  end
end
