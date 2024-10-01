inherited SeaCoating: TSeaCoating
  Caption = 'Pesquisa de Revestimento dos Produtos'
  ClientHeight = 298
  ClientWidth = 604
  ExplicitWidth = 610
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 55
    Width = 598
    Height = 240
    ExplicitTop = 55
    ExplicitWidth = 598
    ExplicitHeight = 240
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 594
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 502
      Height = 222
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
          Width = 371
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 504
      Height = 222
      ExplicitLeft = 504
      ExplicitHeight = 222
      inherited Sb_Sair_0: TSpeedButton
        Top = 165
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 166
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 109
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = 111
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
      inherited SB_Buscar: TSpeedButton
        Top = 54
        Height = 52
        ExplicitLeft = 3
        ExplicitTop = 57
        ExplicitWidth = 86
        ExplicitHeight = 52
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 0
        Height = 51
        ExplicitLeft = 3
        ExplicitTop = 4
        ExplicitWidth = 86
        ExplicitHeight = 51
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 598
    Height = 46
    ExplicitWidth = 598
    ExplicitHeight = 46
    object Lb_Codigo: TLabel
      Left = 7
      Top = 4
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
      Top = 4
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
      Top = 20
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
      Top = 20
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
    Top = 128
  end
  inherited ds_search: TDataSource
    Top = 234
  end
  inherited cds_search: TClientDataSet
    Top = 178
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
