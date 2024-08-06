inherited SeaUf: TSeaUf
  Caption = 'Pesquisa de Estados'
  ClientHeight = 349
  ClientWidth = 566
  ExplicitWidth = 572
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 560
    Height = 275
    ExplicitTop = 71
    ExplicitWidth = 560
    ExplicitHeight = 275
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 556
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 464
      Height = 257
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 466
      Height = 257
      ExplicitLeft = 466
      ExplicitHeight = 257
      inherited Sb_Sair_0: TSpeedButton
        Top = 194
        ExplicitTop = 194
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 131
        ExplicitTop = 131
      end
      inherited SB_Buscar: TSpeedButton
        Top = 68
        ExplicitTop = 68
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 5
        ExplicitTop = 5
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 560
    Height = 62
    ExplicitWidth = 560
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 556
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
      object Lb_BuscaDescricao: TLabel
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
    Left = 184
    Top = 0
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
