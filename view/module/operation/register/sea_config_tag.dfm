inherited SeaConfigTag: TSeaConfigTag
  Caption = 'Pesquisa de etiqueta'
  ClientHeight = 338
  ClientWidth = 598
  ExplicitWidth = 604
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 592
    Height = 264
    ExplicitTop = 71
    ExplicitWidth = 592
    ExplicitHeight = 264
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 588
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 496
      Height = 246
    end
    inherited pnl_pesq_right: TPanel
      Left = 498
      Height = 246
      ExplicitLeft = 498
      ExplicitHeight = 246
      inherited Sb_Sair_0: TSpeedButton
        Top = 183
        ExplicitTop = 183
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 120
        ExplicitTop = 120
      end
      inherited SB_Buscar: TSpeedButton
        Top = 57
        ExplicitTop = 57
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -6
        ExplicitTop = -6
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 592
    Height = 62
    ExplicitWidth = 592
    ExplicitHeight = 62
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 588
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
      object Lb_Codigo: TLabel
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
        Left = 69
        Top = 32
        Width = 513
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
        Width = 60
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
  inherited cds_search: TClientDataSet
    object cds_searchCodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
    end
  end
end
