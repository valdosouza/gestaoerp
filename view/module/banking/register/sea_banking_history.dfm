inherited SeaBankingHistory: TSeaBankingHistory
  Caption = 'Pesquisa de Hit'#243'rico Bancario'
  ClientHeight = 369
  ClientWidth = 568
  ExplicitWidth = 574
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 562
    Height = 287
    ExplicitTop = 79
    ExplicitWidth = 562
    ExplicitHeight = 219
    inherited DBG_Pesquisa: TDBGrid
      Width = 466
      Height = 269
    end
    inherited pnl_pesq_right: TPanel
      Left = 468
      Height = 269
      ExplicitLeft = 468
      ExplicitHeight = 201
      inherited Sb_Sair_0: TSpeedButton
        Top = 206
        ExplicitLeft = 3
        ExplicitTop = 224
        ExplicitWidth = 86
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 143
        ExplicitLeft = 3
        ExplicitTop = 155
        ExplicitWidth = 86
      end
      inherited SB_Buscar: TSpeedButton
        Top = 80
        ExplicitLeft = 3
        ExplicitTop = 86
        ExplicitWidth = 86
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 17
        ExplicitLeft = 3
        ExplicitTop = 32
        ExplicitWidth = 86
      end
    end
    object DBGrid2: TDBGrid
      Left = 2
      Top = 16
      Width = 466
      Height = 265
      Anchors = [akTop, akBottom]
      Color = clCream
      DataSource = ds_search
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = SB_VisualizarClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = []
          Width = 366
          Visible = True
        end>
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 562
    Height = 70
    ExplicitWidth = 562
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 558
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
      object L_Descricao: TLabel
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
      object E_Descricao: TEdit
        Left = 55
        Top = 32
        Width = 497
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
      object E_Codigo: TEdit
        Left = 7
        Top = 32
        Width = 46
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
  inherited Menu: TMainMenu
    Left = 152
    Top = 48
  end
  inherited cds_search: TClientDataSet
    object cds_searchCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
  end
end
