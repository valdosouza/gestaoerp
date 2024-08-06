inherited RegPackage: TRegPackage
  Caption = 'Cadastro de Embalagens'
  ClientHeight = 177
  ClientWidth = 565
  ExplicitWidth = 571
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 113
    Width = 565
    ExplicitTop = 113
    ExplicitWidth = 565
    inherited SB_Inserir: TSpeedButton
      Left = -7
      Width = 94
      ExplicitLeft = 99
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 89
      Width = 94
      ExplicitLeft = 179
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 185
      Width = 94
      ExplicitLeft = 291
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 373
      Width = 92
      ExplicitLeft = 461
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      Width = 93
      ExplicitLeft = 556
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Gravar: TSpeedButton
      Left = 281
      Width = 90
      ExplicitLeft = 367
      ExplicitTop = 5
      ExplicitWidth = 90
    end
  end
  inherited pnl_fundo: TPanel
    Width = 565
    Height = 113
    ExplicitWidth = 565
    ExplicitHeight = 113
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 561
      Height = 109
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Lb_Codigo: TLabel
        Left = 4
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
        Left = 55
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
      object L_Abreviatura: TLabel
        Left = 4
        Top = 56
        Width = 57
        Height = 14
        Caption = 'Abreviatura'
        FocusControl = E_Abreviatura
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 5
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
        Left = 55
        Top = 24
        Width = 496
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
      object E_Abreviatura: TEdit
        Left = 5
        Top = 70
        Width = 69
        Height = 21
        TabOrder = 2
      end
    end
  end
end
