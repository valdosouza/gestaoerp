inherited SeaService: TSeaService
  Caption = 'Pesquisa de Servi'#231'os'
  ClientHeight = 401
  ClientWidth = 679
  ExplicitWidth = 685
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 673
    Height = 327
    ExplicitTop = 71
    ExplicitWidth = 606
    ExplicitHeight = 285
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 669
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 577
      Height = 309
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 419
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRC_VL_VDA'
          Width = 65
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 579
      Height = 309
      ExplicitLeft = 512
      ExplicitHeight = 267
      inherited Sb_Sair_0: TSpeedButton
        Top = 249
        Height = 57
        ExplicitLeft = 3
        ExplicitTop = 203
        ExplicitWidth = 86
        ExplicitHeight = 57
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 189
        Height = 57
        ExplicitLeft = 3
        ExplicitTop = 144
        ExplicitWidth = 86
        ExplicitHeight = 57
      end
      inherited SB_Buscar: TSpeedButton
        Top = 129
        Height = 57
        ExplicitLeft = 3
        ExplicitTop = 85
        ExplicitWidth = 86
        ExplicitHeight = 57
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 69
        Height = 57
        ExplicitLeft = 3
        ExplicitTop = 26
        ExplicitWidth = 86
        ExplicitHeight = 57
      end
      object ChBx_Inativos: TCheckBox
        Left = 21
        Top = 0
        Width = 63
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Inativos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 673
    Height = 62
    ExplicitWidth = 606
    ExplicitHeight = 62
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 669
      Height = 60
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 602
      object L_BuscaDescricao: TLabel
        Left = 107
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
        Left = 104
        Top = 31
        Width = 486
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
        Left = 8
        Top = 31
        Width = 94
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 100
    end
    object cds_searchPRC_VL_VDA: TCurrencyField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRC_VL_VDA'
    end
  end
end
