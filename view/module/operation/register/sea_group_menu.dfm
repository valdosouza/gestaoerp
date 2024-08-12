inherited SeaGroupMenu: TSeaGroupMenu
  Caption = 'Pesquisa de Grupo e SubGrupo do Card'#225'pio'
  ClientHeight = 438
  ClientWidth = 594
  ExplicitWidth = 600
  ExplicitHeight = 482
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 588
    Height = 356
    ExplicitTop = 79
    ExplicitWidth = 588
    ExplicitHeight = 356
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 584
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 492
      Height = 338
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 494
      Height = 338
      ExplicitLeft = 494
      ExplicitHeight = 338
      inherited Sb_Sair_0: TSpeedButton
        Top = 275
        ExplicitTop = 330
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 212
        ExplicitTop = 267
      end
      inherited SB_Buscar: TSpeedButton
        Top = 149
        ExplicitTop = 204
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 86
        ExplicitTop = 141
      end
    end
    object ChBx_Grupo: TCheckBox
      Left = 497
      Top = 16
      Width = 82
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Grupos vazios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 588
    Height = 70
    ExplicitWidth = 588
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 584
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
      object Lb_grupo: TLabel
        Left = 11
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Grupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_subgrupo: TLabel
        Left = 291
        Top = 16
        Width = 49
        Height = 14
        Caption = 'SubGrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaGrupo: TEdit
        Left = 8
        Top = 32
        Width = 280
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
      object E_BuscaSubGrupo: TEdit
        Left = 289
        Top = 32
        Width = 245
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
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'descricao'
    end
    object cds_searchdescricao_subgrupo: TStringField
      DisplayLabel = 'SubGrupo'
      FieldName = 'descricao_subgrupo'
    end
  end
end
