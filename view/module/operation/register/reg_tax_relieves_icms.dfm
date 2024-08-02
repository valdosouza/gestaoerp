inherited RegTaxRelievesIcms: TRegTaxRelievesIcms
  Caption = 'Cadastro do Motivo da Desonera'#231#227'o'
  ClientHeight = 201
  ClientWidth = 573
  ExplicitWidth = 585
  ExplicitHeight = 264
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 137
    Width = 573
    ExplicitTop = 128
    ExplicitWidth = 567
    inherited SB_Inserir: TSpeedButton
      Left = 7
      ExplicitLeft = 7
    end
    inherited SB_Alterar: TSpeedButton
      Left = 111
      Width = 86
      ExplicitLeft = 99
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Excluir: TSpeedButton
      Left = 199
      Width = 86
      ExplicitLeft = 203
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 377
      Width = 87
      ExplicitLeft = 362
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 466
      ExplicitLeft = 466
    end
    inherited SB_Gravar: TSpeedButton
      Left = 287
      Width = 88
      ExplicitLeft = 273
      ExplicitTop = 5
      ExplicitWidth = 88
    end
  end
  inherited pnl_fundo: TPanel
    Width = 573
    Height = 137
    ExplicitWidth = 567
    ExplicitHeight = 128
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 569
      Height = 133
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 563
      ExplicitHeight = 124
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
    Left = 288
    Top = 65528
  end
end
