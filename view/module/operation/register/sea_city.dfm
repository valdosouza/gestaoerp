inherited SeaCity: TSeaCity
  Caption = 'SeaCity'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 74
    Height = 429
    ExplicitTop = 74
    ExplicitHeight = 429
    inherited DBG_Pesquisa: TDBGrid
      Height = 411
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'IBGE'
          Title.Caption = 'C'#243'digo IBGE'
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 571
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Width = 32
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Height = 411
      ExplicitHeight = 411
      inherited Sb_Sair_0: TSpeedButton
        Top = 348
        ExplicitTop = 348
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 285
        ExplicitTop = 285
      end
      inherited SB_Buscar: TSpeedButton
        Top = 222
        ExplicitTop = 222
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 159
        ExplicitTop = 159
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Height = 65
    ExplicitHeight = 65
    object Gbx_Parametros: TGroupBox
      Left = 2
      Top = 2
      Width = 875
      Height = 61
      Align = alClient
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object L_IBGE: TLabel
        Left = 5
        Top = 16
        Width = 59
        Height = 14
        Caption = 'C'#243'digo IBGE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descricao: TLabel
        Left = 124
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
      object L_UF: TLabel
        Left = 583
        Top = 16
        Width = 13
        Height = 14
        Caption = 'UF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_IBGE: TEdit
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
      object E_Descricao: TEdit
        Left = 124
        Top = 32
        Width = 455
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
  object CB_UF: TComboBox [2]
    Left = 588
    Top = 37
    Width = 83
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'AC'
      'AL'
      'AP'
      'AM'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MT'
      'MS'
      'MG'
      'PA'
      'PB'
      'PR'
      'PE'
      'PI'
      'RJ'
      'RN'
      'RS'
      'RO'
      'RR'
      'SC'
      'SP'
      'SE'
      'TO')
  end
  inherited MnuBase: TMainMenu
    Left = 608
    Top = 112
  end
  inherited cds_search: TClientDataSet
    object cds_searchCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cds_searchDescricao: TStringField
      FieldName = 'Descricao'
    end
    object cds_searchIBGE: TIntegerField
      FieldName = 'IBGE'
    end
    object cds_searchUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
  end
end
