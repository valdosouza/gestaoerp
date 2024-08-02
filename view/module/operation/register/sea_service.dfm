inherited SeaService: TSeaService
  Caption = 'Pesquisa de Servi'#231'os'
  ClientHeight = 336
  ClientWidth = 612
  ExplicitWidth = 624
  ExplicitHeight = 399
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 606
    Height = 262
    ExplicitTop = 71
    ExplicitWidth = 600
    ExplicitHeight = 253
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 602
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 510
      Height = 244
    end
    inherited pnl_pesq_right: TPanel
      Left = 512
      Height = 244
      ExplicitLeft = 506
      ExplicitHeight = 235
      inherited Sb_Sair_0: TSpeedButton
        Top = 187
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 208
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 130
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 145
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Buscar: TSpeedButton
        Top = 73
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 82
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 16
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 19
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      object ChBx_Inativos: TCheckBox
        Left = 21
        Top = 0
        Width = 63
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Inativos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 606
    Height = 62
    ExplicitWidth = 600
    ExplicitHeight = 62
    object GroupBox1: TGroupBox
      Left = 2
      Top = 2
      Width = 602
      Height = 60
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 596
      object L_BuscaDescricao: TLabel
        Left = 107
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
        Left = 104
        Top = 31
        Width = 486
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
        Left = 8
        Top = 31
        Width = 94
        Height = 22
        TabOrder = 0
      end
    end
  end
end
