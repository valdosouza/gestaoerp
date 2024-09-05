inherited SeaNote: TSeaNote
  Caption = 'Pesquisa de Observa'#231#245'es'
  ClientHeight = 383
  ClientWidth = 571
  ExplicitWidth = 577
  ExplicitHeight = 427
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 565
    Height = 301
    ExplicitTop = 79
    ExplicitWidth = 565
    ExplicitHeight = 301
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 561
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 469
      Height = 283
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 471
      Height = 283
      ExplicitLeft = 471
      ExplicitHeight = 283
      inherited Sb_Sair_0: TSpeedButton
        Top = 216
        Height = 64
        ExplicitLeft = 3
        ExplicitTop = 215
        ExplicitWidth = 86
        ExplicitHeight = 64
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 148
        Height = 65
        ExplicitLeft = 3
        ExplicitTop = 146
        ExplicitWidth = 86
        ExplicitHeight = 65
      end
      inherited SB_Buscar: TSpeedButton
        Top = 79
        Height = 66
        ExplicitLeft = 3
        ExplicitTop = 76
        ExplicitWidth = 86
        ExplicitHeight = 66
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 7
        Height = 69
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 86
        ExplicitHeight = 69
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 565
    Height = 70
    ExplicitWidth = 565
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 561
      Height = 65
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
        Left = 55
        Top = 32
        Width = 497
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
        Width = 46
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
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
