inherited SeaCategory: TSeaCategory
  Caption = 'Pesquisa de Categorias'
  ClientHeight = 370
  ClientWidth = 578
  ExplicitWidth = 584
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 81
    Width = 572
    Height = 286
    ExplicitTop = 81
    ExplicitWidth = 572
    ExplicitHeight = 286
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 568
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 476
      Height = 268
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 478
      Height = 268
      ExplicitLeft = 478
      ExplicitHeight = 268
      inherited Sb_Sair_0: TSpeedButton
        Top = 205
        ExplicitTop = 221
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 142
        ExplicitTop = 158
      end
      inherited SB_Buscar: TSpeedButton
        Top = 79
        ExplicitTop = 95
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 16
        ExplicitTop = 32
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 572
    Height = 72
    ExplicitWidth = 572
    ExplicitHeight = 72
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 568
      Height = 61
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Lb_Descricao: TLabel
        Left = 57
        Top = 16
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_BuscaCodigo: TLabel
        Left = 10
        Top = 16
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
      object E_BuscaDescricao: TEdit
        Left = 57
        Top = 32
        Width = 492
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
      object E_BuscaCodigo: TEdit
        Left = 3
        Top = 32
        Width = 49
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
    end
  end
  inherited MnuBase: TMainMenu
    Left = 80
    Top = 144
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
    end
  end
end
