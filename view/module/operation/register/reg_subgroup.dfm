inherited RegSubgroup: TRegSubgroup
  Caption = 'Cadastro de SubGrupo'
  ClientHeight = 145
  ClientWidth = 549
  ExplicitWidth = 561
  ExplicitHeight = 208
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 81
    Width = 549
    ExplicitTop = 72
    ExplicitWidth = 543
    inherited SB_Inserir: TSpeedButton
      Left = 1
      Width = 95
      ExplicitLeft = -6
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Alterar: TSpeedButton
      Left = 98
      Width = 86
      ExplicitLeft = 67
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Excluir: TSpeedButton
      Left = 186
      Width = 90
      ExplicitLeft = 159
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 368
      Width = 87
      ExplicitLeft = 338
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 457
      Width = 87
      ExplicitLeft = 442
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Gravar: TSpeedButton
      Left = 278
      Width = 88
      ExplicitLeft = 263
      ExplicitTop = 4
      ExplicitWidth = 88
    end
  end
  inherited pnl_fundo: TPanel
    Width = 549
    Height = 81
    ExplicitWidth = 543
    ExplicitHeight = 72
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 545
      Height = 77
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 539
      ExplicitHeight = 68
      object L_Codigo_Descricao: TLabel
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
end
