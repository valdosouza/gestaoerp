inherited RegSituation: TRegSituation
  Caption = 'Cadastro de Situa'#231#227'o'
  ClientHeight = 199
  ClientWidth = 572
  ExplicitWidth = 584
  ExplicitHeight = 262
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 135
    Width = 572
    ExplicitTop = 126
    ExplicitWidth = 566
    inherited SB_Inserir: TSpeedButton
      Left = 5
      Width = 96
      ExplicitLeft = -1
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      Width = 90
      ExplicitLeft = 97
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Excluir: TSpeedButton
      Left = 195
      Width = 90
      ExplicitLeft = 189
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 379
      Width = 90
      ExplicitLeft = 373
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 471
      Width = 96
      ExplicitLeft = 465
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Gravar: TSpeedButton
      Left = 287
      Width = 90
      ExplicitLeft = 281
      ExplicitTop = 5
      ExplicitWidth = 90
    end
  end
  inherited pnl_fundo: TPanel
    Width = 572
    Height = 135
    ExplicitWidth = 566
    ExplicitHeight = 126
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 568
      Height = 131
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 562
      ExplicitHeight = 122
      object L_Codigo: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descricao: TLabel
        Left = 61
        Top = 8
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Situacao: TLabel
        Left = 9
        Top = 48
        Width = 40
        Height = 14
        Caption = 'M'#243'dulos'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Color: TLabel
        Left = 176
        Top = 47
        Width = 162
        Height = 14
        Caption = 'Sinaliza'#231#227'o - Preto para nenhuma'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 7
        Top = 24
        Width = 49
        Height = 22
        Color = clScrollBar
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Descricao: TEdit
        Left = 59
        Top = 24
        Width = 497
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object cbx_situacao: TComboBox
        Left = 8
        Top = 62
        Width = 161
        Height = 21
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
      object Cb_Color: TColorBox
        Left = 174
        Top = 62
        Width = 164
        Height = 22
        TabOrder = 3
      end
    end
  end
end
