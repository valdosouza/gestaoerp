inherited BaseSearch: TBaseSearch
  Caption = 'Base Search'
  ClientHeight = 506
  ClientWidth = 885
  Touch.InteractiveGestures = []
  Touch.InteractiveGestureOptions = []
  Touch.ParentTabletOptions = False
  Touch.TabletOptions = []
  ExplicitWidth = 891
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Fundo: TPanel [0]
    AlignWithMargins = True
    Left = 3
    Top = 115
    Width = 879
    Height = 388
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Lb_ResultadoPesquisa: TLabel
      Left = 2
      Top = 2
      Width = 116
      Height = 14
      Align = alTop
      Caption = 'Resultado da pesquisa :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object DBG_Pesquisa: TDBGrid
      Left = 2
      Top = 16
      Width = 783
      Height = 370
      Align = alClient
      Color = clCream
      DataSource = ds_search
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBG_PesquisaDblClick
      OnTitleClick = DBG_PesquisaTitleClick
    end
    object pnl_pesq_right: TPanel
      Left = 785
      Top = 16
      Width = 92
      Height = 370
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Sb_Sair_0: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 307
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Fechar - ESC'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = Sb_Sair_0Click
        ExplicitLeft = -8
        ExplicitTop = 321
        ExplicitWidth = 92
      end
      object SB_Visualizar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 244
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Visualizar - F8'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_VisualizarClick
        ExplicitLeft = 835
        ExplicitTop = 312
        ExplicitWidth = 92
      end
      object SB_Buscar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 181
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Buscar - F7'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_BuscarClick
        ExplicitLeft = 835
        ExplicitTop = 252
        ExplicitWidth = 92
      end
      object SB_Cadastrar: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 118
        Width = 86
        Height = 60
        Margins.Top = 0
        Align = alBottom
        Caption = 'Cadastrar - F2'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Layout = blGlyphTop
        ParentFont = False
        OnClick = SB_CadastrarClick
        ExplicitLeft = 835
        ExplicitTop = 192
        ExplicitWidth = 92
      end
    end
  end
  object Pnl_Parametros: TPanel [1]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 879
    Height = 106
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object ds_search: TDataSource
    DataSet = cds_search
    Left = 152
    Top = 258
  end
  object cds_search: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 152
    Top = 202
  end
  object DSP: TDataSetProvider
    DataSet = DM.Qr_Crud
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 152
    Top = 160
  end
end
