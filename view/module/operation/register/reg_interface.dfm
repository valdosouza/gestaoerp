inherited RegInterface: TRegInterface
  Caption = 'Cadastro de Interface'
  ClientHeight = 286
  ClientWidth = 575
  ExplicitWidth = 587
  ExplicitHeight = 349
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 222
    Width = 575
    ExplicitTop = 213
    ExplicitWidth = 569
    inherited SB_Inserir: TSpeedButton
      Left = 2
      Width = 94
      ExplicitLeft = 115
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 98
      Width = 94
      ExplicitLeft = 219
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 194
      Width = 94
      ExplicitLeft = 323
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 386
      Width = 93
      ExplicitLeft = 364
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 481
      Width = 89
      ExplicitLeft = 468
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Gravar: TSpeedButton
      Left = 290
      Width = 94
      ExplicitLeft = 427
      ExplicitTop = 5
      ExplicitWidth = 94
    end
  end
  inherited pnl_fundo: TPanel
    Width = 575
    Height = 222
    ExplicitWidth = 569
    ExplicitHeight = 213
    object Pn_Fundo: TPanel
      Left = 2
      Top = 2
      Width = 571
      Height = 218
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 565
      ExplicitHeight = 209
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
        Left = 58
        Top = 8
        Width = 88
        Height = 14
        Caption = 'Nome da Interface'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_FormName: TLabel
        Left = 8
        Top = 48
        Width = 152
        Height = 18
        Caption = 'Nome do Formul'#225'rio ou relatorio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Menu: TLabel
        Left = 8
        Top = 89
        Width = 71
        Height = 14
        Caption = 'Nome do Menu'
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
        Width = 313
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 376
        Top = 1
        Width = 179
        Height = 203
        Caption = 'Opera'#231#245'es desta Interface'
        TabOrder = 5
        object ChkBx_Permissao: TCheckListBox
          Left = 3
          Top = 14
          Width = 173
          Height = 185
          Color = clCream
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Inserir'
            'Alterar'
            'Excluir'
            'Visualizar')
          ParentFont = False
          Style = lbOwnerDrawFixed
          TabOrder = 0
        end
      end
      object DBRadioGroup1: TRadioGroup
        Left = 229
        Top = 90
        Width = 145
        Height = 35
        Caption = ' Dispon'#237'vel no Sistema '
        Columns = 2
        Items.Strings = (
          'Sim'
          'N'#227'o')
        TabOrder = 4
      end
      object E_FormName: TEdit
        Left = 8
        Top = 64
        Width = 366
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object DBLCB_Menu: TComboBox
        Left = 8
        Top = 103
        Width = 217
        Height = 21
        TabOrder = 3
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 120
    Top = 152
  end
end
