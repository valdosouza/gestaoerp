inherited SeaDeadLine: TSeaDeadLine
  Caption = 'Pesquisa de Formas de Pagto'
  ClientHeight = 352
  ClientWidth = 567
  ExplicitWidth = 573
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 76
    Width = 561
    Height = 273
    ExplicitTop = 76
    ExplicitWidth = 561
    ExplicitHeight = 273
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 557
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 465
      Height = 255
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
          Width = 276
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorMinimo'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 467
      Height = 255
      ExplicitLeft = 467
      ExplicitHeight = 255
      inherited Sb_Sair_0: TSpeedButton
        Top = 192
        ExplicitTop = 192
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 129
        ExplicitTop = 129
      end
      inherited SB_Buscar: TSpeedButton
        Top = 66
        ExplicitTop = 66
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 3
        ExplicitTop = 3
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 561
    Height = 67
    ExplicitWidth = 561
    ExplicitHeight = 67
    object Lb_Codigo: TLabel
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
    object Lb_Descricao: TLabel
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
  end
  inherited MnuBase: TMainMenu
    Left = 152
    Top = 104
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
    object cds_searchValorMinimo: TFloatField
      FieldName = 'ValorMinimo'
      OnGetText = cds_searchValorMinimoGetText
    end
  end
end
