inherited RegSubgroupMenu: TRegSubgroupMenu
  Caption = 'Cadastro de SubGrupo'
  ClientHeight = 122
  ClientWidth = 552
  ExplicitWidth = 564
  ExplicitHeight = 185
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 58
    Width = 552
    ExplicitTop = 49
    ExplicitWidth = 546
    inherited SB_Inserir: TSpeedButton
      Left = -8
      Width = 90
      ExplicitLeft = 39
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Alterar: TSpeedButton
      Left = 84
      Width = 91
      ExplicitLeft = 102
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Excluir: TSpeedButton
      Left = 177
      Width = 91
      ExplicitLeft = 206
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 363
      Width = 91
      ExplicitLeft = 374
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 456
      Width = 91
      ExplicitLeft = 478
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Gravar: TSpeedButton
      Left = 270
      Width = 91
      ExplicitLeft = 270
      ExplicitTop = 5
      ExplicitWidth = 91
    end
  end
  inherited pnl_fundo: TPanel
    Width = 552
    Height = 58
    ExplicitWidth = 546
    ExplicitHeight = 49
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 548
      Height = 54
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 542
      ExplicitHeight = 45
      object Lb_CodigoeDescricao: TLabel
        Left = 5
        Top = 5
        Width = 159
        Height = 14
        Caption = 'C'#243'digo e Descri'#231#227'o do Subgrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 21
        Width = 41
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
        Left = 49
        Top = 21
        Width = 485
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
  inherited Menu: TMainMenu
    Left = 120
    Top = 16
  end
end
