inherited SeaProductBrand: TSeaProductBrand
  Caption = 'Pesquisa de Marca de Produto'
  ClientHeight = 327
  ClientWidth = 579
  ExplicitWidth = 585
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 573
    Height = 253
    ExplicitTop = 71
    ExplicitWidth = 573
    ExplicitHeight = 253
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 569
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 477
      Height = 235
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 479
      Height = 235
      ExplicitLeft = 479
      ExplicitHeight = 235
      inherited Sb_Sair_0: TSpeedButton
        Top = 172
        ExplicitTop = 172
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 109
        ExplicitTop = 109
      end
      inherited SB_Buscar: TSpeedButton
        Top = 46
        ExplicitTop = 46
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -17
        ExplicitTop = -17
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 573
    Height = 62
    ExplicitWidth = 573
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 569
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
      object L_BuscaDescricao: TLabel
        Left = 59
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
      object L_BuscaCodigo: TLabel
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
        Left = 59
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
        TabOrder = 0
      end
      object E_BuscaCodigo: TEdit
        Left = 7
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
        TabOrder = 1
      end
    end
  end
  inherited ds_search: TDataSource
    Left = 160
    Top = 154
  end
  inherited cds_search: TClientDataSet
    Left = 160
    Top = 106
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
