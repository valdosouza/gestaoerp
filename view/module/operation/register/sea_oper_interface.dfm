inherited SeaOperInterface: TSeaOperInterface
  Caption = 'Pesquisa de Opera'#231#227'o de Interfaces'
  ClientHeight = 324
  ClientWidth = 573
  ExplicitWidth = 579
  ExplicitHeight = 368
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 567
    Height = 250
    ExplicitTop = 71
    ExplicitWidth = 567
    ExplicitHeight = 235
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 563
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 471
      Height = 232
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 306
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 473
      Height = 232
      ExplicitLeft = 473
      ExplicitHeight = 217
      inherited Sb_Sair_0: TSpeedButton
        Top = 173
        Height = 56
        ExplicitLeft = 3
        ExplicitTop = 185
        ExplicitWidth = 86
        ExplicitHeight = 56
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 115
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 116
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 56
        Height = 56
        ExplicitLeft = 3
        ExplicitTop = 58
        ExplicitWidth = 86
        ExplicitHeight = 56
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 0
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = 15
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 567
    Height = 62
    ExplicitWidth = 567
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 563
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
    Left = 344
    Top = 160
  end
  inherited ds_search: TDataSource
    Left = 232
    Top = 234
  end
  inherited cds_search: TClientDataSet
    Left = 232
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
