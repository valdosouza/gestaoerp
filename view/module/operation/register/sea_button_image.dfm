inherited SeaButtonImage: TSeaButtonImage
  Caption = 'Pesquisa de Bot'#227'o'
  ClientHeight = 318
  ClientWidth = 653
  ExplicitWidth = 659
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 647
    Height = 244
    ExplicitTop = 71
    ExplicitWidth = 647
    ExplicitHeight = 212
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 643
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 551
      Height = 226
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 436
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 553
      Height = 226
      ExplicitLeft = 553
      ExplicitHeight = 194
      inherited Sb_Sair_0: TSpeedButton
        Top = 173
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 180
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 120
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 117
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Buscar: TSpeedButton
        Top = 67
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 54
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 14
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = -9
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 647
    Height = 62
    ExplicitWidth = 647
    ExplicitHeight = 62
    object L_buscaCodigo: TLabel
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
    object L_BuscaDescricao: TLabel
      Left = 90
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
    object E_BuscaCodigo: TEdit
      Left = 7
      Top = 32
      Width = 77
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
    object E_BuscaDescricao: TEdit
      Left = 90
      Top = 32
      Width = 548
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
  inherited MnuBase: TMainMenu
    Left = 120
    Top = 16
  end
  inherited ds_search: TDataSource
    Left = 160
    Top = 210
  end
  inherited cds_search: TClientDataSet
    Left = 160
    Top = 146
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
