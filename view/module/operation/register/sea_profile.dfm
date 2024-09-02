inherited SeaProfile: TSeaProfile
  Caption = 'Pesquisa de Perfil'
  ClientHeight = 350
  ClientWidth = 585
  ExplicitWidth = 591
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 579
    Height = 276
    ExplicitTop = 71
    ExplicitWidth = 568
    ExplicitHeight = 217
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 575
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 483
      Height = 258
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
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 485
      Height = 258
      ExplicitLeft = 474
      ExplicitHeight = 199
      inherited Sb_Sair_0: TSpeedButton
        Top = 197
        Height = 58
        ExplicitLeft = 3
        ExplicitTop = 175
        ExplicitWidth = 86
        ExplicitHeight = 58
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 136
        Height = 58
        ExplicitLeft = 3
        ExplicitTop = 125
        ExplicitWidth = 86
        ExplicitHeight = 58
      end
      inherited SB_Buscar: TSpeedButton
        Top = 75
        Height = 58
        ExplicitLeft = 3
        ExplicitTop = 64
        ExplicitWidth = 86
        ExplicitHeight = 58
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 14
        Height = 58
        ExplicitLeft = 3
        ExplicitTop = 9
        ExplicitWidth = 86
        ExplicitHeight = 58
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 579
    Height = 62
    ExplicitWidth = 568
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 575
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
      ExplicitWidth = 564
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
      object L_Codigo: TLabel
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
  inherited ds_search: TDataSource
    Left = 176
    Top = 202
  end
  inherited cds_search: TClientDataSet
    Left = 176
    Top = 154
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
