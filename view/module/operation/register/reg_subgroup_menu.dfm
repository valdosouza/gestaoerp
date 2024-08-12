inherited RegSubgroupMenu: TRegSubgroupMenu
  Caption = 'Cadastro de SubGrupo'
  ClientHeight = 202
  ClientWidth = 552
  ExplicitWidth = 558
  ExplicitHeight = 246
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 138
    Width = 552
    ExplicitTop = 138
    ExplicitWidth = 552
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
    Height = 138
    ExplicitWidth = 552
    ExplicitHeight = 138
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 548
      Height = 134
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Impressora: TLabel
        Left = 251
        Top = 44
        Width = 156
        Height = 14
        Caption = 'Caminho da Porta de Impressora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Abas: TLabel
        Left = 5
        Top = 44
        Width = 178
        Height = 14
        Caption = 'Nome da Aba na Tela de Atendimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descricao: TLabel
        Left = 59
        Top = 7
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
      object Lb_Codigo: TLabel
        Left = 6
        Top = 7
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
      object E_Codigo: TEdit
        Left = 6
        Top = 21
        Width = 58
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
        Left = 59
        Top = 21
        Width = 449
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
      object cb_Impressora: TComboBox
        Left = 251
        Top = 59
        Width = 257
        Height = 21
        TabOrder = 2
        Text = 'cb_Impressora'
      end
      object E_Abas: TEdit
        Left = 6
        Top = 59
        Width = 239
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object ChBx_Ativo: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 85
        Width = 565
        Height = 17
        Margins.Top = 1
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 104
    Top = 88
  end
end
