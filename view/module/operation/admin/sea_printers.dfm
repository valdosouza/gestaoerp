inherited SeaPrinters: TSeaPrinters
  Caption = 'Pesquisa de Impressora'
  ClientHeight = 392
  ClientWidth = 586
  ExplicitWidth = 592
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 580
    Height = 310
    ExplicitTop = 79
    ExplicitWidth = 580
    ExplicitHeight = 310
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 576
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 484
      Height = 292
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    end
    inherited pnl_pesq_right: TPanel
      Left = 486
      Height = 292
      ExplicitLeft = 486
      ExplicitHeight = 292
      inherited Sb_Sair_0: TSpeedButton
        Top = 229
        ExplicitTop = 229
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 166
        ExplicitTop = 166
      end
      inherited SB_Buscar: TSpeedButton
        Top = 103
        ExplicitTop = 103
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 40
        ExplicitTop = 40
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 580
    Height = 70
    ExplicitWidth = 580
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 576
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
        Left = 8
        Top = 17
        Width = 99
        Height = 14
        Caption = 'Nome da impressora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Descricao: TEdit
        Left = 8
        Top = 32
        Width = 529
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
    Left = 488
    Top = 8
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
