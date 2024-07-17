inherited SeaBankingHistory: TSeaBankingHistory
  Caption = 'Pesquisa de Hit'#243'rico Bancario'
  ClientHeight = 301
  ClientWidth = 568
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 580
  ExplicitHeight = 364
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 562
    Height = 219
    ExplicitHeight = 375
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 558
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 466
      Height = 201
    end
    inherited pnl_pesq_right: TPanel
      Left = 468
      Height = 201
      ExplicitLeft = 462
      ExplicitTop = 0
      ExplicitHeight = 215
      inherited Sb_Sair_0: TSpeedButton
        Top = 156
        Height = 42
        ExplicitLeft = 3
        ExplicitTop = 135
        ExplicitWidth = 86
        ExplicitHeight = 42
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 105
        Height = 48
        ExplicitLeft = 3
        ExplicitTop = 84
        ExplicitWidth = 86
        ExplicitHeight = 48
      end
      inherited SB_Buscar: TSpeedButton
        Top = 48
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 67
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 0
        Height = 45
        ExplicitLeft = 3
        ExplicitTop = 12
        ExplicitWidth = 86
        ExplicitHeight = 45
      end
    end
    object DBGrid2: TDBGrid
      Left = 2
      Top = 16
      Width = 466
      Height = 197
      Anchors = [akTop, akBottom]
      Color = clCream
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
          FieldName = 'HTB_CODIGO'
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
          FieldName = 'HTB_DESCRICAO'
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
    ExplicitWidth = 873
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
      ExplicitLeft = 4
      ExplicitTop = 10
      ExplicitWidth = 869
      object Label28: TLabel
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
      object Label3: TLabel
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
      object E_BuscaCodigo: TEdit
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
end
