inherited RegService: TRegService
  Caption = 'Cadastro de Servi'#231'os'
  ClientHeight = 350
  ClientWidth = 606
  ExplicitWidth = 618
  ExplicitHeight = 413
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 286
    Width = 606
    ExplicitTop = 277
    ExplicitWidth = 600
    inherited SB_Inserir: TSpeedButton
      Left = 3
      ExplicitLeft = -21
    end
    inherited SB_Alterar: TSpeedButton
      Left = 107
      Width = 96
      ExplicitLeft = 101
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Excluir: TSpeedButton
      Left = 205
      Width = 96
      ExplicitLeft = 199
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 401
      Width = 96
      ExplicitLeft = 395
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 499
      ExplicitLeft = 499
    end
    inherited SB_Gravar: TSpeedButton
      Left = 303
      Width = 96
      ExplicitLeft = 297
      ExplicitTop = 5
      ExplicitWidth = 96
    end
  end
  inherited pnl_fundo: TPanel
    Width = 606
    Height = 286
    ExplicitWidth = 600
    ExplicitHeight = 277
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 602
      Height = 282
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 596
      ExplicitHeight = 273
      object L_Codigo: TLabel
        Left = 9
        Top = 6
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_DescricaoServico: TLabel
        Left = 116
        Top = 7
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        FocusControl = E_DescricaoServico
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_PrecoCusto: TLabel
        Left = 234
        Top = 84
        Width = 73
        Height = 14
        Caption = 'Pre'#231'o de custo'
        FocusControl = E_PrecoCusto
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Grupo: TLabel
        Left = 8
        Top = 44
        Width = 30
        Height = 14
        Caption = 'Grupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_SubGrupo: TLabel
        Left = 310
        Top = 44
        Width = 47
        Height = 14
        Caption = 'Subgrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SB_Grupos: TSpeedButton
        Left = 565
        Top = 58
        Width = 23
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
      end
      object L_Aq_Margem: TLabel
        Left = 325
        Top = 84
        Width = 85
        Height = 14
        AutoSize = False
        Caption = 'Margem de Lucro'
        FocusControl = E_Aq_Margem
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Medida: TLabel
        Left = 8
        Top = 85
        Width = 39
        Height = 14
        Caption = 'Unidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Venda: TLabel
        Left = 417
        Top = 84
        Width = 86
        Height = 14
        Caption = 'Pre'#231'o de Venda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Sb_Medida: TSpeedButton
        Left = 115
        Top = 99
        Width = 23
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
      end
      object L_Aq_Comissao: TLabel
        Left = 144
        Top = 84
        Width = 68
        Height = 14
        Caption = 'Aliq.Comiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_DescricaoServico: TEdit
        Left = 116
        Top = 21
        Width = 476
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
      object E_PrecoCusto: TEdit
        Left = 233
        Top = 99
        Width = 90
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 21
        Width = 105
        Height = 22
        TabStop = False
        Color = clMenu
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object DBLCB_Grupo: TComboBox
        Left = 7
        Top = 58
        Width = 298
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object DBLCB_SubGrupo: TComboBox
        Left = 308
        Top = 58
        Width = 253
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object E_Aq_Margem: TEdit_Setes
        Left = 324
        Top = 99
        Width = 90
        Height = 22
        Alignment = taRightJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = ''
      end
      object E_Vl_Venda: TEdit_Setes
        Left = 416
        Top = 99
        Width = 90
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Text = ''
      end
      object DBLCB_Medida: TComboBox
        Left = 7
        Top = 99
        Width = 106
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object e_aq_comissao: TEdit_Setes
        Left = 141
        Top = 99
        Width = 90
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = ''
      end
      object ChBx_ativo: TCheckBox
        Left = 8
        Top = 253
        Width = 400
        Height = 17
        Caption = 'Este Servi'#231'o encontra-se ativo para qualquer transa'#231#227'o'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 9
      end
      object PageControl1: TPageControl
        Left = 6
        Top = 125
        Width = 585
        Height = 127
        ActivePage = tbs_Internet
        TabOrder = 10
        object TabSheet1: TTabSheet
          Caption = 'Observa'#231#227'o'
          object ME_Observ: TMemo
            Left = 0
            Top = 0
            Width = 577
            Height = 99
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object tbs_Internet: TTabSheet
          Caption = 'Internet'
          ImageIndex = 1
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 577
            Height = 99
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            DesignSize = (
              577
              99)
            object L_Cadastro: TLabel
              Left = 5
              Top = 3
              Width = 217
              Height = 14
              Caption = 'Nome da Categoria na Internet - Vers'#227'o 2013'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Category: TSpeedButton
              Left = 351
              Top = 70
              Width = 91
              Height = 25
              Anchors = [akLeft, akBottom]
              Caption = 'Editar Categorias'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
            end
            object Trw_Cadastro: TTreeView
              Left = 3
              Top = 16
              Width = 343
              Height = 78
              Anchors = [akLeft, akTop, akBottom]
              AutoExpand = True
              HideSelection = False
              Indent = 19
              MultiSelectStyle = []
              ReadOnly = True
              SortType = stText
              TabOrder = 0
            end
          end
        end
      end
    end
  end
end
