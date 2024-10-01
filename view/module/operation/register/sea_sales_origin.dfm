inherited SeaSalesOrigin: TSeaSalesOrigin
  Caption = 'Pesquisa de Origem da Venda'
  ClientHeight = 331
  ClientWidth = 565
  ExplicitWidth = 571
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 559
    Height = 257
    ExplicitTop = 71
    ExplicitWidth = 559
    ExplicitHeight = 240
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 555
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 463
      Height = 239
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
          Width = 332
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 465
      Height = 239
      ExplicitLeft = 465
      ExplicitHeight = 222
      inherited Sb_Sair_0: TSpeedButton
        Top = 176
        ExplicitTop = 159
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 124
        Height = 49
        ExplicitLeft = 3
        ExplicitTop = 112
        ExplicitWidth = 86
        ExplicitHeight = 49
      end
      inherited SB_Buscar: TSpeedButton
        Top = 68
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = 60
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 5
        ExplicitTop = -12
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 559
    Height = 62
    Alignment = taLeftJustify
    ExplicitWidth = 559
    ExplicitHeight = 62
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 555
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
      ExplicitTop = 1
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
    Left = 360
    Top = 16
  end
  inherited cds_search: TClientDataSet
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
