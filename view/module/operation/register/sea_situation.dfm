inherited SeaSituation: TSeaSituation
  Caption = 'Pesquisa de Situa'#231#227'o'
  ClientHeight = 321
  ClientWidth = 576
  ExplicitWidth = 588
  ExplicitHeight = 384
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 570
    Height = 247
    ExplicitTop = 71
    ExplicitWidth = 564
    ExplicitHeight = 238
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 566
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 474
      Height = 229
    end
    inherited pnl_pesq_right: TPanel
      Left = 476
      Height = 229
      ExplicitLeft = 470
      ExplicitHeight = 220
      inherited Sb_Sair_0: TSpeedButton
        Top = 170
        Height = 56
        ExplicitLeft = 3
        ExplicitTop = 177
        ExplicitWidth = 86
        ExplicitHeight = 56
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 112
        Height = 55
        ExplicitLeft = 3
        ExplicitTop = 114
        ExplicitWidth = 86
        ExplicitHeight = 55
      end
      inherited SB_Buscar: TSpeedButton
        Top = 55
        Height = 54
        ExplicitLeft = 3
        ExplicitTop = 51
        ExplicitWidth = 86
        ExplicitHeight = 54
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -1
        Height = 53
        ExplicitLeft = 3
        ExplicitTop = -12
        ExplicitWidth = 86
        ExplicitHeight = 53
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 570
    Height = 62
    ExplicitWidth = 564
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 566
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
      ExplicitWidth = 560
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
      object L_BuscaModulos: TLabel
        Left = 423
        Top = 15
        Width = 34
        Height = 14
        Caption = 'M'#243'dulo'
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
        Width = 360
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
      object Cb_BuscaModulos: TComboBox
        Left = 422
        Top = 32
        Width = 134
        Height = 22
        Style = csDropDownList
        TabOrder = 2
        Items.Strings = (
          'CONSERTO'
          'ASSISTENCIA T'#201'CNICA'
          'ENTREGA DE PEDIDO'
          'OR'#199'AMENTO USINAGEM'
          'EXTINTORES'
          'SAL'#195'O BELEZA'
          'ELETR'#212'NICOS'
          'PET-SHOP'
          'MOVELEIRO'
          'GR'#193'FICA')
      end
    end
  end
end
