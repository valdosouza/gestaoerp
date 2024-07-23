inherited RegCategory: TRegCategory
  Caption = 'Cadastro de Categorias'
  ClientHeight = 249
  ClientWidth = 571
  ExplicitWidth = 583
  ExplicitHeight = 312
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 185
    Width = 571
    ExplicitTop = 176
    ExplicitWidth = 565
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 94
      ExplicitLeft = -5
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      Width = 94
      ExplicitLeft = 91
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 195
      Width = 90
      ExplicitLeft = 183
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 381
      Width = 93
      ExplicitLeft = 372
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 476
      Width = 90
      ExplicitLeft = 464
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Gravar: TSpeedButton
      Left = 287
      Width = 92
      ExplicitLeft = 277
      ExplicitTop = 5
      ExplicitWidth = 92
    end
  end
  inherited pnl_fundo: TPanel
    Width = 571
    Height = 185
    ExplicitWidth = 565
    ExplicitHeight = 176
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 567
      Height = 181
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 561
      ExplicitHeight = 172
      object Lb_Codigo: TLabel
        Left = 5
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
      object Lb_Descricao: TLabel
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
      object Lb_CategoriaPai: TLabel
        Left = 5
        Top = 49
        Width = 63
        Height = 14
        Caption = 'Categoria Pai'
        Enabled = False
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Atendimento: TLabel
        Left = 5
        Top = 87
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
      object Sb_Impressora: TSpeedButton
        Left = 529
        Top = 100
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Lb_Impressora: TLabel
        Left = 256
        Top = 87
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
      object Lb_Interface: TLabel
        Left = 6
        Top = 127
        Width = 81
        Height = 14
        Caption = 'Tipo de Interface'
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
      object Dblcb_CategoriaPai: TComboBox
        Left = 5
        Top = 64
        Width = 540
        Height = 21
        TabOrder = 2
      end
      object E_Abas: TEdit
        Left = 5
        Top = 102
        Width = 246
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Dblcb_Impressora: TComboBox
        Left = 254
        Top = 102
        Width = 274
        Height = 21
        TabOrder = 4
      end
      object DBCB_Interface: TComboBox
        Left = 6
        Top = 144
        Width = 247
        Height = 21
        Style = csDropDownList
        Sorted = True
        TabOrder = 5
        Items.Strings = (
          'BOT'#195'O'
          'LISTA')
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 200
    Top = 65520
  end
end
