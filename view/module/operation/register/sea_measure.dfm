inherited SeaMeasure: TSeaMeasure
  Caption = 'Pesquisa de Medidas\Unidades'
  ClientHeight = 332
  ClientWidth = 581
  ExplicitWidth = 593
  ExplicitHeight = 395
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 575
    Height = 258
    ExplicitTop = 71
    ExplicitWidth = 569
    ExplicitHeight = 249
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 571
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 479
      Height = 240
    end
    inherited pnl_pesq_right: TPanel
      Left = 481
      Height = 240
      ExplicitLeft = 475
      ExplicitHeight = 231
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
    Width = 575
    Height = 62
    ExplicitWidth = 569
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 571
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
      ExplicitWidth = 565
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
end
