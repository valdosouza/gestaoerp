inherited SeaPackage: TSeaPackage
  Caption = 'Pesquisa de Embalagens'
  ClientHeight = 346
  ClientWidth = 567
  ExplicitWidth = 573
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 561
    Height = 272
    ExplicitTop = 71
    ExplicitWidth = 561
    ExplicitHeight = 272
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 557
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 465
      Height = 254
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 467
      Height = 254
      ExplicitLeft = 467
      ExplicitHeight = 254
      inherited Sb_Sair_0: TSpeedButton
        Top = 191
        ExplicitTop = 178
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 128
        ExplicitTop = 115
      end
      inherited SB_Buscar: TSpeedButton
        Top = 65
        ExplicitTop = 52
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 2
        ExplicitTop = -11
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 561
    Height = 62
    ExplicitWidth = 561
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 557
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
      object Lb_Codigo: TLabel
        Left = 7
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
        TabOrder = 1
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
        TabOrder = 0
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 200
    Top = 16
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
