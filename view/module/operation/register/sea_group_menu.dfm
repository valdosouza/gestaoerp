inherited SeaGroupMenu: TSeaGroupMenu
  Caption = 'Pesquisa de Grupo e SubGrupo do Card'#225'pio'
  ClientHeight = 438
  ClientWidth = 594
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 606
  ExplicitHeight = 501
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 588
    Height = 356
    ExplicitTop = 79
    ExplicitWidth = 582
    ExplicitHeight = 333
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 584
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 492
      Height = 338
    end
    inherited pnl_pesq_right: TPanel
      Left = 494
      Height = 338
      ExplicitLeft = 488
      ExplicitHeight = 315
      inherited Sb_Sair_0: TSpeedButton
        Top = 275
        ExplicitTop = 330
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 212
        ExplicitTop = 267
      end
      inherited SB_Buscar: TSpeedButton
        Top = 149
        ExplicitTop = 204
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 86
        ExplicitTop = 141
      end
    end
    object ChBx_Grupo: TCheckBox
      Left = 500
      Top = 0
      Width = 89
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Grupos Vazio'
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
    Width = 588
    Height = 70
    ExplicitWidth = 582
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 584
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
      ExplicitWidth = 578
      object Lb_grupo: TLabel
        Left = 11
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Grupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_subgrupo: TLabel
        Left = 291
        Top = 16
        Width = 49
        Height = 14
        Caption = 'SubGrupo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaGrupo: TEdit
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
      object E_BuscaSubGrupo: TEdit
        Left = 289
        Top = 32
        Width = 245
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
end
