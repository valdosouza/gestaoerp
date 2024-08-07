inherited SeaUsers: TSeaUsers
  Caption = 'Pesquisas de Usu'#225'rios'
  ClientHeight = 532
  ClientWidth = 658
  ExplicitWidth = 664
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 74
    Width = 652
    Height = 455
    ExplicitTop = 74
    ExplicitWidth = 652
    ExplicitHeight = 455
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 648
    end
    object Label22: TLabel [1]
      Left = 1
      Top = 65
      Width = 116
      Height = 14
      Caption = 'Resultado da pesquisa :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object SpeedButton1: TSpeedButton [2]
      Left = 320
      Top = 359
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Cadastrar - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CadastrarClick
      ExplicitLeft = 547
      ExplicitTop = 332
    end
    object SpeedButton2: TSpeedButton [3]
      Left = 323
      Top = 406
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_BuscarClick
      ExplicitLeft = 550
      ExplicitTop = 379
    end
    object SpeedButton3: TSpeedButton [4]
      Left = 320
      Top = 406
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Visualizar - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_VisualizarClick
      ExplicitLeft = 547
      ExplicitTop = 379
    end
    object Sb_Sair_1: TSpeedButton [5]
      Left = 328
      Top = 406
      Width = 92
      Height = 54
      Anchors = [akRight, akBottom]
      Caption = 'Sair- Esc'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ExplicitLeft = 555
      ExplicitTop = 379
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 556
      Height = 437
    end
    inherited pnl_pesq_right: TPanel
      Left = 558
      Height = 437
      ExplicitLeft = 558
      ExplicitHeight = 437
      inherited Sb_Sair_0: TSpeedButton
        Top = 374
        ExplicitTop = 377
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 311
        ExplicitTop = 314
      end
      inherited SB_Buscar: TSpeedButton
        Top = 248
        ExplicitTop = 251
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 185
        ExplicitTop = 188
      end
      object ChBx_Inativos: TCheckBox
        Left = 13
        Top = 6
        Width = 63
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Inativos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 16
      Width = 550
      Height = 437
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clCream
      DataSource = ds_search
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = SB_VisualizarClick
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 403
          Visible = True
        end>
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 652
    Height = 65
    ExplicitWidth = 652
    ExplicitHeight = 65
    object Gbx_Parametros: TGroupBox
      Left = 2
      Top = 2
      Width = 648
      Height = 62
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label27: TLabel
        Left = 5
        Top = 16
        Width = 73
        Height = 14
        Caption = 'C'#243'digo Usu'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 124
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Nome '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCodigo: TEdit
        Left = 5
        Top = 32
        Width = 116
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_BuscaNome: TEdit
        Left = 124
        Top = 32
        Width = 495
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 416
    Top = 8
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchnome: TStringField
      FieldName = 'nome'
    end
  end
end
