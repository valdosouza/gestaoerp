inherited SeaLineBusiness: TSeaLineBusiness
  Caption = 'Pesquisa de Ramo de Atividade'
  ClientHeight = 333
  ClientWidth = 586
  ExplicitWidth = 592
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 580
    Height = 259
    ExplicitTop = 61
    ExplicitWidth = 580
    ExplicitHeight = 217
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 576
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 484
      Height = 241
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
          Width = 355
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 486
      Height = 241
      ExplicitLeft = 486
      ExplicitHeight = 199
      inherited Sb_Sair_0: TSpeedButton
        Top = 183
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 154
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 125
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 106
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 67
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 57
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 9
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 7
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 580
    Height = 62
    ExplicitWidth = 580
    ExplicitHeight = 62
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 576
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
      ExplicitTop = -9
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
    Left = 216
  end
  inherited ds_search: TDataSource
    Top = 234
  end
  inherited cds_search: TClientDataSet
    Top = 170
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
