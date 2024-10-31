inherited SeaCustomerOrigin: TSeaCustomerOrigin
  Caption = 'Pesquisa de Origem de Clientes'
  ClientHeight = 323
  ClientWidth = 565
  ExplicitWidth = 571
  ExplicitHeight = 367
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 559
    Height = 249
    ExplicitTop = 71
    ExplicitWidth = 559
    ExplicitHeight = 198
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 555
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 463
      Height = 231
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 465
      Height = 231
      ExplicitLeft = 465
      ExplicitHeight = 180
      inherited Sb_Sair_0: TSpeedButton
        Top = 178
        Height = 50
        ExplicitLeft = 3
        ExplicitTop = 170
        ExplicitWidth = 86
        ExplicitHeight = 50
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 123
        Height = 52
        ExplicitLeft = 3
        ExplicitTop = 116
        ExplicitWidth = 86
        ExplicitHeight = 52
      end
      inherited SB_Buscar: TSpeedButton
        Top = 67
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = 61
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 10
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 5
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 559
    Height = 62
    ExplicitWidth = 559
    ExplicitHeight = 62
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
    object L_BuscaDescricao: TLabel
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
  end
  inherited MnuBase: TMainMenu
    Left = 216
    Top = 32
  end
  inherited ds_search: TDataSource
    Left = 160
    Top = 186
  end
  inherited cds_search: TClientDataSet
    Left = 160
    Top = 138
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
