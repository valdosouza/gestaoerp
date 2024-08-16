inherited SeaInterface: TSeaInterface
  Caption = 'Pesquisa de Interface'
  ClientHeight = 333
  ClientWidth = 570
  ExplicitWidth = 576
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 564
    Height = 259
    ExplicitTop = 71
    ExplicitWidth = 564
    ExplicitHeight = 259
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 560
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 468
      Height = 241
    end
    inherited pnl_pesq_right: TPanel
      Left = 470
      Height = 241
      ExplicitLeft = 470
      ExplicitHeight = 241
      inherited Sb_Sair_0: TSpeedButton
        Top = 178
        ExplicitTop = 178
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 115
        ExplicitTop = 115
      end
      inherited SB_Buscar: TSpeedButton
        Top = 52
        ExplicitTop = 52
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -11
        ExplicitTop = -11
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 564
    Height = 62
    ExplicitWidth = 564
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 560
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
        Left = 59
        Top = 32
        Width = 492
        Height = 22
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
    Left = 296
    Top = 96
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
