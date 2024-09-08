inherited RegCfop: TRegCfop
  Caption = 'Cadastro de Natureza de Opera'#231#245'es - CFOP'
  ClientHeight = 365
  ClientWidth = 572
  ExplicitWidth = 578
  ExplicitHeight = 409
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 301
    Width = 572
    ExplicitTop = 292
    ExplicitWidth = 566
    inherited SB_Inserir: TSpeedButton
      Left = 1
      ExplicitLeft = 1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      ExplicitLeft = 105
    end
    inherited SB_Excluir: TSpeedButton
      Left = 209
      Width = 85
      ExplicitLeft = 217
      ExplicitTop = 5
      ExplicitWidth = 85
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 384
      Width = 86
      ExplicitLeft = 392
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 472
      Width = 95
      ExplicitLeft = 472
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Gravar: TSpeedButton
      Left = 296
      Width = 86
      ExplicitLeft = 304
      ExplicitTop = 5
      ExplicitWidth = 86
    end
  end
  inherited pnl_fundo: TPanel
    Width = 572
    Height = 301
    ExplicitWidth = 566
    ExplicitHeight = 292
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 568
      Height = 297
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 562
      ExplicitHeight = 288
      object L_Desc_Abreviada: TLabel
        Left = 155
        Top = 9
        Width = 161
        Height = 14
        Caption = 'Descri'#231#227'o Resumida da Natureza'
        FocusControl = E_Desc_Abreviada
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descricao: TLabel
        Left = 7
        Top = 50
        Width = 158
        Height = 14
        Caption = 'Descri'#231#227'o Completa da Natureza'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_CFOP: TLabel
        Left = 63
        Top = 9
        Width = 37
        Height = 14
        Caption = 'C.F.O.P.'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Registro: TLabel
        Left = 8
        Top = 90
        Width = 39
        Height = 13
        Caption = 'Registro'
        FocusControl = E_Registro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Codigo: TLabel
        Left = 8
        Top = 9
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
      object L_Aplicacao: TLabel
        Left = 7
        Top = 127
        Width = 48
        Height = 14
        Caption = 'Aplica'#231#227'o'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 23
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
      object E_Desc_Abreviada: TEdit
        Left = 151
        Top = 23
        Width = 401
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Descricao: TEdit
        Left = 7
        Top = 66
        Width = 546
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object E_CFOP: TEdit
        Left = 57
        Top = 23
        Width = 93
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 1
      end
      object Rgp_Sentido: TRadioGroup
        Left = 70
        Top = 92
        Width = 144
        Height = 33
        Caption = 'Sentido  '
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Entrada'
          'Sa'#237'da')
        ParentFont = False
        TabOrder = 5
      end
      object Rgp_Interno: TRadioGroup
        Left = 215
        Top = 92
        Width = 223
        Height = 33
        Hint = 'Sim: Dentro do estado'#13'N'#227'o: Fora do estado'
        Caption = 'Al'#231'ada - Abrang'#234'ncia'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Estadual'
          'Nacional'
          'Exterior')
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object E_Registro: TEdit
        Left = 7
        Top = 103
        Width = 57
        Height = 21
        TabOrder = 4
      end
      object Rgp_Ativo: TRadioGroup
        Left = 440
        Top = 92
        Width = 113
        Height = 33
        Caption = 'Ativo'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Sim'
          'N'#227'o')
        ParentFont = False
        TabOrder = 7
      end
      object DBMemo1: TMemo
        Left = 2
        Top = 144
        Width = 564
        Height = 151
        Align = alBottom
        Anchors = [akTop, akBottom]
        TabOrder = 8
        ExplicitWidth = 558
        ExplicitHeight = 142
      end
    end
  end
end
