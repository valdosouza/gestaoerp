inherited SeaVehicleBrand: TSeaVehicleBrand
  Caption = 'Pesquisa de Marca e Modelo'
  ClientHeight = 375
  ClientWidth = 564
  ExplicitWidth = 570
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 558
    Height = 293
    ExplicitTop = 79
    ExplicitWidth = 558
    ExplicitHeight = 293
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 554
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 462
      Height = 275
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
          Title.Caption = 'Marca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'modelodescricao'
          Title.Caption = 'Modelo'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 464
      Height = 275
      ExplicitLeft = 464
      ExplicitHeight = 275
      inherited Sb_Sair_0: TSpeedButton
        Top = 212
        ExplicitTop = 212
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 149
        ExplicitTop = 149
      end
      inherited SB_Buscar: TSpeedButton
        Top = 86
        ExplicitTop = 86
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 23
        ExplicitTop = 23
      end
    end
    object ChBx_Marca: TCheckBox
      Left = 464
      Top = 19
      Width = 89
      Height = 17
      Caption = 'Marcas Vazio'
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
    Width = 558
    Height = 70
    ExplicitWidth = 558
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 554
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
      object L_BuscaMarca: TLabel
        Left = 11
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Marca'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_BuscaModelo: TLabel
        Left = 295
        Top = 16
        Width = 34
        Height = 14
        Caption = 'Modelo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaMarca: TEdit
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
      object E_BuscaModelo: TEdit
        Left = 294
        Top = 32
        Width = 242
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
  inherited MnuBase: TMainMenu
    Left = 352
    Top = 128
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
    object cds_searchmodelodescricao: TStringField
      FieldName = 'modelodescricao'
    end
  end
end
