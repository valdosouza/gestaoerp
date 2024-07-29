inherited RegVehicleBrand: TRegVehicleBrand
  Caption = 'Cadastro de Marca e Modelo'
  ClientHeight = 358
  ClientWidth = 564
  ExplicitWidth = 576
  ExplicitHeight = 421
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 294
    Width = 564
    ExplicitTop = 285
    ExplicitWidth = 558
    inherited SB_Inserir: TSpeedButton
      Left = 0
      Width = 94
      ExplicitLeft = -13
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 96
      Width = 94
      ExplicitLeft = 83
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 192
      Width = 90
      ExplicitLeft = 175
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 374
      Width = 91
      ExplicitLeft = 358
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      Width = 92
      ExplicitLeft = 462
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Gravar: TSpeedButton
      Left = 284
      Width = 88
      ExplicitLeft = 265
      ExplicitTop = 5
      ExplicitWidth = 88
    end
  end
  inherited pnl_fundo: TPanel
    Width = 564
    Height = 294
    ExplicitWidth = 558
    ExplicitHeight = 285
    object Panel1: TPanel
      Left = 6
      Top = 8
      Width = 546
      Height = 105
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Descricao: TLabel
        Left = 8
        Top = 5
        Width = 75
        Height = 14
        Caption = 'Nome da Marca'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Fornecedor: TLabel
        Left = 8
        Top = 48
        Width = 86
        Height = 14
        Caption = 'Nome Fornecedor'
        FocusControl = DBLCB_Fornecedor
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Fornecedor: TSpeedButton
        Left = 517
        Top = 61
        Width = 21
        Height = 21
        Caption = '...'
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
        Width = 488
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
      object DBLCB_Fornecedor: TComboBox
        Left = 8
        Top = 62
        Width = 506
        Height = 21
        TabOrder = 2
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 119
      Width = 560
      Height = 173
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitTop = 110
      ExplicitWidth = 554
      object Sb_Modelos: TSpeedButton
        Left = 442
        Top = 141
        Width = 93
        Height = 28
        Caption = 'Editar Modelos'
      end
      object DBGrid1: TDBGrid
        Left = 4
        Top = 3
        Width = 534
        Height = 136
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'MOD_DESCRICAO'
            Title.Caption = 'Rela'#231#227'o de modelos cadastrados'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clNavy
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Style = []
            Visible = True
          end>
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 320
    Top = 16
  end
end
