inherited SeaStocks: TSeaStocks
  Caption = 'Pesquisa de Estoques'
  ClientHeight = 332
  ClientWidth = 564
  ExplicitWidth = 570
  ExplicitHeight = 381
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 558
    Height = 258
    ExplicitTop = 71
    ExplicitWidth = 558
    ExplicitHeight = 258
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 554
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 462
      Height = 240
    end
    inherited pnl_pesq_right: TPanel
      Left = 464
      Height = 240
      ExplicitLeft = 464
      ExplicitHeight = 240
      inherited Sb_Sair_0: TSpeedButton
        Top = 177
        ExplicitTop = 177
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 114
        ExplicitTop = 114
      end
      inherited SB_Buscar: TSpeedButton
        Top = 51
        ExplicitTop = 51
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -12
        ExplicitTop = -12
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 558
    Height = 62
    ExplicitWidth = 558
    ExplicitHeight = 62
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
      TabOrder = 0
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
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 296
    Top = 16
  end
  inherited ds_search: TDataSource
    Left = 272
    Top = 234
  end
  inherited cds_search: TClientDataSet
    Left = 272
    Top = 186
  end
end
